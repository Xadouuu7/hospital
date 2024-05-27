import csv

def quitarDuplicados():

    fichero = []
    nombreCiudades = []

    ## LEEMOS EL FICHERO DONDE HAY CIUDADES DUPLICADAS Y NOS GUARDAMOS SOLO LOS NOMBRES SIN DUPLICADOS
    with open("ciudad.csv", 'r',encoding="UTF-8") as f:
        reader = csv.DictReader(f, delimiter=';')
        for row in reader:
            if row["nombre"] not in nombreCiudades:
                nombreCiudades.append(row["nombre"])

    ## COMPROBAMOS QUE EL NOMBRE ESTÁ EN LA LISTA DE NOMBRES, SI ES TRUE ELIMINA EL NOMBRE DE LA LISTA Y AÑADE LA FILA DEL CSV A UNA LISTA
    with open("ciudad.csv", 'r',encoding="UTF-8") as f:
        reader = csv.DictReader(f, delimiter=';')
        for row in reader:
            if row["nombre"] in nombreCiudades:
                fichero.append(row)
                nombreCiudades.remove(row["nombre"])

    ## BORRAREMOS TODO EL FICHERO Y LE AÑADIREMOS LOS REGISTROS QUE HEMOS AÑADIDO PREVIAMENTE EN LA LISTA
    with open("ciudad.csv",'w',encoding='UTF-8',newline='') as f:
        writer = csv.DictWriter(f,['codigo_postal','nombre'],delimiter=';')
        writer.writeheader()
        for a in fichero:
            writer.writerow({'codigo_postal':a["codigo_postal"],'nombre':a["nombre"]})

## LEER EL FICHERO DE LAS CIUDADES

def leer_ciudad():
    fichero = []
    with open("ciudad.csv", 'r',encoding="UTF-8") as f:
        reader = csv.DictReader(f, delimiter=';')
        for row in reader:
            fichero.append(row)
    return fichero

## LEER EL FICHERO DE LAS PATOLOGIAS

def leer_patologia():
    fichero = []
    with open("patologias.csv", 'r',encoding="UTF-8") as f:
        reader = csv.DictReader(f, delimiter=';')
        for row in reader:
            fichero.append(row)
    return fichero