#include <iostream>
#include <bitset>
#include <cstdio>
#include <cassert>
#include <set>
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

template<int PBITS>
void test() {
    srand(666);
    cout<<"test: "<<PBITS<<endl;

    HLL<PBITS> hll(0xdeadbeef);
    set<string> leset;

    double max_deviation = 0;

    for(int i = 0; i<100000; ++i) {
        string data;
        for(int z = 0; z < 10; ++z)
            data+=rand()%10+'0';

        hll.insert((const uint8_t *)data.c_str(), data.size());
        leset.insert(data);

        int64_t cc = hll.count();

        max_deviation = max(max_deviation, abs(cc - (int64_t)leset.size()) / (double)leset.size());

        if(max_deviation > 1e6)
            assert(0);

    }
    cout<<"max deviation: "<< max_deviation<<endl;
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