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
 
int findMinimum(int* array, int size) {
    int BEG = 0;
    int END = size;
    int MID;
    while (BEG < END) {
        MID = BEG + int((END - BEG) / 2);

        if (array[MID] > array[END])
            BEG = MID + 1;
        else
            END = MID;
    }
    return array[MID];
}

int main() {
    int size;
    cout << "Enter the size of an Array : ";
    cin >> size;

    int* array = defineArray(size);

    cout << "Maximum element in the Array : " << findMinimum(array, size) << endl;

    return 0;
}