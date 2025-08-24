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
void selectionSort(int *array, int n) {
    int swappingCount = 0;
    int compareCount = 0;
    int i, j;
    for (i = 0; i < n - 1; i++) {
        int min = i;
        for (j = i + 1; j < n; j++) {
            if (array[min] > array[j])
                min = j;
            compareCount++;
        }
        swap(array[i], array[min]);
        swappingCount++;
    }
    cout << "Swapping : " << swappingCount << endl;
    cout << "Comparing : " << compareCount << endl;
    cout << "After sorting, ";
    printArray(array, n);
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

    printArray(array, size);
    selectionSort(array, size);

    delete[] array;
    return 0;
}
