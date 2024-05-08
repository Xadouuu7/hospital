import psycopg2
from faker import Faker
import random
import string
from datetime import *
from ficheros import *
from unidecode import unidecode
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
       print('Error: ', error)

def fake_ciudad(conn,cursor):
    fichero = leer_ciudad()
    conn, cursor = conectarBaseDatos()
    datos_ciudad = [(ciudad['codigo_postal'], ciudad['nombre']) for ciudad in fichero]
    post_records = ", ".join(["%s"] * len(datos_ciudad[0]))
    insert_query = f"INSERT INTO ciudad (codigo_postal, nombre) VALUES ({post_records})"
    cursor.executemany(insert_query, datos_ciudad)
    conn.commit()
    conn.close()

    
def fake_direccion(conn,cursor, num_registros):
    fake = Faker('es_ES')
    for _ in range(num_registros):
        direccion = fake.street_name()
        numero = random.randint(1,99)
        piso = random.randint(1,9)
        puerta = random.randint(1,9)
        id_ciudad = random.randint(1,9276)
        consulta = f"INSERT INTO direccion (direccion, numero, piso, puerta, id_ciudad) VALUES (%s, %s, %s, %s, %s)"
        cursor.execute(consulta,(direccion, numero, piso, puerta, id_ciudad))


def fake_persona(conn, cursor, num_registros):
    fake = Faker('es_ES')
    lista_sexo = ['H','M']
    lista_dni = []
    lista_tsi = []
    lista_fecha = []
    letras = ("T","R","W","A","G","M","Y","F","P","D","X","B","N","J","Z","S","Q","V","H","L","C","K","E","T",)
    for _ in range(num_registros):
        dni_generado = False
        while not dni_generado:
            num_dni = random.randint(10000000, 99999999)
            dni = str(num_dni) + letras[num_dni % 23]
            if dni not in lista_dni:
                lista_dni.append(dni)
                dni_generado = True
        nombre = fake.first_name()
        apellido1 = fake.last_name()
        apellido2 = fake.last_name()
        fecha_de_nacimiento = str(fake.date_of_birth(maximum_age=120))
        sexo = random.choice(lista_sexo)
        if sexo == 'H':
            num_sexo = '0'
        else:
            num_sexo = '1'
        tsi = ''.join((apellido1[0:2].upper(), apellido2[0:2].upper(), num_sexo, fecha_de_nacimiento[2:4], fecha_de_nacimiento[5:7], fecha_de_nacimiento[-2:], str(random.randint(0, 999)).zfill(3)))
        lista_tsi.append(tsi)
        lista_fecha.append(fecha_de_nacimiento)
        print(lista_tsi)
        telefono = fake.phone_number().replace(' ', '').replace('+34', '')
        email = nombre[0:3] + '.' + apellido1 + str(fecha_de_nacimiento)[0:4]+ "@gmail.com"
        id_direccion = random.randint(2,60000)
        consulta = f"INSERT INTO persona VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
        cursor.execute(consulta,(dni,nombre, apellido1, apellido2, fecha_de_nacimiento, sexo, telefono, unidecode(email), id_direccion))
    return lista_dni, lista_tsi, lista_fecha

def fake_paciente(conn, cursor, lista_dni, lista_tsi, lista_fecha):
    fecha_actual = str(datetime.now())
    lista_grupo = ['A','AB','B','0']
    lista_rh = ('+','-')
    for dni, tsi, fecha in zip(lista_dni, lista_tsi, lista_fecha):
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
        grupo_sanguineo = random.choice(lista_grupo)
        rh = random.choice(lista_rh)
        consulta = f"INSERT INTO paciente VALUES (%s, %s, %s, %s, %s, %s)"
        cursor.execute(consulta,(tsi,altura,peso,grupo_sanguineo,rh,dni))
        
def fake_empleado(conn, cursor, lista_dni):
    lista_ss = []
    for dni in lista_dni:
        ss_generado = False
        while not ss_generado:
            num_ss = random.randint(100000000000, 999999999999)
            if num_ss not in lista_ss:
                lista_ss.append(num_ss)
                ss_generado = True
        entrada_jornada = random.randint(0,16)
        hora_entrada = int(entrada_jornada)
        hora_salida = hora_entrada + 8
        horario_trabajo = f"{hora_entrada}.00,{hora_salida}.00"
        dias_vacaciones = random.randint(10,20)
        salario = random.randint(1000,10000)
        consulta = f"SELECT MAX(id_empleado) from medico"
        cursor.execute(consulta)
        max_empleado = cursor.fetchall()
        consulta = f"INSERT INTO empleado (horario_trabajo, dias_vacaciones, salario, num_ss, dni_nie) VALUES (numrange(%s), %s, %s, %s, %s)"
        cursor.execute(consulta,(f"({horario_trabajo})", dias_vacaciones, salario, num_ss, dni))
        return max_empleado[0][0]

def fake_medicos(conn, cursor, maximo, num_registros):
    lista_hospitales = [ "Madrid", "Barcelona", "Valencia", "Sevilla", "Zaragoza", "Málaga", "Murcia", "Palma de Mallorca", 
                       "Las Palmas de Gran Canaria", "Bilbao", "Alicante", "Córdoba", "Valladolid","Vigo","Gijón"]
    for _ in range(num_registros):
        maximo += 1
        experiencia_previa = f"Hospital {random.choice(lista_hospitales)}"
        especialidad = random.randint(1,24)
        consulta = f"INSERT INTO medico VALUES (%s, %s, %s, %s)"
        cursor.execute(consulta,(maximo,"Medicina",experiencia_previa,especialidad))

def main():
    conn, cursor = conectarBaseDatos()
    #fake_direccion(conn, cursor)
    lista_dni, lista_tsi, lista_fecha  = fake_persona(conn, cursor)
    fake_paciente(conn, cursor, lista_dni, lista_tsi, lista_fecha)
    maximo = fake_empleado(conn, cursor, lista_dni)
    fake_medicos(conn, cursor, maximo,)
main()