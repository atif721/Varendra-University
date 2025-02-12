/*
4. Write a Java program to reverse the elements in an array without using a second array.
 */
package com.mycompany.programs;

import java.util.Scanner;

public class Program4 {

    public static void main(String[] args) {
        Scanner inp = new Scanner(System.in);

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

        int temp;

        for (int i = 0; i < size / 2; i++) {
            temp = array[i];
            array[i] = array[size - 1 - i];
            array[size - 1 - i] = temp;
        }

        System.out.println("Reversed array : ");
        for (int i = 0; i < size; i++) {
            System.out.printf("%d ", array[i]);
        }
    }
}
