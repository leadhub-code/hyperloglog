#ifndef _HLL_SERIALIZER
#define _HLL_SERIALIZER

#include "hll.hpp"

namespace hll {

struct _HLLSerializer {

    const static uint32_t MAGIC_SPARSE = 0xd37bd4e1;
    const static uint32_t MAGIC_DENSE  = 0xa32fe12c;

    static void write_bits(uint8_t * & dest, uint8_t & bit_offset, uint8_t bits, uint32_t src);
    static uint32_t read_bits(const uint8_t * & src, uint8_t & bit_offset, uint8_t bits);

    static void serialize(const _HLL & hll, uint8_t * data, uint32_t & len);
    static uint32_t serialize_buffer_size(const _HLL & hll);

    static _HLL deserialize(const uint8_t * data);
};

}

#endif
