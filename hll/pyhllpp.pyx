from libc.stdint cimport uint8_t, uint32_t
from libc.stdlib cimport malloc, free

from cpython cimport array
import array

from hll cimport HLL as c_HLL
from hll cimport HLL11 as c_HLL11
from hll cimport HLL12 as c_HLL12
from hll cimport HLL13 as c_HLL13
from hll cimport HLL14 as c_HLL14
from hll cimport HLL15 as c_HLL15
from hll cimport HLL16 as c_HLL16
from hll cimport HLL17 as c_HLL17
from hll cimport HLL18 as c_HLL18
from hll_serializer cimport HLLSerializer as c_HLLSerializer
from hll_serializer cimport HLLSerializer11 as c_HLLSerializer11
from hll_serializer cimport HLLSerializer12 as c_HLLSerializer12
from hll_serializer cimport HLLSerializer13 as c_HLLSerializer13
from hll_serializer cimport HLLSerializer14 as c_HLLSerializer14
from hll_serializer cimport HLLSerializer15 as c_HLLSerializer15
from hll_serializer cimport HLLSerializer16 as c_HLLSerializer16
from hll_serializer cimport HLLSerializer17 as c_HLLSerializer17
from hll_serializer cimport HLLSerializer18 as c_HLLSerializer18

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
        if op == 2: # ==
            return (<HLL>x)._c_hll[0] == (<HLL>y)._c_hll[0]
        else:
            raise Exception('Operation not supported')

    def serialize(self):
        cdef uint8_t * buffer = <uint8_t*> malloc((1024+8)*sizeof(uint8_t))
        cdef uint32_t len = 0
        c_HLLSerializer.serialize(self._c_hll[0], <uint8_t*>buffer, len)
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

cdef class HLL11:
    cdef c_HLL11 * _c_hll

    def __init__(self, uint32_t seed):
        self._c_hll = new c_HLL11(seed)

    def __dealloc__(self):
        del self._c_hll

    def insert(self, key):
        self._c_hll.insert(key.encode(), len(key))

    def count(self):
        return self._c_hll.count()

    def merge(self, other):
        self._c_hll.merge((<HLL11>other)._c_hll[0])

    def __richcmp__(x,y,op):
        if op == 2: # ==
            return (<HLL11>x)._c_hll[0] == (<HLL11>y)._c_hll[0]
        else:
            raise Exception('Operation not supported')

    def serialize(self):
        cdef uint8_t * buffer = <uint8_t*> malloc((1024*1024+8)*sizeof(uint8_t))
        cdef uint32_t len = 0
        c_HLLSerializer11.serialize(self._c_hll[0], <uint8_t*>buffer, len)
        ba = bytearray()
        for i in range(len):
            ba.append(buffer[i])
        free(buffer)
        return bytes(ba)

    @staticmethod
    def deserialize(data):
        cdef uint8_t * buffer = <uint8_t*> malloc((1024*1024+8)*sizeof(uint8_t))
        for i in range(len(data)):
            buffer[i]=data[i]
        HLL_obj = HLL11.__new__(HLL11)
        (<HLL11>HLL_obj)._c_hll = new c_HLL11(c_HLLSerializer11.deserialize(<uint8_t*>buffer))
        free(buffer)
        return HLL_obj

cdef class HLL12:
    cdef c_HLL12 * _c_hll

    def __init__(self, uint32_t seed):
        self._c_hll = new c_HLL12(seed)

    def __dealloc__(self):
        del self._c_hll

    def insert(self, key):
        self._c_hll.insert(key.encode(), len(key))

    def count(self):
        return self._c_hll.count()

    def merge(self, other):
        self._c_hll.merge((<HLL12>other)._c_hll[0])

    def __richcmp__(x,y,op):
        if op == 2: # ==
            return (<HLL12>x)._c_hll[0] == (<HLL12>y)._c_hll[0]
        else:
            raise Exception('Operation not supported')

    def serialize(self):
        cdef uint8_t * buffer = <uint8_t*> malloc((1024*1024+8)*sizeof(uint8_t))
        cdef uint32_t len = 0
        c_HLLSerializer12.serialize(self._c_hll[0], <uint8_t*>buffer, len)
        ba = bytearray()
        for i in range(len):
            ba.append(buffer[i])
        free(buffer)
        return bytes(ba)

    @staticmethod
    def deserialize(data):
        cdef uint8_t * buffer = <uint8_t*> malloc((1024*1024+8)*sizeof(uint8_t))
        for i in range(len(data)):
            buffer[i]=data[i]
        HLL_obj = HLL12.__new__(HLL12)
        (<HLL12>HLL_obj)._c_hll = new c_HLL12(c_HLLSerializer12.deserialize(<uint8_t*>buffer))
        free(buffer)
        return HLL_obj

