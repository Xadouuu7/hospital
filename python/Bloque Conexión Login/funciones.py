import psycopg2
import csv
import hashlib
import random
import string
import os
from tabulate import tabulate
import datetime
def titulo(string):
    os.system('clear')
    print('-' * 40)
    print(string)
    print('-' * 40, end='\n\n\n')
    
def conectarBaseDatos(usuario = 'postgres', contraseña = 'postgres'):
    try:
        db_config = {
            'host': '10.94.255.236',
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
    titulo("Visitas del dia")
    consulta = "SELECT tarjeta_sanitaria, paciente, fecha_hora, motivo_visita, medico FROM view_visita WHERE tarjeta_sanitaria = %s AND TO_CHAR(fecha_hora,'YYYY-MM-DD') = CURRENT_DATE::text"
    cursor.execute(consulta, (usuario,))
    rows = cursor.fetchall()
    print(tabulate(rows, headers=['Tarjeta Sanitaria','Paciente','Fecha y hora','Motivo de visita','Médico'], tablefmt="simple_grid"), end='\n\n\n')
    input("Enter per continuar: ")
    
def verHistorial(usuario,conn,cursor):
    titulo("Visitas pasadas")
    consulta = "SELECT tarjeta_sanitaria,paciente,fecha_hora,motivo_visita,medico FROM view_visita WHERE tarjeta_sanitaria = %s AND TO_CHAR(fecha_hora,'YYYY-MM-DD') != CURRENT_DATE::text ORDER BY fecha_hora DESC"
    cursor.execute(consulta, (usuario,))
    rows = cursor.fetchall()
    print(tabulate(rows, headers=['Tarjeta Sanitaria','Paciente','Fecha y hora','Motivo de visita','Médico'], tablefmt="simple_grid"), end='\n\n\n')
    input("Enter per continuar: ")

def verDiagnosticoReceta(usuario, conn, cursor):
    titulo("Diagnósticos y recetas")
    consulta = "SELECT tarjeta_sanitaria, paciente, descripcion, medicamento, dosis, fecha_hora, medico FROM public.view_receta  WHERE tarjeta_sanitaria = %s ORDER BY fecha_hora DESC;"
    cursor.execute(consulta, (usuario,))
    rows = cursor.fetchall()
    print(tabulate(rows, headers=['Tarjeta Sanitaria','Paciente','Diagnostico','medicamento','Dosis','fecha y hora','Médico'], tablefmt="simple_grid"), end='\n\n\n')
    input("Enter per continuar: ")

def verOperacionesPaciente(usuario, conn, cursor):
    titulo("Operaciones")
    consulta = "SELECT paciente, tarjeta_sanitaria, num_quirofano, num_planta, medico, enfermero, fecha_hora_entrada FROM view_reserva_quirofano WHERE tarjeta_sanitaria = %s ORDER BY fecha_hora_entrada DESC"
    cursor.execute(consulta, (usuario,))
    rows = cursor.fetchall()
    print(tabulate(rows, headers=['Paciente','Tarjeta sanitaria','Quirofano' ,' Planta', 'Medico' ,'Enfermeros/as','Fecha entrada'], tablefmt="simple_grid"), end='\n\n\n')
    input("Enter per continuar: ")

def verExpediente(usuario, conn, cursor):
    verHistorial(usuario,conn,cursor)
    verDiagnosticoReceta(usuario, conn, cursor)
    verOperacionesPaciente(usuario, conn, cursor)
    
## MEDICO 
def personalCargo(usuario, conn, cursor):
    titulo("Personal a cargo")
    consulta = "SELECT enfermero FROM view_contador_enfermeros WHERE num_ss = %s"
    cursor.execute(consulta, (usuario,))
    rows = cursor.fetchall()
    print(tabulate(rows, headers=['Enfermeros a cargo'], tablefmt="simple_grid"), end='\n\n\n')
    input("Enter per continuar: ")

def verOperaciones(usuario, conn, cursor):
    titulo("Operaciones")
    consulta = "SELECT * FROM view_reserva_quirofano WHERE num_ss = %s ORDER BY fecha_hora_entrada ASC"
    cursor.execute(consulta, (usuario,))
    rows = cursor.fetchall()
    print(tabulate(rows, headers=['Paciente','Tarjeta Sanitaria','Quirofano' ,' Planta', 'Medico' ,'Enfermeros','Seguridad Social', 'Fecha entrada','Administrativo'], tablefmt="simple_grid"), end='\n\n\n')
    input("Enter per continuar: ")

def verVisitasMedico(usuario, conn, cursor):
    titulo("Visitas")
    consulta = "SELECT tarjeta_sanitaria, paciente, fecha_hora, motivo_visita, medico FROM public.view_visita WHERE num_ss = %s ORDER BY fecha_hora DESC;"
    cursor.execute(consulta, (usuario,))
    rows = cursor.fetchall()
    print(tabulate(rows, headers=['Tarjeta Sanitaria','Paciente','Fecha y hora','Motivo de visita','Médico','num_ss'], tablefmt="simple_grid"), end='\n\n\n')
    input("Enter per continuar: ")

def verVisitasMedicoPaciente(usuario, conn, cursor):
    os.system("clear")
    respuesta = input("Tarjeta sanitaria del paciente: ")
    consulta = "SELECT tarjeta_sanitaria, paciente, fecha_hora, motivo_visita, medico FROM public.view_visita WHERE tarjeta_sanitaria = %s AND num_ss = %s ORDER BY fecha_hora DESC;"
    cursor.execute(consulta, (respuesta,usuario))
    rows = cursor.fetchall()
    titulo(f"Visitas de {respuesta}")
    print(tabulate(rows, headers=['Tarjeta Sanitaria','Paciente','Fecha y hora','Motivo de visita','Médico','num_ss'], tablefmt="simple_grid"), end='\n\n\n')
    input("Enter per continuar: ")

def verDiagnosticoRecetaPaciente(usuario, conn, cursor):
    os.system("clear")
    respuesta = input("Tarjeta sanitaria del paciente: ")
    consulta = "SELECT tarjeta_sanitaria, paciente, descripcion, medicamento, dosis, fecha_hora, medico FROM public.view_receta  WHERE tarjeta_sanitaria = %s AND num_ss = %s ORDER BY fecha_hora DESC;"
    cursor.execute(consulta, (respuesta,usuario))
    rows = cursor.fetchall()
    titulo(f"Diagnósticos y recetas de {respuesta}")
    print(tabulate(rows, headers=['Tarjeta Sanitaria','Paciente','Diagnostico','medicamento','Dosis','fecha y hora','Médico'], tablefmt="simple_grid"), end='\n\n\n')
    input("Enter per continuar: ")


## Administrativo
def darAltaDireccion(usuario,conn,cursor):
    while True:
        try:
            titulo("Introduzca la dirección")
            direccion = input("Introduzca el nombre de la calle: ")
            numero = input("Introduzca el número: ")
            piso = input("Introduzca el piso: ")
            puerta = input("Introduzca la puerta: ")
            codigo_postal = input("Introduzca el código postal: ")
            consulta = f"INSERT INTO direccion (direccion, numero, piso, puerta, id_ciudad) VALUES (%s,%s,%s,%s,(SELECT id_ciudad FROM ciudad WHERE codigo_postal = %s));"
            cursor.execute(consulta,(direccion,numero,piso,puerta,codigo_postal))
            consulta2 = f"SELECT id_direccion FROM direccion WHERE direccion = %s"
            cursor.execute(consulta2, (direccion,))
            id_direccion = cursor.fetchall()
            return id_direccion[0][0]
        except Exception as error:
            print(f"Error: {error}")
            input("Enter per continuar: ")

def darAltaPersona(usuario,conn,cursor,id_direccion):
    while True:
        try:
            titulo("Introduzca los datos de la persona")
            dni_nie = input("Introduzca el DNI/NIE: ").upper()
            nombre = input("Introduzca el nombre: ").capitalize()
            apellido1 = input("Introduzca el primer apellido: ").capitalize()
            apellido2 = input("Introduzca el segundo apellido: ").capitalize()
            fecha_nacimiento = input("Introduzca la fecha de nacimiento (YYYY-MM-DD): ")
            sexo = input("Introduzca el sexo (H,M,O): ")
            telefono = input("Introduzca el teléfono sin prefijo: ")
            correo_electronico = input("Introduzca el correo: ")
            consulta = f"INSERT INTO persona VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s);"
            cursor.execute(consulta,(dni_nie,nombre,apellido1,apellido2,fecha_nacimiento,sexo,telefono,correo_electronico,id_direccion))
            return dni_nie
        except Exception as error:
            print(f"Error: {error}")
            input()

def darAltaPaciente(usuario,conn,cursor, dni):
    bucle = True
    while bucle:
        try:
            titulo("Introduzca los datos del paciente")
            tarjeta_sanitaria = input("Introduzca la tarjeta sanitaria: ")
            altura = input("Introduzca tu altura en centimetros: ")
            peso = input("Introduzca tu peso (kg): ")
            grupo_sanguineo = input("Introduzca tu grupo sanguineo (A,AB,B,0): ").upper()
            rh = input("Introduzca tu rh (+, -): ")
            consulta = f"INSERT INTO paciente VALUES (%s, %s, %s, %s, %s, %s)"
            cursor.execute(consulta, (tarjeta_sanitaria,altura,peso,grupo_sanguineo,rh,dni))
            bucle = False
        except Exception as error:
            print(f"Error: {error}")
            input('Enter para continuar')

def verPersonalEnfermeria(usuario, conn, cursor):
    titulo("Personal de enfermeria")
    consulta = "SELECT enfermero, num_planta, medico FROM view_contador_enfermeros"
    cursor.execute(consulta)
    rows = cursor.fetchall()
    print(tabulate(rows, headers=['Enfermero','Planta','Medico responsable'], tablefmt="simple_grid"), end='\n\n\n')
    input("Enter per continuar: ")
    

def verOperacionesAdministrativo(usuario, conn, cursor):
    titulo("Operaciones")
    consulta = "SELECT * FROM view_reserva_quirofano ORDER BY fecha_hora_entrada DESC"
    cursor.execute(consulta, (usuario,))
    rows = cursor.fetchall()
    print(tabulate(rows, headers=['Paciente','Tarjeta Sanitaria', 'Quirofano' ,' Planta', 'Medico' ,'Enfermeros/as', 'Seguridad Social', 'Fecha entrada', 'Administrativo/a'], tablefmt="simple_grid"), end='\n\n\n')
    input("Enter per continuar: ")

def verVisitasAdministrativo(usuario, conn, cursor):
    contador = 0
    titulo("Visitas")
    consulta = "SELECT tarjeta_sanitaria, paciente, fecha_hora, motivo_visita, medico FROM public.view_visita ORDER BY fecha_hora DESC;"
    cursor.execute(consulta)
    rows = cursor.fetchall()
    while True:
        bloque_rows = rows[contador:contador+100]
        filas_formateadas = [list(row) for row in bloque_rows]
        if contador == 0:
            print(tabulate(filas_formateadas, headers=['Tarjeta Sanitaria', 'Paciente', 'Fecha y hora', 'Motivo de visita', 'Médico'], tablefmt="simple_grid"), end='\n\n\n')
        else:
            print(tabulate(filas_formateadas, tablefmt="simple_grid"), end='\n\n\n')
        respuesta = input("1 Para ver 100 más / 2 Para salir: ")
        if respuesta == '1':
            contador += 100
        elif respuesta == '2':
            return
    input("Enter para continuar: ")

def verOperacionesAdministrativoFecha(usuario,conn,cursor):
    os.system("clear")
    fecha = input("Introduce la fecha deseada (YYYY-MM-DD): ")
    consulta = "SELECT * FROM view_reserva_quirofano WHERE TO_CHAR(fecha_hora_entrada,'YYYY-MM-DD') = %s"
    cursor.execute(consulta,(fecha,))
    rows = cursor.fetchall()
    titulo(f"Operaciones previstas | {fecha}")
    print(tabulate(rows, headers=['Paciente','Tarjeta sanitaria','Quirófano','Planta','Médico','Enfermeros','Tarjeta Sanitaria','Fecha y hora de entrada','Administrativo'], tablefmt="simple_grid"))
    input("Enter per continuar: ")
    
def verReservaHabitacion(usuario, conn, cursor):
    os.system("clear")
    habitacion = input("Introduzca el numero de habitacion: ") 
    planta = input("Introduzca el numero de planta: ")
    titulo(f"Reservas Habitación | {habitacion}-{planta}")
    consulta = f"SELECT * FROM view_reserva_habitacion WHERE num_habitacion = %s AND num_planta = %s"
    cursor.execute(consulta,(habitacion,planta))
    rows = cursor.fetchall()
    print(tabulate(rows, headers=['Paciente','Numero de habitacion','Numero de planta','fecha de entrada y salida'], tablefmt="simple_grid"), end='\n\n\n')
    input("Enter per continuar: ")

def verVisitasProgramadas(usuario,conn,cursor):
    os.system("clear")
    fecha = input("Introduce la fecha deseada (YYYY-MM-DD): ")
    consulta = "SELECT tarjeta_sanitaria, paciente, fecha_hora, motivo_visita, medico FROM view_visita WHERE TO_CHAR(fecha_hora,'YYYY-MM-DD') = %s"
    cursor.execute(consulta,(fecha,))
    rows = cursor.fetchall()
    titulo(f"Visitas programadas | {fecha}")
    print(tabulate(rows, headers=['Tarjeta Sanitaria','Paciente','Fecha y hora','Motivo de visita','Médico'], tablefmt="simple_grid"), end='\n\n\n')
    input("Enter per continuar: ")

def verInventarioQuirofano(usuario,conn,cursor):
    os.system("clear")
    quirofano = input("Introduce el quirofano: ")
    planta = input("Introduce la planta: ")
    consulta = f"SELECT * FROM view_inv_quirofano WHERE planta = %s AND quirofano = %s"
    cursor.execute(consulta,(planta, quirofano))
    titulo(f"Inventario quirofano {quirofano}-{planta}")
    rows = cursor.fetchall()
    print(tabulate(rows, headers=['Material','Planta','Quirofano'], tablefmt="simple_grid"), end='\n\n\n')
    input("Enter per continuar: ")

# RECURSOS HUMANOS
def darAltaEmpleado(usuario, conn, cursor, dni_nie):
    while True:
        try:
            titulo("Introduzca los datos del empleado")
            horario_trabajo = input("Introduce su horario de trabajo (HH.MM,HH.MM): ")
            dias_vacaciones = input("Introduce los días de vacaciones: ")
            salario = input("Introduce su salario: ")
            num_ss = input("Introduce su número de la seguridad social: ")
            consulta = "INSERT INTO empleado (horario_trabajo, dias_vacaciones, salario, num_ss, dni_nie) VALUES (numrange(%s),%s,%s,%s,%s)"
            cursor.execute(consulta, (f"({horario_trabajo})", dias_vacaciones, salario, num_ss, dni_nie))
            conn.commit()
            consulta2 = "SELECT id_empleado FROM empleado WHERE num_ss = %s"
            cursor.execute(consulta2, (num_ss,))
            id_empleado = cursor.fetchone()[0]
            return id_empleado
        except Exception as error:
            print("Error:", error)
            input("Enter per continuar")

def darAltaProfesion(usuario,conn,cursor,id_empleado):
    bucle = True
    while bucle:
        try:
            titulo("Escoge una profesión")
            print("1. Médico")
            print("2. Enfermero")
            print("3. Científico")
            print("4. Administrativo")
            print("5. RRHH")
            print("6. Farmacéutico")
            print("7. Informático")
            respuesta = input("Escoger una opcion: ")
            if respuesta == '1':
                os.system("clear")
                estudios = input("Introduce sus estudios: ")
                experiencia = input("Introduce su experiéncia previa: ")
                especialidad = input("Introduce su especialidad exacta: ")
                consulta = "INSERT INTO medico VALUES (%s,%s,%s,(SELECT id_especialidad FROM especialidad WHERE nombre = %s))"
                cursor.execute(consulta,(id_empleado,estudios,experiencia,especialidad))
            elif respuesta == '2':
                os.system("clear")
                estudios = input("Introduce sus estudios: ")
                experiencia = input("Introduce su experiéncia previa: ")
                especialidad = input("Introduce su especialidad exacta: ")
                titulo("Tipo de enfermero")
                print("1. Planta")
                print("2. Asignado a un médico")
                print("3. Salir", end='\n\n\n')
                respuesta = input("Escoge una opción: ")
                if respuesta == '1':
                    os.system("clear")
                    planta = input("Introduce el número de planta")
                    consulta = "INSERT INTO enfermero (id_empleado,estudio,experiencia_previa,id_especialidad,num_planta) VALUES (%s,%s,%s,(SELECT id_especialidad FROM especialidad WHERE nombre = %s),%s)"
                    cursor.execute(consulta,(id_empleado,estudios,experiencia,especialidad,planta))
                elif respuesta == '2':
                    os.system("clear")
                    num_ss = input("Introduce el número de la seguridad social del médico responsable: ")
                    consulta = "INSERT INTO enfermero (id_empleado,estudio,experiencia_previa,id_especialidad,id_medico) VALUES (%s,%s,%s,(SELECT id_especialidad FROM especialidad WHERE nombre = %s),(SELECT id_empleado FROM empleado WHERE num_ss = %s))"
                    cursor.execute(consulta,(id_empleado,estudios,experiencia,especialidad,num_ss))
                elif respuesta == '3':
                    bucle = False
            elif respuesta == '3':
                os.system("clear")
                estudios = input("Introduce sus estudios: ")
                experiencia = input("Introduce su experiéncia previa: ")
                especialidad = input("Introduce su especialidad exacta: ")
                id_laboratorio = input("Introduce el número de laboratorio: ")
                num_planta = input("Introduce el número de planta: ")
                consulta = "INSERT INTO cientifico VALUES (%s,%s,%s,(SELECT id_especialidad FROM especialidad WHERE nombre = %s),%s,%s)"
                cursor.execute(consulta,(id_empleado,estudios,experiencia,especialidad,id_laboratorio,num_planta))
            elif respuesta == '4':
                os.system("clear")
                estudios = input("Introduce sus estudios: ")
                experiencia = input("Introduce su experiéncia previa: ")
                consulta = "INSERT INTO administrativo VALUES (%s,%s,%s)"
                cursor.execute(consulta,(id_empleado,estudios,experiencia))
            elif respuesta == '5':
                os.system("clear")
                estudios = input("Introduce sus estudios: ")
                experiencia = input("Introduce su experiéncia previa: ")
                consulta = "INSERT INTO recursos_humanos VALUES (%s,%s,%s)"
                cursor.execute(consulta,(id_empleado,estudios,experiencia))
            elif respuesta == '6':
                os.system("clear")
                estudios = input("Introduce sus estudios: ")
                experiencia = input("Introduce su experiéncia previa: ")
                especialidad = input("Introduce su especialidad exacta: ")
                consulta = "INSERT INTO farmaceutico VALUES (%s,%s,%s,(SELECT id_especialidad FROM especialidad WHERE nombre = %s))"
                cursor.execute(consulta,(id_empleado,estudios,experiencia,especialidad))
            elif respuesta == '7':
                os.system("clear")
                estudios = input("Introduce sus estudios: ")
                experiencia = input("Introduce su experiéncia previa: ")
                consulta = "INSERT INTO informatico VALUES (%s,%s,%s)"
                cursor.execute(consulta,(id_empleado,estudios,experiencia))
            bucle = False
        except Exception as error:
            print(f"Error: {error}")
            input("Enter per continuar: ")

def consultarRecursos(usuario,conn,cursor):
    os.system("clear")
    planta = input("Introduce la planta: ")
    consulta = f'SELECT "Habitaciones", "Quirófanos", "Enfermeros" FROM view_contador_planta WHERE "Planta" = %s'
    cursor.execute(consulta,(planta,))
    titulo(f"Recursos hospitalarios")
    rows = cursor.fetchall()
    print(tabulate(rows, headers=['Habitaciones','Quirófanos','Enfermeros'], tablefmt="simple_grid"), end='\n\n\n')
    input("Enter per continuar: ")

def informePersonal(usuario, conn, cursor):
    lista = [
        "SELECT nombre, CONCAT(apellido1, ' ', apellido2), fecha_nacimiento FROM view_medicos",
        "SELECT nombre, CONCAT(apellido1, ' ', apellido2), fecha_nacimiento FROM view_enfermeros",
        "SELECT nombre, CONCAT(apellido1, ' ', apellido2), fecha_nacimiento FROM view_farmaceuticos",
        "SELECT nombre, CONCAT(apellido1, ' ', apellido2), fecha_nacimiento FROM view_cientificos",
        "SELECT nombre, CONCAT(apellido1, ' ', apellido2), fecha_nacimiento FROM view_recursos_humanos",
        "SELECT nombre, CONCAT(apellido1, ' ', apellido2), fecha_nacimiento FROM view_informaticos"
    ]
    lista_titulos = ['Medicos','Enfermeros','Farmaceuticos','Cientificos','Recursos Humanos','Informaticos']
    for consulta, empleado in zip(lista, lista_titulos):
        contador = 0
        cursor.execute(consulta)
        rows = cursor.fetchall()
        for i in rows:
            contador += 1
        titulo(f"{empleado} | {contador}")
        print(tabulate(rows, headers=["Nombre","Apellidos","Fecha de nacimiento"], tablefmt="simple_grid"), end='\n\n\n')
        input("Enter per continuar: ")

def informeVisitas(usuario, conn, cursor):
    contador = 0
    titulo("Contador visitas por dia")
    consulta = "SELECT * FROM view_contador_visitas"
    cursor.execute(consulta)
    rows = cursor.fetchall()
    while True:
        bloque_rows = rows[contador:contador+100]
        filas_formateadas = [list(row) for row in bloque_rows]
        if contador == 0:
            print(tabulate(filas_formateadas, headers=['Fecha','Total Visitas'], tablefmt="simple_grid"), end='\n\n\n')
        else:
            print(tabulate(filas_formateadas, tablefmt="simple_grid"), end='\n\n\n')
        respuesta = input("1 Para ver 100 más / 2 Para salir: ")
        if respuesta == '1':
            contador += 100
        elif respuesta == '2':
            return

def rankingMedicos(usuario, conn, cursor):
    consulta = f"SELECT * FROM view_ranking_medicos"
    cursor.execute(consulta)
    titulo(f"Ranking visitas por médico")
    rows = cursor.fetchall()
    print(tabulate(rows, headers=['Médico','Cantidad de visitas'], tablefmt="simple_grid"), end='\n\n\n')
    input("Enter per continuar: ")
    
def patologiasMasComunes(usuario, conn, cursor):
    contador = 0
    titulo("Patologias mas comunes")
    consulta = "SELECT * FROM view_malalties_comuns"
    cursor.execute(consulta)
    rows = cursor.fetchall()
    while True:
        bloque_rows = rows[contador:contador+100]
        filas_formateadas = [list(row) for row in bloque_rows]
        if contador == 0:
            print(tabulate(filas_formateadas, headers=['Patologia','Total'], tablefmt="simple_grid"), end='\n\n\n')
        else:
            print(tabulate(filas_formateadas, tablefmt="simple_grid"), end='\n\n\n')
        respuesta = input("1 Para ver 100 más / 2 Para salir: ")
        if respuesta == '1':
            contador += 100
        elif respuesta == '2':
            return

def exportXML_visitas(usuario, conn, cursor):
    titulo('Exportacion de visitas')
    fecha_inicial = input('Introduce la fecha inicial(YYYY-MM-DD):')
    fecha_final = input('Introduce la fecha final(YYYY-MM-DD):')
    try:
        fecha_inicial_dt = datetime.datetime.strptime(fecha_inicial, '%Y-%m-%d')
        fecha_final_dt = datetime.datetime.strptime(fecha_final, '%Y-%m-%d')
        if fecha_inicial_dt >= fecha_final_dt:
            print("Error: La fecha inicial debe ser menor que la fecha final.")
            input("Enter para continuar")
            return 
    except ValueError:
        print("Error: Formato de fecha incorrecto. Use el formato YYYY-MM-DD.")
        input("Enter para continuar")
        return
    consulta = """
    WITH xml_output AS (
        SELECT query_to_xml('SELECT * FROM view_visita2 WHERE TO_CHAR(fecha_hora, ''YYYY-MM-DD'') BETWEEN '%s' AND '%s'', true, false, '') AS xml_result
    )
    SELECT REPLACE(xml_result::text, '<table xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">', '<table xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="visitas.xsd">
    ') AS modified_xml_result
    FROM xml_output;
    """
    
    cursor.execute(consulta, (str(fecha_inicial_dt)[0:11], str(fecha_final_dt)[0:11]))
    xml_result = cursor.fetchone()[0]

    nombre_archivo = '/home/program_user/XML/visitas.xml'
    with open(nombre_archivo, 'w',encoding='UTF-8') as archivo:
        archivo.write(xml_result)
    print(f"Los datos han sido exportados correctamente a {nombre_archivo}.")
    input('Enter para continuar')

def exportXML_patologies(usuario, conn, cursor):
    titulo('Exportacion de patologias')
    consulta = """
    WITH xml_output AS (
        SELECT query_to_xml('SELECT * FROM view_malalties_comuns', true, false, '') AS xml_result
    )
    SELECT REPLACE(xml_result::text, '<table xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">', '<table xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="patologies.xsd">
    ') AS modified_xml_result
    FROM xml_output;
"""
    
    cursor.execute(consulta)
    xml_result = cursor.fetchone()[0]

    nombre_archivo = '/home/program_user/XML/patologies.xml'
    with open(nombre_archivo, 'w',encoding='UTF-8') as archivo:
        archivo.write(xml_result)
    print(f"Los datos han sido exportados correctamente a {nombre_archivo}.")
    input('Enter para continuar')





