package problem01;

public class Student {

    private String name;
    private int id;
    private float cgpa;

    public Student(String name, int id, float cgpa) {
        this.name = name;
        this.id = id;
        this.cgpa = cgpa;
    }

    public Student() {
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setID(int id) {
        this.id = id;
    }

    public void setCGPA(float cgpa) {
        this.cgpa = cgpa;
    }

    public String getName() {
        return name;
    }

    public int getID() {
        return id;
    }

    public float getCGPA() {
        return cgpa;
    }
}
