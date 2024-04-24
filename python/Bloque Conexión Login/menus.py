import os
from sys import exit
from funciones import *


### GENERALES

def menuPrincipal():
    os.system('cls')
    print('-' * 40)
    print('Menu Login')
    print('-' * 40, end='\n\n\n')
    print("1. Inicio de sesion")
    print("2. Registrarse", end='\n\n\n')
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
    os.system('cls')
    print('-' * 40)
    print('Menú gestión paciente')
    print('-' * 40, end='\n\n\n')
    print("1. Concertar visita")
    print("2. Ver visitas")
    print("3. Ver historial")
    print("4. Salir", end='\n\n\n')
    respuesta = input("Escoger una opcion: ", end='')
    if respuesta == 1:
        pass
        ##concertarVisita() si nos apetece
    elif respuesta == 2:
        verVisitas(usuario, conn, cursor)
    elif respuesta == 3:
        verHistorial(usuario, conn, cursor)
    elif respuesta == 4:
        exit()

### MEDICO

### RRHH

###