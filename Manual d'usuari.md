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

Després d'obrir l'aplicació apareixerà el menú d'inici on pots iniciar sessió o registrar-te. Tota l'aplicació es basa en escollir les opcions que tens amb els números. Si l'opció que vols, en el cas d'iniciar sessió, és el número 1 només has d'entrar el número i et redireix a la següent pantalla amb aquesta opció.

![](imagenes/manual%20usuari/menulogin.png)

Si vols iniciar sessió has de entrar el número "1" i donar-li `enter`, en el cas de registrar-te escrius el número 2.

En el cas que escullis el número 1 apareixerà la següent pantalla on pots posar el teu usuari i contrasenya:

![](imagenes/manual%20usuari/iniciarsesion.png)

Una vegada entres les teves credencials ja pots accedir al menú que et pertoqui segons el teu ofici.

En el cas d'escullir el número 2 apareixerà la següent pantalla on pots posar un usuari i una contrasenya per poder accedir a l'aplicació:

![](imagenes/manual%20usuari/registrarse.png)

I així ja tens creat l'usuari per l'aplicació. En el cas dels empleats ja tenen automàticament assignat el seu usuari i la seva contrasenya, l'usuari és el número de la seguretat social i la contrasenya el DNI.


## Metge/ssa

En el cas que l'usuari sigui metge/ssa es mostrarà per pantalla el següent menú:

![](imagenes/manual%20usuari/menugestionmedico.png)

Per poder escollir una opció d'aquest menú s'ha d'escriure el número que vulguis escollir i donar-li `enter`.

### Personal a càrrec

Aquest menú és per poder veure quins infermers/res estan sota càrrec del metge que ha iniciat sessió.

Una vegada selecciones aquesta opció apareix la següent tabla on es pot veure quins són els/les infermers/res que estan sota càrrec.

![](imagenes/manual%20usuari/personalcargo.png)

### Veure operacions

Si escollim l'opció 2 accedim al menú de veure les operacions, aquí ens apareixerà una taula on podem veure a quin pacient operarem, en quin quiròfan, en quina planta, els/les infermers/res que intervendràn a l'operació, la data i l'hora de l'operació i l'administratiu que ha reservat aquesta operació.

![](imagenes/manual%20usuari/veroperacionespropias.png)

### Veure les visites que tinc

Si escollim l'opció 3, accedim al menú de veure quines visites tinc jo com a metge/ssa que ha iniciat sessió. Es pot veure la tarjeta sanitària del pacient, el nom complet del paicent, la data i l'hora de la visita, el motiu de la visita i el/la metge/ssa. En aquest cas hem escollit mostrar per pantalla les visites que té el metge "Nacho Morán" que és amb el metge que hem iniciat sessió per mostrar l'exemple.

![](imagenes/manual%20usuari/vervisitas.png)

### Veure visites d'un pacient

En l'opció 4 del menú, accedim a veure totes les visites d'un pacient que escribim a l'aplicació. Es mostra la següent frase per que introdueixis la tarjeta sanitaria del pacient que vols veure les visites:

![](imagenes/manual%20usuari/vervisitasdeunpaciente.png)

En aquest cas, hauràs de escriure la tarjeta sanitària i et sortiràn totes les visites que té aquell pacient.

![](imagenes/manual%20usuari/vervisitasdeunpaciente1.png)

### Veure diagnòstic i recepta d'un pacient

I per últim, quan escollim el número 5 del menú, es mostra un menú similar per escriure la tarjeta sanitaria del pacient per veure els diagnòstics i les receptes d'un pacient.

![](imagenes/manual%20usuari/verdiagnosticoyrecetadeunpaciente.png)

Una vegada introdueixes la tarjeta sanitaria del pacient que vols veure et mostra una taula amb el nom complet del pacient, el diagnòstic, el medicament que ha receptat, la dosis necessaria, la data i l'hora i el metge.

![](imagenes/manual%20usuari/verdiagnosticoyrecetadeunpaciente1.png)

## Recursos Humans

En el cas que l'usuari sigui un empleat de recursos humans es mostrarà per pantalla el següent menú:

![](imagenes/manual%20usuari/menugestionrrhh.png)

Per poder escollir una opció d'aquest menú s'ha d'escriure el número que vulguis escollir i donar-li `enter`.

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

![](imagenes/manual%20usuari/visitaspordia.png)

### Ranking de visites per metge

Si esculls el número 5 apareix una taula amb els metges que tenen més visites ordenat de major a menor.

![](imagenes/manual%20usuari/rankingmedicos.png)

### Patologies més comuns

L'opció número 6 et mostra una taula amb les patologies més comuns de l'Hospital.

![](imagenes/manual%20usuari/patologiasmascomunes.png)

### Exportar dades de l'Hospital

La última opció, el número 7, exporta informació a un arxiu per poder crear estadístiques amb el programa PowerBI o qualsevol altre servei d'anàlisi de dades amb visualització interactiva. Quan esculls aquesta opció, et mostra un nou menú amb dues opcions:

![](imagenes/manual%20usuari/exportarXML.png)

