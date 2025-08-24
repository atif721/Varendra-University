from math import fabs

def f(x):
    return 0.5*x*x*x - x*x

def bisection(f, xl, xu, max_itr=500, eps=0.05):
    if f(xl)*f(xu) > 0:
        print("Wrong guess!")
        return None

    if f(xl) == 0:
        return xl
    if f(xu) == 0:
        return xu

    itr = 1
    xr_old = (xl + xu) / 2

    while True:
        if f(xl) * f(xr_old) < 0:
            xu = xr_old
        elif f(xu) * f(xr_old) < 0:
            xl = xr_old
        else:
            return xr_old

        xr_new = (xl + xu) / 2
        ae = fabs(xr_new - xr_old)
        xr_old = xr_new

        itr = itr + 1
        if ae <= eps or itr > max_itr:
            break
    return xr_old


te = int(input("Test case : "))
while te:
    xl = int(input("xl : "))
    xu = int(input("xu : "))
    xr = bisection(f, xl, xu)

    if xr is not None:
        print(f"The root of the function is : {xr:.3f}")
        print(f"The value of the function is : {f(xr):.3f}")
    else:
        print("No root found.")

    te -= 1