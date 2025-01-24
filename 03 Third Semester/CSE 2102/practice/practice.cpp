#include <iostream>
using namespace std;

int exeption();
int calculate_Factorial(int a);

int main() {
  system("cls");

  exeption();
  exeption();

  return 0;
}

int exeption() {
  try {
    int n;
    cout << "Enter a number you want its Factorial:";
    cin >> n;
    int fact;

    if (n < 0)throw "E";

    fact = calculate_Factorial(n);
    cout << n << "! = " << fact << endl;
  }
  catch (...) {
    cout << "...Error... \n Factorial is not Applicable for negative number." << endl;
  }

}

int calculate_Factorial(int a) {
  if (a == 1)return 1;
  return a * calculate_Factorial(a - 1);
}