package Employee;

public class Main {

    public static void main(String[] args) {
        Employee emp1 = new Employee(121, "Abrar", 23645.331);
        Employee emp2 = new Employee(141, "Mabrur", 98415.331);
        Employee emp3 = new Employee(161, "Evu", 25555.331);

        emp1.setId(1456);
        emp2.setId(56);
        emp3.setSalary(327791.55);

        System.out.println("Employee 1 ID : " + emp1.getId());
        System.out.println("Employee 2 ID : " + emp2.getId());
        System.out.println("Employee 3 ID : " + emp3.getId());

        System.out.println("Employee 1 Name : " + emp1.getName());
        System.out.println("Employee 2 Name : " + emp2.getName());
        System.out.println("Employee 3 Name : " + emp3.getName());

        System.out.println("Employee 1 salary : " + emp1.getId());
        System.out.println("Employee 2 salary : " + emp2.getId());
        System.out.println("Employee 3 salary : " + emp3.getId());

    }
}
