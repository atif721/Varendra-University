/*
4. Factorial with Floating-Point Inputs
    Accept a floating-point number as input. If the input is not an integer, throw an exception. Otherwise, calculate the factorial.
*/

#include <iostream>
#include <cmath>
using namespace std;

// Iterative factorial function
unsigned long long factorial(int n) {
    if (n < 0) {
        throw "Factorial of a negative number is not defined.";
    }
    unsigned long long result = 1;
    for (int i = 1; i <= n; ++i) {
        result *= i;
    }
    return result;
}

int main() {
    try {
        double input;
        cout << "Enter a number to calculate its factorial: ";
        cin >> input;

        if (input != floor(input)) {
            throw "Input must be an integer.";
        }

        int n = static_cast<int>(input);
        unsigned long long result = factorial(n);
        cout << "Factorial of " << n << " is " << result << endl;
    }
    catch (const char* err) {
        cerr << "Error: " << err << endl;
    }

    return 0;
}
