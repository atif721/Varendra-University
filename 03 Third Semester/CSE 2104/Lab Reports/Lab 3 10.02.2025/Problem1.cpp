#include <iostream>
using namespace std;

void displayArray(int size, int arr []) {
    for (int i = 0; i < size; i++) {
        cout << "Element " << i + 1;
        cout << " : " << arr[i] << endl;
    }
}

int main() {

    cout << "Enter array size : ";
    int size;
    cin >> size;

    int array[size];
    for (int i = 0; i < size; i++) {
        cout << "Enter element " << i + 1 << " : ";
        cin >> array[i];
    }

    displayArray(size, array);

    cout << "Index of the element to remove : ";
    int i_remove;
    cin >> i_remove;

    int item;

    item = array[i_remove];
    size = size - 1;

    for (int i = i_remove; i < size; i++)
    {
        array[i] = array[i + 1];
    }

    displayArray(size, array);
}