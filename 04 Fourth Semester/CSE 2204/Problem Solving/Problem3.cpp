#include <iostream>
using namespace std;

int main() {
  int test;
  cin >> test;

  int num1;
  int num2;

  while (test--) {
    cin >> num1 >> num2;
    cout << num1 % num2 << endl;
  }

  return 0;
}