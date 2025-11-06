#include <bits/stdc++.h>
using namespace std;

int main() {

  int t;
  cin >> t;

  while (t--) {
    long long n, k;
    cin >> n >> k;


    vector <long long> a(n);
    long long beauty = 0;

    for (long long i = 0; i < n; i++) {
      cin >> a[i];
      beauty += __builtin_popcountll(a[i]);
    }


    while (k > 0) {
      long long index = -1;

      for (long long i = 0; i < n; i++) {
        long long before = __builtin_popcountll(a[i]);
        long long after = __builtin_popcountll(a[i] + 1);

        if (after > before) {
          index = i;
          break;
        }
      }
      if (index == -1) {
        break;
      }

      a[index]++;
      beauty++;
      k--;
    }
    cout << "Beauty : " << beauty << endl;
  }

  cout << endl;
  return 0;
}