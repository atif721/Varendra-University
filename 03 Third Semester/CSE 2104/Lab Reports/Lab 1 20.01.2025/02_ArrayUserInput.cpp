#include <iostream>
using namespace std;

int main() {

    int size;
    cout << "Enter array size : ";
    cin >> size;
    cout << endl;

    int arr[size];

    int i = 0, j = 0;
    while (i < size) {
        cout << "Enter array element - " << i + 1 << " : ";
        cin >> arr[i];
        i++;
    }

    cout << endl << "Elements : ";
    while (j < size) {
        cout << arr[j] << " ";
        j++;
    }

    return 0;
}