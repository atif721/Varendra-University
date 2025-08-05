#include <iostream>
using namespace std;

int main() {
    int input;
    cout << "Enter the number of natural numbers to display: ";
    cin >> input;

    int sum_numbers = (input * (input + 1)) / 2;

    for (int i = 0; i < input; i++)
    {
        cout << i + 1 << " ";
    }

    cout << endl
        << "Sum of first " << input << " natural numbers : " << sum_numbers << endl;

    return 0;
}