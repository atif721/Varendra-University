#include <iostream>
using namespace std;

int* defineArray(int size) {
    int* array = new int[size];
    cout << "Enter array elements : " << endl;
    for (int i = 0; i < size; i++) {
        cout << "i-[" << i << "] : ";
        cin >> array[i];
    }
    return array;
}

int findMaximum(int size, int* array) {
    int max = array[0];
    for (int i = 0; i < size; i++) {
        if (array[i] > max) {
            max = array[i];
        }
    }
    return max;
}

int main() {
    int size;
    cout << "Enter the size of an Array : ";
    cin >> size;

    int* array = defineArray(size);

    cout << "Maximum element in the Array : " << findMaximum(size, array) << endl;

    return 0; 
}