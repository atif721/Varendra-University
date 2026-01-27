#include <iostream>
using namespace std;

class Queue {
public:

  int front;
  int rear;
  int size;
  int capacity;
  int* array;

  Queue(int size) {
    front = 1;
    rear = -1;
    capacity = size;
    this->size = 0;
    array = new int[capacity];

  }

  bool isEmpty() {
    return size == 0;
  }

  bool isFull() {
    return  capacity == size;
  }

  void enqueue(int value) {
    if (isFull()) {
      cout << "Queue overflow! Cannot enqueue " << value << endl;
      return;
    }
    rear = (rear + 1) % capacity;
    array[rear] = value;
    size++;
    cout << value << " enqueued to the Queue " << endl;
  }

  void dequeue() {
    if (isEmpty()) {
      cout << "Queue underflow! Cannot dequeue element ";
      return;
    }
    cout << array[front] << " dequeued from Queue " << endl;
    front = (front + 1) % capacity;
    size--;
  }

  void display() {
    if (isEmpty()) {
      cout << "Queue is empty! Nothing to display ";
      return;
    }
    cout << "Current Queue : ";
    for (int i = 1; i <= size; i++) {
      int index = (front + i) % capacity;
      cout << array[index] << " ";
    }
    cout << endl;
  }

  ~Queue() {
    delete [] array;
  }
};


int main() {
  int capacity;
  cout << "Enter the max size of Queue ";
  cin >> capacity;

  Queue* q = new Queue(capacity);

  cout << "After enqueue" << endl;
  q->enqueue(10);
  q->enqueue(20);
  q->enqueue(30);
  q->enqueue(40);
  q->enqueue(50);
  q->display();

  cout << "\nAfter dequeue" << endl;
  q->dequeue();
  q->display();
  q->dequeue();
  q->display();

  delete q;
  return 0;
}
