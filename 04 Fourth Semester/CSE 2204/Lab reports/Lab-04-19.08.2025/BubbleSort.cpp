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
        array[i] = rand() % 850 + 7;
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
void bubbleSort(int *array, int n) {
    int cntSwap = 0;
    int cntCompare = 0;
    for (int i = 0; i < n - 1; i++) {
        bool swapped = false;
        for (int j = 0; j < n - 1 - i; j++) {
            if (array[j] > array[j + 1]) {
                swap(array[j], array[j + 1]);
                swapped = true;
                cntSwap++;
            }
            cntCompare++;
        }
        if (!swapped)
            break;
    }
    cout << "Swapping : " << cntSwap << endl;;
    cout << "Comparing : " << cntCompare << endl;
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
    bubbleSort(array, size);

    delete[] array;
    return 0;
}