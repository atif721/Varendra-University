#include <iostream>
using namespace std;

int main() {

    int size;
    cout << "Enter array size : ";
    cin >> size;
    cout << endl;

    int arr[size];

    int i = 0;
    while (i < size) {
        cout << "Enter array element - " << i + 1 << " : ";
        cin >> arr[i];
        i++;
    }

    int max = arr[0];
    int min = arr[0];

    for (int i = 0; i < size; i++) {

        if (max < arr[i]) {
            max = arr[i];
        }
    }

    for (int i = 0; i < size; i++) {

        if (min > arr[i]) {
            min = arr[i];
        }
    }

    cout << endl << "Max element: " << max << endl;
    cout << endl << "Min element: " << min << endl;

    return 0;
}