from libc.stdint cimport uint8_t, uint32_t
from libc.stdlib cimport malloc, free


from cpython cimport array
import array

from hll cimport HLL as c_HLL
from hll_serializer cimport HLLSerializer as c_HLLSerializer

cdef class HLL:
    cdef c_HLL * _c_hll

    def __init__(self, uint32_t seed):
        self._c_hll = new c_HLL(seed)

    def __dealloc__(self):
        del self._c_hll

    def insert(self, key):
        self._c_hll.insert(key.encode(), len(key))

    def count(self):
        return self._c_hll.count()

    def merge(self, other):
        self._c_hll.merge((<HLL>other)._c_hll[0])

    def __richcmp__(x,y,op):
        if op == 2:
            return (<HLL>x)._c_hll[0] == (<HLL>y)._c_hll[0]
        else:
            assert False

cdef class HLLSerializer:

    @staticmethod
    def serialize(hll):
        cdef uint8_t * buffer = <uint8_t*> malloc((1024+8)*sizeof(uint8_t))
        cdef uint32_t len = 0

        c_HLLSerializer.serialize((<HLL>hll)._c_hll[0], <uint8_t*>buffer, len)

        ba = bytearray()
        for i in range(len):
            ba.append(buffer[i])

        free(buffer)

        return bytes(ba)

    @staticmethod
    def deserialize(data):
        cdef uint8_t * buffer = <uint8_t*> malloc((1024+8)*sizeof(uint8_t))

        for i in range(len(data)):
            buffer[i]=data[i]

        HLL_obj = HLL.__new__(HLL)
        (<HLL>HLL_obj)._c_hll = new c_HLL(c_HLLSerializer.deserialize(<uint8_t*>buffer))

        free(buffer)

        return HLL_obj
