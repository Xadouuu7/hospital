import csv 

def readCiudad():
    fichero = []
    with open("ciudad.csv", 'a',encoding="UTF-8") as file:
        pass
    with open("ciudad.csv", 'r',encoding="UTF-8") as file:
        reader = csv.DictReader(file, delimiter=';')
        for row in reader:
            fichero.append(row)
    return fichero

readCiudad()