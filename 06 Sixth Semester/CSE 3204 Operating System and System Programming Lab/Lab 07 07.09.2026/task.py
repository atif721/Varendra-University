import os

pid = os.fork()

if pid == 0:
    pid2 = os.fork()

    if pid2 == 0:
        os.execl("/bin/vmstat", "vmstat")
    else:
        os.execl("/bin/free", "free", "-h")

else:
    pid3 = os.fork()

    if pid3 == 0:
        os.execl("/bin/ps", "ps")
        
    else:
        os.wait()
        print("Finished running Python program")
