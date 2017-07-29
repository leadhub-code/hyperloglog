import sys
# Add the ptdraft folder path to the sys.path list
sys.path.append('..')
sys.path.append('.')

from pyhllpp import HLL
from pyhllpp import HLL11
from pyhllpp import HLL12
from pyhllpp import HLL13
from pyhllpp import HLL14
from pyhllpp import HLL15
from pyhllpp import HLL16
from pyhllpp import HLL17
from pyhllpp import HLL18

variants = [HLL, HLL11, HLL12, HLL13, HLL14, HLL15, HLL16, HLL17, HLL18]

for v in variants:
    h = v(42)
    assert h.count() == 0
    h.insert('foo')
    assert h.count() == 1
    for i in range(100000):
        h.insert(str(i))
    s = h.serialize()
    h2 = v.deserialize(s)
    assert h2 is not h
    assert h2 == h
    assert h2.count() == h.count()
    print(v, len(s))
