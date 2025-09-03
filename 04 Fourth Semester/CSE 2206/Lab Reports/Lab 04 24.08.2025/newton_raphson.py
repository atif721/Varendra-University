from math import fabs, exp


def func(x):
    return x * exp(x) - 1


def dfunc(x):
    return exp(x) * (1 + x)


def newton_raphson(func, deriv_f, x0, max_iter=500, eps=1e-6):

    if deriv_f(x0) == 0:
        print("Zero derivative at initial guess. Change guess.")
        return None

    x = x0
    for i in range(1, max_iter + 1):
        df_val = deriv_f(x)
        if df_val == 0:
            print("Zero derivative occured. Method fails.")
            return None

        x_new = x - func(x) / df_val
        error = fabs(x_new - x)

        print(f"Iteration {i}: ")
        print(f"x = {x_new:.4f}, f(x) = {func(x_new):.4f},")
        print(f"error = {error:.4e}\n")

        if error <= eps:
            return x_new

        x = x_new

    print("Maximum iterations reached.")
    return x


if __name__ == "__main__":
    guess = float(input("Enter initial guess: "))
    root = newton_raphson(func, dfunc, guess)

    if root is not None:
        print(f"The root of the given equation is = {root:.4f}")
        print(f"The value of f(root) = {func(root):.4e}")
