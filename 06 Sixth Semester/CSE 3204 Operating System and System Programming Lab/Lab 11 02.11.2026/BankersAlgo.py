# Banker's Algorithm

def bankers_algo():
    n = int(input("Number of processes: "))
    r = int(input("Number of resource types: "))

    print("\n--- Allocation Matrix ---")
    alloc = []
    for i in range(n):
        row = list(map(int, input(f"  P{i}: ").split()))
        alloc.append(row)

    print("\n--- Max Matrix ---")
    maximum = []
    for i in range(n):
        row = list(map(int, input(f"  P{i}: ").split()))
        maximum.append(row)

    print("\n--- Available Resources ---")
    avail = list(map(int, input("  Enter: ").split()))

    # Need = Max - Allocation
    need = []
    for i in range(n):
        row = []
        for j in range(r):
            row.append(maximum[i][j] - alloc[i][j])
        need.append(row)

    finished = [False] * n
    safe_seq = []

    while len(safe_seq) < n:
        found = False

        for i in range(n):
            if finished[i]:
                continue

            # Flag: can process i run with the current avail?
            can_run = True
            for j in range(r):
                if need[i][j] > avail[j]:
                    can_run = False
                    break

            if can_run:
                # Process i finishes and releases its resources
                for j in range(r):
                    avail[j] += alloc[i][j]
                safe_seq.append(i)
                finished[i] = True
                found = True

        if not found:
            print("\nSystem is NOT in a safe state", end='')
            print(" (deadlock possible).")
            return

    print("\nSystem is in a SAFE state.")
    print("Safe sequence: ", end='')
    print(" -> ".join(f"P{i}" for i in safe_seq))


bankers_algo()
