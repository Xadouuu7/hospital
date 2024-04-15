import csv

def readCiudad():
    fichero = {}
    with open("ciudad.csv", 'r',encoding="UTF-8") as f:
        reader = csv.DictReader(f, delimiter=';')
        for row in reader:
            fichero.append(row)
    return fichero

readCiudad()