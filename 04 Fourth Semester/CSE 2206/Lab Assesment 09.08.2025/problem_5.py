operator = input("Enter an operator (+,-,*,/) : ")

num1 = int(input("Enter first numher : "))
num2 = int(input("Enter second number : "))

if operator == "+":
    print(f"{num1} + {num2} = {num1+num2}")
elif operator == "-":
    print(f"{num1} - {num2} = {num1-num2}")
elif operator == "*":
    print(f"{num1} * {num2} = {num1*num2}")
elif operator == "/":
    if num2 != 0:
        print(f"{num1} / {num2} = {num1/num2:.2f}")
    else:
        print("Error! Division by zero")
else:
    print("Invalid operator")
