package Problem04;

public class Main {
    public static void main(String[] args) {
        Vehicle v1 = new Vehicle();
        v1.speedUp();

        v1 = new Bicycle();
        v1.speedUp();

        v1 = new Car();
        v1.speedUp();
    }
}
