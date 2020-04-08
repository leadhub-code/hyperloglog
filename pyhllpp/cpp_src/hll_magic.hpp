//------------------------------------------------------------------------------------
// Values taken from apendix of: https://stefanheule.com/papers/edbt13-hyperloglog.pdf
//------------------------------------------------------------------------------------

#ifndef _HLL_MAGIC_HPP
#define _HLL_MAGIC_HPP

#include <algorithm>
#include <array>

namespace hll {

struct HLLMagic {
    static double get_alpha(uint32_t precision);
    static double get_threshold(uint32_t precision);
    static double get_unbiased_estimate(uint32_t precision, double estimate);

    static const double       biases[15][201];
    static const double     unbiases[15][201];
    static const uint32_t bias_sizes[15];
};

}

#endif
