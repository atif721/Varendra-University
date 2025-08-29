#include <iostream>
using namespace std;

void dynamicInsertionSort(int *array, int key, int currentSize) {
    int i, j;
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

    char condition;
    int key;
    int *sortedArray = nullptr;
    int size = 0;
    while (true) {
        cout << "Enter array element : ";
        cin >> key;
        int *newArray = new int[size + 1];

        for (int i = 0; i < size; i++) {
            newArray[i] = sortedArray[i];
        }

        dynamicInsertionSort(newArray, key, size);
        delete[] sortedArray;
        sortedArray = newArray;
        size++;
        cout << endl;

        cout << "Want to continue insertion ? (y/n) : ";
        cin >> condition;

        if (condition != 'y')
            break;
    }

    delete[] sortedArray;
    return 0;
}
