import numpy as np
import matplotlib.pyplot as plt

# Aceleración gravitatoria [m/s^2]
g = 9.8

# --------------------------------------------------------------
# Función: posición
# Implementa las ecuaciones del tiro parabólico en 3D.
# Usamos: r(t) = r0 + v0*t + (1/2)*a*t^2
# Pero en x e y la aceleración es cero.
# En z la aceleración es -g.
def posicion(x0, y0, z0, vx0, vy0, vz0, t_final):
    x = x0 + vx0*t_final
    y = y0 + vy0*t_final
    z = z0 + vz0*t_final - 0.5*g*t_final**2
    return x, y, z

# --------------------------------------------------------------
# Función: trayectoria
# Devuelve muchos puntos entre t = 0 y t = t_final
# para graficar la curva espacial (x,y,z).
def trayectoria(x0, y0, z0, vx0, vy0, vz0, t_final, n=300):
    ty = np.linspace(0, t_final, n)
    x_ty = x0 + vx0*ty
    y_ty = y0 + vy0*ty
    z_ty = z0 + vz0*ty-0.5*g*ty**2
    return ty, x_ty, y_ty, z_ty

# --------------------------------------------------------------
# Función: graficar_trayectoria
# Genera una figura 3D de la curva
# x(t), y(t), z(t).
def graficar_trayectoria(x_ty, y_ty, z_ty):
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')

    ax.plot(x_ty, y_ty, z_ty)

    ax.set_xlabel("x (m)")
    ax.set_ylabel("y (m)")
    ax.set_zlabel("z (m)")
    ax.set_title("Trayectoria")

    plt.show()

def main():
    x0 = float(input("Ingrese x0: "))
    y0 = float(input("Ingrese y0: "))
    z0 = float(input("Ingrese z0: "))

    vx0 = float(input("Ingrese vx0: "))
    vy0 = float(input("Ingrese vy0: "))
    vz0 = float(input("Ingrese vz0: "))

    t = float(input("Ingrese Tiempo t: "))

    # Cálculo de la posición final
    xf, yf, zf = posicion(x0, y0, z0, vx0, vy0, vz0, t)

    print("\n=== Resultado ===")
    print(f"x(t) = {xf}")
    print(f"y(t) = {yf}")
    print(f"z(t) = {zf}")

    # Cálculo de trayectoria completa
    ty, x_ty, y_ty, z_ty = trayectoria(x0, y0, z0, vx0, vy0, vz0, t)

    # Gráfica
    graficar_trayectoria(x_ty, y_ty, z_ty)

if __name__ == "__main__":
    main()
