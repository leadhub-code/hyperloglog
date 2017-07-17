//-----------------------------------------------------------------------------
// Implemented from: https://stefanheule.com/papers/edbt13-hyperloglog.pdf
//-----------------------------------------------------------------------------

#pragma once

#include <cstring>
#include <cstdint>
#include <cmath>
#include <algorithm>
#include "hll_alpha.h"
#include "murmur.h"

template <uint32_t PBITS>
struct HLL {
    constexpr static uint32_t SIZE = 1<<PBITS;
    constexpr static double ALPHA = HLLAlpha<PBITS>::ALPHA;

    uint32_t seed;
    uint8_t registers[SIZE];

public:
    HLL(uint32_t seed = 0);

    void insert(const uint8_t * data, size_t len);
    uint64_t count() const;
    void merge(const HLL & other);

    bool operator == (const HLL<PBITS> &) const;
    HLL<PBITS> & operator += (const HLL<PBITS> &);
};

template<uint32_t PBITS>
HLL<PBITS>::HLL(uint32_t seed) : seed(seed) {
    memset(registers, 0, sizeof(*registers)*SIZE);
}

template<uint32_t PBITS>
void HLL<PBITS>::insert(const uint8_t * data, size_t len) {
    uint64_t h = MurmurHash64A(data, len, seed);
    int idx = h >> (sizeof(uint64_t)*8 - PBITS);
    uint8_t ro = (h?__builtin_clzll((h << PBITS) >> PBITS):sizeof(uint64_t) * 8) - PBITS + 1;
    registers[idx] = std::max(registers[idx], ro);
}

template<uint32_t PBITS>
uint64_t HLL<PBITS>::count() const {
    double sum = 0;
    for(uint32_t i = 0; i < SIZE; ++i) sum += pow(2, -registers[i]);
    double estimate = ALPHA * SIZE * SIZE / sum;

    if (estimate <= SIZE * 5 / 2) {
        uint32_t zeros = 0;
        for(uint32_t i = 0; i < SIZE; ++i) zeros += !registers[i];
        if (zeros != 0) estimate = SIZE * log(SIZE / (double) zeros);
    }

    return estimate;
}

template<uint32_t PBITS>
void HLL<PBITS>::merge(const HLL<PBITS> & other) {
    for(uint32_t i = 0; i < SIZE; ++i) {
        registers[i] = std::max(registers[i], other.registers[i]);
    }
}

template<uint32_t PBITS>
bool HLL<PBITS>::operator == (const HLL<PBITS> & other) const {
    for(uint32_t i = 0; i < SIZE; ++i)
        if(registers[i]!=other.registers[i]) return 0;
    return 1;
}

template<uint32_t PBITS>
HLL<PBITS> & HLL<PBITS>::operator += (const HLL<PBITS> & other) {
    merge(other);
    return *this;
}
