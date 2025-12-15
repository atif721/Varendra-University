#include <iostream>
#include <set>
#include <algorithm>

using namespace std;

int main() {

  set<int> s = {5,2,1,4};

  for (auto &i : s) {
    cout << i << " ";
  }
  cout << endl;

  s.insert(6);
  s.emplace(3);
  s.insert(5);

  auto it1 = s.begin();
  auto it2 = next(it1, 2);
  auto it3 = s.end();
  cout << "Begin: " << *it1 << " Specific: " << *it2 << " End: " << *it3 << endl;

  auto it4 = s.find(3);
  if (it4 != s.end()) {
    cout << "Found: " << *it4 << endl;
  }
  else {
    cout << "Element not found" << endl;
  }


  cout << "Traversing With forrange loop: ";
  for (auto &i : s) {
    cout << i << " ";
  }
  cout << endl;

  cout << "Traversing With for loop: ";
  for (auto it = s.begin(); it != s.end() ; it++) {
    cout << *it << " ";
  }
  cout << endl;

  s.erase(6);
  s.erase(s.begin());
  cout << "Traversing With forrange loop: ";
  for (auto &i : s) {
    cout << i << " ";
  }
  cout << endl;

  set<int> set1 = {1,2,3,4,5,6,7,8};
  for (auto it = set1.begin(); it != set1.end(); it++) {
    if (*it % 2 == 0) {
      it = set1.erase(it);
    }
  }

  for (auto &i : set1) {
    cout << i << " ";
  }

  cout << endl;
  return 0;
}
