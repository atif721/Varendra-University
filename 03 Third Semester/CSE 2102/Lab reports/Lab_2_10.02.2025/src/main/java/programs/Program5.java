/*
5. Write a Java program to find the second highest element of an array.
 */
package programs;

import java.util.Scanner;

public class Program5 {

    public static void main(String[] args) {
        Scanner inp = new Scanner(System.in);

        System.out.println(1 != 15);

        System.out.print("Enter the size of an array : ");
        int size = inp.nextInt();

        int[] array = new int[size];

        for (int i = 0; i < array.length; i++) {
            System.out.printf("Enter element - %d : ", (i + 1));
            array[i] = inp.nextInt();
        }

        System.out.print("Array elements : ");
        for (int i = 0; i < size; i++) {
            System.out.printf("%d ", array[i]);
        }

        int max = array[0];
        int secondMax = array[0];

        for (int i = 0; i < array.length; i++) {
            if (array[i] > max) {
                secondMax = max;
                max = array[i];
            } else if (array[i] > secondMax && array[i] != max) {
                secondMax = array[i];
            }
        }

        System.out.println("\nSecond highest element: " + secondMax);

        inp.close();
    }
}
