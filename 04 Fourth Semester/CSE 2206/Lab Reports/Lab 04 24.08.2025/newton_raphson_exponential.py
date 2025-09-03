from math import exp, fabs


def equation(x):
    return x * exp(x) - 1


def derivative(x):
    return exp(x) * (1 + x)


def newton_method(equation, deriv_eq, initial, max_steps=500, tol=1e-6):
    if deriv_eq(initial) == 0:
        print("Derivative is zero at initial point. Try another guess.")
        return None

    current = initial
    for step in range(1, max_steps + 1):
        deriv_val = deriv_eq(current)
        if deriv_val == 0:
            print("Zero derivative encountered. Method fails.")
            return None

        next_val = current - equation(current) / deriv_val
        err = fabs(next_val - current)

        print(f"Step {step}: ")
        print(f"x = {next_val:.4f}, f(x) = {equation(next_val):.4f},")
        print(f"error = {err:.4e}\n")

        if err <= tol:
            return next_val

        current = next_val

    print("Max steps reached.")
    return current


if __name__ == "__main__":
    start_guess = float(input("Enter starting guess: "))
    solution = newton_method(equation, derivative, start_guess)

    if solution is not None:
        print(f"The root of the equation is = {solution:.4f}")
        print(f"The value of f(root) = {equation(solution):.4e}")
