/*
2. Recursive Factorial Calculation with Exception Handling
    # Use recursion to calculate the factorial, and throw exceptions for invalid inputs or large numbers causing overflow.
*/

#include <iostream>
using namespace std;

// Function to calculate factorial recursively
int factorial(int n, int result = 1) {
    if (n < 0) {
        throw "Factorial of a negative number is not defined.";
    }
    if (n == 0 || n == 1) {
        return result;
    }

    // Check for overflow before performing the multiplication
    int prev_result = result;
    result *= n;
    
    if (result / n != prev_result) {
        throw "Factorial result is too large and caused an overflow.";
    }

    return factorial(n - 1, result);
}

int main() {
    try {
        int n;
        cout << "Enter a number to calculate its factorial: ";
        cin >> n;

        int result = factorial(n);
        cout << "Factorial of " << n << " is " << result << endl;
    }
    catch (const char* err) {
        cerr << "Error: " << err << endl;
    }

    return 0;
}
