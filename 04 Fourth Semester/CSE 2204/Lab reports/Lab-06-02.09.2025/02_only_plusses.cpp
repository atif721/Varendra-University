// only plusses problem

#include <iostream>
using namespace std;

int main() {
  //   int a = 2;
  //   int b = 3;
  //   int c = 5;

  int a;
  int b;
  int c;

  cout << "Enter value of a, b, c : ";
  cin >> a >> b >> c;

  for (int i = 0; i < 5; i++) {
    if (a <= b && a <= c) {
      a++;
    } else if (b <= c && b <= a) {
      b++;
    } else {
      c++;
    }
  }
  cout << "a * b * c : " << a * b * c << endl;

  return 0;
}