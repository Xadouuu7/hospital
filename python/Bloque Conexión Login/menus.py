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
        print("4. Ver diagnósticos y receta")
        print("5. Salir", end='\n\n\n')
        respuesta = input("Escoger una opcion: ")
        if respuesta == '1':
            pass
            ##concertarVisita() si nos apetece
        elif respuesta == '2':
            verVisitaPaciente(usuario, conn, cursor)
        elif respuesta == '3':
            verHistorial(usuario, conn, cursor)
        elif respuesta == '4':
            verDiagnosticoReceta(usuario, conn, cursor)
        elif respuesta == '5':
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

def menuAdministrativo(usuario, conn, cursor):
    bucle = True
    while bucle:
        try:
            os.system('cls')
            print('-' * 40)
            print('Menú gestión Administrativo')
            print('-' * 40, end='\n\n\n')
            print("1. Dar alta paciente")
            print("2. Ver personal enfermeria")
            print("3. Ver operaciones")
            print("4. Ver visitas")
            print("5. Reservas de habitaciones")
            print("6. Reservas de quirofano")
            print("7. Ver visitas programadas")
            print("8. Ver inventario Quirofano")
            print("9. Salir")
            respuesta = input("Escoger una opcion: ")
            if respuesta == '1':
                id_direccion = darAltaDireccion(usuario, conn, cursor)
                dni_nie = darAltaPersona(usuario, conn, cursor, id_direccion)
                darAltaPaciente(usuario, conn, cursor, dni_nie)
            elif respuesta == '2':
                verPersonalEnfermeria(usuario,conn,cursor)
            elif respuesta == '3':
                verOperacionesAdministrativo(usuario, conn, cursor)
            elif respuesta == '4':
                verVisitasAdministrativo(usuario, conn, cursor)
            elif respuesta == '5': 
                verReservaHabitacion(usuario, conn, cursor)
            elif respuesta == '6':
                verOperacionesAdministrativo(usuario,conn,cursor)
            elif respuesta == '7':
                verVisitasProgramadas(usuario,conn,cursor)
            elif respuesta == '8':
                verInventarioQuirofano(usuario,conn,cursor)
            elif respuesta == '9':
                bucle = False
        except Exception as error:
            print(f"Error: {error}")
            input("Enter per continuar: ")
###

def menuRecursosHumanos(usuario, conn, cursor):
    bucle = True
    while bucle:
        try:
            os.system('cls')
            print('-' * 40)
            print('Menú gestión recursos humanos')
            print('-' * 40, end='\n\n\n')
            print("1. Dar alta empleado")
            print("2. Salir")
            respuesta = input("Escoger una opcion: ")
            if respuesta == '1':
                id_direccion = darAltaDireccion(usuario, conn, cursor)
                dni_nie = darAltaPersona(usuario, conn, cursor, id_direccion)
                id_empleado = darAltaEmpleado(usuario, conn, cursor, dni_nie)
                darAltaProfesion(usuario, conn, cursor, id_empleado)
            elif respuesta == '2':
                bucle = False
        except Exception as error:
            print(f"Error: {error}")
            input("Enter per continuar: ")