def pares(n):
    if n == 0:
        return n
    else:
        print(n*2)
        return pares(n-1)