package Square;

public class Main {

    public static void main(String[] args) {
        Square sq1 = new Square(15);
        Square sq2 = new Square(20);
        Square sq3 = new Square(35);

        sq1.setLength(56);
        System.out.println("Length of the Square1 " + sq1.getLength());

        sq2.setLength(14);
        System.out.println("Length of the Square2 " + sq2.getLength());

        System.out.println("Length of the Square3 " + sq3.getLength());

    }
}
