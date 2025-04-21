package problem01;

public class Main {

    public static void main(String[] args) {
        Student stu1 = new Student("Nishat", 241311050, 3.76f);
        Student stu2 = new Student("Rinkey", 241311059, 4.00f);
        Student stu3 = new Student("Hridy", 241311060, 3.00f);
        stu1.setName("Nishat");
        stu1.setID(241311050);
        stu1.setCGPA(3.76f);

        stu2.setName("Rinkey");
        stu2.setID(241311059);
        stu2.setCGPA(4.00f);

        stu3.setName("hridy");
        stu3.setID(241311060);
        stu3.setCGPA(3.00f);

        System.out.println(stu1.getName());
        System.out.println(stu1.getID());
        System.out.println(stu1.getCGPA());
        System.out.println(stu2.getName());
        System.out.println(stu2.getID());
        System.out.println(stu2.getCGPA());
        System.out.println(stu3.getName());
        System.out.println(stu3.getID());
        System.out.println(stu3.getCGPA());
    }
}
