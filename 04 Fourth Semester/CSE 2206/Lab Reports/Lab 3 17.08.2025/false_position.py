from math import fabs


def f(x):
    return 0.5 * x*x*x - x*x


def false_position(f, xl, xu, max_itr=500, eps=0.05):
    if f(xl) * f(xu) > 0:
        print("Invalid guess!")
        print("f(a) and f(b) must have opposite signs.")
        return None

    xr_old = xl
    for i in range(1, max_itr + 1):
        xr = (xl * f(xu) - xu * f(xl)) / (f(xu) - f(xl))
        ae = fabs(xr - xr_old)

        if fabs(f(xr)) < 1e-6 or ae <= eps:
            return xr

        if f(xl) * f(xr) < 0:
            xu = xr
        else:
            xl = xr

        xr_old = xr

    print("Maximum iterations reached without convergence")
    return xr


te = int(input("Test case : "))
while te:
    xl = float(input("xl : "))
    xu = float(input("xu : "))
    xr = false_position(f, xl, xu)

    if xr is not None:
        print(f"The root of the function is : {xr:.4f}")
        print(f"The value of the function is f(x) = {f(xr):.4f}")

    te -= 1
