#include <iostream>
#include <stdlib.h>
#include <sstream>

using namespace std;

int main(int argc, char *argv[]) {
        int max=1, i;

        if (argc < 2) {
                cout << "Usage: ./reclamation <number of pages>" << endl;
                return 0;
        }
        istringstream ss(argv[1]);
        if (!(ss >> max)) {
                cerr << "Invalid number of pages: " << argv[1] << endl;
                return 1;
        }

        if (max <= 0){
                cerr << "Number of pages must be greater than 0." << endl;
                return 1;
        }

        for (i=0; i<max; i++){
                malloc(4096);
        }

        cout << "Allocated " << max << " pages of 4096 bytes." << endl;
        cout << "Total memory allocated: " << max*4096 << " bytes." << endl;

        return 0;
}
