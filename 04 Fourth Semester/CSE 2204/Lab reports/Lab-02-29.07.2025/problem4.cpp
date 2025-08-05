#include <iostream>
using namespace std;

int *defineArray(int &size) {
    cout << "Enter the size of an Array : ";
    cin >> size;
    int *array = new int[size];
    cout << "Enter array elements : " << endl;
    for (int i = 0; i < size; i++) {
        cout << "i-[" << i << "] : ";
        cin >> array[i];
    }
    return array;
}

int firstOccurrence(int size, int *array, int target) {
    for (int i = 0; i < size; i++) {
        if (array[i] == target) {
            return i;
        }
    }
    return -1;
}

int main() {

    int size;
    int *array = defineArray(size);

    int target;
    cout << "Enter the value to find First Occurance : ";
    cin >> target;

    int occurrenceIndex = firstOccurrence(size, array, target);

    if (occurrenceIndex != -1) {
        cout << "Element Found at index : " << occurrenceIndex << endl;
    }
    else {
        cout << "Element Not Found" << occurrenceIndex << endl;
    }

    delete[] array;

    return 0;
}

