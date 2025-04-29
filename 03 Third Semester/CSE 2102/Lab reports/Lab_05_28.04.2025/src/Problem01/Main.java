package Problem01;

public class Main {
    public static void main(String[] args) {

        Calculator cal1 = new Calculator();
        System.out.println("Sum of two integer : " + cal1.Addition(50, 60));
        System.out.println("Sum of two double : " + cal1.Addition(53.2, 47.5));
        System.out.println("Sum of three integer : " + cal1.Addition(5, 6, 8) + "\n");
    }
}