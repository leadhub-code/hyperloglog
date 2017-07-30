//-----------------------------------------------------------------------------
// Implemented from: https://stefanheule.com/papers/edbt13-hyperloglog.pdf
//-----------------------------------------------------------------------------

#pragma once

#include <cstdint>

namespace hll {

struct HLL {
    using register_type = uint8_t;

    uint32_t precision, size, seed;
    register_type * registers;

public:
    HLL(uint32_t precision, uint32_t seed);
    HLL(const HLL &);
    HLL & operator = (const HLL &);
    ~HLL();

    void insert(const uint8_t * key, uint32_t key_len);
    uint64_t count() const;
    void merge(const HLL & other);
    bool operator==(const HLL & other) const;
};

}