La primera opció t'obre un nou menú on has d'introduir dues dates (data d'inici i data final) d'aquesta manera et selecciona totes les visites entre aquestes dues dates que tu escullis. 

![](imagenes/manual%20usuari/exportarXML1.png)

Has d'introduir la data en aquest format: AAAA/MM/DD (Any/Mes/Dia).

L'opció número 2 simplement et dona un arxiu amb les patologies més comuns, no fa falta escollir res.

## Administratiu/va

Quan un usuari que és administratiu/va inicia sessió apareix el següent menú:

![](imagenes/manual%20usuari/menugestionadministrativo.png)

### Donar d'alta a un pacient

La primera opció és per donar d'alta a un pacient, una vegada esculls aquesta opció se't mostraran una sèrie de menús diferents per omplir les dades del pacient. Primer has d'entrar la direcció del pacient:

![](imagenes/manual%20usuari/introducirdireccion.png)

Quan introdueixes la direcció, et surt el següent menú per introduir les dades personals del pacient: dni, nom, cognoms, data de naixement... En el cas de la data de naixement has d'introduir-la amb la següent forma: AAAA/MM/DD (any/mes/dia).

![](imagenes/manual%20usuari/datospersona.png)

I, per últim, et demana les dades com a pacient: tarjeta sanitaria, altura, pes...En aquest cas l'altura s'ha d'introduir en centímetres, en el cas del pes s'ha d'introduir en quilograms. Pel que fa al grup sanguini obligatòriament ha de ser A, AB, B o 0 i en el cas de l'RH ha de ser "+" o "-".

![](imagenes/manual%20usuari/datospaciente.png)

### Veure el personal d'infermeria

La segona opció del menú d'administració és per veure el càrrec del personal d'infermeria, si estan assignats a una planta o a un metge. Quan esculls aquesta opció et mostra una taula amb els/les infermers/res i el número de planta o el nom del metge.

![](imagenes/manual%20usuari/personalenfermeria.png)

### Veure les operacions programades

La tercera opció del menú és per veure quines són totes les operacions que hi ha programades, et mostra el nom del pacient, el quiròfan, la planta, el metge que l'operarà, els infermers que intervenen en l'operació, la data i l'hora quan és l'operació i l'administratiu que va programar aquesta operació.

![](imagenes/manual%20usuari/veroperaciones.png)

### Veure visites programades

La quarta opció del menú és per veure quines són les visites programades, et mostra la tarjeta sanitaria del pacient, el nom complet, la data i l'hora de la visita, el motiu de la visita i el/la metge/ssa que atendrà la visita.

![](imagenes/manual%20usuari/visitasmasrecientes.png)

Surten les 100 visites més recents. A sota de la taula on et mostra tota la informació apareixerà una pregunta on et diu que si esculls 1 et mostra 100 visites més, si no vols veure més pots donar-li al dos per sortir.

![](imagenes/manual%20usuari/visitasmasrecientes1.png)

### Veure les reserves d'habitacions

En l'opció número cinc primer apareix que introdueixis el número d'habitació i el número de planta que vols consultar.

![](imagenes/manual%20usuari/reservashabitacion.png)

Quan esculls el número d'habitació i el número de planta et mostra les reserves d'aquella habitació en concret. Et mostra el pacient, el número d'habitació, la planta i la data d'entrada i sortida.

![](imagenes/manual%20usuari/reservashabitacion1.png)

### Veure les reserves de quiròfan

L'opció número sis és per veure les reserves de quiròfan d'un dia en concret. Quan esculls aquesta opció primer t'apareix que introdueixis la data de la qual vols veure les reserves de quiròfan. La data s'ha d'introduir de la següent forma: AAAA/MM/DD (any/mes/dia).

![](imagenes/manual%20usuari/reservasquirofano.png)

Quan esculls el dia, et mostra una taula amb el pacient a operar, en quin quiròfan, en quina planta, el/la metge/ssa que l'opera, els/les infermers/res que intervenen, la tarjeta sanitaria del pacient i la data i hora de l'operació.

![](imagenes/manual%20usuari/reservasquirofano1.png)

### Veure les visites programades d'un dia en concret

L'opció set és per veure les visites programades d'un dia que introdueixes manualment. Quan esculls aquesta opció s'obre un nou menú on et demana la data que vols escullir per veure les visites d'aquell dia. La data s'ha d'introduir d'aquesta forma: AAAA/MM/DD (any/mes/dia).

![](imagenes/manual%20usuari/vervisitasprogramadas.png)

Quan esculls la data, et mostra una taula per pantalla amb la tarjeta sanitaria, el nom del pacient, la data i l'hora de la visita, el motiu de la visita i el/la metge/ssa que l'atén.

![](imagenes/manual%20usuari/vervisitasprogramas1.png)

### Veure l'inventari del quiròfan

L'última opció del menú d'administratiu, el número 8, és on es veu l'inventori de cada quiròfan. Quan esculls aquesta opció et mostra per pantalla que introdueixis el número de quiròfan i el número de planta.

![](imagenes/manual%20usuari/verinventarioquirofano.png)

I quan esculls el quiròfan que vols veure, et mostrarà una taula amb el material que hi ha dins d'aquell quiròfan:

![](imagenes/manual%20usuari/verinventarioquirofano1.png)

## Informàtic/a

Quan l'usuari inicia sessió és informàtic/a apareix el següent menú:

![](imagenes/manual%20usuari/menugestioninformatico.png)

Aquest menú és per fer proves dins de la base de dades de l'Hospital, per tant, cada opció d'aquest menú és per crear dades falses i introduir-les dins de la base de dades.
Cada opció es per què vols introduir (pacients, metges, infermers...). En el cas de que vulguis introduir qualsevol d'aquestes opcions has d'escollir el número que pertoca.

![](imagenes/manual%20usuari/informaticodummy.png)

Totes les opcions són iguals, una vegada la esculls has d'introduir la quantitat que vols introduir.

I l'última opció és per borrar les dades falses creades, quan esculls aquesta opció apareix el següent menú:

![](imagenes/manual%20usuari/informaticoborrardummy.png) 

Et pregunta si vols confirmar aquesta ordre i has d'introduir el número 1 per continuar.