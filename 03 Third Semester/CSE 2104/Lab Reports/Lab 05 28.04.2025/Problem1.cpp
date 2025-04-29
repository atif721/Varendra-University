#include <iostream>

using namespace std;

class Node {
public:
    int data;
    Node* next;

    Node (int value) {
        data = value;
        next = nullptr;
    }
};

Node* createLinkedList () {

    Node* head = nullptr;
    Node* temp = nullptr;

    cout << "Enter elements (e/E to exit) : ";
    int value;

    while (cin >> value) {

        Node* newNode = new Node (value);

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

void insertAtFront (Node&* head, int value) {
    Node* temp = new Node (value);
    temp->next = head;
    head = temp;
}

void insertAtEnd (Node&* head, int value) {
    Node* temp = new Node (value);

    if (head == nullptr) {
        head = temp;
    }
    else {
        Node* current = head;
        while (current->next) {
            current = current->next;
        }
        current->next = temp
    }
}


void insertAtPosition (Node&* head, int value, int index) {

}

void printLinkedList (Node*& head) {
    Node* temp = head;
    while (temp) {
        cout << temp->data << "->";
        temp = temp->next;
    }
    cout << "NULL" << endl;
}


int main () {


    Node* head = nullptr;
    head = createLinkedList ();

    printLinkedList (head);

    return 0;
}