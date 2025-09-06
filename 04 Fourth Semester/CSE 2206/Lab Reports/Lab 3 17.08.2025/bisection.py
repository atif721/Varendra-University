from math import fabs


def f(x):
    return x**3 + 4*x**2-1


def bisection(f, xl, xu, max_itr=500, eps=0.05):
    if f(xl) * f(xu) > 0:
        print("Invalid interval! f(xl) and f(xu) must have opposite signs.")
        return None

    xr_old = (xl + xu) / 2

    for itr in range(1, max_itr + 1):
        if f(xl) * f(xr_old) < 0:
            xu = xr_old
        elif f(xl) * f(xr_old) > 0:
            xl = xr_old
        else:
            return xr_old

        xr_new = (xl + xu) / 2

        err_midpoint = fabs(xr_new - xr_old)

        if err_midpoint <= eps:
            return xr_new

        xr_old = xr_new
        itr += 1

    return xr_old


te = int(input("Test case : "))
for _ in range(te):
    xl = float(input("xl : "))
    xu = float(input("xu : "))
    xr = bisection(f, xl, xu)

    if xr is not None:
        print(f"\nFinal Root = {xr:.6f}")
        print(f"f(root) = {f(xr):.6f}")
    else:
        print("No root found.")
