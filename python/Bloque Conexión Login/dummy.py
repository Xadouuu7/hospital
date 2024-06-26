import psycopg2
from faker import Faker
import random
import string
from datetime import *
from ficheros import *
from unidecode import unidecode
from funciones import conectarBaseDatos
from datos import *

## AÑADIR LA DUMMY DATA DE CIUDAD DEL CSV, LLAMA AL ARCHIVO "FICHEROS" DONDE ESTÁN LAS FUNCIONES PARA LEER EL CSV. 

def fake_ciudad(conn,cursor):
    fichero = leer_ciudad()
    datos_ciudad = [(ciudad['codigo_postal'], ciudad['nombre']) for ciudad in fichero]
    post_records = ", ".join(["%s"] * len(datos_ciudad[0]))
    insert_query = f"INSERT INTO ciudad (codigo_postal, nombre) VALUES ({post_records})"
    cursor.executemany(insert_query, datos_ciudad)
    conn.commit()
    conn.close()

## AÑADIR LA DUMMY DATA DE PATOLOGIAS DEL CSV, LLAMA AL ARCHIVO "FICHEROS" DONDE ESTÁN LAS FUNCIONES PARA LEER EL CSV.     

def fake_patologia(conn,cursor):
    fichero = leer_patologia()
    datos_patologia = [(patologia['\ufeffId_patologia'], patologia['Nombre']) for patologia in fichero]
    post_records = ", ".join(["%s"] * len(datos_patologia[0]))
    insert_query = f"INSERT INTO patologia (id_patologia, nombre) VALUES ({post_records})"
    cursor.executemany(insert_query, datos_patologia)
    conn.commit()
    conn.close()
    
## CREA LA DIRECCIÓN PARA LA DUMMY DATA    

def fake_direccion(conn,cursor, num_registros):
    fake = Faker('es_ES')
    consulta = f"SELECT CASE WHEN MAX(id_direccion) IS NULL THEN '1' ELSE MAX(id_direccion) END FROM direccion;"
    cursor.execute(consulta)
    max_idDireccion = cursor.fetchall()
    for _ in range(num_registros):
        direccion = fake.street_name() ## UTILIZAMOS EL FAKER PARA GENERAR DIRECCIONES FALSAS EN ESPAÑOL
        numero = random.randint(1,99) ## Y PARA EL RESTO UTILIZAMOS UN RANDOM
        piso = random.randint(1,9)
        puerta = random.randint(1,9)
        id_ciudad = random.randint(1,9276)
        consulta = f"INSERT INTO direccion (direccion, numero, piso, puerta, id_ciudad) VALUES (%s, %s, %s, %s, %s)"
        cursor.execute(consulta,(direccion, numero, piso, puerta, id_ciudad)) ## LO INSERTAMOS EN LA BASE DE DATOS
    return max_idDireccion[0][0] 

## CREA LA PERSONA PARA LA DUMMY DATA

def fake_persona(conn, cursor, num_registros, id_direcion):
    lista_sexo = ['H','M']
    lista_dni = []
    lista_tsi = []
    lista_fecha = []
    letras = ("T","R","W","A","G","M","Y","F","P","D","X","B","N","J","Z","S","Q","V","H","L","C","K","E","T",) ## LETRAS PARA EL DNI
    cursor.execute("SELECT CASE WHEN MAX(dni_nie) IS NULL THEN '10000000A' ELSE MAX(dni_nie) END FROM persona;") ## SELECCIONA EL DNI MÁS ALTO PARA QUE NO SE CREEN REPETIDOS
    dni_minimo = cursor.fetchone()[0][:-1]
    for _ in range(int(num_registros)):
        if random.randint(0, 20) <= 15: ## GENERA UN RANDOM PARA CREAR PERSONAS O ESPAÑOLAS O RUSAS
            fake = Faker('es_ES')
        else:
            fake = Faker('ru_RU')
        dni_minimo = int(dni_minimo)  + 1 ## SUMA UNO AL DNI PARA QUE NO HAYAN REPETIDOS
        dni = str(dni_minimo) + letras[dni_minimo % 23] ## LE HACE EL MOD 23 PARA ESCOGER LA LETRA
        lista_dni.append(dni)
        nombre = fake.first_name() ## GENERAMOS NOMBRES INVENTADOS CON EL FAKER EN ESPAÑOL
        apellido1 = fake.last_name()
        apellido2 = fake.last_name()
        fecha_de_nacimiento = str(fake.date_of_birth(maximum_age=120)) ## GENERAMOS LA FECHA DE NACIMIENTO FALSA CON EDAD MÁXIMA EN 120.
        sexo = random.choice(lista_sexo) ## ESCOGE ALEATORIAMENTE SI ES HOMBRE O MUJER Y LE DA UN NÚMERO PARA LA TARJETA SANITARIA
        if sexo == 'H':
            num_sexo = '0'
        else:
            num_sexo = '1'
        tsi = ''.join((apellido1[0:2].upper(), apellido2[0:2].upper(), num_sexo, fecha_de_nacimiento[2:4], fecha_de_nacimiento[5:7], fecha_de_nacimiento[-2:], str(random.randint(0, 999)).zfill(3)))  ## GENERAMOS LA TARJETA SANITARIA
        lista_tsi.append(tsi)
        lista_fecha.append(fecha_de_nacimiento)
        fake = Faker('es_ES')
        telefono = fake.phone_number().replace(' ', '').replace('+34', '') ## GENERAMOS NUMERO FALSO EN ESPAÑOL
        email = unidecode(nombre[0:3] + '.' + apellido1 + str(fecha_de_nacimiento)[0:4] + "@gmail.com") ## GENERAMOS UN CORREO ELECTRÓNICO FALSO CON PARTE DEL NOMBRE, EL APELLIDO Y LA FECHA DE NACIMIENTO
        id_direcion += 1
        consulta = f"INSERT INTO persona VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
        cursor.execute(consulta, (dni, nombre, apellido1, apellido2, fecha_de_nacimiento, sexo, telefono, email.replace("'",''), id_direcion)) ## LO INSERTAMOS EN LA BASE DE DATOS
    return lista_dni, lista_tsi, lista_fecha

