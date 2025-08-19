#include <iostream>
using namespace std;

void printArray(int* array, int size) {
    cout << "Array Elements are : ";
    for (int i = 0; i < size; i++) {
        cout << array[i] << " ";
    }
    cout << endl;
}

void bubbleSort(int* array, int n) {
    bool swapped;
    int swapCount = 0;
    int compareCount = 0;
    for (int i = 0; i < n - 1; i++) {
        swapped = false;
        for (int j = 0; j < n - 1; j++) {
            if (array[j] > array[j + 1]) {
                int temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
                swapped = true;
                swapCount++;
            }
            compareCount++;
        }
        if (swapped == false) {
            break;
        }
    }
    printArray(array, n);
    cout << "Swapping : " << swapCount << endl;
    cout << "Comparing : " << compareCount << endl;
}

int main() {

    // int size;
    // cout << "Enter the array size : ";
    // cin >> size;

    // int* array = new int[size];

    // cout << "Enter array elements : ";
    // for (int i = 0; i < size; i++) {
    //     cin >> array[i];
    // }

    int array1[] = { 5,6,7,15,36,100 };
    int array2[] = { 60,50,40,30,20,10 };
    int array3[] = { 6,4,9,3,11,8,15,12 };

    int size1 = sizeof(array1) / sizeof(array1[0]);
    int size2 = sizeof(array2) / sizeof(array2[0]);
    int size3 = sizeof(array3) / sizeof(array3[0]);

    cout << "Before sorting ";
    printArray(array1, size1);
    cout << "After sorting ";
    bubbleSort(array1, size1);

    cout << "Before sorting ";
    printArray(array2, size2);
    cout << "After sorting ";
    bubbleSort(array2, size2);

    cout << "Before sorting ";
    printArray(array3, size3);
    cout << "After sorting ";
    bubbleSort(array3, size3);

    return 0;
}
