#include <iostream>
using namespace std;

void deleteElement(int arr [], int& size, int value) {
    int pos = -1;

    for (int i = 0; i < size; i++) {
        if (arr[i] == value) {
            pos = i;
            break;
        }
    }

    if (pos != -1) {
        for (int i = pos; i < size - 1; i++) {
            arr[i] = arr[i + 1];
        }
        size--;
        cout << "Element " << value << " deleted.\n";
    }
    else {
        cout << "Element " << value;
        cout << " not found in the array.\n";
    }
}

void displayArray(int arr [], int size) {
    for (int i = 0; i < size; i++) {
        cout << arr[i] << " ";
    }
    cout << endl;
}

int main() {

    cout << "Enter array size : ";
    int size;
    cin >> size;

    int array[size];
    for (int i = 0; i < size; i++)
    {
        cout << "Enter element " << i + 1 << " : ";
        cin >> array[i];
    }

    cout << "Original array: ";
    displayArray(array, size);

    int value;
    cout << "Enter value to delete: ";
    cin >> value;

    deleteElement(array, size, value);

    cout << "Updated array: ";
    displayArray(array, size);

    return 0;
}