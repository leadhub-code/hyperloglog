from libc.stdint cimport uint8_t, uint32_t, uint64_t

cdef extern from "hll.h":
    cdef cppclass HLL "HLL<10>":
        HLL(uint32_t seed) except +
        void insert(uint8_t * key, size_t len) except +
        uint64_t count() except +
        void merge(const HLL & other) except +
