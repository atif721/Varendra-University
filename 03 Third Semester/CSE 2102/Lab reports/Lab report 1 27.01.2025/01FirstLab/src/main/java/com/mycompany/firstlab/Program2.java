package com.mycompany.firstlab;

public class Program2 {

    public void stringMethods() {
        String string1 = "Hello";
        char result = string1.charAt(0);
        System.out.printf("charAt %d : %c\n", 0, result);

        String firstN = "Abdullah ";
        String lastN = "Atif";
        System.out.println("Concating names : " + firstN.concat(lastN));

        String string2 = "Varendra";
        System.out.println("Contains : " + string2.contains("ar"));
        System.out.println("Contains : " + string2.contains("V"));
        System.out.println("Contains : " + string2.contains("U"));

        String stringEq1 = "CSE-2102";
        String stringEq2 = "CSE-2102";
        String stringEq3 = "MAT-2141";

        System.out.println("String equality : " + stringEq1.equals(stringEq2));
        System.out.println("String equality : " + stringEq2.equals(stringEq3));

        String string3 = "Bangladesh is a beautiful country";
        System.out.println("Index of  : " + string3.indexOf("country"));

        String stringTest1 = "University";
        String stringTest2 = "";
        System.out.println("Empty : " + stringTest1.isEmpty());
        System.out.println("Empty : " + stringTest2.isEmpty());

        String checkLen = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        System.out.println("Length : " + checkLen.length());

        String repStr = "Good N";
        System.out.println(repStr.replace('N', 'M'));

        String myStr = "Split a string by spaces, and also punctuation.";
        String regex = "[,\\.\\s]";
        String[] myArray = myStr.split(regex);
        for (String s : myArray) {
            System.out.println(s);
        }

        String upLowTxt = "Real Madrid";
        System.out.println("Upper case : " + upLowTxt.toUpperCase());
        System.out.println("Lower case : " + upLowTxt.toLowerCase());

        String trimStr = "       Hello World!       ";
        System.out.println("Without trim : " + trimStr);
        System.out.println("When trimed : " + trimStr.trim());
    }
}
