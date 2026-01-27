#include <iostream>
using namespace std;

const int MAX = 100;
int stack[MAX];
int top = -1;

void push(int val) {
  if (top >= MAX - 1) {
    cout << "Stack Overflow\n";
    return;
  }
  stack[++top] = val;
  cout << "Push " << val << " → stack: [";
  for (int i = 0; i <= top; ++i) {
    cout << stack[i];
    if (i != top) cout << ", ";
  }
  cout << "]\n";
}

void pop() {
  if (top < 0) {
    cout << "Stack Underflow\n";
    return;
  }
  cout << "Pop " << stack[top] << " → stack: [";
  top--;
  for (int i = 0; i <= top; ++i) {
    cout << stack[i];
    if (i != top) cout << ", ";
  }
  cout << "]\n";
}

int main() {
  int n;
  cout << "Enter number of containers: ";
  cin >> n;

  int loaded[MAX], unloaded[MAX];
  cout << "Enter loading order:\n";
  for (int i = 0; i < n; i++) {
    cin >> loaded[i];
  }

  cout << "Enter unloading order:\n";
  for (int i = 0; i < n; i++) {
    cin >> unloaded[i];
  }

  int j = 0; // Index for unloaded[]
  for (int i = 0; i < n; i++) {
    push(loaded[i]);

    while (top >= 0 && stack[top] == unloaded[j]) {
      pop();
      j++;
    }
  }

  if (top == -1)
    cout << "The unloading sequence is VALID.\n";
  else
    cout << "The unloading sequence is NOT valid.\n";

  return 0;
}
