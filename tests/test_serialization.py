import sys
# Add the ptdraft folder path to the sys.path list
sys.path.append('..')
sys.path.append('.')

import uuid

from pyhllpp import HLL, HLLSerializer

hll = HLL(666)

for i in range(100000):
    data = HLLSerializer.serialize(hll)
    hll_d = HLLSerializer.deserialize(data)

    if not hll == hll_d:
        raise Exception("fail")

    hll.insert(str(uuid.uuid4()))

print("Python OK")
