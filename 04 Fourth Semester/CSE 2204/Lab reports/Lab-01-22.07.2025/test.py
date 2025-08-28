def input_dimension(prompt):
    return int(input(prompt))


def input_matrix(rows, cols, name):
    print(f"\nEnter values for Matrix {name} ({rows}x{cols}):")
    matrix = []
    for i in range(rows):
        row = []
        for j in range(cols):
            value = int(input(f"{name}[{i + 1}][{j + 1}]: "))
            row.append(value)
        matrix.append(row)
    return matrix


def multiply_matrices(A: list, B: list, m: int, n: int, p: int) -> list:
    result = [[0] * p for _ in range(m)]
    for i in range(m):
        for j in range(p):
            for k in range(n):
                result[i][j] += A[i][k] * B[k][j]
    return result


def print_matrix(matrix, name):
    print(f"\n--- {name} ---")

    max_width = max(len(str(num)) for row in matrix for num in row)

    for row in matrix:
        for val in row:
            print(str(val).rjust(max_width + 2), end=" ")
        print()


def main():
    m: int = input_dimension("Enter number of rows for Matrix A: ")
    n: int = input_dimension(
        "Enter number of columns for Matrix A (and rows for B): ")
    p: int = input_dimension("Enter number of columns for Matrix B: ")

    A: list = input_matrix(m, n, "A")
    B: list = input_matrix(n, p, "B")

    C: list = multiply_matrices(A, B, m, n, p)

    print_matrix(A, "Matrix A")
    print_matrix(B, "Matrix B")
    print_matrix(C, "Result (A x B)")


if __name__ == "__main__":
    main()
