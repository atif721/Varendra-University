package inheritance;

class Animal {

    String name = "unknown";
    String food = "null";
    int age = 0;

    public void display() {
        System.out.println("Name : " + name);
        System.out.println("Food : " + food);
        System.out.println("Age : " + age);
    }
}

class Cat extends Animal {

    Animal an1 = new Animal();

    public void change() {
        an1.name = "Jerry";
        an1.food = "Cat";
        an1.age = 2;
    }

    public void displayInfo() {
        System.out.println("Name : " + an1.name);
        System.out.println("Food : " + an1.food);
        System.out.println("Age : " + an1.age);
    }
}

public class Main extends Cat {

    public static void main(String[] args) {
        Main obj1 = new Main();

        obj1.display();
        obj1.change();
        obj1.displayInfo();
    }
}
