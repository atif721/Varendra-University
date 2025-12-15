#include <bits/stdc++.h>
using namespace std;

int main() {
  int test;
  cin >> test;

  while (test--) {
    string s;
    cin >> s;

    sort(s.begin(), s.end());
    cout << s[0] << endl;
  }

  return 0;
}