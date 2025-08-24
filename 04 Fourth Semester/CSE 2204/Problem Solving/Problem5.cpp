#include <iostream>
using namespace std;

int main() {
  int test;
  cin >> test;

  int num;
  int sum = 0;
  while (test--) {
    cin >> num;
    while (num != 0) {
      sum += num % 10;
      num = num / 10;
    }
    cout << sum << endl;;
    sum = 0;
  }

  return 0;
}