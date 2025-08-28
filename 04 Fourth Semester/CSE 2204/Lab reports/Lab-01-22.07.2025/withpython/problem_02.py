#include <iostream>
using namespace std;

int main() {
    int n;
    cout << "Enter n numbers : ";
    cin >> n;

    cout << "first one" << endl;
    for (int i = 1; i <= n; i++)
    {
        for (int j = 1; j <= i; j++)
        {
            cout << i;
        }
        cout << endl;
    }

    cout << endl
        << "second " << endl;
    int val;
    for (int i = 1; i <= n; i++)
    {
        val = (i % 2 == 0) ? 0 : 1;
        for (int j = 1; j <= i; j++)
        {
            cout << val;
            val = 1 - val;
        }
        cout << endl;
    }

    cout << endl
        << "third" << endl;
    for (int i = 0; i < n; i++)
    {
        cout << "*";
    }
    cout << endl;

    for (int i = 1; i <= n; i++)
    {
        for (int j = 1; j <= i; j++)
        {
            cout << "*";
        }
        cout << endl;
    }

    return 0;
}
