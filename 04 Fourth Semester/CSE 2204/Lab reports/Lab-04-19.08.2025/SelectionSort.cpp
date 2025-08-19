#include <iostream>
using namespace std;

void selectionSort(int arr[], int n) {
    for(int i = 0; i < n-1; i++) {
        int minIndex = i;
        for(int j = i+1; j < n; j++) {
            if(arr[j] < arr[minIndex]) {  // For ascending order
                minIndex = j;
            }
        }
        if(minIndex != i) swap(arr[i], arr[minIndex]);
    }
}

int main() {
    int arr[] = {5, 2, 9, 1, 5};
    int n = sizeof(arr)/sizeof(arr[0]);

    selectionSort(arr, n);

    cout << "Selection Sorted Array: ";
    for(int i = 0; i < n; i++) cout << arr[i] << " ";
    cout << endl;

    return 0;
}
