#include <iostream>
#include <bitset>
#include <cstdio>
#include <cassert>

#include "../hll/hll_serializer.h"

using namespace std;
using namespace hll;

#define D(x) std::cout<<#x<<": "<<std::endl<<">>>  "<<x<<std::endl;

void print(const HLL & hll) {
    for(int i = 0; i < hll.size; ++i)
        if(hll.registers[i] != 0)
            cout<<i <<' '<<(int)hll.registers[i]<<endl;
}

void print_buff(const uint8_t * buff, int len){
    for(int i = 0; i < len; ++i)
        cout<<bitset<8>(buff[i])<<' ';
    cout<<endl;
}

void test(int precision) {
    uint8_t * buffer = new uint8_t[1<<(precision+1)];

    srand(666);
    HLL hll(precision, 0xaaaaaaaa);
    HLL hll_d(precision, 0xaaaaaaaa);

    cout<<"bits: "<< precision<<" => ";
    for(int i = 0; i < 50000; ++i) {
        uint32_t len;
        HLLSerializer::serialize(hll, buffer, len);

        hll_d = HLLSerializer::deserialize(buffer);

        assert(hll == hll_d);
        assert(hll.seed == hll_d.seed);
        assert(hll.precision == hll_d.precision);

        uint8_t data[8];
        for(int z = 0; z < 8; ++z)
            data[z] = rand()%256;

        hll.insert(data, 8);
    }
    cout<<"OK"<<endl;
}

int main() {

    for(int i = 4; i < 19; ++i)
        test(i);

    return 0;
}
