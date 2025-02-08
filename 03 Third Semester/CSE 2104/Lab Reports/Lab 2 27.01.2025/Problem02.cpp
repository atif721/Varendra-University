// adding multiple elements in array later
#include <iostream>
using namespace std;

int main() {
    int n, x, i, max;

    cout << "Enter the max size of the array: ";
    cin >> max;

    int array[max];

    cout << endl << "Enter the initial size of the array: ";
    cin >> n;

    if (n > max) {
        cout << "Error: Initial size cannot be greater than the max size!" << endl;
        return 1;
    }

    cout << endl;
    for (i = 0; i < n; i++) {
        cout << "Element - " << i + 1 << " : ";
        cin >> array[i];
    }

    int m;
    cout << endl << "Number of new elements to enter: ";
    cin >> m;

    if ((n + m) > max) {
        cout << "Error: Cannot add ";
        cout << m << " elements. Exceeds max size of the array!" << endl;
        return 1;
    }

    for (i = n; i < (n + m); i++) {
        cout << "Element - " << i + 1 << " : ";
        cin >> array[i];
    }

    cout << endl << "Updated array:" << endl;
    for (i = 0; i < (n + m); i++) {
        cout << "Element - " << i + 1 << " : " << array[i] << endl;
    }

    return 0;
}