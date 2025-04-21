package Student;

public class Main {

    public static void main(String[] args) {
        Student s1 = new Student(51, "Atif", "CSE", 3.12);
        Student s2 = new Student(311050, "Hridy", "EEE", 4.00);
        Student s3 = new Student(110, "Arafat", "CSE", 2.81);

        s1.setId(311051);
        s1.setCgpa(3.60);

        s2.setDept("CSE");
        s2.setName("Soniya");

        s3.setId(311041);
        s3.setCgpa(3.81);

        System.out.println("Student-1 Name : " + s1.getName());
        System.out.println("Student-1 ID : " + s1.getId());
        System.out.println("Student-1 CGPA : " + s1.getCgpa() + "\n");

        System.out.println("Student-2 Name : " + s2.getName());
        System.out.println("Student-2 ID : " + s2.getId());
        System.out.println("Student-2 CGPA : " + s2.getCgpa() + "\n");

        System.out.println("Student-3 Name : " + s3.getName());
        System.out.println("Student-3 ID : " + s3.getId());
        System.out.println("Student-3 CGPA : " + s3.getCgpa());

    }
}
