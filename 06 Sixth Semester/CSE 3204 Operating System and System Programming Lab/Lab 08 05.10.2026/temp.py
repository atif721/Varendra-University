# FCFS Scheduling

n = int(input("Enter number of processes: "))
processes = []

for i in range(1, n + 1):
    pid = input(f"\nEnter Process ID {i}: ")
    at = int(input("Arrival Time: "))
    bt = int(input("Burst Time: "))
    processes.append([pid, at, bt])

# Sort by arrival time
processes.sort(key=lambda x: x[1])

current_time = total_wt = total_tat = 0
result = []

print("\nPID\tAT\tBT\tST\tCT\tTAT\tWT")
print("-" * 50)

for pid, at, bt in processes:
    if current_time < at:
        current_time = at

    start = current_time
    ct = start + bt
    tat = ct - at
    wt = tat - bt

    result.append([pid, start, ct])
    total_wt += wt
    total_tat += tat
    current_time = ct

    print(f"{pid}\t{at}\t{bt}\t{start}\t{ct}\t{tat}\t{wt}")

print("-" * 50)
print(f"\nAverage Waiting Time    : {total_wt/n:.2f}")
print(f"Average Turnaround Time : {total_tat/n:.2f}")

# Gantt Chart
print("\nGantt Chart:\n")
print(" " + "-------" * len(result))
print("|" + "".join(f"  {p[0]}  |" for p in result))
print(" " + "-------" * len(result))
print(result[0][1], end="")
for p in result:
    print(f"{p[2]:>7}", end="")
print()