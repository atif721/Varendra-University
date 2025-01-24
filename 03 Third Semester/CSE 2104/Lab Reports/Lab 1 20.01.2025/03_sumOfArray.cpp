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

    int sum = 0;

    for (int i = 0; i < size; i++) {
        sum += arr[i];
    }

    cout << endl << "Sum of elements : " << sum << endl;


    return 0;
}