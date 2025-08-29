#include <iostream>
using namespace std;

void InsertionSortAfterInsert(int *array, int currentSize, int key) {
    int j;
    j = currentSize - 1;
    while (j >= 0 && array[j] > key) {
        array[j + 1] = array[j];
        j--;
    }
    array[j + 1] = key;

    cout << "After inserting " << key << " : ";
    for (int i = 0; i <= currentSize; i++) {
        cout << array[i] << " ";
    }
    cout << endl;
}

int main() {

    int n;
    int key;
    cout << "Enter number of elements to insert : ";
    cin >> n;

    int *sortedArray = new int[n];
    cout << "Enter array elements " << endl;;
    for (int i = 0; i < n; i++) {
        cout << "Element (" << i + 1 << ") : ";
        cin >> key;
        InsertionSortAfterInsert(sortedArray, i, key);
        cout << endl;
    }

    delete[] sortedArray;
    return 0;
}