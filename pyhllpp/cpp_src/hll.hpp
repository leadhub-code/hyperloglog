//-----------------------------------------------------------------------------
// Implemented from: https://stefanheule.com/papers/edbt13-hyperloglog.pdf
//-----------------------------------------------------------------------------

#ifndef _HLL_HPP
#define _HLL_HPP

#include <cstdint>

namespace hll {

struct _HLL {
    using register_type = uint8_t;

    uint32_t precision, size, seed;
    register_type * registers;

public:
    _HLL();
    _HLL(uint32_t precision, uint32_t seed);
    _HLL(const _HLL &);
    _HLL & operator = (const _HLL &);
    ~_HLL();

    void insert(const uint8_t * key, uint32_t key_len);
    uint64_t count() const;
    void merge(const _HLL & other);
    bool operator==(const _HLL & other) const;
};

}

#endif
