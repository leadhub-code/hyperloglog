from libcpp cimport bool
from libc.stdint cimport uint8_t, uint32_t, uint64_t

cdef extern from "cpp_src/hll.cpp" namespace "hll":
    pass

cdef extern from "cpp_src/hll.hpp" namespace "hll":
    cdef cppclass _HLL:
        _HLL(uint32_t precision, uint32_t seed) except +
        _HLL(const _HLL & other) except +
        operator=(const _HLL & other) except +

        void insert(const uint8_t * key, uint32_t key_len) except +
        bool equals(const _HLL & other) except +
        uint64_t count() except +
        void merge(const _HLL & other) except +
        bool operator==(const _HLL & other) except +
