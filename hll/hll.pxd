from libc.stdint cimport uint8_t, uint32_t, uint64_t
from libcpp.string cimport string

cdef extern from "hll.h":

    cdef cppclass HLL "HLL<10>":
        HLL(uint32_t seed) except +
        HLL(const HLL & other) except +
        void insert(uint8_t * key, size_t len) except +
        uint64_t count() except +
        void merge(const HLL & other) except +
        operator==(const HLL & other) except +

    cdef cppclass HLL11 "HLL<11>":
        HLL11(uint32_t seed) except +
        HLL11(const HLL11 & other) except +
        void insert(uint8_t * key, size_t len) except +
        uint64_t count() except +
        void merge(const HLL11 & other) except +
        operator==(const HLL11 & other) except +

    cdef cppclass HLL12 "HLL<12>":
        HLL12(uint32_t seed) except +
        HLL12(const HLL12 & other) except +
        void insert(uint8_t * key, size_t len) except +
        uint64_t count() except +
        void merge(const HLL12 & other) except +
        operator==(const HLL12 & other) except +

    cdef cppclass HLL13 "HLL<13>":
        HLL13(uint32_t seed) except +
        HLL13(const HLL13 & other) except +
        void insert(uint8_t * key, size_t len) except +
        uint64_t count() except +
        void merge(const HLL13 & other) except +
        operator==(const HLL13 & other) except +

    cdef cppclass HLL14 "HLL<14>":
        HLL14(uint32_t seed) except +
        HLL14(const HLL14 & other) except +
        void insert(uint8_t * key, size_t len) except +
        uint64_t count() except +
        void merge(const HLL14 & other) except +
        operator==(const HLL14 & other) except +

    cdef cppclass HLL15 "HLL<15>":
        HLL15(uint32_t seed) except +
        HLL15(const HLL15 & other) except +
        void insert(uint8_t * key, size_t len) except +
        uint64_t count() except +
        void merge(const HLL15 & other) except +
        operator==(const HLL15 & other) except +

    cdef cppclass HLL16 "HLL<16>":
        HLL16(uint32_t seed) except +
        HLL16(const HLL16 & other) except +
        void insert(uint8_t * key, size_t len) except +
        uint64_t count() except +
        void merge(const HLL16 & other) except +
        operator==(const HLL16 & other) except +

    cdef cppclass HLL17 "HLL<17>":
        HLL17(uint32_t seed) except +
        HLL17(const HLL17 & other) except +
        void insert(uint8_t * key, size_t len) except +
        uint64_t count() except +
        void merge(const HLL17 & other) except +
        operator==(const HLL17 & other) except +

    cdef cppclass HLL18 "HLL<18>":
        HLL18(uint32_t seed) except +
        HLL18(const HLL18 & other) except +
        void insert(uint8_t * key, size_t len) except +
        uint64_t count() except +
        void merge(const HLL18 & other) except +
        operator==(const HLL18 & other) except +
