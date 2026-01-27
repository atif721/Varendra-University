#include <iostream>
using namespace std;

const int MAX = 100;
int queue[MAX];
int front = 0, rear = -1;

void enqueue(int value) {
  if (rear >= MAX - 1) {
    cout << "Queue Overflow\n";
    return;
  }
  queue[++rear] = value;
  cout << "push " << value << endl;
}

void dequeue() {
  if (front > rear) {
    cout << "Queue Underflow\n";
    return;
  }
  cout << "pop " << queue[front++] << endl;
}

int main() {
  int n, m;
  cout << "Enter number of entered customers: ";
  cin >> n;

  int entered[MAX];
  cout << "Enter entry sequence:\n";
  for (int i = 0; i < n; i++) {
    cin >> entered[i];
    enqueue(entered[i]);
  }

  cout << "Enter number of served customers: ";
  cin >> m;

  int served[MAX];
  cout << "Enter served sequence:\n";
  for (int i = 0; i < m; i++) {
    cin >> served[i];
  }

  int servedIndex = 0;
  while (front <= rear && servedIndex < m) {
    if (queue[front] == served[servedIndex]) {
      dequeue(); // match
      servedIndex++;
    }
    else {
      front++; // skip
    }
  }

  if (servedIndex == m)
    cout << "The served sequence is VALID.\n";
  else
    cout << "The served sequence is NOT valid.\n";

  return 0;
}
