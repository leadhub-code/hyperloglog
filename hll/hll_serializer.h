#pragma once

#include <stdexcept>
#include "hll.h"

#include <iostream>
using namespace std;

template <uint32_t PBITS>
struct HLLSerializer {
    constexpr static uint32_t MAGIC_SPARSE = 0xd37bd4e1;
    constexpr static uint32_t MAGIC_DENSE  = 0xa32fe12c;
    constexpr static uint32_t MIN_BUFFER_SIZE = (1<<PBITS)+12;

    static void serialize(const HLL<PBITS> & hll, uint8_t * data, uint32_t & len);
    static HLL<PBITS> deserialize(const uint8_t * data);

private:
    static void write_bits(uint8_t * &dest, uint8_t & bit_offset, uint8_t bits, uint32_t src) {
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

    static uint32_t read_bits(const uint8_t * &src, uint8_t & bit_offset, uint8_t bits) {
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
};

template <uint32_t PBITS>
void HLLSerializer<PBITS>::serialize(const HLL<PBITS> & hll, uint8_t * data, uint32_t & len) {
    uint8_t * begin = data;
    const auto & hr = hll.registers;

    uint32_t nonzeros = 0;
    for(uint32_t i = 0; i < HLL<PBITS>::SIZE; ++i) {
        nonzeros += hr[i]!=0;
    }

    if(nonzeros*(PBITS+6)<HLL<PBITS>::SIZE*6) {
        *(uint32_t*)data = MAGIC_SPARSE; data += 4;
        *(uint32_t*)data = nonzeros; data += 4;

        memset(data, 0, ((nonzeros*(PBITS+6)+7)>>3)*sizeof(*data));

        uint8_t bit_offset = 0;
        for(uint32_t i = 0; i < HLL<PBITS>::SIZE; ++i) {
            if(hr[i]!=0) {
                write_bits(data, bit_offset, PBITS, i);
                write_bits(data, bit_offset, 6, hr[i]);
            }
        }
        if(bit_offset!=0) data++;
    }
    else {
        *(uint32_t*)data = MAGIC_DENSE; data += 4;

        for(uint32_t i = 0; i < HLL<PBITS>::SIZE/4; ++i) {
            data[0] = (hr[4*i]<<2)|((hr[4*i+1]>>4)&3);
            data[1] = (hr[4*i+1]<<4)|((hr[4*i+2]>>2)&15);
            data[2] = (hr[4*i+2]<<6)|(hr[4*i+3]&63);
            data += 3;
        }
    }

    *(uint32_t*)data = hll.seed; data += 4;
    len = data - begin;
}

template <uint32_t PBITS>
HLL<PBITS> HLLSerializer<PBITS>::deserialize(const uint8_t * data) {
    HLL<PBITS> hll;
    auto & hr = hll.registers;

    uint32_t magic = *(uint32_t*)data; data += 4;

    if(magic == MAGIC_SPARSE) {
        uint32_t nonzeros = *(uint32_t*)data; data += 4;
        uint8_t bit_offset = 0;
        for(uint32_t z = 0; z < nonzeros; ++z) {
            uint32_t i = read_bits(data, bit_offset, PBITS);
            hr[i] = read_bits(data, bit_offset, 6);
        }
        if(bit_offset!=0) data++;
    }
    else if(magic == MAGIC_DENSE) {
        for(uint32_t i = 0; i < HLL<PBITS>::SIZE/4; ++i) {
            hr[4*i] = data[0]>>2;
            hr[4*i+1] = ((data[0]&3)<<4)|(data[1]>>4);
            hr[4*i+2] = ((data[1]&15)<<2)|(data[2]>>6);
            hr[4*i+3] = data[2]&63;
            data += 3;
        }
    } else {
        throw std::runtime_error("HLL: Unknown magic number.");
    }

    hll.seed = *(uint32_t*)data;
    return hll;
}