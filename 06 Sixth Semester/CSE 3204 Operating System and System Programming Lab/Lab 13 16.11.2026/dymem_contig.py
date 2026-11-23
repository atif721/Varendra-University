import matplotlib.pyplot as plt

# Memory Block Class
class MemoryBlock:
    def __init__(self, size):
        self.size = size
        self.free = True
        self.process = None

# Display Memory Blocks
def display_memory(memory):

    print("\nMemory Status:\n")

    for i, block in enumerate(memory):

        if block.free:
            print(f"Block {i+1}: {block.size} KB -> FREE")

        else:
            print(f"Block {i+1}: {block.size} KB -> Process {block.process}")

# Visualization Function
def visualize_memory(memory, title):

    labels = []
    sizes = []
    colors = []

    for i, block in enumerate(memory):

        labels.append(f"B{i+1}")
        sizes.append(block.size)

        if block.free:
            colors.append("lightgray")
        else:
            colors.append("orange")

    plt.figure(figsize=(10, 2))

    left = 0

    for i in range(len(sizes)):

        plt.barh(
            y=0,
            width=sizes[i],
            left=left,
            color=colors[i],
            edgecolor='black'
        )

        plt.text(
            left + sizes[i]/2,
            0,
            labels[i],
            ha='center',
            va='center'
        )

        left += sizes[i]
    plt.yticks([])
    plt.title(title)
    plt.xlabel("Memory Size (KB)")
    plt.show()

# First Fit Algorithm
def first_fit(memory, process_size, process_name):

    for block in memory:

        if block.free and block.size >= process_size:

            block.free = False
            block.process = process_name

            fragmentation = block.size - process_size

            return fragmentation

    return None

# Best Fit Algorithm
def best_fit(memory, process_size, process_name):

    best_block = None
    min_fragment = float('inf')

    for block in memory:

        if block.free and block.size >= process_size:

            fragment = block.size - process_size

            if fragment < min_fragment:
                min_fragment = fragment
                best_block = block

    if best_block:

        best_block.free = False
        best_block.process = process_name

        return min_fragment

    return None

# Worst Fit Algorithm
def worst_fit(memory, process_size, process_name):

    worst_block = None
    max_fragment = -1

    for block in memory:

        if block.free and block.size >= process_size:

            fragment = block.size - process_size

            if fragment > max_fragment:
                max_fragment = fragment
                worst_block = block

    if worst_block:

        worst_block.free = False
        worst_block.process = process_name

        return max_fragment

    return None

# Next Fit Algorithm
def next_fit(memory, process_size, process_name, start_index):

    n = len(memory)
    i = start_index

    while True:

        block = memory[i]

        if block.free and block.size >= process_size:

            block.free = False
            block.process = process_name

            fragmentation = block.size - process_size

            return fragmentation, (i + 1) % n

        i = (i + 1) % n

        if i == start_index:
            break

    return None, start_index

# Main Program
memory_sizes = [100, 500, 200, 300, 600]
processes = [212, 417, 112, 426]

# Create Separate Memory Copies
memory_ff = [MemoryBlock(size) for size in memory_sizes]
memory_bf = [MemoryBlock(size) for size in memory_sizes]
memory_wf = [MemoryBlock(size) for size in memory_sizes]
memory_nf = [MemoryBlock(size) for size in memory_sizes]

# First Fit Execution
print("\n========== FIRST FIT ==========")

ff_fragment = 0

for i, p in enumerate(processes):

    result = first_fit(memory_ff, p, f"P{i+1}")

    if result is not None:
        ff_fragment += result
        print(f"Process P{i+1} allocated")
    else:
        print(f"Process P{i+1} cannot be allocated")


display_memory(memory_ff)
visualize_memory(memory_ff, "First Fit Allocation")

# Best Fit Execution
print("\n========== BEST FIT ==========")

bf_fragment = 0

for i, p in enumerate(processes):

    result = best_fit(memory_bf, p, f"P{i+1}")

    if result is not None:
        bf_fragment += result
        print(f"Process P{i+1} allocated")
    else:
        print(f"Process P{i+1} cannot be allocated")


display_memory(memory_bf)
visualize_memory(memory_bf, "Best Fit Allocation")

# Worst Fit Execution
print("\n========== WORST FIT ==========")

wf_fragment = 0

for i, p in enumerate(processes):

    result = worst_fit(memory_wf, p, f"P{i+1}")

    if result is not None:
        wf_fragment += result
        print(f"Process P{i+1} allocated")
    else:
        print(f"Process P{i+1} cannot be allocated")

display_memory(memory_wf)
visualize_memory(memory_wf, "Worst Fit Allocation")

# Next Fit Execution
print("\n========== NEXT FIT ==========")

nf_fragment = 0
start = 0

for i, p in enumerate(processes):

    result, start = next_fit(memory_nf, p, f"P{i+1}", start)

    if result is not None:
        nf_fragment += result
        print(f"Process P{i+1} allocated")
    else:
        print(f"Process P{i+1} cannot be allocated")


display_memory(memory_nf)
visualize_memory(memory_nf, "Next Fit Allocation")

# Comparison Graph
algorithms = ["First Fit", "Best Fit", "Worst Fit", "Next Fit"]
fragmentation = [
    ff_fragment,
    bf_fragment,
    wf_fragment,
    nf_fragment
]

plt.figure(figsize=(8, 5))
plt.bar(algorithms, fragmentation)
plt.title("Fragmentation Comparison")
plt.xlabel("Algorithms")
plt.ylabel("Total Fragmentation")
plt.show()

# Final Analysis
print("\n========= FINAL ANALYSIS =========")
print(f"First Fit Fragmentation : {ff_fragment} KB")
print(f"Best Fit Fragmentation  : {bf_fragment} KB")
print(f"Worst Fit Fragmentation : {wf_fragment} KB")
print(f"Next Fit Fragmentation  : {nf_fragment} KB")
