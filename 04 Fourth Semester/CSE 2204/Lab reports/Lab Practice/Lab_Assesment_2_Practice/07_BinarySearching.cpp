#include <bits/stdc++.h>
using namespace std;

int main() {
  vector<int> arr = {2, 3, 4, 5, 8};
  int key = 5, low = 0, high = arr.size() - 1, flag = 0;

  while (low <= high) {
    int mid = (low + high) / 2;

    if (arr[mid] == key) {
      flag = 1;
      cout << "Element found at index " << mid << endl;
      break;
    }
    else if (arr[mid] < key)
      low = mid + 1;
    else
      high = mid - 1;
  }

  if (flag == 0)
    cout << "Element not found" << endl;

  return 0;
}
