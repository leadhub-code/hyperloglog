import sys
# Add the ptdraft folder path to the sys.path list
sys.path.append('..')
sys.path.append('.')

import uuid

from pyhllpp import HLL, HLLSerializer

for prec in range(4, 15):

    hll = HLL(prec, 666)

    for i in range(50000):
        data = HLLSerializer.serialize(hll)
        hll_d = HLLSerializer.deserialize(data)

        if not hll.equals(hll_d):
            raise Exception("fail")

        hll.insert(str(uuid.uuid4()))

    print("precision " + str(prec) + " OK")

print("Python OK")
