#include <iostream>
using namespace std;

class MyClass {
private:
    static int s_member;
public:
    static int counter; // Declaration of static data member

    MyClass() {
        counter++; // Increment counter whenever an object is created
    }

    // Static member function to modify the private static data member
    static void setStaticMember(int value) {
        s_member = value;
    }

    // Static member function to access private static data member
    static int getStaticMember() {
        return s_member;
    }

    static void displayCounter() {
        // Static function can access only static data members
        cout << "Number of objects created: " << counter << endl;
    }
};

// Definition and initialization of static data member
int MyClass::counter = 0;
int MyClass::s_member = 33;

int main() {
    system("cls");

    MyClass obj1;
    MyClass obj2;
    MyClass obj3;

    // Accessing static data member using class name
    MyClass::displayCounter();

    // Accessing private static data member using static member functions
    cout << "Initial value of s_member: " << MyClass::getStaticMember() << endl;

    // Modifying the private static data member
    MyClass::setStaticMember(100);
    cout << "Updated value of s_member: " << MyClass::getStaticMember() << endl;

    return 0;
}

