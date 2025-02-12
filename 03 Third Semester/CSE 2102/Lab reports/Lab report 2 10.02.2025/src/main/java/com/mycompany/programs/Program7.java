/*
7. Write a Java program to calculate the sum of all the prime numbers in a 20 array.
 */
package com.mycompany.programs;

import java.util.Scanner;

public class Program7 {

    public static boolean isPrime(int n) {
        if (n < 2) {
            return false;
        }

        int i = 2;
        while (i * i <= n) {
            if (n % i == 0) {
                return false;
            }
            i++;
        }
        return true;
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        int row, column;

        System.out.print("Input row: ");
        row = sc.nextInt();

        System.out.print("Input column: ");
        column = sc.nextInt();

        int[][] array = new int[row][column];

        for (int i = 0; i < row; i++) {

            System.out.printf("Input %d elements for row %d: ", row, i + 1);

            for (int j = 0; j < column; j++) {
                array[i][j] = sc.nextInt();
            }
        }

        int sum = 0;

        for (int i = 0; i < row; i++) {
            for (int j = 0; j < column; j++) {
                if (isPrime(array[i][j])) {
                    sum += array[i][j];
                }
            }
        }

        System.out.println("Sum of prime numbers: " + sum);

    }
}
