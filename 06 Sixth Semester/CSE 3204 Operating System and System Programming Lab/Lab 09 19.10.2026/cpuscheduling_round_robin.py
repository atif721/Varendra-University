# Round Robin Scheduling
from collections import deque

processes = [
    {"id": "P1", "at": 0, "bt": 8},
    {"id": "P2", "at": 2, "bt": 4},
    {"id": "P3", "at": 4, "bt": 9},
    {"id": "P4", "at": 6, "bt": 3},
    {"id": "P5", "at": 8, "bt": 5},
]
TQ = 2

time = 0
queue = deque()
remaining_bt = {p["id"]: p["bt"] for p in processes}
arrival_map = {p["id"]: p["at"] for p in processes}
completed = {}
gantt = []

processes.sort(key=lambda x: x["at"])
i = 0

while i < len(processes) or queue:
    while i < len(processes) and processes[i]["at"] <= time:
        queue.append(processes[i]["id"])
        i += 1

    if not queue:
        time += 1
        continue

    current = queue.popleft()
    
    start = time
    exec_time = min(TQ, remaining_bt[current])
    time += exec_time
    remaining_bt[current] -= exec_time
    
    gantt.append((current, start, time))

    while i < len(processes) and processes[i]["at"] <= time:
        queue.append(processes[i]["id"])
        i += 1

    if remaining_bt[current] > 0:
        queue.append(current)
    else:
        completed[current] = time

# Metrics
print("\n")
total_tat = total_wt = 0
print("P\tAT\tBT\tCT\tTAT\tWT")
for p in processes:
    ct = completed[p["id"]]
    tat = ct - p["at"]
    wt = tat - p["bt"]
    total_tat += tat
    total_wt += wt
    print(f"{p['id']}\t{p['at']}\t{p['bt']}\t{ct}\t{tat}\t{wt}")

n = len(processes)
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