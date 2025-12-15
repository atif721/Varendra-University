#include <iostream>
using namespace std;

int main() {
  int test;
  cin >> test;

  while (test--) {
    int countZeros = 0, countOnes = 0;

    int length;
    cin >> length;

    string binary;
    cin >> binary;
    for (int i = 0; i < length; i++) {
      if (binary[i] == '0') {
        countZeros++;
      }
    }

    for (int i = 0; i < countZeros; i++) {
      if (binary[i] == '1') {
        countOnes++;
      }
    }

    cout << countOnes << endl;
  }

  return 0;
}