def check_prime(n):
    if n <= 1:
        return False
    if n <= 3:
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False
    return True


def main():
    num = int(input("Enter a number to check prime number : "))
    flag = check_prime(num)
    if flag:
        print("Prime")
    else:
        print("Not Prime")


if __name__ == "__main__":
    main()
