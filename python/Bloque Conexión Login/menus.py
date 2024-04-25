import os
from funciones import *
from sys import exit
from tabulate import tabulate

def menuPrincipal():
    os.system('cls')
    print('-' * 40)
    print('Menu Login')
    print('-' * 40, end='\n\n\n')
    print("1. Inicio de sesion")
    print("2. Registrarse")
    print("3. Salir", end='\n\n\n')
    print("Escoger una opcion: ", end='')

def menuLogin():
    os.system('cls')
    print('-' * 40)
    print('Iniciar Sesión')
    print('-' * 40, end='\n\n\n')
    print('Nombre de Usuario: ',end='')
    usuario = input()
    print('Contraseña: ', end='')
    contraseña = input()
    return usuario,contraseña

def menuRegistrarse():
    os.system('cls')
    print('-' * 40)
    print('Registrarse')
    print('-' * 40, end='\n\n\n')
    print('CIP: ',end='')
    cip = input()
    print('Contraseña: ', end='')
    contraseña = input()
    return cip,contraseña

### PACIENTE

def menuPaciente(usuario, conn, cursor):
    bucle = True
    while bucle:
        os.system('cls')
        print('-' * 40)
        print('Menú gestión paciente')
        print('-' * 40, end='\n\n\n')
        print("1. Concertar visita #EXTRA")
        print("2. Ver visitas")
        print("3. Ver historial")
        print("4. Salir", end='\n\n\n')
        respuesta = input("Escoger una opcion: ")
        if respuesta == '1':
            pass
            ##concertarVisita() si nos apetece
        elif respuesta == '2':
            verVisitaPaciente(usuario, conn, cursor)
        elif respuesta == '3':
            verHistorial(usuario, conn, cursor)
        elif respuesta == '4':
            bucle = False

### MEDICO
def menuMedico(usuario, conn, cursor):
    bucle = True
    while bucle:
        os.system('cls')
        print('-' * 40)
        print('Menú gestión medico')
        print('-' * 40, end='\n\n\n')
        print("1. Personal a cargo")
        print("2. Ver operaciones")
        print("3. Ver visitas")
        print("4. Ver visitas pacientes")
        print("5. Ver Diagnostico y receta de un paciente")
        print("6. Salir")
        respuesta = input("Escoger una opcion: ")
        if respuesta == '1':
            personalCargo(usuario, conn, cursor)
        elif respuesta == '2':
            verOperaciones(usuario, conn, cursor)
        elif respuesta == '3':
            verVisitasMedico(usuario, conn, cursor)
        elif respuesta == '4':
            verVisitasMedicoPaciente(usuario, conn, cursor)
        elif respuesta == '5':
            verDiagnosticoRecetaPaciente(usuario, conn, cursor)
        elif respuesta == '6':
            bucle = False

### Administrativo

###