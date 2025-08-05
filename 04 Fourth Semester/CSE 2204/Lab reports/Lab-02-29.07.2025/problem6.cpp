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

int countOccurance(int size, int* array, int target) {
    int count = 0;
    for (int i = 0; i < size; i++) {
        if (array[i] == target) {
            count++;
        }
    }
    return count;
}

int main() {
    int size;
    cout << "Enter the size of an Array : ";
    cin >> size;

    int* array = defineArray(size);

    int target;
    cout << "Enter the value to count Occurance : ";
    cin >> target;

    cout << target << " appears in the array " << countOccurance(size, array, target) << " times" << endl;

    return 0;
} 