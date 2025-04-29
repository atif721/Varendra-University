package Problem03;

class Employee {

    public int id = 2011;
    public String name = "Sakib Khan";

    public double calculateSalary() {
        return 500.33;
    }

    public void displayEmployee() {
        System.out.println("Id : " + id);
        System.out.println("Name : " + name);
        System.out.println("Salary : " + calculateSalary());
    }
}

class Worker extends Employee {

    public void setName() {
        this.name = "Nisho";
    }

    public void setId() {
        this.id = 2012;
    }

    double baseSalary = 10000.00;
    int bonus = 50000;

    @Override
    public double calculateSalary() {
        return baseSalary + bonus;
    }

    public void displayWorker() {
        setName();
        setId();
        System.out.println("Id : " + id);
        System.out.println("Name : " + name);
        System.out.println("Salary : " + calculateSalary());
    }
}

class Supervisor extends Employee {

    public void setName() {
        this.name = "Raihan Rafi";
    }

    public void setId() {
        this.id = 5542;
    }

    double baseSalary = 55000.00;
    int bonus = 4000;

    @Override
    public double calculateSalary() {
        return baseSalary + bonus;
    }

    public void displaySupervisor() {
        setName();
        setId();
        System.out.println("Id : " + id);
        System.out.println("Name : " + name);
        System.out.println("Salary : " + calculateSalary());
    }
}