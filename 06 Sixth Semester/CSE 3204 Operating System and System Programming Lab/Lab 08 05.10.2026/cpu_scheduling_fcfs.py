# FCFS Scheduling

processes = []

n = int(input("Enter number of processes: "))

for i in range(1, n + 1):
    pid = input(f"\nEnter Process ID {i}: ")
    at = int(input("Arrival Time: "))
    bt = int(input("Burst Time: "))
    processes.append([pid, at, bt])

print("\n\nProcess List")
print("-" * 30)
print("PID\tAT\tBT")
print("-" * 30)

for p in processes:
print(f"{p[0]}\t{p[1]}\t{p[2]}")

print("-" * 30)

processes.sort(key=lambda x: x[1])

current_time = 0
total_wt = 0
total_tat = 0

result = []
gantt = []

for pid, at, bt in processes:

if current_time < at:
        current_time = at

    start_time = current_time
    ct = start_time + bt

    tat = ct - at
    wt = tat - bt

    result.append([pid, at, bt, start_time, ct, tat, wt])

    gantt.append([pid, start_time, ct])

    current_time = ct

    total_wt += wt
    total_tat += tat

print("\n\nFCFS Scheduling Table")
print("-" * 70)

print("PID\tAT\tBT\tST\tCT\tTAT\tWT")
print("-" * 70)

for p in result:
print(
f"{p[0]}\t{p[1]}\t{p[2]}\t"
f"{p[3]}\t{p[4]}\t{p[5]}\t{p[6]}"
)

print("-" * 70)

avg_wt = total_wt / n
avg_tat = total_tat / n

print(f"\nAverage Waiting Time    : {avg_wt:.2f}")
print(f"Average Turnaround Time : {avg_tat:.2f}")

print("\n\nGantt Chart")

print(" ", end="")
for p in gantt:
print("-------", end="")
print()

print("|", end="")
for p in gantt:
print(f"  {p[0]}  |", end="")
print()

print(" ", end="")
for p in gantt:
print("-------", end="")
print()

print(f"{gantt[0][1]}", end="")

for p in gantt:
print(f"{p[2]:>7}", end="")

print()