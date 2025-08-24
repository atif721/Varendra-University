def f(x):
    return 0.5 * x**3 - x**2


def df(x):
    return 1.5 * x**2 - 2 * x


def newton_raphson(f, df, x0, max_itr=100, eps=0.001):
    iter_count = 1
    x_old = x0
    while iter_count <= max_itr:
        f_val = f(x_old)
        df_val = df(x_old)

        if df_val == 0:
            print("Zero derivative. Method fails")
            return None
        x_new = x_old - f_val / df_val
        error = abs(x_new - x_old)

        print(f"Iteration {iter_count}: x = {x_new:.6f}, ")
        print(f"f(x) = {f(x_new):.6f}")
        if error <= eps:
            return x_new
        x_old = x_new
        iter_count += 1

    print("Maximum iterations reached.")
    return x_old


x0 = float(input("X0 ? : "))
root = newton_raphson(f, df, x0)

if root is not None:
    print(f"\nRoot found at x = {root:.6f}")
    print(f"f(x) = {f(root):.6f}")
