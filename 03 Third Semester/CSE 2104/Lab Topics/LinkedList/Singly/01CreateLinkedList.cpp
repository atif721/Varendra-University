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

// method-1
// Node createSinglyLinkedList(Node*& head, int value) {
//     Node* HEAD = new Node(value);

//     if (head == nullptr)
//     {
//         head = HEAD;
//     }
//     else {
//         Node* current = head;
//         while (current->next)
//         {
//             current = current->next;
//         }
//         current->next = HEAD;
//     }
// }

// method-2
Node* createSinglyLinkedList(Node* head, int value) {
    Node* temp = new Node(value);

    if (head == nullptr)
    {
        head = temp;
    }
    else {
        Node* current = head;
        while (current->next)
        {
            current = current->next;
        }
        current->next = temp;
    }

    return head;
}

void printLinkedList(Node* head) {
    Node* temp = head;
    while (temp)
    {
        cout << temp->data << "->";
        temp = temp->next;
    }
    cout << "NULL" << endl;

}


int main() {

    // method-1

    // Node* head = new Node(5);
    // Node* head1 = new Node(15);
    // Node* head2 = new Node(25);
    // head->next = head1;
    // head1->next = head2;
    // head2->next = nullptr;

    // method-2

    Node* head = nullptr;
    head = createSinglyLinkedList(head, 50);
    head = createSinglyLinkedList(head, 15);
    head = createSinglyLinkedList(head, 25);
    head = createSinglyLinkedList(head, 2125);

    cout << head << endl;

    printLinkedList(head);

    cout << endl;

    return 0;
}
