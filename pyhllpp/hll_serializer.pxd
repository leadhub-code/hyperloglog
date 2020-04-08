from hll cimport _HLL
from libc.stdint cimport uint8_t, uint32_t

cdef extern from "cpp_src/hll_serializer.cpp" namespace "hll":
    pass

cdef extern from "cpp_src/hll_serializer.hpp" namespace "hll":
    cdef cppclass _HLLSerializer:
        @staticmethod
        uint32_t serialize_buffer_size(const _HLL & hll) except +

        @staticmethod
        void serialize(const _HLL & hll, uint8_t * data, uint32_t & len) except +

        @staticmethod
        _HLL deserialize(const uint8_t * data) except +
