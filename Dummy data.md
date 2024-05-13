---
title: Dummy data
layout: home
nav_order: 5
---

# Dummy Data

Per poder fer les proves inicials, l'Hospital de Blanes ens demana que creem dades aleatòries en cadascuna de les taules. Aquestes dades han de tener sentit i format correcte. En concret ens demanen unes 100.000 visites, 50.000 pacients, 100 metges/sses, 200 infermers/res i 150 empleats variats més. 

- [Arxiu de Dummy Data](/python/Bloque%20Conexión%20Login/dummy.py)
- [Arxiu del menú des d'on es pot executar](/python/Bloque%20Conexión%20Login/menus.py)

# Com generem les dades per diferents taules?

En aquesta part del treball explicarem com hem fet les dades aleatòries de les diferents taules de la Base de dades, hi ha taules que la manera de fer-ho és similar però hi ha altres taules que ho hem fet d'una altra manera.

# Ciutats i direccions

A l'hora de crear les ciutats, hem utilitzat [CSV de municipis d'Espanya](/python/Bloque%20Conexión%20Login/ciudad.csv) amb tots els municipis d'Espanya, d'aquesta manera ens assegurem que sense importar la direcció de la persona que s'ha d'afegir a la Base de Dades està contemplat el municipi d'on pot provenir. Utilitzem una funció anomenada `fake_ciudad()` on pasem per paràmetre `(conn, cursor)`. Aquests paràmetres són la connexió a la base de dades i el cursor.
La funció que utilitzem per fer la ciutat és la següent:

```python
def fake_ciudad(conn,cursor):
    fichero = leer_ciudad()
    datos_ciudad = [(ciudad['codigo_postal'], ciudad['nombre']) for ciudad in fichero]
    post_records = ", ".join(["%s"] * len(datos_ciudad[0]))
    insert_query = f"INSERT INTO ciudad (codigo_postal, nombre) VALUES ({post_records})"
    cursor.executemany(insert_query, datos_ciudad)
    conn.commit()
    conn.close()
```

Utilitzem un `for` per recòrrer el csv on hi són tots els municipis i ho afegim a una llista. després amb el `post_records` mira quants registres de ciutat hi ha i segons el número que hi hagi ho executa tantes vegades.
Després utilitzem la variable `insert_query` per insertar dins de la Base de dades la informació que ha guardat el cursor, amb `INSERT INTO ciudad (codigo_postal, nombre) VALUES `.
D'aquesta manera també ens assegurem que no hi ha municipis repetits dins de la Base de dades i que tot sigui correcte a l'hora d'entrar les dades de les direccions.

Per crear les direccions hem utilitzat la llibreria de python `faker` amb la versió en espanyol. D'aquesta manera ens assegurem que les direccions entrades són reals i versemblants.
Aquesta funció, com em mencionat, utilitza la llibreria `faker` en espanyol per poder generar noms de direccions lògiques que poden estar a Espanya. S'anomena `fake_direccion()` i passem per paràmetre `(conn, cursor, num_registros)`, és a dir, passem la connexió a la base de dades, el cursor i el `num_registros` que és l'`input` que ens diu quantes direccions falses es volen crear des del menú.

```python
def fake_direccion(conn,cursor, num_registros):
    fake = Faker('es_ES')
```

Després utilitzem un `for` per generar totes les dades que necessitem per la direcció completa:

```python
    for _ in range(num_registros):
        direccion = fake.street_name()
        numero = random.randint(1,99)
        piso = random.randint(1,9)
        puerta = random.randint(1,9)
        id_ciudad = random.randint(1,9276)
```

Aquesta funció, com hem mencionat anteriorment, utilitza la llibrería `faker` en espanyol per poder generar dades lògiques espanyoles. 
Després utilitzem un `for` per generar totes les dades que necessitem de la direcció:

- **Nom**: El nom de la direcció utilitza la llibreria `faker`.
- **Número**: El número del carrer utilitza la llibreria `random` per generar un número aleatori entre l'1 i el 99.
- **Pis i porta**: Fa exactament el mateix que el número del carrer però amb un número aleatori de l'1 al 9.
- **id_ciutat**: Utilitza una generació d'un número aleatori des de l'1 fins al 9276, que és el número de municipis que hi ha dins del csv.

