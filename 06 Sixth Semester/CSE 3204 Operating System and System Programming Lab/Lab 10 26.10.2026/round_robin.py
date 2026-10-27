from collections import deque

n = int(input("Enter number of processes: "))
procs = []
for i in range(1, n + 1):
    pid, at, bt = map(int, input(f"\nEnter Process ID for {i}, Arrival Time, Burst Time: ").split())
    procs.append([pid, at, bt])

tq = int(input("Enter time quantization: "))

time, completed, gantt = 0, {}, []
queue = deque()
remaining_bt = {p[0]: p[2] for p in procs}


procs.sort(key=lambda x: x[1])
i = 0


while i < len(procs) or queue:
    while i < len(procs) and procs[i][1] <= time:
        queue.append(procs[i][0])
        i += 1
    if not queue:
        time += 1
        continue

    current = queue.popleft()

    start = time
    exec_time = min(tq, remaining_bt[current])
    time += exec_time
    remaining_bt[current] -= exec_time

    gantt.append((current, start, time,))

    while i < len(procs) and procs[i][0] <= time:
        queue.append(procs[i][0])
        i += 1
    if remaining_bt[current] > 0:
        queue.append(current)
    else:
        completed[current] = time

total_tat = total_wt = 0
print("\nP\tAT\tBT\tCT\tTAT\tWT")
for p in procs:
    ct = completed[p[0]]
    tat = ct - p[1]
    wt = tat - p[2]
    total_tat += tat
    total_wt += wt
    print(f"{p[0]}\t{p[1]}\t{p[2]}\t{ct}\t{tat}\t{wt}")


n = len(procs)
print(f"\nAverage TAT = {total_tat/n:.2f}")
print(f"Average WT  = {total_wt/n:.2f}")

# Gantt chart
print("\nGantt Chart:")
for p in gantt:
    print(f"|  {p[0]} ", end="")
print("|")

print(gantt[0][1], end="")
for p in gantt:
    print(f"    {p[2]}", end="")
print("\n")
