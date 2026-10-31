# Priority Scheduling (Non-Preemptive).

processes = [
    {"id": "P1", "at": 0, "bt": 10, "pr": 3},
    {"id": "P2", "at": 1, "bt": 5,  "pr": 1},
    {"id": "P3", "at": 2, "bt": 8,  "pr": 4},
    {"id": "P4", "at": 3, "bt": 6,  "pr": 2},
    {"id": "P5", "at": 4, "bt": 4,  "pr": 5},
]

# Initialization
time = 0
completed = {}
gantt = []

# Start simulation
while len(completed) < len(processes):
    available = [
        p for p in processes
        if p["at"] <= time and p["id"] not in completed
    ]

    if not available:
        time += 1
        continue

    current = min(available, key=lambda p: (p["pr"], p["at"], p["id"]))
    pid = current["id"]

    start = time
    time += current["bt"]
    completed[pid] = time

    gantt.append((pid, start, time))

# metrics
total_tat = total_wt = 0
print("\nP\tAT\tBT\tPR\tCT\tTAT\tWT")
for p in processes:
    ct = completed[p["id"]]
    tat = ct - p["at"]
    wt = tat - p["bt"]
    total_tat += tat
    total_wt += wt
    print(f"{p['id']}\t{p['at']}\t{p['bt']}\t{p['pr']}\t{ct}\t{tat}\t{wt}")

n = len(processes)
print(f"\nAverage TAT = {total_tat/n:.2f}")
print(f"Average WT  = {total_wt/n:.2f}")

print("\nGantt Chart:")
for p in gantt:
    print(f"| {p[0]} ", end="")
print("|")

print(gantt[0][1], end="")
for p in gantt:
    print(f"    {p[2]}", end="")
print("\n")