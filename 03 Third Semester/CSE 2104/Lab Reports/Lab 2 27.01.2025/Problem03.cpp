// linear search

#include <iostream>
using namespace std;

int main() {

    int n, i;

    cout << "Enter the size of an array: ";
    cin >> n;

    int array[n];
    cout << endl;

    for (i = 0; i < n; i++) {
        cout << "Element - " << i + 1 << " : ";
        cin >> array[i];
    }

    int search;
    cout << endl
        << "Enter element you want to find: ";
    cin >> search;


    bool found = false;
    for (i = 0; i < n; i++) {
        if (array[i] == search)
        {
            cout << "Element found at index " << i << endl;
            found = true;
            break;
        }
    }

    if (!found) {
        cout << "Element not found in the array." << endl;
    }

    return 0;
}