import os 

pid = os.fork()

if pid == 0:
    pid2 = os.fork()
    if pid2 == 0:
        os.execlp("uptime", "uptime")
    else:
        os.waitpid(pid2,0)
        os.execlp("free", "free", "-h")
else:
    pid3 = os.fork()
    if pid3 == 0:
        os.execlp("ps", "ps")
    else:
        os.waitpid(pid,0)
        os.waitpid(pid3,0)
        print("Finished running python programm")
