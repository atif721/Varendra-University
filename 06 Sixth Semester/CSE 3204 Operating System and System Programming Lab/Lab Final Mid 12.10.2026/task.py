import os

rs = os.fork()

# try:
#     rs = os.fork()
# except OSError:
#     rs = -1

if rs == 0:
    print("Child PID:", os.getpid(), flush=True)
    print("Parent PID:", os.getppid(), flush=True)
    print("Child process", flush=True)
    os._exit(2)

elif rs > 0:
    print("Parent PID:", os.getpid())
    print("Child PID:", rs)

    _, status = os.waitpid(rs, 0)

    if os.WIFEXITED(status):
        print("Child Exit Status:", os.WEXITSTATUS(status))

elif rs < 0:
    print("Fork failed")