```python
        consulta = f"INSERT INTO direccion (direccion, numero, piso, puerta, id_ciudad) VALUES (%s, %s, %s, %s, %s)"
        cursor.execute(consulta,(direccion, numero, piso, puerta, id_ciudad))
        consulta = f"SELECT MAX(id_direccion) from direccion"
        cursor.execute(consulta)
    max_idDireccion = cursor.fetchall()
    return max_idDireccion
```

Després creem una variable per que s'executi la inserció dins de la Base de Dades amb les dades que hem generat. Seleccionem l'última id de direcció per guardar-ho a la variable `max_idDireccion` i poder utilitzar-ho a la taula `persona`.

## Persona

En la nostra base de dades tenim una taula per guardar a totes les persones (siguin pacients o empleats).
Tenim una funció per generar a les persones de manera aleatoria.
Aquesta funció primer té diferents llistes que necessitem a l'hora de generar certes columnes de la taula: sexe, dni, tarjeta sanitària i data de naixement. A l'hora d'escollir les lletres del dni utilitzem una tupla.

```python
def fake_persona(conn, cursor, num_registros, maxid):
    fake = Faker('es_ES')
    lista_sexo = ['H','M']
    lista_dni = []
    lista_tsi = []
    lista_fecha = []
    letras = ("T","R","W","A","G","M","Y","F","P","D","X","B","N","J","Z","S","Q","V","H","L","C","K","E","T",)
```

Després per generar un dni vàlid, utilitzem la tupla i un `for` per poder crear la quantitat de DNIs que es demanin des del menú amb l'`input`. Després amb un `while` generem la quantitat de DNIs necessaris.

```python
for _ in range(int(num_registros)):
    if random.randint(0, 20) <= 15:
        fake = Faker('es_ES')
    else:
        fake = Faker('ru_RU')
    dni_generado = False 
    while not dni_generado:
        num_dni = random.randint(10000000, 99999999)
        dni = str(num_dni) + letras[num_dni % 23]
        if dni not in lista_dni:
            lista_dni.add(dni)
            dni_generado = True
```

Primer generem un número aleatori entre 10000000 i 99999999, una vegada tenim aquest número creem una variable que es diu `dni` on fem una combinació del número generat prèviament i fem el mod 23 del número generat per afegir la lletra que pertoca segons el número que ha sorgit. Utilitzem una llista per assegurar-nos de que els DNIs generats d'una vegada no es repeteixen: sí el dni no és a la `lista_dni` l'escriu dins la llista i també es guarda a la variable. 

Després, per generar el nom i els cognoms de la persona utilitzem la llibreria `faker` en espanyol, d'aquesta manera ens genera noms i cognoms que puguin ser en el nostre idioma.

```python
nombre = fake.first_name()
apellido1 = fake.last_name()
apellido2 = fake.last_name()
```

Continuant amb la generació aleatoria de persones, utilitzem la llibreria `faker` també per generar dates de naixement posant que la màxima edat que volem sigui 120 anys:

```python
fecha_de_nacimiento = str(fake.date_of_birth(maximum_age=120))
```

Amb el sexe de les persones utilitzem la llista on hi ha 'H' per home i 'M' per dona. Per escollir el sexe utilitzem la llibreria `random` per que esculli de manera aleatoria qualsevol de les dues lletres. 

```python
sexo = random.choice(lista_sexo)
```

Això l'utilitzem després per la tarjeta sanitaria. La tarjeta sanitaria consta de 4 lletres i 10 números: Les quatre lletres corresponen a les dues primeres lletres del primer cognom i les dues primeres lletres del segon cognom. Per tant, dins del codi utilitzem els cognoms que ha generat i agafem les dues primeres lletres per utilitzar-les en la generació de la tarjeta sanitaria. La tarjeta sanitaria després de les quatre lletres conté el primer número que consta d'un 0 si ets home o un 1 si ets una dona. Per aquest motiu, utilitzem un `if` amb el sexe que s'ha generat aleatoriament.

```python
if sexo == 'H':
    num_sexo = '0'
else:
    num_sexo = '1'
```

Després la tarjeta sanitaria conté la data de naixement de la persona en format YY/MM/DD, per tant, utilitzem la variable `fecha_de_nacimiento` per poder fer-ho. Per acabar, els tres últims números de la tarjeta sanitaria són números aleatoris, per tant, utilitzem la llibreria `random` perque esculli un número entre el 000 i el 999.

```python
tsi = ''.join((apellido1[0:2].upper(), apellido2[0:2].upper(), num_sexo, fecha_de_nacimiento[2:4], fecha_de_nacimiento[5:7], fecha_de_nacimiento[-2:], str(random.randint(0, 999)).zfill(3)))
lista_tsi.append(tsi)
```

