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

int* inputArray(int size) {
    int* array = new int[size];
    cout << "Enter " << size << " elements : ";
    for (int i = 0; i < size; i++) {
        cin >> array[i];
    }
    return array;
}

Node* createLinkedList(int array [], int size) {
    Node* head = nullptr;
    for (int i = 0; i < size; i++) {
        Node* temp = new Node(array[i]);
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

int main() {

    cout << "Enter array size : ";
    int size;
    cin >> size;
    int* array = inputArray(size);

    Node* head = createLinkedList(array, size);
    printLinkedList(head);

    Node* current = head;
    while (current) {
        Node* next = current->next;
        delete current;
        current = next;
    }
    delete [] array;

    return 0;
}