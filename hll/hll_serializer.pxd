from libc.stdint cimport uint8_t, uint32_t

cimport hll
from hll cimport HLL

cdef extern from "hll_serializer.h":

    cdef cppclass HLLSerializer "hll::HLLSerializer":

        @staticmethod
        uint32_t serialize_buffer_size(const HLL & hll) except +

        @staticmethod
        void serialize(const HLL & hll, uint8_t * data, uint32_t & len) except +

        # should be marked except +, but there is a problem with cython compilation creating default constructed object before try/except block
        @staticmethod
        HLL deserialize(const uint8_t * data)
