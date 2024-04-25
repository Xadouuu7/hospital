from funciones import *
from menus import *

## GENERAL
def paginaInicial():
    bucle = True
    while bucle:
        try:
            menuPrincipal()
            respuesta = input()
            if '1' == respuesta:
                usuario,contraseña = menuLogin()
                conn, cursor = conectarBaseDatos(usuario,contraseña)
                rol = comprobarRol(usuario)
                if rol == 'medico':
                    menuMedico(usuario, conn, cursor)
                elif rol == 'administrativo':
                    menuAdministrativo(usuario, conn, cursor)
                elif rol == 'cientifico':
                    pass
                elif rol == 'enfermero':
                    pass
                elif rol == 'farmaceutico':
                    pass
                elif rol == 'recursos_humanos':
                    pass
                elif rol == 'informatico':
                    pass
                else:
                    menuPaciente(usuario, conn, cursor)
            elif '2' == respuesta:
                cip,contraseña = menuRegistrarse()
                crearUsuario(cip,contraseña)
            elif '3' == respuesta:
                bucle = False
        except Exception as error:
            print(f"Error: {error}")
            input("Enter per continuar")


def main():
    paginaInicial()

main()