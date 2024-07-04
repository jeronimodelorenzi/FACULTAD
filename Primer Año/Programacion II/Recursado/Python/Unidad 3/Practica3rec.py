def lucca(n):
    if n == 0:
        return 2
    elif n == 1:
        return 1
    else:
        return lucca(n-1)+lucca(n-2)
    
def pell(n):
    if n == 0 or n == 1:
        return n
    else:
        return (2*pell(n-1))+ pell(n-2)

def jacob(n):
    if n == 0 or n == 1:
        return n
    else:
        return jacob(n-1)+ (2*jacob(n-2))

def factorial_final (n, resultado = 1):
    if n == 0:
        return resultado
    else:
        return factorial_final(n-1,resultado*n)

def suma_n_rec(n):
    if n == 0:
        return 0
    else:
        return n + suma_n_rec(n-1)

def suma_n_ite(n):
    suma = 0
    for i in range(1,n+1):
        suma += i
    return suma

def suma_nm_rec(n,m):
    if n>m:
        return 0
    else:
        return n + suma_nm_rec(n+1,m)
    
def suma_nm_ite(n,m):
    suma = 0
    for i in range(n,m+1):
        suma += i
    return suma

def multiplos_k_rec(n,k):
    resultado = 1
    if n == 0:
        return 
    else:
        resultado = n * k
        print(resultado)
        return multiplos_k_rec(n-1,k)

def factorial_rec(n):
    if n == 0:
        return 1
    else:
        return n*factorial_rec(n-1)