## GENERAMOS PACIENTES

def fake_paciente(conn, cursor, lista_dni, lista_tsi, lista_fecha):
    fecha_actual = str(datetime.now())
    lista_grupo = ['A','AB','B','0']
    lista_rh = ('+','-')
    for dni, tsi, fecha in zip(lista_dni, lista_tsi, lista_fecha): ## SEGÚN LA EDAD, LE ASIGNAMOS UNA ALTURA Y UN PESO ACORDE.
        edad = int(fecha_actual[0:4]) - int(fecha[0:4])
        if edad >= 0 and edad <= 1:
            altura = random.randint(30,80)
            peso = random.randint(1,10)
        elif edad >= 2 and edad <= 6:
            altura = random.randint(81,120)
            peso = random.randint(11,20)
        elif edad >= 7 and edad <= 11:
            altura = random.randint(121,148)
            peso = random.randint(21,40)
        elif edad >= 12 and edad <= 14:
            altura = random.randint(149,165)
            peso = random.randint(35,60)
        elif edad >= 15 and edad <= 18:
            altura = random.randint(148,200)
            peso = random.randint(40,80)
        elif edad >= 19 and edad <= 60:
            altura = random.randint(148,220)
            peso = random.randint(40,130)
        else:
            altura = random.randint(148,190)
            peso = random.randint(40,100)
        grupo_sanguineo = random.choice(lista_grupo) ## ALEATORIAMENTE ESCOGE UN GRUPO SANGUÍNEO.
        rh = random.choice(lista_rh)
        consulta = f"INSERT INTO paciente VALUES (%s, %s, %s, %s, %s, %s)" 
        cursor.execute(consulta,(tsi,altura,peso,grupo_sanguineo,rh,dni)) ## LO INSERTAMOS EN LA BASE DE DATOS.
        
## GENERAMOS EMPLEADOS 
        
def fake_empleado(conn, cursor, lista_dni):
    lista_ss = []
    consulta = f"SELECT CASE WHEN MAX(id_empleado) IS NULL THEN '1' ELSE MAX(id_empleado) END from empleado"
    cursor.execute(consulta)
    max_empleado = cursor.fetchall()
    for dni in lista_dni:
        ss_generado = False
        while not ss_generado:
            num_ss = random.randint(100000000000, 999999999999) ## NÚMERO DE LA SEGURIDAD SOCIAL
            if num_ss not in lista_ss:
                lista_ss.append(num_ss)
                ss_generado = True
        entrada_jornada = random.randint(0,16) ## LA JORNADA LABORAL ALEATORIA
        hora_entrada = int(entrada_jornada)
        hora_salida = hora_entrada + 8 ## PARA QUE SIEMPRE SEAN JORNADAS DE 8 HORAS.
        horario_trabajo = f"{hora_entrada}.00,{hora_salida}.00"
        dias_vacaciones = random.randint(10,20) ## ALEATORIAMENTE LE ADJUDICAMOS ENTRE 10 Y 20 DIAS DE VACACIONES.
        salario = random.randint(1000,10000) ## ALEATORIAMENTE LE ADJUDICAMOS UN SALARIO.
        consulta = f"INSERT INTO empleado (horario_trabajo, dias_vacaciones, salario, num_ss, dni_nie) VALUES (numrange(%s), %s, %s, %s, %s)"
        cursor.execute(consulta,(f"({horario_trabajo})", dias_vacaciones, salario, num_ss, dni)) ## LO INSERTAMOS EN LA BASE DE DATOS.
    return max_empleado[0][0]

## FUNCIONES PARA CADA TIPO DE EMPLEADO

def fake_medicos(conn, cursor, maximo, num_registros):
    for _ in range(num_registros):
        maximo += 1
        experiencia_previa = f"Hospital de {random.choice(lista_hospitales)}"
        especialidad = random.randint(1,24)
        consulta = f"INSERT INTO medico VALUES (%s, %s, %s, %s)"
        cursor.execute(consulta,(maximo,random.choice(estudios_medicos),experiencia_previa,especialidad)) ## LO INSERTAMOS EN LA BASE DE DATOS.

