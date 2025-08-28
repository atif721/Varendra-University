#include <iostream>
using namespace std;

void printArray(int* array, int n) {
    cout << "Array elements : ";
    for (int i = 0; i < n; i++) {
        cout << array[i];
    }
}

void preSortedInerstionSort(int* array, int n, int key) {
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

    int n;
    int key;
    cout << "Enter number of elements to insert : ";
    cin >> n;

    int* sortedArray = new int[n];
    cout << "Enter array elements : ";
    for (int i = 0; i < n; i++) {
        cin >> key;
        preSortedInerstionSort(sortedArray, i + 1, key);
    }

    delete[] sortedArray;
    return 0;
}