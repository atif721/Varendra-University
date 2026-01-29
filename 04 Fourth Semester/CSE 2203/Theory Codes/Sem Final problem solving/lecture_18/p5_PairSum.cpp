#include <bits/stdc++.h>
using namespace std;

int main() {
  int test;
  cin >> test;

  while (test--) {
    int n;
    cout << "Array size: ";
    cin >> n;

    int arr[n];
    cout << "Array elements : ";
    for (int i = 0; i < n; i++) {
      cin >> arr[i];
    }

    int target;
    cout << "Target : ";
    cin >> target;

    bool found = 0;

    for (int i = 0; i < n; i++) {
      for (int j = i + 1; j < n; j++) {
        if (arr[i] + arr[j] == target) {
          found = true;
        }
      }
    }

    cout << found << endl;
  }

  return 0;
}