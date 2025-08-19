#include <iostream>
using namespace std;

void printArray(int* array, int size) {
    cout << "Array Elements are : ";
    for (int i = 0; i < size; i++) {
        cout << array[i] << " ";
    }
    cout << endl;
}

void selectionSort(int* array, int n) {
    int swappingCount = 0;
    int compareCount = 0;
    int i, j;
    for (i = 0; i < n - 1; i++) {
        int min = i;
        for (j = i + 1; j < n; j++) {
            if (array[min] > array[j]) {
                min = j;
            }
            compareCount++;
        }
        int temp = array[i];
        array[i] = array[min];
        array[min] = temp;
        swappingCount++;
    }
    printArray(array, n);
    cout << "Swapping : " << swappingCount << endl;
    cout << "Comparing : " << compareCount << endl;
}

int main() {
    // srand(time(NULL));
    cout << rand() % 3 + 2 << endl;

    int array1[] = { 5,6,9,15,36,100 };
    int array2[] = { 60,50,40,30,20,10 };
    int array3[] = { 6,4,9,3,11,8,15,12 };

    int size1 = sizeof(array1) / sizeof(array1[0]);
    int size2 = sizeof(array2) / sizeof(array2[0]);
    int size3 = sizeof(array3) / sizeof(array3[0]);

    cout << "Before sorting ";
    printArray(array1, size1);
    cout << "After sorting ";
    selectionSort(array1, size1);

    cout << "Before sorting ";
    printArray(array2, size2);
    cout << "After sorting ";
    selectionSort(array2, size2);

    cout << "Before sorting ";
    printArray(array3, size3);
    cout << "After sorting ";
    selectionSort(array3, size3);

    return 0;
}
