#include <iostream>
using namespace std;

class Node
{

public:
  int data;
  Node *next;

  Node(int value)
  {
    data = value;
    next = nullptr;
  }
};

Node *createLinkedList();
void printLinkedList(Node *head);
void insertAtFront(Node *&head, int value);
void insertAtEnd(Node *&head, int value);
void insertAtPosition(Node *&head, int value, int position);
void deleteLinkedList(Node *&head);

int main()
{
  Node *head = nullptr;

  head = createLinkedList();
  printLinkedList(head);

  int value, pos;

  cout << "\nInsert a value at front: ";
  cin >> value;
  insertAtFront(head, value);
  printLinkedList(head);

  cout << "\nInsert a value at end: ";
  cin >> value;
  insertAtEnd(head, value);
  printLinkedList(head);

  cout << "\nInsert a value at specific position (starting from 1):\n";
  cout << "Enter value and position: ";
  cin >> value >> pos;
  insertAtPosition(head, value, pos);
  printLinkedList(head);

  deleteLinkedList(head);

  return 0;
}

Node *createLinkedList()
{
  cout << "Enter elements (-1 to exit): ";
  int value;
  Node *head = nullptr;
  Node *temp = nullptr;

  while (true)
  {
    cin >> value;
    if (value == -1)
      break;

    Node *newNode = new Node(value);
    if (head == nullptr)
    {
      head = temp = newNode;
    }
    else
    {
      temp->next = newNode;
      temp = newNode;
    }
  }

  return head;
}

void printLinkedList(Node *head)
{
  Node *temp = head;
  while (temp)
  {
    cout << temp->data << "->";
    temp = temp->next;
  }
  cout << "NULL" << endl;
}

void insertAtFront(Node *&head, int value)
{
  Node *temp = new Node(value);
  temp->next = head;
  head = temp;
}

void insertAtEnd(Node *&head, int value)
{
  Node *temp = new Node(value);
  if (head == nullptr)
  {
    head = temp;
  }
  else
  {
    Node *current = head;
    while (current->next)
    {
      current = current->next;
    }
    current->next = temp;
  }
}

void insertAtPosition(Node *&head, int value, int position)
{
  if (position <= 1)
  {
    insertAtFront(head, value);
    return;
  }

  Node *temp = new Node(value);
  Node *current = head;
  int count = 1;

  while (current && count < position - 1)
  {
    current = current->next;
    count++;
  }

  if (current == nullptr)
  {
    cout << "Position is too large! Inserting at end." << endl;
    insertAtEnd(head, value);
  }
  else
  {
    temp->next = current->next;
    current->next = temp;
  }
}

void deleteLinkedList(Node *&head)
{
  Node *current = head;
  while (current)
  {
    Node *next = current->next;
    delete current;
    current = next;
  }
  head = nullptr;
}
