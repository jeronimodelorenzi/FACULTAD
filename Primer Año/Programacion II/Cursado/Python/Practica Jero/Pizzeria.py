print("BIENVENIDOS A LA PIZZERIA PACO")

dinero = int(input("\nIntroduzca la cantidad de dinero: "))
listIngredientes = []
pizza = [["Napolitana", 3], ["Muzzarella", 1], ["Especial", 5]]

def añadirIngrediente (precioTotal):
    
    print("\nEl coste de todos los ingredientes extras es de 0.5 dolares ")
    
    pregunta = input("\nDesea agregar algun ingrediente extra?: ")
    precioIngredientes = 0

    while pregunta == "si":
        ingrediente = input("\nQue ingrediente desea agregar: ")
        pregunta = input("\nDesea agregar algun ingrediente extra?: ")
        listIngredientes.append(ingrediente)
        precioIngredientes = len(listIngredientes) * 0.5
        precioTotal += precioIngredientes
        
        if precioTotal <= dinero:
            print(f"\nDebe pagar {precioTotal}, le quedarían {dinero - precioTotal}")
        else:
            print(f"\nNo tiene suficiente dinero para pagar. El total es {precioTotal} y solo tiene {dinero}")

def generarTicket(pizzaElegida, precioTotal):
    print("\nTICKET\n")
    print("Orden:")
    print(f" 1. {pizzaElegida[0]}   precio: {precioTotal}")
    
    if listIngredientes:
        print(f" Ingredientes extras: {', '.join(listIngredientes)}   precio: {len(listIngredientes) * 0.5} ")
    
    total_con_ingredientes = precioTotal + len(listIngredientes) * 0.5
    print(f" Total: {total_con_ingredientes}")
    print(f" Vuelto: {dinero - total_con_ingredientes}")

def elegirPizza ():
    
    eleccion = input("\nQue tipo de pizza queres elegir: ")
    precioTotal = 0
    
    for i in pizza:
        if eleccion == i[0]:
            pizzaElegida = i
            precioTotal = i[1]
            print(f"\nElegiste el tipo de pizza {pizzaElegida[0]} y su precio es {precioTotal} ")

    añadirIngrediente(precioTotal)

    generarTicket(pizzaElegida, precioTotal)

elegirPizza()