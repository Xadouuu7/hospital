---
title: Home
layout: home
---

# Projecte Base de Dades i Programació: Hospital de Blanes
Fet per: Anderson Pérez Brazoban, Isaac Ruiz García i  M. del Mar Manzano Baena

# Documentació de l'esquema de la Base de Dades

## Esquema ER - Relacional

A l’hora de fer el disseny de l’Entitat-Relació vam començar per llegir els requisits que ens demanen per portar la gestió de l’hospital de Blanes. 

Primer ens parlen del personal de l’hospital, per tant, vam prendre la decisió de fer un model Entitat-Relació Estès amb les persones. Aquesta decisió es pren perquè hi ha informació que volem guardar tant dels empleats com dels pacients que és la mateixa, exceptuant algunes coses específiques. Al principi vam crear diferents subclasses segons si era pacient, metge, infermer… Però al final ens vam adonar que tornem a repetir massa informació que són comuns a tots els empleats, per tant, vam prendre la decisió de fer una superclasse dins de “persona” que és “empleat”.
El disseny de la superclasse persona tracta d’una especialització (top-down) on primer s’identifica la superclasse (persona) i posteriorment es troben les subclasses (“persona” i “pacients”). En aquest cas, l’especialització és solapada perquè els empleats poden ser pacients de l’hospital on treballen, per tant, també és total perquè qualsevol persona ha de pertànyer a “empleats”, a “pacients” o a ambdues.

En canvi, la superclasse “empleats”, encara que també és una especialització (top-down) on primer s’identifica la superclasse “empleats” i després les subclasses de diferents tipus de treballadors: metges, infermers, científics, farmacèutics, administratius, recursos humans i varis. Aquesta decisió es va prendre a part de per evitar repetir informació igual, també és per l’hora de crear els rols dins de la base de dades, ja que els diferents actors de la base de dades tindran diferents tipus d’accés a les dades segons la seva relació amb la base de dades.

Posteriorment vam decidir fer una entitat amb especialitat per assegurar-nos de que les dades entrades de cada especialitat del personal mèdic són correctes, exactament igual que fem a l’hora de separar direcció i ciutat en diferents entitats.

A l’hora de distribuir les diferents parts de l’hospital vam arribar a la conclusió de que totes les diferents habitacions de l’hospital (quiròfan, magatzems, habitacions, consultes…) són entitats febles perquè depenen de la planta on es troben. Com són entitats febles totes elles tindran la clau forana de la planta en la seva taula, d’aquesta manera es pot identificar quins magatzems, habitacions, consultes… són.
Les reserves tant de quiròfan com de visita hem decidit fer-ho entitat perquè és informació important on s’ha de tenir diferents informacions com el metge, el pacient, la data i l’hora de la reserva, primer vam pensar això només però després vam decidir afegir “administratius” que puguin fer aquestes reserves. 
L’historial mèdic del pacient nosaltres l’hem plasmat en l’entitat “visita”, ja que té les relacions que es necessiten tant amb les proves mèdiques, com a les receptes, al diagnòstic, etc.
A l’hora de fer els medicaments, patologies i els diferents tipus de materials ens hem basat en l’exemple de la base de dades Pagila. A Pagila hi ha una taula de “pel·lícules” on estan emmagatzemades tots els títols de les pel·lícules que tenen disponibles i després tenen una taula nova amb l’inventari de les còpies de les pel·lícules que tenen. Ho hem fet de la mateixa manera amb els medicaments, les patologies i el material de l’hospital, creant un inventari per a cada.

Per concloure, la majoria de decisions les hem pres pensant fonamentalment en els permisos a l’hora d’accedir a la base de dades. També hem basat varies decisions en altres bases de dades a les que tenim accés de prova (com Pagila o Adventureworks).

## SQL

Les coses a mencionar del codi SQL que hem fet per crear les taules són les següents:
Al DNI de les persones l’hem afegit un “check” que corrobori si té 9 caràcters, dels quals 8 són números i l’últim és una lletra dins d’aquestes: TRWAGMYFPDXBNJZSQVHLCKE. 
Al nom i als cognoms hem utilitzat un “check” perquè comprovi si fa que la primera lletra sigui majúscula i la resta minúscula (“initcap”).
Al correu electrònic hem afegit un “check” amb això:
'^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'. Això indica que hi ha lletres de l’alfabet, números o guions abans i després de l’arroba i abans i després del punt.
A la tarjeta sanitaria hem corroborat que el que s’introdueix siguin 14 caràcters; de la mateixa forma que a “grup_sanguini” i “rh” només es pot posar “A”, “B”, “AB” o “0”  i “+” i “-” respectivament.
Al número de la Seguretat Social hem posat que comprovi si té 12 digits.


----

[^1]: [It can take up to 10 minutes for changes to your site to publish after you push the changes to GitHub](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/creating-a-github-pages-site-with-jekyll#creating-your-site).

[Just the Docs]: https://just-the-docs.github.io/just-the-docs/
[GitHub Pages]: https://docs.github.com/en/pages
[README]: https://github.com/just-the-docs/just-the-docs-template/blob/main/README.md
[Jekyll]: https://jekyllrb.com
[GitHub Pages / Actions workflow]: https://github.blog/changelog/2022-07-27-github-pages-custom-github-actions-workflows-beta/
[use this template]: https://github.com/just-the-docs/just-the-docs-template/generate
