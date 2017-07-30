from libcpp cimport bool
from libc.stdint cimport uint8_t, uint32_t, uint64_t

cdef extern from "hll.h":

    cdef cppclass HLL "hll::HLL":

        HLL(uint32_t precision, uint32_t seed) except +
        HLL(const HLL & other) except +
        operator=(const HLL & other) except +

        void insert(const uint8_t * key, uint32_t key_len) except +
        bool equals(const HLL & other) except +
        uint64_t count() except +
        void merge(const HLL & other) except +
        bool operator==(const HLL & other) except +
