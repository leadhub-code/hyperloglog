#pragma once

template <uint32_t PBITS>
struct HLLAlpha {
    constexpr static double ALPHA = 0.7213/(1.0 + 1.079/(double)(1<<PBITS));
};

template <>
struct HLLAlpha<4> { constexpr static double ALPHA = 0.673; };

template <>
struct HLLAlpha<5> { constexpr static double ALPHA = 0.697; };

template <>
struct HLLAlpha<6> { constexpr static double ALPHA = 0.709; };