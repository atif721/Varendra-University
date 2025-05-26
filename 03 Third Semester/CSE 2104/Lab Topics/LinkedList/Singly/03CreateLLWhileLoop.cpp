#include <iostream>
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
  cout << "Enter elements (e/E to exit) : ";
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
  deleteLinkedList(head);

  return 0;
}

