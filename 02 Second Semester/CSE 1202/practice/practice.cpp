#include <iostream>
using namespace std;

class Person {
private:
  string name, address;
  int age;

public:
  Person(string na, int ag, string add) {
    name = na;
    age = ag;
    address = add;
  }
  virtual void displayAll(){
    cout << "Name: " << name << endl;
    cout << "Age: " << age << endl;
    cout << "Address: " << address << endl;
  }
  virtual ~Person() {}
};

class Student: public Person {
private:
  string grades;

public:
  Student(string na, int ag, string add, string gra): Person(na, ag, add), grades(gra){}

  void displayAll() override {
    Person::displayAll();
    cout << "Grades: "<<grades<<endl;
  }
};

class Teacher: public Person {
private:
  string subjects;

public:
  Teacher(string na, int ag, string add, string sub): Person (na, ag, add), subjects(sub){}

  void displayAll() override {
    Person::displayAll();
    cout << "Subjects: "<<subjects<<endl;
  }
};

class Staff : public Person {
private:
  string workSchedule;

public:
  Staff(string na, int ag, string add, string sch) : Person ( na, ag, add), workSchedule(sch){}

  void displayAll() override {
    Person::displayAll();
    cout << "Work Schedule: " << workSchedule << endl;
  }
};


int main() {
    system ("cls");
  Person* ob1 = new Student("Nishat", 22, "Rajshahi", "A+");
  Person* ob2 = new Teacher("Sir", 50, "I don't know", "CSE");
  Person* ob3 = new Staff("Nawsheen", 22, "Rajshahi", "10AM - 4PM");

  cout << "Details of Students: "<<endl;
  ob1->displayAll();
  cout << "Details of Teachers: "<<endl;
  ob2->displayAll();
  cout << "Details of Staff: "<<endl;
  ob3->displayAll();
  delete ob1,ob2,ob3;

  return 0;
}