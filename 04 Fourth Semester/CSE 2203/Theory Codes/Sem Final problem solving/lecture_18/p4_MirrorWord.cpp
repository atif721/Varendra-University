#include <bits/stdc++.h>
using namespace std;

int main() {
  int test;
  cin >> test;

  while (test--) {
    string s;
    cin >> s;
    string ans = "";
    for (int i = s.size() - 1; i >= 0; i--) {
      if (s[i] == 'b')
        ans += 'd';
      else if (s[i] == 'd')
        ans += 'b';
      else
        ans += 'o';
    }
    cout << ans << endl;
  }

  return 0;
}