Generem la tarjeta sanitaria juntament amb el nom però no ho afegim a la base de dades perquè la tarjeta sanitaria l'afegim a la taula de pacient, per tant, la generem a partir de les dades que es generen de la persona però ho guardem a una llista per després utilitzar-la a l'inserció de pacients. Fem el mateix amb la data de naixement, la guardem a una llista per utilitzar-la a l'hora de crear els pacients.

```python
telefono = fake.phone_number().replace(' ', '').replace('+34', '')
```

Després per generar el número de telèfon utilitzem la llibreria `faker`. Li treu el prefix i l'espai que es genera quan es crea el telèfon.

El correu electrònic el generem a partir de les dades pròpies de la persona que s'ha generat. Agafem les tres primeres lletres del nom, el primer cognom sencer i l'any de naixement +'@gmail.com'.

```python
email = nombre[0:3] + '.' + apellido1 + str(fecha_de_nacimiento)[0:4]+ "@gmail.com"
```

Per acabar utilitzem una variable anomenada `consulta` on guardem el `INSERT` de l'SQL per afegir les dades dins de la Base de Dades, i executem un cursor per fer-ho.

## Pacient

Dins de la taula de pacient guardem una sèrie de dades importants relacionades amb la salut: tarjeta sanitaria, altura, pes, grup sanguini, RH i el DNI com a clau foràna de `persona`.

Per generar les dades de la taula pacient utilitzem una funció nova. Al principi tenim una variable on guardem la data actual per utilitzar-la a l'hora de calcular l'edat de cada persona. Tenim una llista amb els possibles grups sanguinis i una tupla amb els possibles RH.

```python
def fake_paciente(conn, cursor, lista_dni, lista_tsi, lista_fecha):
    fecha_actual = str(datetime.now())
    lista_grupo = ['A','AB','B','0']
    lista_rh = ('+','-')
```

Després, utilitzem un `for` que fa un recorregut per les llista del DNI, la llista de les tarjetes sanitàries i la llista de les dates de naixement per seleccionar individualment cada valor. Això és per generar la quantitat de persones necessàries i que calculi l'edat segons la variable de la data actual i la data naixement. 
Utilitzem un `if` per generar diferents altures i pesos segons l'edat del pacient perquè siguin versemblants:

```python
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
```

Per acabar, utilitzem la llibreria `random` per escullir aleatòriament el grup sanguini i l'RH de la llista i la tupla respectivament:

```python
        grupo_sanguineo = random.choice(lista_grupo)
        rh = random.choice(lista_rh)
```

I afegim les dades dins de la base de dades amb un cursor:

```python
        consulta = f"INSERT INTO paciente VALUES (%s, %s, %s, %s, %s, %s)"
        cursor.execute(consulta,(tsi,altura,peso,grupo_sanguineo,rh,dni))
```

## Empleats

Per a crear els empleats hem creat una funció que s'anomena `fake_empleado()` i passem per paràmetres `(conn, cursor, lista_dni)` que és la connexió, el cursor i la llista on estan els DNIs per poder posar-ho a la taula com a clau forana.

Generem una llista pel número de la seguretat social. Creem una variable que s'anomena `consulta` on seleccionem l'`id_empleado` màxim per poder agafar l'últim que hem generat. Després utilitzem un `for` per recorrer la llista i saber quants cops hem de generar el número de la seguretat social. Ho genera amb un número aleatori entre el 100000000000 i el 999999999999. 

```python
def fake_empleado(conn, cursor, lista_dni):
    lista_ss = []
    consulta = f"SELECT MAX(id_empleado) from empleado"
    cursor.execute(consulta)
    max_empleado = cursor.fetchall()
    for dni in lista_dni:
        ss_generado = False
        while not ss_generado:
            num_ss = random.randint(100000000000, 999999999999)
            if num_ss not in lista_ss:
                lista_ss.append(num_ss)
                ss_generado = True
```

Per generar la jornada laboral, utilitzem números random i que per l'hora de sortida afegeixi 8 hores. Després fem una variable que sigui l'hora d'entrada i l'hora de sortida per insertar-ho a `horario_trabajo`. Per acabar utilitzem un cursor per acabar-ho d'afegir a la base de dades.