def fake_enfermeros(conn, cursor, maximo, num_registros):
    for _ in range(num_registros):
        opcion = random.randint(0, 1)
        maximo += 1
        experiencia_previa = f"Hospital de {random.choice(lista_hospitales)}"
        especialidad = random.randint(1, 24)
        if opcion == 0:  ## PARA HACER QUE SEA DE PLANTA O QUE DEPENDA DE UN MÉDICO
            consulta = f"INSERT INTO enfermero (id_empleado, estudio, experiencia_previa, id_especialidad, num_planta) VALUES (%s, %s, %s, %s, %s)"
            cursor.execute(consulta, (maximo, random.choice(estudios_enfermeros), experiencia_previa, especialidad, 1,)) ## LO INSERTAMOS EN LA BASE DE DATOS.
        else:
            consulta = f"SELECT id_empleado FROM medico ORDER BY RANDOM() LIMIT 1"
            cursor.execute(consulta)
            id_medico = cursor.fetchone()[0]
            consulta = f"INSERT INTO enfermero (id_empleado, estudio, experiencia_previa, id_especialidad, id_medico) VALUES (%s, %s, %s, %s, %s)"
            cursor.execute(consulta, (maximo, random.choice(estudios_enfermeros), experiencia_previa, especialidad, id_medico)) ## LO INSERTAMOS EN LA BASE DE DATOS.

def fake_administrativo(conn, cursor, maximo, num_registros):
    for _ in range(num_registros):
        maximo += 1
        estudios = 'Técnico Superior en Documentación y Administración Sanitarias'
        experiencia_previa = f"Hospital de {random.choice(lista_hospitales)}" ## UTILIZAMOS EL ARCHIVO "DATOS" PARA GENERAR HOSPITALES
        consulta = f"INSERT INTO administrativo VALUES (%s, %s, %s)"
        cursor.execute(consulta,(maximo,estudios,experiencia_previa)) ## LO INSERTAMOS EN LA BASE DE DATOS.

def fake_recursos_humanos(conn, cursor, maximo, num_registros):
    for _ in range(num_registros):
        maximo += 1
        experiencia_previa = f"Hospital de {random.choice(lista_hospitales)}" ## UTILIZAMOS EL ARCHIVO "DATOS" PARA GENERAR HOSPITALES
        consulta = f"INSERT INTO recursos_humanos VALUES (%s, %s, %s)"
        cursor.execute(consulta,(maximo,random.choice(estudios_recursos_humanos),experiencia_previa)) ## LO INSERTAMOS EN LA BASE DE DATOS.

## DIAGNOSTICOS
    
def fake_diagnostico(conn,cursor,num_registros):
    lista_descripciones = []
    consulta = f"SELECT CASE WHEN MAX(id_diagnostico) IS NULL THEN '1' ELSE MAX(id_diagnostico) END from diagnostico"
    cursor.execute(consulta)
    max_diagnostico = cursor.fetchone()[0]
    for _ in range(num_registros):
        consulta = f"SELECT id_patologia FROM patologia ORDER BY RANDOM() LIMIT 1"
        cursor.execute(consulta)
        id_patologia = cursor.fetchone()[0]
        motivo = random.choice(palabras_clave) ## UTILIZAMOS EL ARCHIVO "DATOS" PARA GENERAR UN MOTIVO DE LA VISITA CON SENTIDO.
        descripcion = random.choice(descripciones[motivo])
        diagnostico = f"{motivo} {descripcion}"
        lista_descripciones.append(diagnostico)
        consulta = f"INSERT INTO diagnostico (id_patologia,descripcion) VALUES (%s, %s)"
        cursor.execute(consulta,(id_patologia, diagnostico)) ## LO INSERTAMOS EN LA BASE DE DATOS.
    return lista_descripciones, max_diagnostico

## VISITA

def fake_visita(conn, cursor, lista_descripciones, max_diagnostico):
    fake = Faker('es_ES')
    for motivo in lista_descripciones:
        max_diagnostico += 1 
        cursor.execute("SELECT id_empleado FROM medico ORDER BY RANDOM() LIMIT 1")
        id_medico = cursor.fetchone()[0] 
        cursor.execute("SELECT tarjeta_sanitaria FROM paciente ORDER BY RANDOM() LIMIT 1")
        tsi = cursor.fetchone()[0]
        cursor.execute("SELECT id_consulta, num_planta FROM consulta ORDER BY RANDOM() LIMIT 1")
        id_consulta, num_planta = cursor.fetchone()
        consulta = f"INSERT INTO visita (id_medico,tarjeta_sanitaria,id_diagnostico,id_consulta,num_planta,fecha_hora,motivo_visita) VALUES (%s, %s, %s, %s, %s, %s, %s)"
        cursor.execute(consulta,(id_medico,tsi,max_diagnostico,id_consulta,num_planta,fake.date_time(),motivo)) ## LO INSERTAMOS EN LA BASE DE DATOS.
