import os

print("Enter three integer numbers : ")
first = input()
second = input ()
third = input()

pid = os.fork()

if pid == 0:
    print("File created under child process")
    pid2 = os.fork()
    if pid2 == 0:
        os.execl("/usr/bin/touch","touch","child_process_file.txt")
    else:
        os.execl("/usr/bin/chmod", "chmod", "764", "child_process_file.txt")
else:
    print("Largest number among three integers ", max(first, second, third))
    os.waitpid(pid,0)
