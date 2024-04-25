from funciones import *
from menus import *

## GENERAL
def paginaInicial():
    bucle = True
    while bucle:
        menuPrincipal()
        respuesta = input()
        if '1' == respuesta:
            usuario,contraseña = menuLogin()
            conn, cursor = conectarBaseDatos(usuario,contraseña)
            rol = comprobarRol(usuario)
            if rol == 'medico':
                menuMedico(usuario, conn, cursor)
            elif rol == 'administrativo':
                pass
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


def main():
    paginaInicial()

main()