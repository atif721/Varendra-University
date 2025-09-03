#include <iostream>
#include <cmath>

using namespace std;
int main() {

  int n;
  cin >> n;

  if (n == 0 || n == 1) {
    cout << 1 << endl;
    return 0;
  }

  double sum = 0;

  for (int i = 2; i <= n; i++) {
    sum = sum + log10(i);
  }

  int digits = floor(sum) + 1;
  cout << digits << endl;

  return 0;
}