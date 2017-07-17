from libc.stdint cimport uint8_t

from hll cimport HLL as c_HLL

cdef class HLL:
    cdef c_HLL * _c_hll

    def __cinit__(self, seed):
        self._c_hll = new c_HLL(seed)
    def __dealloc__(self):
        del self._c_hll

    def insert(self, key):
        self._c_hll.insert(key.encode(), len(key))

    def count(self):
        return self._c_hll.count()

    def merge(self, other):
        self._c_hll.merge((<HLL>other)._c_hll[0])