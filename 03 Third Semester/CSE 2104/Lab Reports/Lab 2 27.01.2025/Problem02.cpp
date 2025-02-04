// adding multiple elements in array later
#include <iostream>
using namespace std;

int main() {

    int n, x, i, max;

    cout << "Enter the max size of the array : ";
    cin >> max;

    int array[max];

    cout << endl
        << "Enter the size of an array: ";
    cin >> n;

    array[n];
    cout << endl;

    for (i = 0; i < n; i++)
    {
        cout << "Element - " << i + 1 << " : ";
        cin >> array[i];
    }

    cout << endl;

    int m;
    cout << "Number of new elements to enter : ";
    cin >> m;

    for (i = n; i < (n + m); i++)
    {
        cout << "Element - " << (i + 1) << " : ";
        cin >> array[i];
    }

    cout << endl;
    for (i = 0; i < (n + m); i++)
    {
        cout << "Element - " << i + 1 << " : " << array[i] << endl;
    }

    return 0;
}