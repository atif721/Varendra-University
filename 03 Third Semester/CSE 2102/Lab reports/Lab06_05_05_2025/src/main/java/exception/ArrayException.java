package exception;

public class ArrayException {

    public static void main(String[] args) {
        try {
            int[] numbers = {1, 2, 3};
            System.out.println("Invalid index value: " + numbers[10]);

        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("Error: Invalid array index!");
            System.out.println("Exception type: " + e.getClass().getSimpleName());

        } finally {
            System.out.println("Finally block executed");
        }
    }
}
