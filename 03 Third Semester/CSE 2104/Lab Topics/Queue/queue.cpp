#include <iostream>
using namespace std;

class Queue {

public:
    int* arr;
    int front;
    int rear;
    int capacity;
    int size;

    Queue(int size) {
        capacity = size;
        arr = new int[capacity];
        front = 0;
        rear = -1;
        this->size = 0;
    }

    bool isEmpty() {
        return size == 0;
    }

    bool isFull() {
        return size == capacity;
    }

    void enqueue(int x) {
        if (isFull()) {
            cout << "Queue Overflow! Cannot enqueue " << x << endl;
            return;
        }
        rear = (rear + 1) % capacity;
        arr[rear] = x;
        size++;
        cout << x << " enqueued to the queue; ";
    }

    void dequeue() {
        if (isEmpty()) {
            cout << "Queue Underflow! Nothing to dequeue." << endl;
            return;
        }
        cout << arr[front] << " dequeued from the queue; ";
        front = (front + 1) % capacity;
        size--;
    }

    void display() {
        if (isEmpty()) {
            cout << "Queue is empty." << endl;
            return;
        }
        cout << "Queue elements: ";
        for (int i = 0; i < size; i++) {
            int index = (front + i) % capacity;
            cout << arr[index] << " ";
        }
        cout << endl;
    }

    ~Queue() {
        delete [] arr;
    }
};

int main() {
    int capacity;
    cout << "Enter the max size of the queue: ";
    cin >> capacity;

    Queue* q = new Queue(capacity);

    cout << "After enqueue " << endl;

    q->enqueue(10);
    q->display();
    q->enqueue(20);
    q->display();
    q->enqueue(30);
    q->display();
    q->enqueue(40);
    q->display();
    q->enqueue(50);
    q->display();

    cout << "After dequeue" << endl;
    q->dequeue();
    q->display();
    q->dequeue();
    q->display();
    q->dequeue();
    q->display();
    q->dequeue();
    q->display();


    return 0;
}
