# FCFS Scheduling
n = int(input("Enter number of processes: "))
procs = []
for i in range(1, n + 1):
    pid = input(f"\nEnter Process ID {i}: ")
    procs.append([pid, int(input("Arrival Time: ")),
                 int(input("Burst Time: "))])


def line(k=20): return print("-" * k)


print("\n\nProcess List")
line()
print("PID\tAT\tBT")
line()
for p in procs:
    print(*p, sep="\t")
line()

t, result = 0, []
for pid, at, bt in sorted(procs, key=lambda x: x[1]):
    t = max(t, at)
    ct = t + bt
    result.append([pid, at, bt, t, ct, ct - at, ct - at - bt])
    t = ct

print("\n\nFCFS Scheduling Table")
line(50)
print("PID\tAT\tBT\tST\tCT\tTAT\tWT")
line(50)
for r in result:
    print(*r, sep="\t")
line(50)

print(f"\nAverage Waiting Time    : {sum(r[6] for r in result) / n:.2f}")
print(f"Average Turnaround Time : {sum(r[5] for r in result) / n:.2f}")

bar = " " + "-------" * n
print("\n\nGantt Chart")
print(bar)
print("|" + "".join(f"  {r[0]}  |" for r in result))
print(bar)
print(f"{result[0][3]}" + "".join(f"{r[4]:>7}" for r in result))
