from funciones import *
from menus import *

## GENERAL
def paginaInicial():
    while True:
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
        else:
            cip,contraseña = menuRegistrarse()
            crearUsuario(cip,contraseña)


def main():
    paginaInicial()

main()