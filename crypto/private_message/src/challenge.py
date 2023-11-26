from Crypto.Util.number import isPrime, getStrongPrime

def next_prime(n):
    n += 1
    while not isPrime(n):
        n += 1
    return n


flag = b"TSGLIVE{I_heard_that_this_is_a_private_message,_so_I_generated_private_keys_from_this!_________What?_Isn't_that_what_you_meant?}"

assert len(flag) == 128

m = int.from_bytes(flag, "big")

p = getStrongPrime(1024)
q = next_prime(m)

N = p * q
e = 0x10001

c = pow(m, e, N)

print(f"N = {N}")
print(f"e = {e}")
print(f"c = {c}")
