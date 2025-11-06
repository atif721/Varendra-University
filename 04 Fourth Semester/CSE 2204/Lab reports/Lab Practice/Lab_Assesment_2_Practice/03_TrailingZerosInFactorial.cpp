#include <bits/stdc++.h>
using namespace std;

int main() {

  int n;
  cout << "Enter a number : ";
  cin >> n;

  int count = 0;

  while (n > 0) {
    n /= 5;
    count += n;
  }

  cout << "Trailing zeros in factorial = " << count << endl;


  cout << endl;
  return 0;
}