cdef class HLL13:
    cdef c_HLL13 * _c_hll

    def __init__(self, uint32_t seed):
        self._c_hll = new c_HLL13(seed)

    def __dealloc__(self):
        del self._c_hll

    def insert(self, key):
        self._c_hll.insert(key.encode(), len(key))

    def count(self):
        return self._c_hll.count()

    def merge(self, other):
        self._c_hll.merge((<HLL13>other)._c_hll[0])

    def __richcmp__(x,y,op):
        if op == 2: # ==
            return (<HLL13>x)._c_hll[0] == (<HLL13>y)._c_hll[0]
        else:
            raise Exception('Operation not supported')

    def serialize(self):
        cdef uint8_t * buffer = <uint8_t*> malloc((1024*1024+8)*sizeof(uint8_t))
        cdef uint32_t len = 0
        c_HLLSerializer13.serialize(self._c_hll[0], <uint8_t*>buffer, len)
        ba = bytearray()
        for i in range(len):
            ba.append(buffer[i])
        free(buffer)
        return bytes(ba)

    @staticmethod
    def deserialize(data):
        cdef uint8_t * buffer = <uint8_t*> malloc((1024*1024+8)*sizeof(uint8_t))
        for i in range(len(data)):
            buffer[i]=data[i]
        HLL_obj = HLL13.__new__(HLL13)
        (<HLL13>HLL_obj)._c_hll = new c_HLL13(c_HLLSerializer13.deserialize(<uint8_t*>buffer))
        free(buffer)
        return HLL_obj

cdef class HLL14:
    cdef c_HLL14 * _c_hll

    def __init__(self, uint32_t seed):
        self._c_hll = new c_HLL14(seed)

    def __dealloc__(self):
        del self._c_hll

    def insert(self, key):
        self._c_hll.insert(key.encode(), len(key))

    def count(self):
        return self._c_hll.count()

    def merge(self, other):
        self._c_hll.merge((<HLL14>other)._c_hll[0])

    def __richcmp__(x,y,op):
        if op == 2: # ==
            return (<HLL14>x)._c_hll[0] == (<HLL14>y)._c_hll[0]
        else:
            raise Exception('Operation not supported')

    def serialize(self):
        cdef uint8_t * buffer = <uint8_t*> malloc((1024*1024+8)*sizeof(uint8_t))
        cdef uint32_t len = 0
        c_HLLSerializer14.serialize(self._c_hll[0], <uint8_t*>buffer, len)
        ba = bytearray()
        for i in range(len):
            ba.append(buffer[i])
        free(buffer)
        return bytes(ba)

    @staticmethod
    def deserialize(data):
        cdef uint8_t * buffer = <uint8_t*> malloc((1024*1024+8)*sizeof(uint8_t))
        for i in range(len(data)):
            buffer[i]=data[i]
        HLL_obj = HLL14.__new__(HLL14)
        (<HLL14>HLL_obj)._c_hll = new c_HLL14(c_HLLSerializer14.deserialize(<uint8_t*>buffer))
        free(buffer)
        return HLL_obj

cdef class HLL15:
    cdef c_HLL15 * _c_hll

    def __init__(self, uint32_t seed):
        self._c_hll = new c_HLL15(seed)

    def __dealloc__(self):
        del self._c_hll

    def insert(self, key):
        self._c_hll.insert(key.encode(), len(key))

    def count(self):
        return self._c_hll.count()

    def merge(self, other):
        self._c_hll.merge((<HLL15>other)._c_hll[0])

    def __richcmp__(x,y,op):
        if op == 2: # ==
            return (<HLL15>x)._c_hll[0] == (<HLL15>y)._c_hll[0]
        else:
            raise Exception('Operation not supported')

    def serialize(self):
        cdef uint8_t * buffer = <uint8_t*> malloc((1024*1024+8)*sizeof(uint8_t))
        cdef uint32_t len = 0
        c_HLLSerializer15.serialize(self._c_hll[0], <uint8_t*>buffer, len)
        ba = bytearray()
        for i in range(len):
            ba.append(buffer[i])
        free(buffer)
        return bytes(ba)

    @staticmethod
    def deserialize(data):
        cdef uint8_t * buffer = <uint8_t*> malloc((1024*1024+8)*sizeof(uint8_t))
        for i in range(len(data)):
            buffer[i]=data[i]
        HLL_obj = HLL15.__new__(HLL15)
        (<HLL15>HLL_obj)._c_hll = new c_HLL15(c_HLLSerializer15.deserialize(<uint8_t*>buffer))
        free(buffer)
        return HLL_obj

