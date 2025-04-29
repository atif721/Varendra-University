package Problem04;

class Vehicle {
    public void speedUp() {
        System.out.println("Speeding up your Vehicle");
    }
}

class Bicycle extends Vehicle {
    int currentSpeed = 10;

    @Override
    public void speedUp() {
        System.out.println("Speeding up your Bike");
    }
}

class Car extends Vehicle {
    int currentSpeed = 100;

    @Override
    public void speedUp() {
        System.out.println("Speeding up your Car");
    }
}