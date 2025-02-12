// 1. Write a Java program to find the sum of all odd numbers in an array.
//
package com.mycompany.programs;

import java.util.Scanner;

public class Program1 {

    public static void main(String[] args) {
        Scanner inp = new Scanner(System.in);

        System.out.print("Enter the size of an array : ");
        int size = inp.nextInt();

        int[] array = new int[size];

        for (int i = 0; i < array.length; i++) {
            System.out.printf("Enter element - %d : ", (i + 1));
            array[i] = inp.nextInt();
        }

        int sum = 0;

        for (int i = 0; i < array.length; i++) {
            if (array[i] % 2 != 0) {
                sum += array[i];
            }
        }

        System.out.println("Sum of all odd numbers : " + sum);

    }
}
