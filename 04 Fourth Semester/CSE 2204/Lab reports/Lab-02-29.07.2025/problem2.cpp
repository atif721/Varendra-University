#include <iostream>
using namespace std;

int* defineArray(int size) {
    int* array = new int[size];
    cout << "Enter array elements (rotated sorted array) : " << endl;
    for (int i = 0; i < size; i++) {
        cout << "i-[" << i << "] : ";
        cin >> array[i];
    }
    return array;
}

int findElement(int size, int* array, int target) {
    int BEG = 0;
    int END = size;
    int MID;
    while (BEG <= END) {
        MID = BEG + int((END - BEG) / 2);
        if (array[MID] == target) {
            return MID;
        }

        if (array[BEG] <= array[MID]) {
            //here left checking
            if (target >= array[BEG] && target < array[MID]) {
                END = MID - 1;
            }
            else {
                BEG = MID + 1;
            }
        }
        else {
            //here rigth checking
            if (target > array[MID] && target <= array[END]) {
                BEG = MID + 1;
            }
            else {
                END = MID - 1;
            }
        }
    }
    return -1;
}

int main() {
    int size;
    cout << "Enter the size of an Array : ";
    cin >> size;

    int* array = defineArray(size);

    int target;
    cout << "Enter the target value to find  : ";
    cin >> target;

    int occuranceIndex = findElement(size, array, target);

    if (occuranceIndex != -1) {
        cout << "Element Found at index : " << occuranceIndex;
    }
    else {
        cout << "Element Not Found";
    }

    return 0;
}