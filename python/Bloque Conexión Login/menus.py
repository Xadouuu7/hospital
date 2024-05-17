import os
from funciones import *
from sys import exit
from tabulate import tabulate
from dummy import *
def menuPrincipal():
    os.system('clear')
    print('-' * 40)
    print('Menu Login')
    print('-' * 40, end='\n\n\n')
    print("1. Inicio de sesion")
    print("2. Registrarse")
    print("3. Salir", end='\n\n\n')
    print("Escoger una opcion: ", end='')

def menuLogin():
    os.system('clear')
    print('-' * 40)
    print('Iniciar Sesión')
    print('-' * 40, end='\n\n\n')
    print('Nombre de Usuario: ',end='')
    usuario = input()
    print('Contraseña: ', end='')
    contraseña = input()
    return usuario,contraseña

def menuRegistrarse():
    os.system('clear')
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
        try:
            os.system('clear')
            print('-' * 40)
            print('Menú gestión paciente')
            print('-' * 40, end='\n\n\n')
            print("1. Ver visitas")
            print("2. Ver historial")
            print("3. Ver diagnósticos y receta")
            print("4. Salir", end='\n\n\n')
            respuesta = input("Escoger una opcion: ")
            if respuesta == '1':
                verVisitaPaciente(usuario, conn, cursor)
            elif respuesta == '2':
                verHistorial(usuario, conn, cursor)
            elif respuesta == '3':
                verDiagnosticoReceta(usuario, conn, cursor)
            elif respuesta == '4':
                bucle = False
        except Exception as error:
            print(f"Error: {error}")
            input("Enter per continuar")

### MEDICO
def menuMedico(usuario, conn, cursor):
    bucle = True
    while bucle:
        try:
            os.system('clear')
            print('-' * 40)
            print('Menú gestión medico')
            print('-' * 40, end='\n\n\n')
            print("1. Personal a cargo")
            print("2. Ver operaciones")
            print("3. Ver visitas")
            print("4. Ver visitas pacientes")
            print("5. Ver Diagnostico y receta de un paciente")
            print("6. Salir", end='\n\n\n')
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
        except Exception as error:
            print(f"Error: {error}")
            input("Enter para continuar")

### Administrativo

def menuAdministrativo(usuario, conn, cursor):
    bucle = True
    while bucle:
        try:
            os.system('clear')
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
            print("9. Salir", end='\n\n\n')
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
                verOperacionesAdministrativoFecha(usuario,conn,cursor)
            elif respuesta == '7':
                verVisitasProgramadas(usuario,conn,cursor)
            elif respuesta == '8':
                verInventarioQuirofano(usuario,conn,cursor)
            elif respuesta == '9':
                bucle = False
        except Exception as error:
            print(f"Error: {error}")
            input("Enter per continuar: ")
### RRHH

def menuRecursosHumanos(usuario, conn, cursor):
    bucle = True
    while bucle:
        try:
            os.system('clear')
            print('-' * 40)
            print('Menú gestión recursos humanos')
            print('-' * 40, end='\n\n\n')
            print("1. Dar alta empleado")
            print("2. Consultar recursos hospitalarios")
            print("3. Informe personal")
            print("4. Informe visitas")
            print("5. Ranking médicos")
            print("6. Patologias más comunes")
            print("7. Exportar a XML")
            print("8. Salir", end='\n\n\n')
            respuesta = input("Escoger una opcion: ")
            if respuesta == '1':
                id_direccion = darAltaDireccion(usuario, conn, cursor)
                dni_nie = darAltaPersona(usuario, conn, cursor, id_direccion)
                id_empleado = darAltaEmpleado(usuario, conn, cursor, dni_nie)
                darAltaProfesion(usuario, conn, cursor, id_empleado)
            elif respuesta == '2':
                consultarRecursos(usuario, conn, cursor)
            elif respuesta == '3':
                informePersonal(usuario, conn, cursor)
            elif respuesta == '4':
                informeVisitas(usuario, conn, cursor)
            elif respuesta == '5':
                rankingMedicos(usuario, conn, cursor)
            elif respuesta == '6':
                patologiasMasComunes(usuario, conn, cursor)
            elif respuesta == '7':
                titulo('Exportar XML')
                print('1. Exportar XML de las visitas entre dos fechas')
                print('2. Exportar XML de las patologias mas comunes')
                respuesta = input("Escoger una opcion: ")
                if respuesta == '1':
                    exportXML_visitas(usuario, conn, cursor)
                elif respuesta == '2':
                    exportXML_patologies(usuario, conn, cursor)
            elif respuesta == '8':
                bucle = False
        except Exception as error:
            print(f"Error: {error}")
            input("Enter per continuar: ")

