from math import fabs


def f(x):
    return x**3 - 2*x - 5


def Secant(f, x0, x1, max_itr=500, eps=0.005):
    itr = 1

    while True:
        f0 = f(x0)
        f1 = f(x1)

        if (f1-f0 == 0):
            print("Denominator becomes zero. Try different")
            return None

        x2 = x1 - (f1*(x1-x0) / (f1-f0))

        ae = fabs(x2-x1)

        x0 = x1
        x1 = x2
        itr += 1

        if (ae <= eps or itr > max_itr):
            break

    return x1


x0 = float(input("Enter value of x0 : "))
x1 = float(input("Enter value of x0 : "))

xr = Secant(f, x0, x1)

if xr is not None:
    print(f"The root is at {xr:.4f}")
    print(f"f(xr) = {f(xr):.4f}")
