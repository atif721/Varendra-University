// addinig a element at last index of array
#include <iostream>
using namespace std;

int main()
{
    system("cls");
    int n, x, i;

    cout << "Enter the size of an array: ";
    cin >> n;

    int array[n];
    cout << endl;

    for (i = 0; i < n; i++)
    {
        cout << "Element - " << i + 1 << " : ";
        cin >> array[i];
    }

    cout << endl
         << "Enter the new element : ";
    cin >> x;

    array[i] = x;
    n++;

    cout << endl;
    for (i = 0; i < n; i++)
    {
        cout << "Element - " << i + 1 << " : " << array[i] << endl;
    }

    return 0;
}