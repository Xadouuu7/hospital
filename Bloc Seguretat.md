---
title: Bloc Seguretat
layout: home
nav_order: 3
---

# BLOC DE SEGURETAT

## MATRIU DE SEGURETAT


## SSL
El primer pas és crear un certificat SSL/TLS. Per fer-ho, utilitzarem OpenSSL, una eina que ens ajudarà a aconseguir-ho.

Aquesta comanda generarà una nova sol·licitud de signatura de certificat (CSR).
```
sudo openssl req -new -text -out server.req
```

ara farem una operació RSA amb la següent ordre, que agafarà la clau privada RSA de l'arxiu ```privkey.pem``` i guardarà la clau en un ```arxiu.key```
```
sudo openssl rsa -in privkey.pem -out server.key
```

Aquesta comanda genera un certificat autofirmat en el qual agafarà la sol·licitud de certificat ```server.req```, la clau privada del certificat ```server.key``` i generarà un fitxer anomenat ```server.crt```, creant així un certificat X.509 autofirmat.
```
sudo openssl req -x509 -in server.req -text -key server.key -out server.crt
```

Ara modificarem els fitxers ```server.key``` i ```server.crt``` perquè només el propietari tingui permisos de lectura i escriptura.
```
sudo chmod og-rwx server.key server.crt
```

Traslladem els fitxers a la ruta de destinació i canviem el propietari i el grup a 'postgres' de tots els fitxers ```server.key``` i ```server.crt```.
```
mv server.crt server.key /var/lib/postgresql/15/main/
chown -R postgres:postgres server.*
```

Per configurar correctament PostgreSQL, necessitaràs accedir a l'arxiu de configuració 'postgres.conf' amb el teu editor de text preferit. Hauràs de prestar atenció a tres línies específiques:

- ```ssl = on```, permet l'ús de SSL (Secure Sockets Layer), tot i que per norma general aquesta opció està activada de forma predeterminada.
- ```ssl_cert_file```, hauràs d'especificar la ruta del teu arxiu .crt que conté el certificat SSL.
- ```ssl_key_file```, hauràs de proporcionar la ruta del teu arxiu .key que conté la clau privada SSL.

```
# - SSL -

ssl = on
#ssl_ca_file = ''
ssl_cert_file = '/var/lib/postgresql/15/main/server.crt'
#ssl_crl_file = ''
#ssl_crl_dir = ''
ssl_key_file = '/var/lib/postgresql/15/main/server.key'
#ssl_ciphers = 'HIGH:MEDIUM:+3DES:!aNULL' # allowed SSL ciphers
#ssl_prefer_server_ciphers = on
#ssl_ecdh_curve = 'prime256v1'
#ssl_min_protocol_version = 'TLSv1.2'
#ssl_max_protocol_version = ''
#ssl_dh_params_file = ''
#ssl_passphrase_command = ''
#ssl_passphrase_command_supports_reload = off
```

Amb aquesta configuració només es permet que les connexions locals puguin accedir a la base de dades sense cap informació addicional. Totes les connexions IPv4 hauran de autenticar-se utilitzant MD5 a través de SSL, el que ens proporciona una capa addicional de seguretat.
```
# Database administrative login by Unix domain socket
local   all             postgres                                peer

# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:
#host    all             all             127.0.0.1/32            scram-sha-256
hostssl    all             all             0.0.0.0/0               md5
# IPv6 local connections:
#host    all             all             ::1/128                 scram-sha-256
# Allow replication connections from localhost, by a user with the
# replication privilege.
local   replication     all                                     peer
host    replication     all             127.0.0.1/32            scram-sha-256
host    replication     all             ::1/128                 scram-sha-256
```

Aquí la comprovació de que estem connectats utilitzant SSL.
![](imagenes/postgres/bloc_seguretat/verificacion_ssl.png)

## DATAMASKING
## AEPD
