from math import fabs

def f(x):
    return 0.5 * x*x*x - x*x

def false_position(f, x, y, max_itr=500, eps=0.05):
    if f(x) * f(y) > 0:
        print("Invalid guess!")
        print("f(a) and f(b) must have opposite signs.")
        return None

    xr_old = x
    for i in range(1, max_itr + 1):
        xr = (x * f(y) - y * f(x)) / (f(y) - f(x))
        ae = fabs(xr - xr_old)

        if fabs(f(xr)) < 1e-6 or ae <= eps:
            return xr

        if f(x) * f(xr) < 0:
            y = xr
        else:
            x = xr

        xr_old = xr

    print("Maximum iterations reached without convergence")
    return xr


te = int(input("Test case : "))
while te:
    x = float(input("xl : "))
    y = float(input("xu : "))
    xr = false_position(f, x, y)

    if xr is not None:
        print(f"The root of the function is : {xr:.4f}")
        print(f"The value of the function is f(x) = {f(xr):.4f}")

    te -= 1
