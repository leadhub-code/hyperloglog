#include <iostream>
#include <iomanip>
#include <bitset>
#include <cstdio>
#include <cassert>
#include <set>

#include "../pyhllpp/cpp_src/hll_serializer.hpp"

using namespace std;
using namespace hll;

#define D(x) std::cout<<#x<<": "<<std::endl<<">>>  "<<x<<std::endl;

void print(const _HLL & hll) {
    for(unsigned i = 0; i < hll.size; ++i)
        if(hll.registers[i] != 0)
            cout<<i <<' '<<(int)hll.registers[i]<<endl;
}

void print_buff(const uint8_t * buff, int len){
    for(int i = 0; i < len; ++i)
        cout<<bitset<8>(buff[i])<<' ';
    cout<<endl;
}

void test(int precision) {
    srand(666);
    cout << "test: " << std::setw(2) << precision << endl;

    _HLL hll(precision, 0xdeadbeef);
    set<string> leset;

    double max_deviation = 0;

    for(int i = 0; i<5000; ++i) {
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

    for(int i = 4; i < 19; ++i)
        test(i);

    return 0;
}
