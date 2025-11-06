#include <bits/stdc++.h>
using namespace std;

int main() {
  vector<int> arr = {5, 3, 8, 4, 2};
  int n = arr.size();

  for (int i = 0; i < n - 1; i++) {
    int flag = 0;
    for (int j = 0; j < n - i - 1; j++) {
      if (arr[j] > arr[j + 1]) {
        swap(arr[j], arr[j + 1]);
        flag = 1;
      }
    }
    if (flag == 0)
      break; // already sorted
  }

  cout << "Sorted Array: ";
  for (int x : arr)
    cout << x << " ";
  cout << endl;

  return 0;
}
