/*
#include <iostream>
#include <string>

using namespace std;

class Shallow {
public:
  string *data; // Pointer to string

  Shallow(const string &d) {
    data = new string(d); // Dynamically allocate a string
  }

  // Shallow copy constructor
  Shallow(const Shallow &s) : data(s.data) {} // Copying the pointer

  ~Shallow() {
    delete data; // Delete the allocated string
  }
};

class Deep {
public:
  string data;

  Deep(const string &d) : data(d) {}

  // Deep copy constructor
  Deep(const Deep &d) : data(d.data) {} // Copying the string

  ~Deep() {}
};

int main() {
  Shallow s1("Hello");
  Shallow s2 = s1; // Shallow copy
  Deep d1("World");
  Deep d2 = d1; // Deep copy

  // Print initial values
  cout << "Before modification:" << endl;
  cout << "s1: " << *s1.data << endl; // Output: Hello
  cout << "s2: " << *s2.data << endl; // Output: Hello
  cout << "d1: " << d1.data << endl;  // Output: World
  cout << "d2: " << d2.data << endl;  // Output: World

  // Modifying s1 will affect s2
  (*s1.data)[0] = 'h'; // Both s1 and s2 will show "hello"

  // Print values after modification
  cout << "\nAfter modifying s1:" << endl;
  cout << "s1: " << *s1.data << endl; // Output: hello
  cout << "s2: " << *s2.data << endl; // Output: hello

  // Modifying d1 will not affect d2
  d1.data[0] = 'w'; // d1 shows "world", d2 still shows "World"

  // Print values after modification
  cout << "\nAfter modifying d1:" << endl;
  cout << "d1: " << d1.data << endl; // Output: world
  cout << "d2: " << d2.data << endl; // Output: World

  return 0;
}
*/

#include <iostream>
using namespace std;
class A {
private:
  int x;

public:
  A(int p) {
    // x = new int;
    x = p;
  }
  A(A &obj) {

    // x = new int;
    x = (obj.x);
  }
  void set(int m) {
    x = m;
  }

  void show() {
    cout << x << endl;
  }
};

int main() {

  A ob(10);
  A ob1 = ob;
  ob.show();
  ob1.show();
  ob1.set(20);
  ob.show();
  ob1.show();

  return 0;
}