#include <bits/stdc++.h>
using namespace std;

int main() {
  vector<int> arr = {5, 3, 8, 4, 2};
  int n = arr.size();

  for (int i = 0; i < n - 1; i++) {
    int minIndex = i;
    for (int j = i + 1; j < n; j++) {
      if (arr[j] < arr[minIndex])
        minIndex = j;
    }
    swap(arr[i], arr[minIndex]);
  }

  cout << "Sorted Array: ";
  for (int x : arr)
    cout << x << " ";
  cout << endl;

  return 0;
}
