import os

pid = os.fork()

if pid == 0:
    os.execl("/bin/sh", "touch amarfile.txt && chmod 764 amarfile.txt")
else:
    print("Largest number among three integers ")
    os.waitpid(pid,0)
