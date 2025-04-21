package Student;

public class Student {

    private int id;
    private String name;
    private String dept;
    private double cgpa;

    public Student(int id, String name, String dept, double cgpa) {
        this.id = id;
        this.name = name;
        this.dept = dept;
        this.cgpa = cgpa;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public double getCgpa() {
        return cgpa;
    }

    public void setCgpa(double cgpa) {
        this.cgpa = cgpa;
    }

}
