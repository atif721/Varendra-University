// linear search
#include <iostream>
using namespace std;

int main()
{
    system("cls");
    int n, i;

    cout << "Enter the size of an array: ";
    cin >> n;

    int array[n];
    cout << endl;

    for (i = 0; i < n; i++)
    {
        cout << "Element - " << i + 1 << " : ";
        cin >> array[i];
    }

    int search;
    cout << endl
         << "Enter element you want to find : ";
    cin >> search;

    cout << endl;

    for (i = 0; i < n; i++)
    {
        if (array[i] == search)
        {
            cout << "Element found at index " << i << endl;
            break;
        }
        else
        {
            cout << "Element not found";
            break;
        }
    }

    return 0;
}