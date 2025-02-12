/*
3. Write a Java program to search an element in an array.
 */
package com.mycompany.programs;

import java.util.Scanner;

public class Program3 {

    public static void main(String[] args) {
        Scanner inp = new Scanner(System.in);

        System.out.print("Enter the size of an array : ");
        int size = inp.nextInt();

        int[] array = new int[size];

        for (int i = 0; i < array.length; i++) {
            System.out.printf("Enter element - %d : ", (i + 1));
            array[i] = inp.nextInt();
        }

        System.out.println("Enter element you want to search : ");
        int search = inp.nextInt();

        boolean result = false;

        for (int i = 0; i < array.length; i++) {
            if (array[i] == search) {
                System.out.printf("Element found at index %d", i);
                result = true;
                break;
            }
        }

        if (!result) {
            System.out.println("Error! element not found");
        }
    }
}
