import psycopg2
from faker import Faker
import random
import string
from datetime import *
from ficheros import *

def conectarBaseDatos(usuario = 'postgres', contraseña = 'postgres'):
    try:
        db_config = {
            'host': '192.168.1.115',
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

def fake_ciudad():
    fichero = leer_ciudad()
    conn, cursor = conectarBaseDatos()
    datos_ciudad = [(ciudad['codigo_postal'], ciudad['nombre']) for ciudad in fichero]
    post_records = ", ".join(["%s"] * len(datos_ciudad[0]))
    insert_query = f"INSERT INTO ciudad (codigo_postal, nombre) VALUES ({post_records})"
    cursor.executemany(insert_query, datos_ciudad)
    conn.commit()
    conn.close()

    
def fake_direccion():
    fake = Faker('es_ES')
    num_registros = 10
    for _ in range(num_registros):
        id_ciudad = _


def fake_persona():
    fake = Faker('es_ES')
    num_registros = 10
    lista_personas = []
    lista_sexo = ['H','M','O']

    for _ in range(num_registros):
        dni = (''.join(random.choices(string.digits, k=8)))
        nombre = fake.first_name()
        apellido1 = fake.last_name()
        apellido2 = fake.last_name()
        fecha_de_nacimiento = fake.date_of_birth(maximum_age=130)
        sexo = random.choice(lista_sexo)
        numero_telefono = fake.phone_number().replace(' ', '').replace('+34', '')
        email = nombre[0:3] + '.' + apellido1 + str(fecha_de_nacimiento)[0:4]+ "@gmail.com"
        

def fake_empleado():
    pass

fake_ciudad()