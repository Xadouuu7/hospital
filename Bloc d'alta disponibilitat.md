---
title: Bloc d'alta disponibilitat
layout: home
nav_order: 4
---

# BLOC D'ALTA DISPONIBILITAT

# Infraestructura de hardware
## Servidor
2x [Dell EMC PowerEdge R7515 Rack Servidor Premium](https://www.dell.com/es-es/shop/servidores-almacenamiento-y-redes/poweredge-r7515-servidor-rack-premium/spd/poweredge-r7515/per751509a): 6.934,73 €

![](imagenes/postgres/Bloc%20d'alta%20disponibilitat/Servidor.png)

### Components



| Component                     | Descripció                                                                                           |
| ----------------------------- | ---------------------------------------------------------------------------------------------------- |
| Processador                   | AMD EPYC 7543P 2.8GHz, 32C/64T, 256M Cache (225W) DDR4-3200                                          |
| Memoria RAM                   | 4x 16GB RDIMM, 3200MT/s, Dual Rank                                                                   |
| Emmagatzematge frontal        | Xassís amb 24x2.5"                                                                                   |
| RAID                          | RAID desconfigurada per HDDs o SSDs (permet barrejar diferents tipus)                                |
| Emmagatzematge intern         | 2x 480GB SSD SATA Read Intensive 6Gbps 512 2.5in Hot-plug AG Drive, 1 DWPD                           |
| Controladora d'emmagatzematge | PERC H740P, HBA330, RAID intern                                                                      |
| Ports USB                     | 4x USB 3.0 (1 frontal, 2 interns i 1 traser)                                                         |
| Ports de xarxa                | 2x ports RJ-45 d'1GbE                                                                                |
| Font d'alimentació            | Dual Hot-plug Redundant Power Supply(1+1) 750W Titanium 200-240Vac(CAUTION only supports 200-240Vac) |
| Sistema operatiu preinstalat  | Cap                                                                                                  |
| Dimensions                    | Alçada: 4.28 cm, Ample: 44.6 cm, Profunditat: 70.1 cm                                                |
| Pes                           | 16.5kg aproximadament                                                                                |
| Assitència                    | ProSupport and NextBusiness Day Onsite Service durant 84 mesos

## Discs durs

Segons la recerca que hem fet i expliquem més abaix, ens decantem per agafar 6 discs durs per posar a cada servidor. Hem escollit el [Seagate Barracuda SATA 6Gb/s 128MB 1TB](https://a.co/d/fencil0). Els servidors que hem escollit poden ampliar-se d'emmagatzematge, per tant, a priori agafem 3TB per a cada servidor, però sempre es poden ampliar en cas de que la base de dades s'ompli amb més velocitat del que estava previst.

### Recerca

L'Hospital de Blanes dona cobertura, principalment, als municipis de Blanes, Lloret de Mar i Tossa (amb les seves urbanitzacions corresponents), per tant, això implica uns 86.000 pacients aproximadament. Podriem afegir, i considerar, també els turistes que pasen en aquesta zona les seves vacances, podriem fer una aproximació d'uns 200.000 pacients aproximadament (amb els turistes). 

Totes les dades que utilitzarem a continuació estan estretes de l"*Informe anual del sistema nacional de salud, 2022"*

Segons aquest informe, la freqüència amb la que els catalans van al metge són unes 7,8 vegades a l'any. 
![](imagenes/postgres/Bloc%20d'alta%20disponibilitat/gráfico1.png)
Aquest és el gràfic 5-13 de l'"*Informe anual del sistema nacional de salud, 2022"*, aquí es pot veure la freqüentació de les consultes d'atenció primaria del Sistema Nacional de Salut segons professional (metge/ssa o infermer/a) a 2021. Com es pot veure a Catalunya és 4,6 visites al/la metge/ssa i 3,2 a l'infermer/a.

Per tant, podem calcular una aproximació de 86.000 pacients locals per 7,8 vegades a l'any, serien unes 654.000 visites a l'any de pacients locals. Podem afegir el doble d'aquestes pel que fa als turistes. En total seríen una mica més d'un milió aproximadament.

![](imagenes/postgres/Bloc%20d'alta%20disponibilitat/gráfico2.png)

Per altra banda, en aquesta part de l'Informe podem veure com la freqüentació d'ingressos per persona i any són de 0,1 a Espanya. Això implicaria unes 9.000 hospitalitzacions a l'any aproximadament. 

![](imagenes/postgres/Bloc%20d'alta%20disponibilitat/gráfico3.png)
Segons el mateix informe, l'any 2021 hi va haver 3.388.609 intervencions quirúrguiques en tot el país. Això significa que seria, aproximadament, respecte a 86.000 habitants unes 6020 intervencions quirúrguiques a l'any. Tenint consideració dels turistes podriem augmentar 1.000 aquestes intervencions a l'any per fer-nos una idea. Això faria unes 7.000 intervencions a l'any. 

![](imagenes/postgres/Bloc%20d'alta%20disponibilitat/gráfico4.png)
Per últim, pel que fa a consultes d'urgència d'atenció primària, van ser 29.718.224 a l'any 2021. Per tant, una aproximació a 86.000 d'habitants serien unes 53.234 visites d'urgència a l'any.

Tot això, si afegim totes les posibilitats que hem explicat aquí, ens situem en 1.070.000 aproximadament, només pel que fa a visites, en general podrien ser aproximadament un milió i mig (tenint en compte les reserves de quiròfan i d'habitacions). 
Això implicaria, aproximadament, un milió i mig de files de dades a l'any que s'introduiran a la base de dades. 

Segons el repte que van fer l'Anderson i la Maria del Mar sobre afegir mil milió de files dins d'una base de dades, que cada fila contenia 3 columnes d'informació, aquestes dades van ser d'aproximadament 50 Gb d'emmagatzematge.
Tenint en compte que nosaltres, per a l'hospital, requerirem aproximadament de poc més d'un milió i mig de files a l'any que contenen 30 columnes cadascuna, podriem considerar que serien 5Gb d'emmagatzematge a l'any aproximadament (donat que hi ha columnes de la nostra base de dades amb molta més informació que la del mil milió de files).

## Armari Rack

[Armari rack 19" 12U 600 x 800 I700](https://www.rackonline.es/armarios-rack-12u/armario-rack-19-12u-600-x-800-i700.html#/21-color-negro_antracita_ral_7016/23-puerta_frontal-puerta_cristal)
![](imagenes/postgres/Bloc%20d'alta%20disponibilitat/armari_rack.png)

## SAI

Una de les millors maneres de garantir l'alta disponibilitat dels nostres servidors és mitjançant l'ús d'un SAI (Sistema d'Alimentació Ininterrompuda). Aquest dispositiu permet mantenir el subministrament elèctric als nostres servidors durant els talls d'energia, assegurant el seu funcionament continu i evitant la pèrdua de dades o danys a l'equip a causa d'apagades repentines.
A més, els SAIs també proporcionen protecció contra fluctuacions de voltatge, pics de corrent i altres problemes relacionats amb la qualitat de l'energia elèctrica. És un element essencial en la infraestructura de qualsevol servidor crític.

![](imagenes/postgres/Bloc%20d'alta%20disponibilitat/sai.jpg)

Aquest [SAI](https://todosai.com/todosai/294-SAI-Phasak-2000VA-Online-LCD--PH-8020.html) utilitza la tecnologia on-line que garanteix una alimentació estable en tot moment, protegint els servidors de qualsevol fluctuació o interferència. Amb una capacitat de 2000VA i una potència de 1800W, el SAI té la capacitat suficient per alimentar dos servidors amb un consum de 750W cadascun, amb marge per a futurs augments de càrrega. A més de tot, té un programari de gestió que ens permetrà programar les accions del SAI com ara l'apagat automàtic dels servidors després d'un tall de llum o l'avís per correu electrònic dels esdeveniments.s

# Backups

En aquesta part mostrem el codi de Python que utilitzem per fer backups de la base de dades.

## Codi de python
```
import os
import subprocess
import datetime
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import requests
from github import Github

# Dades d'autenticació per pujar l'arxiu al Github:
repository_name = "Xadouuu7/hospital"
backup_path = "/etc/postgresql/backup"
date = datetime.datetime.now().strftime("%d-%b-%Y")
backup_file = f"Backup_logico_{date}.dump"

# Dades d'accés al server de POSTGRESQL:
user = "postgres"
password = "postgres" 
server = "192.168.1.73"

# Ruta on vam guardar els arxius de backup
backup_path = "/etc/postgresql/backup"
date = datetime.datetime.now().strftime("%d-%b-%Y")
backup_file = f"Backup_logico_{date}.dump"

# Fem la còpia de totes les bases de dades que hi ha a PostgreSQL server i comprimeix l'arxiu:
dump_command = f"PGPASSWORD={password} pg_dumpall -h {server} -U {user} | gzip > {backup_path}/{backup_file}.gz"
subprocess.run(dump_command, shell=True, check=True)

# Eliminem els arxius de backup creats fa més de 30 dies
old_files = subprocess.run(f"find {backup_path}/* -mtime +30", shell=True, capture_output=True, text=True)
for file in old_files.stdout.split('\n'):
    if file:
        os.remove(file)

# Canviem el propietari de l'arxiu de backup: 
os.chown(f"{backup_path}/{backup_file}.gz", 114, 114)  # El "114" és la ID de postgres.

# Obtenim el repositori de GitHub amb el token personal de l'Anderson:
g = Github("Token_del_repositori_De_Github")
repo = g.get_repo(repository_name)

# Pujem l'arxiu al respositori "hospital" de Github:
with open(f"{backup_path}/{backup_file}.gz", 'rb') as file:
    content = file.read()
    repo.create_file(f"backups/{backup_file}.gz", f"Backup lógico {date}", content)

# Enviem el correu electrònic que notifica que el backup s'ha fet:
smtp_server = "smtp.gmail.com"
smtp_port = 587
sender_email = "a.perez12@sapalomera.cat"
receiver_email = "a.perez12@sapalomera.cat"
password = "contrasenya"

message = MIMEMultipart()
message["From"] = sender_email
message["To"] = receiver_email
message["Subject"] = "Backup Logico PostgreSQL"
body = "La copia de seguridad lógica de la base de datos PostgreSQL ha sido realizada correctamente."
message.attach(MIMEText(body, "plain"))

text = message.as_string()

with smtplib.SMTP(smtp_server, smtp_port) as server:
    server.starttls()
    server.login(sender_email, password)
    server.sendmail(sender_email, receiver_email, text)

# Enviem la notificació a través d'un bot de Telegram: 
TOKEN = "6994393989:AAEpPV3jAr9vV4MnFVI_M3HJ-azcpPQDdmE"
CHAT_ID = "1599791868"
URL = f"https://api.telegram.org/bot{TOKEN}/sendMessage"
TEXT = f"Copia de seguridad backup_logico realizada {date}"

data = {
    "chat_id": CHAT_ID,
    "text": TEXT,
    "disable_web_page_preview": "1"
}

requests.post(URL, data=data) 
```

## Explicació del codi de backup

Aquest script realitza una copia de seguretat lògica completa de la base de dades, envia un missatge per correu electrònic i per Telegram. A més, també puja la copia a un repositori de GitHub per poder tenir la còpia en cloud i no només en local.

## CRONTAB 

S'ha decidit programar l'execució de la còpia de seguretat del servidor de PostgreSQL a les 6 del matí per les següents raons:

- **Menor càrrega de treball**: A les 6 del matí la càrrega de treball del servidor és baixa ja que hi ha menys càrrega de treball, la qual cosa ens garanteix que la còpia de seguretat no afecti el rendiment del sistema.
- **Major disponibilitat**: Tenint una còpia de seguretat recent al començament del dia, es garanteix una major disponibilitat de les dades en cas de qualsevol eventualitat que pugui ocórrer durant el dia.

![crontab](imagenes/postgres/Bloc%20d'alta%20disponibilitat/crontab.png)

# Restauració de tota la base de dades

En cas de que hi hagi algun problema amb la base de dades, hem de crear un script que faci una restauració de tota la base de dades.
## Script
```
#!/bin/bash

# Dades d'accés a POSTGRESQL server
USER="postgres"
export PGPASSWORD="postgres"
SERVER="192.168.1.73"

# Ruta on vam guardar els arxius de backup
BACKUP_PATH="/etc/postgresql/backup"
DATE=$(date +"%d-%b-%Y")
BACKUP_FILE="Backup_logico_$DATE.dump.gz"
LAST_BACKUP=""

# Comprovem si l'arxiu de backup d'avui existeix
if [ -f "$BACKUP_PATH/$BACKUP_FILE" ]; then
    LAST_BACKUP="$BACKUP_FILE"
else
    # Si no existeix, busquem l'últim arxiu disponible
    LAST_BACKUP=$(ls -t $BACKUP_PATH/Backup_logico_* | head -n 1)
fi

# Si no s'ha trobat cap arxiu de backup, mostrem un missatge i sortim
if [ -z "$LAST_BACKUP" ]; then
    echo "No s'ha trobat cap arxiu de backup disponible."
    exit 1
fi

# Descomprimim l'arxiu de backup
echo $BACKUP_PATH
echo $LAST_BACKUP
gunzip -c "$LAST_BACKUP" > "$BACKUP_PATH/restore_$DATE.sql"

# Restaurem les bases de dades
psql -h $SERVER -U $USER -f "$BACKUP_PATH/restore_$DATE.sql"
```
## Explicació del codi de restauració

Aquest script és una eina per restaurar la base de dades en cas de que hi hagi algun problema. Primer s'asegura si existeix un arxiu de backup recent per poder restaurar-lo. Si no és així, busca l'arxiu més recent disponible, en cas de que no hi hagi cap arxiu de backup ho mostra per terminal. Si troba l'arxiu de backup, el descomprimeix i el restaura.

----

[^1]: [It can take up to 10 minutes for changes to your site to publish after you push the changes to GitHub](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/creating-a-github-pages-site-with-jekyll#creating-your-site).

[Just the Docs]: https://just-the-docs.github.io/just-the-docs/
[GitHub Pages]: https://docs.github.com/en/pages
[README]: https://github.com/just-the-docs/just-the-docs-template/blob/main/README.md
[Jekyll]: https://jekyllrb.com
[GitHub Pages / Actions workflow]: https://github.blog/changelog/2022-07-27-github-pages-custom-github-actions-workflows-beta/
[use this template]: https://github.com/just-the-docs/just-the-docs-template/generate