```python
        entrada_jornada = random.randint(0,16)
        hora_entrada = int(entrada_jornada)
        hora_salida = hora_entrada + 8
        horario_trabajo = f"{hora_entrada}.00,{hora_salida}.00"
        dias_vacaciones = random.randint(10,20)
        salario = random.randint(1000,10000)
        consulta = f"INSERT INTO empleado (horario_trabajo, dias_vacaciones, salario, num_ss, dni_nie) VALUES (numrange(%s), %s, %s, %s, %s)"
        cursor.execute(consulta,(f"({horario_trabajo})", dias_vacaciones, salario, num_ss, dni))
    return max_empleado[0][0]
```

Al final retornem l'últim número generat de l'id d'empleat (utilitzem `[0][0]` perquè la sentència SQL retorna una llista dins d'una tupla, així podem agafar només els valors que necessitem).

A tots els empleats utilitzem un fixer diferent que s'anomena "datos.py" on guardem llistes que ens fan falta a l'hora de generar certs aspectes dels empleats:

```python
lista_hospitales = [ "Madrid", "Barcelona", "Valencia", "Sevilla", "Zaragoza", "Málaga", "Murcia", "Palma de Mallorca", 
                       "Las Palmas de Gran Canaria", "Bilbao", "Alicante", "Córdoba", "Valladolid","Vigo","Gijón"]
```

Aquesta llista l'utilitzem per generar l'experiència previa dels/de les metges/ses a l'hora de posar en quin hospital van estar treballant abans.

```python
estudios_medicos = ['Grado en Medicina con especialidad en Anestesiología y reanimación', 'Grado en Medicina con especialidad en Anatomía Patológica',
                'Grado en Medicina con especialidad en Cardiología', 'Grado en Medicina con especialidad en Cirugía general',
                'Grado en Medicina con especialidad en Dermatología', 'Grado en Medicina con especialidad en Diagnostico para la imagen',
                'Grado en Medicina con especialidad en Digestología', 'Grado en Medicina con especialidad en Endocrinología',
                'Grado en Medicina con especialidad en Ginecología y obstetricia', 'Grado en Medicina con especialidad en Medicina del deporte']
```

Aquesta llista l'utilitzem per generar els diferents graus que han pogut cursar els/les metges/ses.

```python
estudios_enfermeros = ['Grado de Enfermería con especialidad en Cirugía general', 'Grado de Enfermería con especialidad en Ginecología y obstetricia',
                'Grado de Enfermería con especialidad en Pediatría', 'Grado de Enfermería con especialidad en Trabajo Social',
                'Grado de Enfermería con especialidad en Salud Mental']
```

Aquesta llista l'utilitzem per generar els graus que han pogut fer els/les infermers/res.

I, per últim, aquesta llista l'utilitzem per generar els diferents estudis que han pogut fer els empleats de recursos humans:

```python
estudios_recursos_humanos = ['Grado en Relaciones Laborales y Recursos Humanos', 'Grado en Psicología', 'Grado en Derecho', 
                        'Grado en Administración y Dirección de Empresas', 'Grado en Pedagogía', 'Grado en Economía', 'Grado en Sociología']
```

## Empleats

Totes les funcions que generen empleats entren per paràmetre la connexió a la base de dades, el cursor, el `maximo` que és l'últim `id_empleado` que s'ha generat i el `num_registros` per saber quants empleats es volen crear.

### Metges/es

Per a crear un metge utilitzem un `for` que recorre la quantitat de vegades que s'ha posat per paràmetre a `num_registros`. Cada cop que el `for` s'executa s'afegeix 1 a l'`id_empleado` per que sempre agafi l'últim. Per afegir els estudis, utilitzem una llista 
```python
    for _ in range(num_registros):
        maximo += 1
        experiencia_previa = f"Hospital de {random.choice(lista_hospitales)}"
        especialidad = random.randint(1,24)
        consulta = f"INSERT INTO medico VALUES (%s, %s, %s, %s)"
        cursor.execute(consulta,(maximo,random.choice(estudios_medicos),experiencia_previa,especialidad))
```
Per generar l'experiència previa utilitzem la frase "Hospital de" i d'una llista anomenada `lista_hospitales` on tenim diversos municipis ho fem de manera aleatoria. A l'hora d'escollir l'especialitat que té el metge fem que ho esculli de manera aleatoria dins de l'`id_especialitat` des de l'1 fins el 24 (que són les especialitats que poden ser de metge). Després s'executa el cursor que fa l'`INSERT` dins de la base de dades.

### Infermer/es

