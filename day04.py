import sys
import md5

secret = 'bgvyzdsv'
i = 0
n = int(sys.argv[1])
prefix = '0' * n

while True:
    hash = md5.new()
    hash.update(secret + str(i))

    if hash.hexdigest()[0:n] == prefix:
        print i
        break

    i += 1
