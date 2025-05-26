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

void insertAtFront(Node *&head, int value) {
  Node *frontNode = new Node(value);
  frontNode->next = head;
  head = frontNode;
}

void inserAtPosition(Node *&head, int pos, int value) {
  if (pos <= 1) {
    insertAtFront(head, value);
    return;
  }
  Node *temp = head;
  for (int i = 2; i < pos and temp; i++) {
    temp = temp->next;
  }
  if (!temp) {
    cout << "Limit reached..." << endl;
    return;
  }
  Node *current = new Node(value);
  current->next = temp->next;
  temp->next = current;
}

Node *insertAtEnd(Node *head, int value) {
  Node *temp = new Node(value);
  if (!head)
    return temp;

  Node *current = head;
  for (; current->next; current = current->next) {
  }
  current->next = temp;
  return head;
}

void printLinkedList(Node *head) {
  for (; head; head = head->next) {
    cout << head->data << "->";
  }
  cout << "NULL" << endl;
}

int main() {
 cout << "Insert element in LinkedList (e/E to exit) : ";
  int value, pos;

  Node *head = nullptr;
  for (; cin >> value; head = insertAtEnd(head, value)) {
  }
  printLinkedList(head);
  cin.clear();
  cin.ignore();

  cout << "Enter value to insert at FRONT : ";
  cin >> value;
  insertAtFront(head, value);
  printLinkedList(head);

  cout << "Enter value to insert at END : ";
  cin >> value;
  head = insertAtEnd(head, value);
  printLinkedList(head);

  cout << "Insert value at specific position(start from 1)\n";
  cout << "Enter POSITION and VALUE : ";
  cin >> pos >> value;
  inserAtPosition(head, pos, value);
  printLinkedList(head);

  while (head) {
    Node *next = head->next;
    delete head;
    head = next;
  }

  cout << "After deleting : ";
  printLinkedList(head);

  return 0;
}