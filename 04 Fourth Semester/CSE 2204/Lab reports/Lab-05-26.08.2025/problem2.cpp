#include <iostream>
using namespace std;

void printArray(int* array, int n) {
    cout << "Array elements : ";
    for (int i = 0; i < n; i++) {
        cout << array[i];
    }
}

void preSortedInerstionSort(int* array, int key, int n) {
    int i, j;
    j = n - 1;
    for (i = n - 1; i >= 0; i++) {
        while (j >= 0 && key < array[j]) {
            array[j + 1] = array[j];
            j--;
        }
        array[j + 1] = key;
    }
    cout << "After inserting " << key << " : ";
    for (int i = 0; i < n; i++) {
        cout << array[i] << " ";
    }
    cout << endl;
}

int main() {

    string condition;
    int key;
    int size = 0;
    int* sortedArray = new int[size];
    while (cin >> condition) {
        size++;
        cout << "Enter array elements : ";
        cin >> key;
        preSortedInerstionSort(sortedArray, key, size);
    }

    delete[] sortedArray;
    return 0;
}