### Informático

def menuInformatico(usuario, conn, cursor):
    bucle = True
    while bucle:
        try:
            os.system('clear')
            titulo('Menú informático')
            print('1. Insertar pacientes')
            print('2. Insertar medicos')
            print('3. Insertar enfermeros')
            print('4. Insertar administrativo')
            print('5. Insertar recursos humanos')
            print('6. Insertar visitas')
            print('7. Borrar dummy')
            print("8. Salir", end='\n\n\n')
            respuesta = input("Escoger una opcion: ")
            if respuesta == '1':
                titulo("Insertar pacientes")
                respuesta = int(input("Número pacientes: "))
                maxid = fake_direccion(usuario,cursor,int(respuesta))
                lista_dni, lista_tsi, lista_fecha  = fake_persona(usuario,cursor,respuesta, maxid)
                fake_paciente(usuario,cursor,lista_dni,lista_tsi,lista_fecha)
            elif respuesta == '2':
                titulo("Insertar medicos")
                respuesta = int(input("Número medicos: "))
                maxid = fake_direccion(usuario,cursor,int(respuesta))
                lista_dni, lista_tsi, lista_fecha  = fake_persona(usuario,cursor,respuesta, maxid)
                maximo = fake_empleado(usuario, cursor, lista_dni)
                fake_medicos(conn, cursor, maximo, respuesta)
            elif respuesta == '3':
                titulo("Insertar enfermeros")
                respuesta = int(input("Número enfermeros: "))
                maxid = fake_direccion(usuario,cursor,int(respuesta))
                lista_dni, lista_tsi, lista_fecha  = fake_persona(usuario,cursor,respuesta, maxid)
                maximo = fake_empleado(usuario, cursor, lista_dni)
                fake_enfermeros(conn, cursor, maximo, respuesta)
            elif respuesta == '4':
                titulo("Insertar administrativo")
                respuesta = int(input("Número administrativo: "))
                maxid = fake_direccion(usuario,cursor,int(respuesta))
                lista_dni, lista_tsi, lista_fecha  = fake_persona(usuario,cursor,respuesta, maxid)
                maximo = fake_empleado(usuario, cursor, lista_dni)
                fake_administrativo(conn, cursor, maximo, respuesta)
            elif respuesta == '5':
                titulo("Insertar recursos humanos")
                respuesta = int(input("Número de empleados de recursos humanos: "))
                maxid = fake_direccion(usuario,cursor,int(respuesta))
                lista_dni, lista_tsi, lista_fecha  = fake_persona(usuario,cursor,respuesta, maxid)
                maximo = fake_empleado(usuario, cursor, lista_dni)
                fake_recursos_humanos(conn, cursor, maximo, respuesta)
            elif respuesta == '6':
                titulo("Insertar visitas")
                respuesta = int(input("Número de visitas: "))
                lista_descripciones, max_diagnostico = fake_diagnostico(conn,cursor,respuesta)
                fake_visita(conn,cursor,lista_descripciones,max_diagnostico)
            elif respuesta == '7':
                titulo("Borrar dummy")
                respuesta = input("1 para confimar: ")
                if respuesta == '1':
                    cursor.execute('TRUNCATE TABLE persona CASCADE;')
                    cursor.execute('TRUNCATE TABLE direccion CASCADE;')
                    cursor.execute('TRUNCATE TABLE diagnostico CASCADE;')
                    cursor.execute("SELECT setval('direccion_id_direccion_seq', 1, true);")
                    cursor.execute("SELECT setval('diagnostico_id_diagnostico_seq', 1, true);")
                    cursor.execute("SELECT setval('empleado_id_empleado_seq', 1, true);")
                    cursor.execute("SELECT setval('visita_id_visita_seq', 1, true);")
            elif respuesta == '8':
                bucle = False
        except Exception as error:
            print(f"Error: {error}")
            input("Enter per continuar: ")