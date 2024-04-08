import psycopg2
import hashlib
import csv
import os
import random
import string
### MENU
def tituloMenu(texto):
    print('-' * 40)
    print(texto)
    print('-' * 40, end='\n\n\n')

def menuInicial():
    os.system('cls')
    tituloMenu('Menu Login')
    print("1. Inicio de sesion")
    print("2. Registrarse", end='\n\n\n')
    print("Escoger una opcion: ", end='')
    respuesta = input()
    if '1' == respuesta:
        menuIniciarSesion()
    else:
        menuRegistrarse()

def menuIniciarSesion():
    os.system('cls')
    tituloMenu('Iniciar Sesion')
    print('Nombre de Usuario: ',end='')
    usuario = input()
    print('Contraseña: ', end='')
    contraseña = input()
    conectarBaseDatos(usuario,contraseña)
    

def menuRegistrarse():
    os.system('cls')
    tituloMenu('Registrarse')
    print('Nombre usuario: ',end='')
    usuario = input()
    print('Contraseña: ', end='')
    contraseña = input()
    crearUsuario(usuario,contraseña)
    menuInicial()

def conectarBaseDatos(usuario = 'postgres', contraseña = 'postgres'):
    try:
        db_config = {
            'host': '192.168.1.45',
            'user': usuario,
            'password': contraseña,
        }
        conn = psycopg2.connect(**db_config)
        cursor = conn.cursor()  
        conn.autocommit = True
        return conn,cursor
    except psycopg2.OperationalError:
       print('Error en el usuario o la contraseña')

def crearUsuario(usuario, contraseña):
    try:
        if not comprobarUsuario(usuario):
            ## CREACION DEL USUARIO EN POSTGRES
            conn, cursor = conectarBaseDatos()
            query = f'CREATE ROLE "{usuario}" LOGIN PASSWORD %s'
            cursor.execute(query,(contraseña,))

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




