from libc.stdint cimport uint8_t, uint32_t
from libc.stdlib cimport malloc, free
from cpython cimport array
from cython.operator cimport dereference as deref

from hll cimport _HLL as c_HLL
from hll_serializer cimport _HLLSerializer as c_HLLSerializer
cimport hll_magic

cdef class HLL:
    cdef c_HLL * _c_hll

    def __init__(self, uint32_t precision, uint32_t seed):
        self._c_hll = new c_HLL(precision, seed)

    def __dealloc__(self):
        del self._c_hll

    def insert(self, key):
        self._c_hll.insert(key.encode(), len(key))

    def count(self):
        return self._c_hll.count()

    def merge(self, other):
        self._c_hll.merge(deref((<HLL>other)._c_hll))

    def equals(self, other):
        return deref(self._c_hll) == deref((<HLL>other)._c_hll)

cdef class HLLSerializer:

    @staticmethod
    def serialize(hll):
        cdef c_HLL * hll_ptr = (<HLL>hll)._c_hll
        cdef uint32_t buffer_size = c_HLLSerializer.serialize_buffer_size(deref(hll_ptr))

        cdef uint8_t * buffer = <uint8_t*> malloc(buffer_size)
        cdef uint32_t len = 0

        c_HLLSerializer.serialize(deref(hll_ptr), <uint8_t*>buffer, len)

        ba = bytearray()
        for i in range(len):
            ba.append(buffer[i])

        free(buffer)

        return bytes(ba)

    @staticmethod
    def deserialize(pybuffer):
        cdef uint8_t * buffer = <uint8_t*> malloc(len(pybuffer)*sizeof(uint8_t))

        for i in range(len(pybuffer)):
            buffer[i]=pybuffer[i]

        HLL_obj = HLL.__new__(HLL)
        (<HLL>HLL_obj)._c_hll = new c_HLL(c_HLLSerializer.deserialize(<uint8_t*>buffer))

        free(buffer)

        return HLL_obj
