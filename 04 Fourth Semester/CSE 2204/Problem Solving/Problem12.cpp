#include<iostream>
using namespace std;
int main() {
  int t, n, c;
  cin >> t;
  while (t--) {
    cin >> n;
    c = 0;
    for (;n;n /= 10) c++;
    cout << c << '\n';
  }
}
