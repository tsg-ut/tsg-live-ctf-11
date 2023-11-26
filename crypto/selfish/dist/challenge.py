from Crypto.Util.number import getStrongPrime
from math import gcd
from random import getrandbits


flag = b"TSGLIVE{__REDACTED__}"

m = int.from_bytes(flag, "big")

p = getStrongPrime(1024)
q = getStrongPrime(1024)

N = p * q
phi = (p - 1) * (q - 1)

# choose small private exponent
while True:
    d = getrandbits(500)
    if gcd(d, phi) == 1:
        break

e = pow(d, -1, phi)
c = pow(m, e, N)

print(f"N = {N}")
print(f"e = {e}")
print(f"c = {c}")
