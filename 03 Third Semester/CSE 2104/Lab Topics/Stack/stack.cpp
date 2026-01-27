#include <iostream>
using namespace std;

class Stack {
  int maxSize;
  int* array;
  int top;

public:
  Stack(int maxSize) {
    this->maxSize = maxSize;
    top = -1;
    array = new int[maxSize];
  }

  bool isFull() {
    return top == maxSize - 1;
  }

  bool isEmpty() {
    return top == -1;
  }

  void push(int value) {
    if (isFull()) {
      cout << "Stack Overflow! Can't push element" << endl;
      return;
    }
    top++;
    array[top] = value;
    cout << value << " pushed to the stack; ";
  }

  void pop() {
    if (isEmpty()) {
      cout << "Stack Underflow! Can't pop element" << endl;
      return;
    }
    top--;
    cout << array[top + 1] << " popped from the stack; ";
  }

  void display() {
    cout << "Current Stack : ";
    if (isEmpty()) {
      cout << "Stack is empty!" << endl;
      return;
    }

    for (int i = 0; i <= top; i++) {
      cout << array[i] << " ";
    }
    cout << endl;
  }

  ~Stack() {}
};

int main() {
  int maxSize;
  cout << "Enter the max size : ";
  cin >> maxSize;

  Stack* s = new Stack(maxSize);

  cout << "After pushing " << endl;
  s->push(10);
  s->display();
  s->push(20);
  s->display();
  s->push(30);
  s->display();
  s->push(40);
  s->display();
  s->push(50);
  s->display();

  cout << "After poping" << endl;
  s->pop();
  s->display();
  s->pop();
  s->display();
  s->pop();
  s->display();
  s->pop();
  s->display();


  return 0;
}
