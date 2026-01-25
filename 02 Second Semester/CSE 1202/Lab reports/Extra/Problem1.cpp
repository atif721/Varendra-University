/*
1. Write a program that calculates the factorial of a given number n. Use exception handling to:
    #Throw an exception if the input is negative.
*/
/*
#include <iostream>
using namespace std;

// Function to calculate factorial
void Checkfactorial() {

    try {
        int n;
        cout << "Enter a number to calculate its factorial: ";
        cin >> n;

        if (n < 0) {
            throw "Factorial of a negative number is not defined.";
        }
        int result = 1;
        for (int i = 1; i <= n; ++i) {
            result *= i;
        }
        cout << "Factorial of " << n << " is " << result << endl;
    }
    catch (const char* err) {
        cerr << "Error: " << err << endl;
    }
}

int main() {
    system("cls");

    Checkfactorial();
    Checkfactorial();
    return 0;
}
*/

#include <iostream>
using namespace std;

// Function to calculate factorial
unsigned long long factorial(int n) {
    if (n < 0) {
        throw "Factorial of a negative number is not defined.";
    }

    unsigned long long result = 1;
    for (int i = 1; i <= n; ++i) {
        unsigned long long prev_result = result; // Store the previous result
        result *= i;

        // Check for overflow by comparing the result after division
        if (result / i != prev_result) {
            throw "Factorial result is too large and caused an overflow.";
        }
    }
    return result;
}

int main() {
    try {
        int n;
        cout << "Enter a number to calculate its factorial: ";
        cin >> n;

        unsigned long long result = factorial(n);
        cout << "Factorial of " << n << " is " << result << endl;
    } catch (const char* err) {
        cerr << "Error: " << err << endl;
    }

    return 0;
}
