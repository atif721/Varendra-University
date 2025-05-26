package Problem04;

class Vehicle {
    public void speedUp() {
        System.out.println("Vehicle:\n Previous speed: 20km/h, Speeding upto : 40km/h");
    }
}

class Bicycle extends Vehicle {
    int currentSpeed = 10;

    @Override
    public void speedUp() {
        System.out.println("Bicycle:\n Previous speed: 10km/h, Speeding upto : 15km/h");
    }
}

class Car extends Vehicle {
    int currentSpeed = 100;

    @Override
    public void speedUp() {
        System.out.println("Car:\n Previous speed: 80km/h, Speeding upto : 100km/h");
    }
}