//
package com.mycompany.firstlab;

import java.util.Scanner;

public class Program1 {

    Scanner inp = new Scanner(System.in);

    private int[] array;

    public void inputArray() {
        System.out.print("Enter the size of the array : ");
        int size = inp.nextInt();

        array = new int[size];

        for (int i = 0; i < array.length; i++) {
            System.out.printf("Enter element - %d : ", i + 1);
            array[i] = inp.nextInt();
        }
    }

    public void displayArray() {
        for (int i = 0; i < array.length; i++) {
            System.out.printf("Element - %d : %d\n", (i + 1), array[i]);
        }
    }
}
