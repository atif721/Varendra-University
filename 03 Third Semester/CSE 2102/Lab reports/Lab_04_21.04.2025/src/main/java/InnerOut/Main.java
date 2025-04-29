package InnerOut;

class Outer {

    int A = 455;

    class Inner {

        int B = 545;
    }
}

public class Main {

    public static void main(String[] args) {
        Outer obj1 = new Outer();

        Outer.Inner obj2 = obj1.new Inner();

        System.out.println("Sum : " + (obj1.A + obj2.B));
    }
}
