from libc.stdint cimport uint8_t, uint32_t

cimport hll
from hll cimport HLL
from hll cimport HLL11
from hll cimport HLL12
from hll cimport HLL13
from hll cimport HLL14
from hll cimport HLL15
from hll cimport HLL16
from hll cimport HLL17
from hll cimport HLL18

cdef extern from "hll_serializer.h":

    cdef cppclass HLLSerializer "HLLSerializer<10>":

        @staticmethod
        void serialize(const HLL & hll, uint8_t * data, uint32_t & len);

        @staticmethod
        HLL deserialize(const uint8_t * data);


    cdef cppclass HLLSerializer11 "HLLSerializer<11>":

        @staticmethod
        void serialize(const HLL11 & hll, uint8_t * data, uint32_t & len);

        @staticmethod
        HLL11 deserialize(const uint8_t * data);


    cdef cppclass HLLSerializer12 "HLLSerializer<12>":

        @staticmethod
        void serialize(const HLL12 & hll, uint8_t * data, uint32_t & len);

        @staticmethod
        HLL12 deserialize(const uint8_t * data);


    cdef cppclass HLLSerializer13 "HLLSerializer<13>":

        @staticmethod
        void serialize(const HLL13 & hll, uint8_t * data, uint32_t & len);

        @staticmethod
        HLL13 deserialize(const uint8_t * data);


    cdef cppclass HLLSerializer14 "HLLSerializer<14>":

        @staticmethod
        void serialize(const HLL14 & hll, uint8_t * data, uint32_t & len);

        @staticmethod
        HLL14 deserialize(const uint8_t * data);


    cdef cppclass HLLSerializer15 "HLLSerializer<15>":

        @staticmethod
        void serialize(const HLL15 & hll, uint8_t * data, uint32_t & len);

        @staticmethod
        HLL15 deserialize(const uint8_t * data);


    cdef cppclass HLLSerializer16 "HLLSerializer<16>":

        @staticmethod
        void serialize(const HLL16 & hll, uint8_t * data, uint32_t & len);

        @staticmethod
        HLL16 deserialize(const uint8_t * data);


    cdef cppclass HLLSerializer17 "HLLSerializer<17>":

        @staticmethod
        void serialize(const HLL17 & hll, uint8_t * data, uint32_t & len);

        @staticmethod
        HLL17 deserialize(const uint8_t * data);


    cdef cppclass HLLSerializer18 "HLLSerializer<18>":

        @staticmethod
        void serialize(const HLL18 & hll, uint8_t * data, uint32_t & len);

        @staticmethod
        HLL18 deserialize(const uint8_t * data);
