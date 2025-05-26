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
    rear = 0;
    capacity = size;
    this->size = 0;
    array = new int[capacity + 1];
  }

  bool isEmpty() {
    return size == 0;
  }

  bool isFull() {
    return size == capacity;
  }

  void enqueue(int value) {
    if (isFull()) {
      cout << "Queue overflow! Cannot enqueue " << value << endl;
      return;
    }
    rear = (rear % capacity) + 1;
    array[rear] = value;
    size++;
    cout << value << " enqueued to the Queue " << endl;
  }

  void dequeue() {
    if (isEmpty()) {
      cout << "Queue underflow! Cannot dequeue element" << endl;
      return;
    }
    cout << array[front] << " dequeued from Queue " << endl;
    front = (front % capacity) + 1;
    size--;
  }

  void display() {
    if (isEmpty()) {
      cout << "Queue is empty! Nothing to display" << endl;
      return;
    }
    cout << "Current Queue : ";
    for (int i = 0; i < size; i++) {
      int index = ((front - 1 + i) % capacity) + 1;
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
  cout << "Enter the max size of the queue: ";
  cin >> capacity;

  Queue* q = new Queue(capacity);

  cout << "After enqueue " << endl;

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
  q->dequeue();
  q->display();
  q->dequeue();
  q->display();
  q->dequeue();
  q->dequeue();
  q->display();

  delete q;
  return 0;
}
