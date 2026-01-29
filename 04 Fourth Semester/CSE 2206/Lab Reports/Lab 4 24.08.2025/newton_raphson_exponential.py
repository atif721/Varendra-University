from math import exp, fabs


def f(x):
    return x * exp(x) - 1


def f_prime(x):
    return exp(x) * (1 + x)


def newton(f, f_prime, x0, tol=1e-6, max_iter=100):
    for i in range(1, max_iter + 1):
        if f_prime(x0) == 0:
            print("Derivative is zero. Try another guess.")
            return None

        x1 = x0 - f(x0) / f_prime(x0)
        err = fabs(x1 - x0)

        print(f"Iter {i}: x={x1:.6f}, f(x)={f(x1):.6f}, err={err:.2e}")

        if err < tol:
            return x1
        x0 = x1

    print("Max iterations reached.")
    return x0


guess = float(input("Enter starting guess: "))
root = newton(f, f_prime, guess)

if root is not None:
    print(f"\nRoot ≈ {root:.6f}")
    print(f"f(root) ≈ {f(root):.3e}")
