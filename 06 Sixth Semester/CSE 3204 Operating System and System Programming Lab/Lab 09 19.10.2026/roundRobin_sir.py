from collections import deque

# Input
processes = [
    {"id": "P1", "at": 0, "bt": 10},
    {"id": "P2", "at": 1, "bt": 5},
    {"id": "P3", "at": 2, "bt": 8},
    {"id": "P4", "at": 3, "bt": 6},
    {"id": "P5", "at": 4, "bt": 4},
]

TQ = 3

# Initialization
time = 0
queue = deque()
remaining_bt = {p["id"]: p["bt"] for p in processes}
arrival_map = {p["id"]: p["at"] for p in processes}
completed = {}
gantt = []

# Sort by arrival time
processes.sort(key=lambda x: x["at"])
i = 0

# Start simulation
while i < len(processes) or queue:
    
    # Add arriving processes
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

    # Add newly arrived processes during execution
    while i < len(processes) and processes[i]["at"] <= time:
        queue.append(processes[i]["id"])
        i += 1

    # If not finished, re-add to queue
    if remaining_bt[current] > 0:
        queue.append(current)
    else:
        completed[current] = time

# Calculate metrics
print("\nGantt Chart:")
for p in gantt:
    print(f"| {p[0]} ", end="")
print("|")

print(gantt[0][1], end="")
for p in gantt:
    print(f"    {p[2]}", end="")
print("\n")

total_tat = 0
total_wt = 0

print("\nProcess Details:")
print("P\tAT\tBT\tCT\tTAT\tWT")

for p in processes:
    pid = p["id"]
    at = p["at"]
    bt = p["bt"]
    ct = completed[pid]
    tat = ct - at
    wt = tat - bt

    total_tat += tat
    total_wt += wt

    print(f"{pid}\t{at}\t{bt}\t{ct}\t{tat}\t{wt}")

n = len(processes)
print(f"\nAverage TAT = {total_tat/n:.2f}")
print(f"Average WT  = {total_wt/n:.2f}")