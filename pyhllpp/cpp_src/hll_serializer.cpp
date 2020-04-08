#include <cstring>
#include <stdexcept>
#include "hll_serializer.hpp"

namespace hll {

uint32_t _HLLSerializer::serialize_buffer_size(const _HLL & hll) {
    return hll.size * sizeof(_HLL::register_type) + sizeof(MAGIC_DENSE) + sizeof(hll.precision) + sizeof(hll.seed);
}

void _HLLSerializer::serialize(const _HLL & hll, uint8_t * data, uint32_t & len) {
    uint8_t * begin = data;
    const auto & hr = hll.registers;

    uint32_t nonzeros = 0;
    for(uint32_t i = 0; i < hll.size; ++i)
        nonzeros += hr[i] != 0;

    uint32_t type = MAGIC_DENSE;
    if(nonzeros * (hll.precision + 6) < hll.size * 6)
        type = MAGIC_SPARSE;

    *(uint32_t*)data = type; data += 4;
    *(uint32_t*)data = hll.precision; data += 4;
    *(uint32_t*)data = hll.seed; data += 4;

    if(type == MAGIC_SPARSE) {
        *(uint32_t*)data = nonzeros; data += 4;

        memset(data, 0, (( nonzeros * (hll.precision + 6) + 7) >> 3)*sizeof(uint8_t));

        uint8_t bit_offset = 0;
        for(uint32_t i = 0; i < hll.size; ++i) {
            if(hr[i] != 0) {
                write_bits(data, bit_offset, hll.precision, i);
                write_bits(data, bit_offset, 6, hr[i]);
            }
        }
        if(bit_offset != 0) data++;
    }
    else { // (type == MAGIC_DENSE)
        for(uint32_t i = 0; i < hll.size / 4; ++i) {
            data[0] = (hr[4*i]  <<2)|((hr[4*i+1]>>4)&3);
            data[1] = (hr[4*i+1]<<4)|((hr[4*i+2]>>2)&15);
            data[2] = (hr[4*i+2]<<6)| (hr[4*i+3]&63);
            data += 3;
        }
    }

    len = (data - begin)*sizeof(uint8_t);
}


_HLL _HLLSerializer::deserialize(const uint8_t * data) {
    uint32_t magic = *(uint32_t*)data; data += 4;
    uint32_t precision = *(uint32_t*)data; data += 4;
    uint32_t seed = *(uint32_t*)data; data += 4;

    if(magic != MAGIC_SPARSE && magic != MAGIC_DENSE)
        throw std::runtime_error("_HLLSerializer: corrupted magic number");

    _HLL hll(precision, seed);
    auto & hr = hll.registers;

    if(magic == MAGIC_SPARSE) {
        uint32_t nonzeros = *(uint32_t*)data; data += 4;

        uint8_t bit_offset = 0;
        for(uint32_t z = 0; z < nonzeros; ++z) {
            uint32_t i = read_bits(data, bit_offset, hll.precision);

            hr[i] = read_bits(data, bit_offset, 6);
        }
        if(bit_offset!=0) data++;
    }
    else { // (type == MAGIC_DENSE)
        for(uint32_t i = 0; i < hll.size / 4; ++i) {
            hr[4*i  ] =                    data[0]>>2;
            hr[4*i+1] = ((data[0]&3) <<4)|(data[1]>>4);
            hr[4*i+2] = ((data[1]&15)<<2)|(data[2]>>6);
            hr[4*i+3] =   data[2]&63;
            data += 3;
        }
    }

    return hll;
}

void _HLLSerializer::write_bits(uint8_t * & dest, uint8_t & bit_offset, uint8_t bits, uint32_t src)  {
    while(bits>8-bit_offset) {
        *dest |= (src>>(bits-(8-bit_offset)))&((1<<(8-bit_offset))-1);
        dest++; bits -= 8-bit_offset; bit_offset = 0;
    }
    *dest |= (src&((1<<bits)-1))<<(8-bits-bit_offset);
    bit_offset += bits;
    if(bit_offset == 8){
        bit_offset = 0;
        dest++;
    }
}

uint32_t _HLLSerializer::read_bits(const uint8_t * & src, uint8_t & bit_offset, uint8_t bits)  {
    uint32_t res = 0;
    while(bits>8-bit_offset) {
        res <<= 8; //-bit_offset;
        res |= (*src)&((1<<(8-bit_offset))-1);
        src++; bits -= 8-bit_offset; bit_offset = 0;
    }
    res <<= bits;
    res |= ((*src)>>(8-bit_offset-bits))&((1<<bits)-1);
    bit_offset += bits;
    if(bit_offset == 8){
        bit_offset = 0;
        src++;
    }
    return res;
}

}
