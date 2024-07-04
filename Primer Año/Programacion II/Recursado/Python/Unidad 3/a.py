def factorial_ite(n):
    """
    Número: Natural
    Nat -> Nat
    Calcula en forma iterativa el factorial de un número natrual dado.
    factorial_ite(5) = 120, factorial_ite(0) = 1, factorial_ite(1) = 1
    """

    fact = 1
    for i in range(2,n+1):
        fact = i * fact
    return fact

def test_factorial_ite():
    assert factorial_ite(5) == 120
    assert factorial_ite(0) == 1
    assert factorial_ite(1) == 1

def main():
    n = int(input("Ingrese un numero natural incluido el 0: "))
    factorial = factorial_ite(n)
    print(f"El factorial de {n} es {factorial}")

if __name__ == "__main__":
    main()


# def factorial_rec(n):
#     """ 
#     Número: Natural.
#     Nat->Nat
#     Calcular en forma recursiva el factorial de un número natural dado.
#     factorial_rec(5) = 120, factorial_rec(0) = 1, factorial_rec(1) = 1
#     """
#     if n == 0:
#         return 1
#     else:
#         return n * factorial_rec(n - 1)

# # Casos de prueba utilizando pytest
# def test_factorial_rec():
#     assert factorial_rec(0) == 1
#     assert factorial_rec(1) == 1
#     assert factorial_rec(5) == 120

# def main():
#    n = int(input("Ingrese un numero natural incluido el 0: "))
#    factorial = factorial_rec(n)
#    print(f"El factorial de {n} es {factorial}")

# if __name__ == "__main__":
#   main()