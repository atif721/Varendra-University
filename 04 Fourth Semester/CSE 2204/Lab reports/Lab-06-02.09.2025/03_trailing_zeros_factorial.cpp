// trailing zeros in a factorial
#include <iostream>
using namespace std;

int main() {

  int num;
  int count = 0;

  cout << "Enter a number : ";
  cin >> num;

  for (int i = 5; i <= num; i *= 5) {
    count = num / 5;
  }
  cout << "Trailing zeros of " << count << endl;

  return 0;
}