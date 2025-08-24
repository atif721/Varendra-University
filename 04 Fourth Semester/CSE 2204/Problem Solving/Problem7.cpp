#include <iostream>
using namespace std;

int main() {
  int num;
  cin >> num;

  int opt;
  cin >> opt;

  while (opt--) {
    if (num % 10 != 0) {
      num--;
    }
    else {
      num = num / 10;
    }
  }
  cout << num << endl;

  return 0;
}