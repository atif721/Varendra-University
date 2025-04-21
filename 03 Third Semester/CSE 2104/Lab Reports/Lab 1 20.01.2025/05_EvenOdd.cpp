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

    cout << endl << "Even : ";
    for (int i = 0; i < size; i++) {
        if (arr[i] % 2 == 0) {
            cout << arr[i] << " ";
        }
    }

    cout << endl << "Odd : ";
    for (int i = 0; i < size; i++) {
        if (arr[i] % 2 != 0) {
            cout << arr[i] << " ";
        }
    }

    return 0;
}