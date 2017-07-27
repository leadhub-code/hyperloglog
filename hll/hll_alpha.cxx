#include "hll_alpha.h"

template <uint32_t PBITS> constexpr std::array<double, 1> HLLBiasEstimatorData<PBITS>::bias;
template <uint32_t PBITS> constexpr std::array<double, 1> HLLBiasEstimatorData<PBITS>::corr;

constexpr const std::array<double, 200> HLLBiasEstimatorData<10>::bias;
constexpr const std::array<double, 200> HLLBiasEstimatorData<10>::corr;
