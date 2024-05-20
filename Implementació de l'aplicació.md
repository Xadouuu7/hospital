---
title: Implementació de l'aplicació
layout: home
nav_order: 9
---

# Implementació de l'aplicació 

Nosaltres hem programat la nostra aplicació des de Visual Studio Code amb python, ara necessitem la forma de que la nostra aplicació es pugui implementar als diferents ordinadors del personal de l'hospital que es pugui instal·lar de manera desatesa o havent d'evitar instal·lar res al client.

Per tant, aquesta secció és per explicar com farem que els empleats de l'hospital puguin tenir accés a l'aplicació des del seus ordinadors cumplint amb aquests requeriments.

## Connexió per SSH 

La solució que nosaltres proposem és guardar el programa de python en el servidor, que els usuaris es connectin per SSH al servidor utilitzant un usuari que executa automàticament un script que executa el programa de python.

### Com ho hem assolit

Primer hem creat l'usuari que es connecta al servidor.

```bash
sudo useradd -m program_user
sudo passwd program_user 
```

Primer hem guardat el programa de python dins del servidor a la carpeta `/hospital/programa` amb la comanda `git clone`. Després hem creat un script que inicialitza el programa de python, aquest programa s'anomena `script.sh`:

```bash
#!/bin/sh
python3 /hospital/programa/main.py
```

Per fer que s'executi el programa de python quan aquest usuari inici sessió hem modificat un arxiu ocult dins del directori de l'usuari anomenat `.profile`. Primer hem de donar permissos a l'usuari sobre l'script anomenat `script.sh`:

```bash
sudo chmod +x /hospital/programa/script.sh
```

Després hem canviat l'arxiu `/etc/passwd` perquè l'arxiu que s'executi quan aquest usuari inici sessió sigui l'`script.sh` que hem fet per executar el python:

```bash
program_user:x:1002:1002::/home/program_user:/home/program_user/script.sh
```

Aqui mostrem com ara connectant-se des d'SSH i utilitzant aquest usuari s'inicia de manera automàtica el programa de python. Hem fet la prova amb el PuTTy.

![](/imagenes/postgres/Implementació%20aplicació/putty.png)

Iniciem l'usuari que hem creat i amb el qual s'inicia el programa:

![](/imagenes/postgres/Implementació%20aplicació/connexio.png)

I per últim, tenim com s'inicialitza el programa:

![](/imagenes/postgres/Implementació%20aplicació/sesion.png)

