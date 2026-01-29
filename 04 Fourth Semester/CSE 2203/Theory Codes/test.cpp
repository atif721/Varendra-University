#include <iostream>
#include <set>
#include <algorithm>

using namespace std;

int main() {
  set<int> set1 = {1,2,3,4,5,6,7,8};
  for (auto it : set1) {
    if (*it % 2 == 0) {
      it = set1.erase(it);
    }
    else {
      it++;
    }
  }

  for (auto i : set1) {
    cout << i << " ";
  }


  cout << endl;
  return 0;
}
