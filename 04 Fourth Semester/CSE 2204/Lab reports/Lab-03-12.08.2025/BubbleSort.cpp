#include<iostream>
using namespace std;

int main() {
    int length;
    cout << "Enter length of array : ";
    cin >> length;

    int* array = new int[length];
    cout << "Enter " << length << " elements : ";
    for (int i = 0; i < length; i++) {
        cin >> array[i];
    }

    for (int i = 0; i < length - 1; i++) {
        for (int j = 0; j < length - 1 - i; j++) {
            if (array[j] > array[j + 1]) {
                int temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }

    cout << "Bubble Sorted array : ";
    for (int i = 0; i < length; i++) {
        cout << array[i] << " ";
    }

    delete[] array;

    return 0;
}

// have to implement comparision and swapping count later