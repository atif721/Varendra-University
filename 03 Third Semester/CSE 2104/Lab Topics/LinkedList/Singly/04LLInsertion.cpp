#include<iostream>
using namespace std;

class Node {
public:
  int data;
  Node* next;
  Node(int data) {
    this->data = data;
    next = nullptr;
  }
};
Node* createLinkedList() {
  cout << "Enter elements (-1 to end): ";
  int value;
  Node* head = nullptr;
  Node* temp = nullptr;

  while (cin >> value) {
    Node* newNode = new Node(value);
    if (head == nullptr) {
      head = temp = newNode;
    }
    else {
      temp->next = newNode;
      temp = newNode;
    }
  }

  return head;
}
void printLinkedList(Node* head) {
  Node* temp = head;
  while (temp) {
    cout << temp->data << "->";
    temp = temp->next;
  }
  cout << "NULL" << endl;
}
void insertAtFront(Node*& head, int value) {
  Node* temp = new Node(value);
  temp->next = head;
  head = temp;
}
void insertAtEnd(Node*& head, int value) {
  Node* temp = new Node(value);
  if (head == nullptr) {
    head = temp;
  }
  else {
    Node* current = head;
    while (current->next) {
      current = current->next;
    }
    current->next = temp;
  }
}
void insertAtPosition(Node*& head, int value, int position) {
  if (position <= 1) {
    insertAtFront(head, value);
    return;
  }
  Node* current = new Node(value);
  Node* temp = head;
  for (int i = 1; i < position - 1;i++) {
    if (not temp) {
      cout << "Limit exceeded" << endl;
      return;
    }
    temp = temp->next;
  }
  if (not temp) {
    cout << "Limit exceeded" << endl;
    return;
  }
  current->next = temp->next;
  temp->next = current;
}
void deleteLinkedList(Node*& head) {
  Node* current = head;
  while (current) {
    Node* next = current->next;
    delete current;
    current = next;
  }
  head = nullptr;
}
int main() {
  Node* head = nullptr;
  head = createLinkedList();
  printLinkedList(head);

  cin.ignore();
  int value, pos;
  cout << "\nInsert a value at front: ";
  cin >> value;
  insertAtFront(head, value);
  printLinkedList(head);

  cin.ignore();
  cout << "\nInsert a value at end: ";
  cin >> value;
  insertAtEnd(head, value);
  printLinkedList(head);

  cin.ignore();
  cout << "\nInsert a value at specific position (starting from 1):\n";
  cout << "Enter value and position: ";
  cin >> value >> pos;
  insertAtPosition(head, value, pos);
  printLinkedList(head);
  deleteLinkedList(head);

  return 0;
}
