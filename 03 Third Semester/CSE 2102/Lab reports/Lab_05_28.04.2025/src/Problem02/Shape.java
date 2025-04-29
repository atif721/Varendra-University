package Problem02;

public class Shape {

    public void calculateArea(int side_length) {
        System.out.println("Area of Square : " + (side_length * side_length));
    }

    public void calculateArea(int length, int width) {
        System.out.println("Area of Rectangle : " + (length * width));
    }

    public void calculateArea(double radius) {
        System.out.printf("Area of Circle : %.2f ", radius * radius * 3.1416);
    }
}
