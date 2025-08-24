#include <iostream>
using namespace std;

int main() {
  int test;
  cin >> test;

  int input;
  while (test--) {
    cin >> input;
    if (input < 10) {
      cout << "Thanks for helping Chef!" << endl;
    }
    else {
      cout << "-1" << endl;
    }
  }

  return 0;
}