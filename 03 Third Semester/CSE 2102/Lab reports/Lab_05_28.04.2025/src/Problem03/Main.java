package Problem03;

public class Main {
    public static void main(String[] args) {

        Employee emp1 = new Employee();
        emp1.displayEmployee();
        System.out.println();

        Worker wr1 = new Worker();
        wr1.displayWorker();
        System.out.println();

        Supervisor sp1 = new Supervisor();
        sp1.displaySupervisor();

    }
}
