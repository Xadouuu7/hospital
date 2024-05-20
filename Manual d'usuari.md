---
title: Manual d'usuari
layout: home
nav_order: 7
---

# Manual d'usuari

Aquest és el manual d'usuari que escrivim per que l'usuari final pugui saber com s'utilitza l'aplicació de l'Hospital segons el seu ofici.

## Introducció

Per connectar-te a l'aplicació només necessitaràs copiar i pegar una comanda a la terminal de l'ordinador.

Per poder fer això, primer s'ha d'utilitzar el buscador de l'ordinador. El buscador s'obre o prement el botó d'inici de la barra de sota de l'ordinador (barra d'eines) o polsant la tecla "Win" de l'ordinador:

![](imagenes/manual%20usuari/buscador.png)

En aquesta línia que està subratllada de vermell escrius "terminal" i sortirà la terminal de l'ordinador:

![](imagenes/manual%20usuari/terminal.png)

Obres la terminal i allà has de copiar i pegar la següent comanda: `ssh program_user@10.94.255.236`. Li donas a `enter` i et demanarà una contrasenya que és la següent: `12345` (també pots copiar i pegar-la) i li tornes a donar a `enter`. 

![](imagenes/manual%20usuari/ssh.png)

Automàticament s'obrirà el menú inicial de l'aplicació.

## Menú inicial

Després d'obrir l'aplicació apareixerà el menú d'inici on pots iniciar sessió o registrar-te.

![](imagenes/manual%20usuari/menulogin.png)

Si vols iniciar sessió has de entrar el número "1" i donar-li enter, en el cas de registrar-te escrius el número 2.

En el cas que escullis el número 1 apareixerà la següent pantalla on pots posar el teu usuari i contrasenya:

![](imagenes/manual%20usuari/iniciarsesion.png)

Una vegada entres les teves credencials ja pots accedir al menú que et pertoqui segons el teu ofici.

En el cas d'escullir el número 2 apareixerà la següent pantalla on pots posar un usuari i una contrasenya per poder accedir a l'aplicació:

![](imagenes/manual%20usuari/registrarse.png)

I així ja tens creat l'usuari per l'aplicació. En el cas dels empleats ja tenen automàticament assignat el seu usuari i la seva contrasenya, l'usuari és el número de la seguretat social i la contrasenya el DNI.

## Metge

En el cas que l'usuari sigui metge/ssa es mostrarà per pantalla el següent menú:

![](imagenes/manual%20usuari/menugestionmedico.png)

Per poder escollir una opció d'aquest menú s'ha d'escriure el número que vulguis escollir i donar-li enter.

### Personal a càrrec

Aquest menú és per poder veure quins infermers/res estan sota càrrec del metge que ha iniciat sessió.

Una vegada selecciones aquesta opció apareix la següent tabla on es pot veure quins són els/les infermers/res que estan sota càrrec.

![](imagenes/manual%20usuari/personalcargo.png)

### Veure operacions

Si escollim l'opció 2 accedim al menú de veure les operacions, aquí ens apareixerà una taula on podem veure a quin pacient operarem, en quin quiròfan, en quina planta, els/les infermers/res que intervendràn a l'operació, la data i hora de l'operació i l'administratiu que ha reservat aquesta operació.

![](imagenes/manual%20usuari/veroperaciones.png)

### Veure les visites que tinc

Si escollim l'opció 3, accedim al menú de veure quines visites tinc jo com a metge/ssa que ha iniciat sessió. Es pot veure la tarjeta sanitària del pacient, el nom complet del paicent, la data i hora de la visita, el motiu de la visita i el/la metge/ssa. En aquest cas hem escollit mostrar per pantalla les visites que té el metge "Nacho Morán" que és amb el metge que hem iniciat sessió per mostrar l'exemple.

![](imagenes/manual%20usuari/vervisitas.png)

### Veure visites d'un pacient

En l'opció 4 del menú, accedim a veure totes les visites d'un pacient que escribim a l'aplicació. Es mostra la següent frase per que introdueixis la tarjeta sanitaria del pacient que vols veure les visites:

![](imagenes/manual%20usuari/vervisitasdeunpaciente.png)

En aquest cas, hauràs de escriure la tarjeta sanitària i et sortiràn totes les visites que té aquell pacient.

![](imagenes/manual%20usuari/vervisitasdeunpaciente1.png)

### Veure diagnòstic i recepta d'un pacient

I per últim, quan escollim el número 5 del menú, es mostra un menú similar per escriure la tarjeta sanitaria del pacient per veure els diagnòstics i les receptes d'un pacient.

![](imagenes/manual%20usuari/verdiagnosticoyrecetadeunpaciente.png)

Una vegada introdueixes la tarjeta sanitaria del pacient que vols veure et mostra una taula amb el nom complet del pacient, el diagnòstic, el medicament que ha receptat, la dosis necessaria, la data i hora i el metge.

![](imagenes/manual%20usuari/verdiagnosticoyrecetadeunpaciente1.png)

## Recursos Humans

En el cas que l'usuari sigui un empleat de recursos humans es mostrarà per pantalla el següent menú:

![](imagenes/manual%20usuari/menugestionrrhh.png)

Per poder escollir una opció d'aquest menú s'ha d'escriure el número que vulguis escollir i donar-li enter.

### Donar alta a un empleat

L'opció 1 del menú és donar d'alta a un empleat a l'aplicació. En aquest menú et mostra l'horari de treball que farà, els dies de festa que té, el salari que cobrarà i el número de la Seguretat Social.

![](imagenes/manual%20usuari/introducirempleado.png)

Una vegada introdueixes aquestes dades et demanarà que seleccionis una opció depenent de quin empleat vulguis donar d'alta (metge, infermer, científic...).

![](imagenes/manual%20usuari/introducirempleado1.png)

Només has d'escollir el número del professional que vols donar d'alta.

### Consultar recursos hospitalaris

L'opció 2 d'aquest menú és per veure quantes habitacions, quants quiròfans i quants infermers/res hi ha per planta. Et demana per pantalla que introdueixis la planta que vols consultar:

![](imagenes/manual%20usuari/recursoshospitalarios.png)

I quan introdueixes la planta, et mostra la quantitat de cada per pantalla en forma de taula:

![](imagenes/manual%20usuari/recursoshospitalarios1.png)

### Informe del personal

L'opció 3 del menú és veure un informe del personal. Es mostra per pantalla el nom complet de l'empleat i la data de naixement. Primer et mostra els metges en una taula i cada cop que li dones a `enter` et mostra altres empleats.

![](imagenes/manual%20usuari/informepersonal.png)

### Informe del número de visites per dia

L'opció número 4 és l'informe de quantes visites hi ha en un dia. Surt per ordre de data.

![](imagenes/manual%20usuari/)

### Ranking de visites per metge





### 