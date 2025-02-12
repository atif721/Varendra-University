package com.mycompany.firstlab;

public class Program3 {

    public void printElement() {
        for (int i = 1; i <= 10; i++) {
            if (i == 5) {
                continue;
            }
            System.out.println(i);
        }
    }
}
