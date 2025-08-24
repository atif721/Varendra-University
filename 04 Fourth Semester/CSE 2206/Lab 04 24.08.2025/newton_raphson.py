from math import fabs

def f(x):
    return x*x*x - 2*x -5

def f_deriv(x):
    return 3*x*x -2

def newton_raphson(f, f_deriv, x0, max_itr=500, eps=0.05):
    if(f_deriv(x0) ==0 ):
        print("Change the guess!")
        return 
    itr = 1
    xr_old = x0
    
    
    while True:
        if(f_deriv(xr_old) == 0):
            print("Change the guess!")
            return
    
        xr_new = xr_old - (f(xr_old) / f_deriv(xr_old))
        ae = fabs(xr_new - xr_old)
        xr_old = xr_new
        itr +=1
        if(ae<= eps or itr>max_itr):
            break
    return xr_old

x0 = float(input("Enter inital guess : "))

root = newton_raphson(f, f_deriv, x0)

print(f"The root of the given equation is : {root:.5f}")
print(f"The value of f(root) : {f(root):.5f}")