from math import exp, fabs


def target_func(y):
    return y * exp(y) - 1


def target_deriv(y):
    return exp(y) * (1 + y)


def newton_solver(func, deriv_func, y_start, max_loops=500, precision=1e-6):
    if deriv_func(y_start) == 0:
        print("Zero derivative at starting point. Choose a different guess.")
        return None

    y_current = y_start
    for loop in range(1, max_loops + 1):
        deriv_result = deriv_func(y_current)
        if deriv_result == 0:
            print("Derivative became zero. Method cannot proceed.")
            return None

        y_next = y_current - func(y_current) / deriv_result
        diff = fabs(y_next - y_current)

        print(f"Loop {loop}: ")
        print(f"y = {y_next:.4f}, f(y) = {func(y_next):.4f},")
        print(f"difference = {diff:.4e}\n")

        if diff <= precision:
            return y_next

        y_current = y_next

    print("Maximum loops reached.")
    return y_current


initial_value = float(input("Enter initial value: "))
result = newton_solver(target_func, target_deriv, initial_value)

if result is not None:
    print(f"The root of the equation is = {result:.4f}")
    print(f"The value of f(root) = {target_func(result):.4e}")
