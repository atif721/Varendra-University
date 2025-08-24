#include <iostream>
using namespace std;

int main() {
  int n;
  int m;
  cin >> n >> m;

  if ((m < n ? m : n) % 2 == 0) {
    cout << "Malvika" << endl;
  }
  else {
    cout << "Akshat" << endl;
  }

  return 0;
}
