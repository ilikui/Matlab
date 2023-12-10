import socket
import time

sock = socket.socket(socket.AF_INET,socket.SOCK_STREAM)

sock.bind(('127.0.0.1',5432))

sock.listen(5)

a=[1,2,3,4]

while True:
    
    s=str(a)
    
    connection,address = sock.accept()
   
    print("client ip is:",address)
   
    buf = connection.recv(40960)
    print(buf.decode('utf-8'))

    
    connection.send(bytes(s, encoding="utf-8"))
   
    connection.close()
    time.sleep(1)

sock.close()