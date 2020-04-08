#include <cstring>
#include <cmath>
#include <stdexcept>

#include "hll.hpp"
#include "hll_magic.hpp"
#include "murmur.hpp"

namespace hll {

// SONGNOTE: only for cython except +
_HLL::_HLL() : precision(0), size(1), seed(0) {
    registers = new register_type[size];
}

_HLL::_HLL(uint32_t precision, uint32_t seed) : precision(precision), size(1<<precision), seed(seed) {
    registers = new register_type[size];
    memset(registers, 0, sizeof(register_type) * size);
}

_HLL::_HLL(const _HLL & other) : precision(other.precision), size(other.size), seed(other.seed) {
    registers = new register_type[size];
    memcpy(registers, other.registers, sizeof(register_type) * size);
}

_HLL & _HLL::operator = (const _HLL & other) {
    if(this == &other)
        return *this;

    delete[] registers;

    precision = other.precision;
    size = other.size;
    seed = other.seed;

    registers = new register_type[size];
    memcpy(registers, other.registers, sizeof(register_type) * size);
    return *this;
}


_HLL::~_HLL() {
    delete[] registers;
}

void _HLL::insert(const uint8_t * key, uint32_t key_len) {
    uint64_t h = MurmurHash64A(key, key_len, seed);
    int idx = h >> (sizeof(uint64_t) * 8 - precision);
    uint8_t ro = (h ? __builtin_clzll((h << precision) >> precision) : sizeof(uint64_t) * 8) - precision + 1;
    registers[idx] = std::max(registers[idx], ro);
}

uint64_t _HLL::count() const {
    double sum = 0;
    for(uint32_t i = 0; i < size; ++i) sum += pow(2, -registers[i]);
    double estimate = HLLMagic::get_alpha(precision) * size * size / sum;

    double corr_estimate = estimate < 5*size ? HLLMagic::get_unbiased_estimate(precision, estimate) : estimate;

    uint32_t zeros = 0;
    for(uint32_t i = 0; i < size; ++i) zeros += !registers[i];

    double lin_count_estimate = corr_estimate;

    if(zeros != 0)
        lin_count_estimate = size * log(size / (double) zeros);

    if(lin_count_estimate < HLLMagic::get_threshold(precision))
        return lin_count_estimate;
    else
        return corr_estimate;
}

void _HLL::merge(const _HLL & other) {
    if(precision != other.precision)
        throw std::runtime_error("Precisions of HLLs must match in order to merge");

    for(uint32_t i = 0; i < size; ++i)
        registers[i] = std::max(registers[i], other.registers[i]);
}

bool _HLL::operator==(const _HLL & other) const {
    if(precision != other.precision || seed != other.seed) return 0;
    return !memcmp(registers, other.registers, sizeof(register_type) * size);
}

}
