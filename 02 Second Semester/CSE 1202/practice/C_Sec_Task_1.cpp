#include<iostream>
using namespace std;

class Teacher {
private:
    int teacherID = 11001;
    string subject = "CSE 1201";

public:
    void displayTeacherDetails() {
        cout << "Teacher ID : " << teacherID << endl;
        cout << "Teacher Subject : " << subject << endl;
    }
};

class Researcher {
private:
    string researchTopic = "Unemployement in Bangladesh";
    string papersPublished = "04th December, 2024";

public:
    void displayrResearcherDetails() {
        cout << "Reaserch Topic : " << researchTopic << endl;
        cout << "Research Paper Published : " << papersPublished << endl;
    }
};

class Admin {
private:
    int adminID = 55231;
    string department = "Computer Science";

public:
    
    void displayrAdminDetails() {
        cout << "Admin ID : " << adminID << endl;
        cout << "Admin Department : " << department << endl;
    }
};

class Professor : public Teacher, Researcher, Admin {
public:
    void displayDetails() {
        Teacher::displayTeacherDetails();
        Researcher::displayrResearcherDetails();
        Admin::displayrAdminDetails();
    }

};

int main() {
    system("cls");

    Professor pro1;
    pro1.displayDetails();

    return 0;
}