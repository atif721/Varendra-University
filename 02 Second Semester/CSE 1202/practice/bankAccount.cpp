#include <iostream>
using namespace std;

class BankAccount {
private:
    double balance;

public:
    BankAccount() {} // default constructor
    BankAccount(double balan) {
        balance = balan;
    }

    void withdraw(double withdraw) {
        try {
            if (withdraw > balance) {
                throw "E";
            }
        }
        catch (...) {
            cout << "Insufficient funds." << endl;
        }
    }
};

int main() {
    system("cls");

    BankAccount acc1, acc2(5000.55), acc3(1500.565);
    acc2.withdraw(500.22);
    acc3.withdraw(50000.22);

    return 0;
}