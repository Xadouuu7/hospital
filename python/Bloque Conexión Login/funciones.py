import psycopg2
import csv
import hashlib
import random
import string
from tabulate import tabulate



def conectarBaseDatos(usuario = 'postgres', contraseña = 'postgres'):
    try:
        db_config = {
            'host': '192.168.1.73',
            'user': usuario,
            'password': contraseña,
            'dbname':'hospital'
        }
        conn = psycopg2.connect(**db_config)
        cursor = conn.cursor()  
        conn.autocommit = True
        return conn,cursor
    except Exception as error:
       print('Error en el usuario o la contraseña', error)

def crearUsuario(usuario, contraseña):
    try:
        if not comprobarUsuario(usuario):
            ## CREACION DEL USUARIO EN POSTGRES
            conn, cursor = conectarBaseDatos()
            query1 = f'CREATE ROLE "{usuario}" LOGIN PASSWORD %s'
            query2 = f'GRANT paciente TO "{usuario}"'
            cursor.execute(query1,(contraseña,))
            cursor.execute(query2)

            ## CREACION DEL USUARIO EN CSV
            ### SALTS
            salt_usuario = (''.join(random.choices(string.ascii_uppercase + string.ascii_lowercase + string.digits, k=20)))
            salt_contraseña = (''.join(random.choices(string.ascii_uppercase + string.ascii_lowercase + string.digits, k=20)))

            ### HASHING
            usuario = hashlib.sha256(usuario.encode() + salt_usuario.encode()).hexdigest()
            contraseña = hashlib.sha256(contraseña.encode() + salt_contraseña.encode()).hexdigest()

            ### WRITING TO CSV
            fichero = readUsuario()
            with open("usuarios.csv", 'w', newline='',encoding="UTF-8") as file:
                writer = csv.DictWriter(file,['salt_usuario','usuario','salt_contraseña','contraseña'], delimiter=';')
                writer.writeheader()
                for row in fichero:
                    writer.writerow(row)
                writer.writerow({'salt_usuario':salt_usuario, 'usuario': usuario, 'salt_contraseña':salt_contraseña, 'contraseña':contraseña})
    except Exception as error:
        print("Ha ocurrido un error:", error)
        input("Enter para continuar: ")

def comprobarUsuario(usuario):
    conn, cursor = conectarBaseDatos()
    query = "SELECT usename FROM pg_catalog.pg_user WHERE usename = %s"
    cursor.execute(query, (usuario,))
    if cursor.fetchone():
        print("\nEl usuario ya existe.")
        input("Enter para continuar")
        return True
    
def readUsuario():
    fichero = []
    with open("usuarios.csv", 'a',encoding="UTF-8") as file:
        pass
    with open("usuarios.csv", 'r',encoding="UTF-8") as file:
        reader = csv.DictReader(file, delimiter=';')
        for row in reader:
            fichero.append(row)
    return fichero

def comprobarRol(usuario):
    conn, cursor = conectarBaseDatos()
    consulta = "SELECT grupos FROM view_rol WHERE usuario = %s"
    cursor.execute(consulta, (usuario,))
    resultados = cursor.fetchall()
    return resultados[0][0][0]

## PACIENTE
def verVisitaPaciente(usuario, conn, cursor):
    consulta = "SELECT * FROM view_visita WHERE tarjeta_sanitaria = %s AND TO_CHAR(fecha_hora,'YYYY-MM-DD') = CURRENT_DATE::text"
    cursor.execute(consulta, (usuario,))
    rows = cursor.fetchall()
    print(tabulate(rows, headers=['Tarjeta Sanitaria','Paciente','Fecha y hora','Motivo de visita','Médico'], tablefmt="simple_grid"))
    input("Enter per continuar: ")
    
def verHistorial(usuario,conn,cursor):
    consulta = "SELECT * FROM view_visita WHERE tarjeta_sanitaria = %s AND TO_CHAR(fecha_hora,'YYYY-MM-DD') != CURRENT_DATE::text"
    cursor.execute(consulta, (usuario,))
    rows = cursor.fetchall()
    print(tabulate(rows, headers=['Tarjeta Sanitaria','Paciente','Fecha y hora','Motivo de visita','Médico'], tablefmt="simple_grid"))
    input("Enter per continuar: ")

## MEDICO 
def personalCargo(usuario, conn, cursor):
    consulta = "SELECT enfermero FROM view_contador_enfermeros WHERE num_ss = %s"
    cursor.execute(consulta, (usuario,))
    rows = cursor.fetchall()
    print(tabulate(rows, headers=['Enfermeros a cargo'], tablefmt="simple_grid"))
    input("Enter per continuar: ")

def verOperaciones(usuario, conn, cursor):
    consulta = "SELECT * FROM view_reserva_quirofano WHERE num_ss = %s ORDER BY fecha_hora_entrada ASC"
    cursor.execute(consulta, (usuario,))
    rows = cursor.fetchall()
    print("Operaciones")
    print(tabulate(rows, headers=['Paciente', 'Quirofano' ,' Planta', 'Medico' , 'Seguridad Social', 'Fecha entrada'], tablefmt="simple_grid"))
    input("Enter per continuar: ")

def verVisitasMedico(usuario, conn, cursor):
    consulta = "SELECT tarjeta_sanitaria, paciente, fecha_hora, motivo_visita, medico FROM public.view_visita WHERE num_ss = %s ORDER BY fecha_hora DESC;"
    cursor.execute(consulta, (usuario,))
    rows = cursor.fetchall()
    print("visitas")
    print(tabulate(rows, headers=['Tarjeta Sanitaria','Paciente','Fecha y hora','Motivo de visita','Médico','num_ss'], tablefmt="simple_grid"))
    input("Enter per continuar: ")

def verVisitasMedicoPaciente(usuario, conn, cursor):
    respuesta = input("Tarjeta sanitaria del paciente: ")
    consulta = "SELECT tarjeta_sanitaria, paciente, fecha_hora, motivo_visita, medico FROM public.view_visita WHERE tarjeta_sanitaria = %s AND num_ss = %s ORDER BY fecha_hora DESC;"
    cursor.execute(consulta, (respuesta,usuario))
    rows = cursor.fetchall()
    print("visitas")
    print(tabulate(rows, headers=['Tarjeta Sanitaria','Paciente','Fecha y hora','Motivo de visita','Médico','num_ss'], tablefmt="simple_grid"))
    input("Enter per continuar: ")

def verDiagnosticoRecetaPaciente(usuario, conn, cursor):
    respuesta = input("Tarjeta sanitaria del paciente: ")
    consulta = "SELECT tarjeta_sanitaria, paciente, descripcion, medicamento, dosis, fecha_hora, medico FROM public.view_receta  WHERE tarjeta_sanitaria = %s AND num_ss = %s ORDER BY fecha_hora DESC;"
    cursor.execute(consulta, (respuesta,usuario))
    rows = cursor.fetchall()
    print(tabulate(rows, headers=['Tarjeta Sanitaria','Paciente','Diagnostico','medicamento','Dosis','fecha y hora','Médico'], tablefmt="simple_grid"))
    input("Enter per continuar: ")
