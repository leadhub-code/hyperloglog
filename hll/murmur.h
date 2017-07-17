#pragma once

#include <cstring>
#include <cstdint>

uint64_t MurmurHash64A ( const uint8_t * key, size_t len, uint32_t seed );

