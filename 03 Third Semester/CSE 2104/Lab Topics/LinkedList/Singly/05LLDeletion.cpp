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

Node* createLinkedList();
void printLinkedList(Node* head);
void deleteAtPosition(Node*& head, int position);
void deleteAtBeginning(Node*& head);
void deleteAtEnd(Node*& head);

int main() {
  Node* head = createLinkedList();

  cout << "Original Linked List: ";
  printLinkedList(head);

  cout << "Deleting node at position 0 (beginning): ";
  deleteAtBeginning(head);
  printLinkedList(head);

  int position;
  cout << "Enter position to delete: ";
  cin >> position;
  deleteAtPosition(head, position);
  printLinkedList(head);

  cout << "Deleting node at the end: ";
  deleteAtEnd(head);
  printLinkedList(head);

  return 0;
}

Node* createLinkedList() {
  cout << "Enter elements (-1 to end): ";
  int value;
  Node* head = nullptr;
  Node* tail = nullptr;

  while (true) {
    cin >> value;
    if (value == -1) break;

    Node* temp = new Node(value);
    if (head == nullptr) {
      head = tail = temp;
    }
    else {
      tail->next = temp;
      tail = temp;
    }
  }

  return head;
}

void printLinkedList(Node* head) {
  Node* temp = head;
  while (temp != nullptr) {
    cout << temp->data << " -> ";
    temp = temp->next;
  }
  cout << "NULL" << endl;
}

void deleteAtBeginning(Node*& head) {
  if (head == nullptr) {
    cout << "List is empty!" << endl;
    return;
  }

  Node* temp = head;
  head = head->next;
  delete temp;
}

void deleteAtPosition(Node*& head, int position) {
  if (head == nullptr) {
    cout << "List is empty!" << endl;
    return;
  }

  if (position == 0) {
    deleteAtBeginning(head);
    return;
  }

  Node* temp = head;
  for (int i = 0; temp != nullptr && i < position - 1; i++) {
    temp = temp->next;
  }

  if (temp == nullptr || temp->next == nullptr) {
    cout << "Position out of range!" << endl;
    return;
  }

  Node* nodeToDelete = temp->next;
  temp->next = temp->next->next;
  delete nodeToDelete;
}

void deleteAtEnd(Node*& head) {
  if (head == nullptr) {
    cout << "List is empty!" << endl;
    return;
  }

  if (head->next == nullptr) {
    delete head;
    head = nullptr;
    return;
  }

  Node* temp = head;
  while (temp->next != nullptr && temp->next->next != nullptr) {
    temp = temp->next;
  }

  delete temp->next;
  temp->next = nullptr;
}