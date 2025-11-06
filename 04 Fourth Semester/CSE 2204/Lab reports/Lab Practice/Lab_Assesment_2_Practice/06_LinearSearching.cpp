#include <bits/stdc++.h>
using namespace std;

int main() {
  vector<int> arr = {5, 3, 8, 4, 2};
  int key = 4, flag = 0;

  for (int i = 0; i < arr.size(); i++) {
    if (arr[i] == key) {
      flag = 1;
      cout << "Element found at index " << i << endl;
      break;
    }
  }

  if (flag == 0)
    cout << "Element not found" << endl;

  return 0;
}
