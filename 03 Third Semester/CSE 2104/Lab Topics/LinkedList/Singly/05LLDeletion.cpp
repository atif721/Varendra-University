#include <iostream>
using namespace std;

class Node {
public:
  int data;
  Node *next;
  Node(int data) {
    this->data = data;
    next = nullptr;
  }
};

Node *createNode(Node *head, int value) {
  Node *temp = new Node(value);
  if (!head)
    return temp;

  Node *current = head;
  for (; current->next; current = current->next) {
  }
  current->next = temp;
  return head;
}

void deleteAtFront(Node *&head) {
  Node *temp = head;
  head = head->next;
  delete temp;
}

void deleteAtEnd(Node *&head) {
  if (!head->next) {
    delete head;
    head = nullptr;
    return;
  }
  Node *current = head;
  while (current->next->next) {
    current = current->next;
  }
  delete current->next;
  current->next = nullptr;
}

void deleteAtPosition(Node *&head, int pos) {

  if (pos <= 1) {
    deleteAtFront(head);
    return;
  }
  Node *current = head;
  for (int i = 2; i < pos && current->next; i++) {
    current = current->next;
  }
  if (!current->next) {
    cout << "Position out of range" << endl;
    return;
  }
  Node *temp = current->next;
  current->next = temp->next;
  delete temp;
}

void printLinkedList(Node *head) {
  for (; head; head = head->next) {
    cout << head->data << "->";
  }
  cout << "NULL" << endl;
}

void deleteLinkedList(Node *&head) {
  while (head) {
    deleteAtFront(head);
  }
}

int main() {
  cout << "Insert element in LinkedList (e/E to exit) : ";
  int value, pos;

  Node *head = nullptr;
  for (; cin >> value; head = createNode(head, value)) {
  }
  printLinkedList(head);
  cin.clear();
  cin.ignore();

  if (!head) {
    cout << "List is empty" << endl;
    return -1;
  }

  cout << "Deleting at FRONT..." << endl;
  deleteAtFront(head);
  printLinkedList(head);

  cout << "Deleting at END..." << endl;
  deleteAtEnd(head);
  printLinkedList(head);

  cout << "Delete at position... Enter POSITION : ";
  cin >> pos;
  deleteAtPosition(head, pos);
  printLinkedList(head);

  cout << "Deleting entire list..." << endl;
  deleteLinkedList(head);
  printLinkedList(head);

  return 0;
}