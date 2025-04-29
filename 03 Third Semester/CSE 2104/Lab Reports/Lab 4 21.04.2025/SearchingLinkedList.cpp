#include <iostream>
using namespace std;

class Node {
public:
    int data;
    Node* next;

    Node(int value) {
        data = value;
        next = nullptr;
    }
};

Node* createLinkedList(int arr [], int size) {
    Node* head = nullptr;
    Node* temp = nullptr;
    Node* current = nullptr;

    for (int i = 0; i < size; i++)
    {
        temp = new Node(arr[i]);

        if (head == nullptr)
        {
            head = temp;
            current = temp;
        }
        else
        {
            current->next = temp;
            current = current->next;
        }
    }

    return head;
}

void printLinkedList(Node* head) {
    Node* current = head;
    while (current != nullptr)
    {
        cout << current->data << "->";
        current = current->next;
    }
    cout << "NULL" << endl;
}

int searchLinkedList(Node* head, int value) {
    int index = -1;
    int counter = 0;

    while (head != nullptr)
    {
        if (head->data == value)
        {
            index = counter;
            break;
        }
        counter++;
        head = head->next;
    }

    return index;
}

int main() {
    int size;
    cout << "Enter the number of elements: ";
    cin >> size;

    int* array = new int[size];

    cout << "Enter " << size << " elements: ";
    for (int i = 0; i < size; i++)
    {
        cin >> array[i];
    }

    Node* head1 = createLinkedList(array, size);
    printLinkedList(head1);

    cout << "Enter element to search: ";
    int value;
    cin >> value;

    int index = searchLinkedList(head1, value);

    if (index == -1)
    {
        cout << "Element not found." << endl;
    }
    else
    {
        cout << "Element found at index: " << index << endl;
    }

    Node* current = head1;
    while (current != nullptr)
    {
        Node* next = current->next;
        delete current;
        current = next;
    }

    delete [] array;

    return 0;
}