Els/les infermer/es poden dependre d'una planta o d'un metge, per això primer fem una variable `opcion` que esculli de manera aleatoria el 0 o l'1. Si l'opció és 0 significa que depèn d'una planta i per tant posem de manera automàtica la planta. Si es genera un 1 significa que depèn d'un metge i per tant afegim un id de metge a l'empleat.
```python
        if opcion == 0:
            consulta = f"INSERT INTO enfermero (id_empleado, estudio, experiencia_previa, id_especialidad, num_planta) VALUES (%s, %s, %s, %s, %s)"
            cursor.execute(consulta, (maximo, random.choice(estudios_enfermeros), experiencia_previa, especialidad, 1,))
        else:
            consulta = f"SELECT id_empleado FROM medico ORDER BY RANDOM() LIMIT 1"
            cursor.execute(consulta)
            id_medico = cursor.fetchone()[0]
            consulta = f"INSERT INTO enfermero (id_empleado, estudio, experiencia_previa, id_especialidad, id_medico) VALUES (%s, %s, %s, %s, %s)"
            cursor.execute(consulta, (maximo, random.choice(estudios_enfermeros), experiencia_previa, especialidad, id_medico))
```

### Administratius/ves

En el cas d'administratiu pels estudis utilitzem el de Tècnic/a superior en documentació i administració sanitaria, la resta de coses són exactament iguals que els altres empleats.

```python
def fake_administrativo(conn, cursor, maximo, num_registros):
    for _ in range(num_registros):
        maximo += 1
        estudios = 'Técnico Superior en Documentación y Administración Sanitarias'
        experiencia_previa = f"Hospital de {random.choice(lista_hospitales)}"
        consulta = f"INSERT INTO administrativo VALUES (%s, %s, %s)"
        cursor.execute(consulta,(maximo,estudios,experiencia_previa))
```

### Recursos humans

Igual que metge/ssa però amb una llista diferent per els diferents estudis que es poden tenir si treballes a recursos humans.

## Visites

## Diagnòstic

## Materials: general, quiròfan i laboratori

Pels materials tant general, com de quiròfan i de laboratori simplement hem fet una petita investigació sobre els diferents materials que es poden fer servir. Amb aquesta investigació en diferents pàgines webs del material emprat, hem creat tres arxius on estan els diferents `INSERT` necessaris per tenir-ho dins de la base de dades.
- [Material general](/python/Bloque%20Conexión%20Login/material_general.sql)
- [Material Quiròfan](/python/Bloque%20Conexión%20Login/material_quiròfan.sql)
- [Material Laboratori](python/Bloque%20Conexión%20Login/material_laboratori.sql)

## Generar i eliminar dades des del menú de l'aplicació

Dins del menú de l'informàtic/a hem afegit una opció per poder esborrar les dades que es vulguin:

```python
            elif respuesta == '7':
                titulo("Borrar dummy")
                respuesta = input("1 para confimar: ")
                if respuesta == '1':
                    cursor.execute('TRUNCATE TABLE persona CASCADE;')
                    cursor.execute('TRUNCATE TABLE direccion CASCADE;')
                    cursor.execute('TRUNCATE TABLE diagnostico CASCADE;')
                    cursor.execute("SELECT setval('direccion_id_direccion_seq', 1, true);")
                    cursor.execute("SELECT setval('diagnostico_id_diagnostico_seq', 1, true);")
```
L'opció 7 del menú de l'informàtic és fer una execució de diferents cursors que eliminen la informació.

## Índexos

Hem considerat crear els índexos de les dues taules més utilitzades de la base de dades: visita i diagnòstic. Utilitzem `CONCURRENTLY` perquè es pugui continuar fent inserts dins d'aquestes taules.

```sql
CREATE INDEX CONCURRENTLY indice_visitas ON visita (id_visita);

CREATE INDEX CONCURRENTLY indice_diagnosticos ON diagnostico (id_diagnostico);
```

----

[^1]: [It can take up to 10 minutes for changes to your site to publish after you push the changes to GitHub](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/creating-a-github-pages-site-with-jekyll#creating-your-site).

[Just the Docs]: https://just-the-docs.github.io/just-the-docs/
[GitHub Pages]: https://docs.github.com/en/pages
[README]: https://github.com/just-the-docs/just-the-docs-template/blob/main/README.md
[Jekyll]: https://jekyllrb.com
[GitHub Pages / Actions workflow]: https://github.blog/changelog/2022-07-27-github-pages-custom-github-actions-workflows-beta/
[use this template]: https://github.com/just-the-docs/just-the-docs-template/generate