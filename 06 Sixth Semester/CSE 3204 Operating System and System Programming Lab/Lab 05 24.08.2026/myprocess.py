import os

pid = os.fork()

if pid == 0:
    print("This is a child process")
    print("Created process pid", pid)
    print("Child process PID:", os.getpid())
elif pid > 0:
    print("This is parent process")
    print("Created process pid", pid)
    print("Parent process PID:", os.getpid())
else:
    print("Process creation failed")
