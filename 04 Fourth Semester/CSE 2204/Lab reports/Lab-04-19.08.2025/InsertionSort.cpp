#include <iostream>
#include <ctime>
using namespace std;
void printArray(int *array, int size) {
    cout << "Array Elements are : ";
    for (int i = 0; i < size; i++) {
        cout << array[i] << " ";
    }
    cout << endl;
}
void gentArray(int *array, int n, string type) {
    srand(time(NULL));
    for (int i = 0; i < n; i++)
        array[i] = rand() % 600 + 132;
    if (type == "average")
        return;
    for (int i = 0; i < n - 1; i++)
        for (int j = 0; j < n - 1 - i; j++)
            if (array[j] > array[j + 1]) {
                swap(array[j], array[j + 1]);
            }
    if (type == "worst")
        for (int i = 0; i < n / 2; i++) {
            swap(array[i], array[n - 1 - i]);
        }
}
void insertionSort(int *array, int n) {
    int shiftingCount = 0;
    int compareCount = 0;
    for (int i = 1; i < n; i++) {
        int key = array[i];
        int j = i - 1;
        while (j >= 0) {
            compareCount++;
            if (array[j] > key) {
                array[j + 1] = array[j];
                j--;
                shiftingCount++;
            }
            else 
                break;
        }
        array[j + 1] = key;
    }
    cout << "Shifting : " << shiftingCount << endl;
    cout << "Comparing : " << compareCount << endl;
    // cout << "After sorting, ";
    // printArray(array, n);
}

int main() {
    string cases;
    cout << "Case (best, average, worst) ?: ";
    cin >> cases;
    int size;
    cout << "Element Size ? : ";
    cin >> size;

    int *array = new int[size];
    gentArray(array, size, cases);
    cout << "\nCase: " << cases << " | ";
    cout << "Size: " << size << endl;

    // printArray(array, size);
    insertionSort(array, size);

    delete[] array;
    return 0;
}