/*
2. Write a Java program that takes two arrays as input, calculate the
index wise sum of these arrays, and store the result in a third array.
 */
package programs;

import java.util.Scanner;

public class Program2 {

    public static void main(String[] args) {
        Scanner inp = new Scanner(System.in);

        System.out.print("Enter the size of both Arrays : ");
        int size = inp.nextInt();

        int[] array1 = new int[size];

        System.out.println("Array1 elements input : ");
        for (int i = 0; i < array1.length; i++) {
            System.out.printf("Enter element - %d : ", (i + 1));
            array1[i] = inp.nextInt();
        }

        int[] array2 = new int[size];

        System.out.println("\nArray2 elements input : ");
        for (int i = 0; i < array2.length; i++) {
            System.out.printf("Enter element - %d : ", (i + 1));
            array2[i] = inp.nextInt();
        }

        int[] array3 = new int[size];

        for (int i = 0; i < size; i++) {
            array3[i] = array1[i] + array2[i];
        }

        System.out.println("Index wise summed Array : ");
        for (int i = 0; i < size; i++) {
            System.out.printf("%d ", array3[i]);
        }
    }
}
