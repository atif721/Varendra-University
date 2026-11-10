def bankers_algo():
    n = int(input("Number of process: "))
    r = int(input("Number of rescource: "))

    print("\n-----Allocation Matrix-----")
    alloc = []
    for i in range(n):
        row = list(map(int, input(f" P{i}: ").split()))
        alloc.append(row)

    print("\n-----Max Matrix-----")
    maximum = []
    for i in range(n):
        row = list(map(int, input(f" P{i} ").split()))
        maximum.append(row)

    print("\n----Available Resource----")
    avail = list(map(int, input(" Enter: ").split()))

    # Need= max - allocation
    need = []
    for i in range(n):
        row = []
        for j in range(r):
            row.append(maximum[i][j] - alloc[i][j])
        need.append(row)

    # finished =  [True, False, ]
    finished = [False] * n
    safe_seq = []

# P1 P2
    while len(safe_seq) < n:
        found = False

        for i in range(n):
            if finished[i]:
                continue

            can_run = True
            for j in range(r):

                if need[i][j] > avail[j]:
                    can_run = False
                    break

            if can_run:
                for j in range(r):
                    avail[j] += alloc[i][j]
                safe_seq.append(i)
                finished[i] = True
                found = True

        if not found:
            print("\n System is not in safe state (deadlock possible)")
            return

    print("\nSystem is in safe state")
    print("Safe sequence: ", end='')
    print(" -> ".join(f"P{i}" for i in safe_seq)) continue


bankers_algo()