cdef class HLL16:
    cdef c_HLL16 * _c_hll

    def __init__(self, uint32_t seed):
        self._c_hll = new c_HLL16(seed)

    def __dealloc__(self):
        del self._c_hll

    def insert(self, key):
        self._c_hll.insert(key.encode(), len(key))

    def count(self):
        return self._c_hll.count()

    def merge(self, other):
        self._c_hll.merge((<HLL16>other)._c_hll[0])

    def __richcmp__(x,y,op):
        if op == 2: # ==
            return (<HLL16>x)._c_hll[0] == (<HLL16>y)._c_hll[0]
        else:
            raise Exception('Operation not supported')

    def serialize(self):
        cdef uint8_t * buffer = <uint8_t*> malloc((1024*1024+8)*sizeof(uint8_t))
        cdef uint32_t len = 0
        c_HLLSerializer16.serialize(self._c_hll[0], <uint8_t*>buffer, len)
        ba = bytearray()
        for i in range(len):
            ba.append(buffer[i])
        free(buffer)
        return bytes(ba)

    @staticmethod
    def deserialize(data):
        cdef uint8_t * buffer = <uint8_t*> malloc((1024*1024+8)*sizeof(uint8_t))
        for i in range(len(data)):
            buffer[i]=data[i]
        HLL_obj = HLL16.__new__(HLL16)
        (<HLL16>HLL_obj)._c_hll = new c_HLL16(c_HLLSerializer16.deserialize(<uint8_t*>buffer))
        free(buffer)
        return HLL_obj

cdef class HLL17:
    cdef c_HLL17 * _c_hll

    def __init__(self, uint32_t seed):
        self._c_hll = new c_HLL17(seed)

    def __dealloc__(self):
        del self._c_hll

    def insert(self, key):
        self._c_hll.insert(key.encode(), len(key))

    def count(self):
        return self._c_hll.count()

    def merge(self, other):
        self._c_hll.merge((<HLL17>other)._c_hll[0])

    def __richcmp__(x,y,op):
        if op == 2: # ==
            return (<HLL17>x)._c_hll[0] == (<HLL17>y)._c_hll[0]
        else:
            raise Exception('Operation not supported')

    def serialize(self):
        cdef uint8_t * buffer = <uint8_t*> malloc((1024*1024+8)*sizeof(uint8_t))
        cdef uint32_t len = 0
        c_HLLSerializer17.serialize(self._c_hll[0], <uint8_t*>buffer, len)
        ba = bytearray()
        for i in range(len):
            ba.append(buffer[i])
        free(buffer)
        return bytes(ba)

    @staticmethod
    def deserialize(data):
        cdef uint8_t * buffer = <uint8_t*> malloc((1024*1024+8)*sizeof(uint8_t))
        for i in range(len(data)):
            buffer[i]=data[i]
        HLL_obj = HLL17.__new__(HLL17)
        (<HLL17>HLL_obj)._c_hll = new c_HLL17(c_HLLSerializer17.deserialize(<uint8_t*>buffer))
        free(buffer)
        return HLL_obj

cdef class HLL18:
    cdef c_HLL18 * _c_hll

    def __init__(self, uint32_t seed):
        self._c_hll = new c_HLL18(seed)

    def __dealloc__(self):
        del self._c_hll

    def insert(self, key):
        self._c_hll.insert(key.encode(), len(key))

    def count(self):
        return self._c_hll.count()

    def merge(self, other):
        self._c_hll.merge((<HLL18>other)._c_hll[0])

    def __richcmp__(x,y,op):
        if op == 2: # ==
            return (<HLL18>x)._c_hll[0] == (<HLL18>y)._c_hll[0]
        else:
            raise Exception('Operation not supported')

    def serialize(self):
        cdef uint8_t * buffer = <uint8_t*> malloc((1024*1024+8)*sizeof(uint8_t))
        cdef uint32_t len = 0
        c_HLLSerializer18.serialize(self._c_hll[0], <uint8_t*>buffer, len)
        ba = bytearray()
        for i in range(len):
            ba.append(buffer[i])
        free(buffer)
        return bytes(ba)

    @staticmethod
    def deserialize(data):
        cdef uint8_t * buffer = <uint8_t*> malloc((1024*1024+8)*sizeof(uint8_t))
        for i in range(len(data)):
            buffer[i]=data[i]
        HLL_obj = HLL18.__new__(HLL18)
        (<HLL18>HLL_obj)._c_hll = new c_HLL18(c_HLLSerializer18.deserialize(<uint8_t*>buffer))
        free(buffer)
        return HLL_obj
