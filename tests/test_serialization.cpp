#include <iostream>
#include <bitset>
#include <cstdio>
#include <cassert>

#include "../hll/hll_serializer.h"

using namespace std;

#define D(x) std::cout<<#x<<": "<<std::endl<<">>>  "<<x<<std::endl;

template <uint32_t PBITS>
void print(const HLL<PBITS> & hll) {
    for(int i = 0; i < (1<<PBITS); ++i)
        if(hll.registers[i] != 0)
            cout<<i <<' '<<(int)hll.registers[i]<<endl;
}

void print_buff(const uint8_t * buff, int len){
    for(int i = 0; i < len; ++i)
        cout<<bitset<8>(buff[i])<<' ';
    cout<<endl;
}


template <int PBITS>
void test() {
    static uint8_t buffer[HLLSerializer<PBITS>::MIN_BUFFER_SIZE];

    srand(666);
    HLL<PBITS> hll(0xaaaaaaaa);
    HLL<PBITS> hll_d(0xaaaaaaaa);

    cout<<"bits: "<< PBITS<<" => ";
    for(int i = 0; i < 100000; ++i) {
        uint32_t len;
        HLLSerializer<PBITS>::serialize(hll, buffer, len);

        hll_d = HLLSerializer<PBITS>::deserialize(buffer);

        assert(hll == hll_d);
        assert(hll.seed == hll_d.seed);

        uint8_t data[8];
        for(int z = 0; z < 8; ++z)
            data[z] = rand()%256;

        hll.insert(data, 8);
    }
    cout<<"OK"<<endl;
}

int main() {

    test<4>();
    test<6>();
    test<8>();
    test<10>();
    test<12>();
    // test<14>();
    // test<16>();

    return 0;
}
