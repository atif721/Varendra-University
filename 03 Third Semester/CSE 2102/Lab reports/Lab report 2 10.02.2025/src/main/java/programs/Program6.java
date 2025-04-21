/*
6. Write a Java program that calculates the average of an
array, excluding the highest and lowest values in the array.
 */
package programs;

import java.util.Scanner;

public class Program6 {

    public static void main(String[] args) {
        Scanner inp = new Scanner(System.in);

        System.out.print("Enter the size of an array : ");
        int size = inp.nextInt();

        int[] array = new int[size];

        for (int i = 0; i < array.length; i++) {
            System.out.printf("Enter element - %d : ", (i + 1));
            array[i] = inp.nextInt();
        }

        int max = array[0];
        int min = array[0];
        int sum = 0;

        for (int i = 0; i < array.length; i++) {
            if (array[i] > max) {
                max = array[i];
            }
            if (array[i] < min) {
                min = array[i];
            }
        }

        for (int i = 0; i < array.length; i++) {
            if (array[i] != max && array[i] != min) {
                sum += array[i];
            }
        }

        System.out.println("Sum of the array : " + sum);

        double average = sum / (array.length - 2);
        System.out.println("Average : " + average);
    }
}
