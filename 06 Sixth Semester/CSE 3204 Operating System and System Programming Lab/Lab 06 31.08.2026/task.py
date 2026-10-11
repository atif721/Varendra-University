import os

a, b, c = int(input("Enter first number: ")), int(
    input("Enter second number: ")), int(input("Enter third number: "))

pid = os.fork()

if pid == 0:
    print("[Child] process creating file and setting permission")
    os.execlp("sh", "sh", "-c",
              "touch child_process_file.txt && chmod 764 child_process_file.txt")
else:
    print("[Parent] process; Largest number is: ", max(a, b, c))
    os.waitpid(pid, 0)
