from libc.stdint cimport uint8_t, uint32_t

cimport hll
from hll cimport HLL

cdef extern from "hll_serializer.h":
    cdef cppclass HLLSerializer "HLLSerializer<10>":
        @staticmethod
        void serialize(const HLL & hll, uint8_t * data, uint32_t & len);

        @staticmethod
        HLL deserialize(const uint8_t * data);
