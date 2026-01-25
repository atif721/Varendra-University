/*
3. Factorial for Multiple Inputs
    Allow the user to input multiple numbers and calculate their factorials in a loop. Use exception handling to continue processing even if one input is invalid or causes an error.

*/

#include <iostream>
using namespace std;

// Iterative factorial function
int factorial(int n) {
    if (n < 0) {
        throw "Factorial of a negative number is not defined.";
    }
    int result = 1;
    for (int i = 1; i <= n; ++i) {
        result *= i;
    }
    return result;
}

int main() {
    int numbers[5]; // Array for multiple inputs
    cout << "Enter 5 numbers to calculate their factorials:\n";
    for (int i = 0; i < 5; ++i) {
        cin >> numbers[i];
    }

    for (int i = 0; i < 5; ++i) {
        try {
            int result = factorial(numbers[i]);
            cout << "Factorial of " << numbers[i] << " is " << result << endl;
        }
        catch (const char* err) {
            cerr << "Error with input " << numbers[i] << ": " << err << endl;
        }
    }

    return 0;
}
