def permutacion():
    sigma = []
    n = int(input("\n Ingrese el cardinal de la permutacion: "))
    i = 0

    while i < n:
        a = int(input(f"Ingrese valores del 1 hasta {n}: "))
        if a in sigma:
            print("El numero ya esta el la permutacion")
        elif a > n:
            print(f"{a} es mayor a {n}")
        else:
            sigma.append(a)
            i += 1

    sigma_1 = sigma.pop(0)  

    for i in range(len(sigma)):
        if sigma[i] > sigma_1:
            sigma[i] -= 1

    print(sigma)

permutacion()