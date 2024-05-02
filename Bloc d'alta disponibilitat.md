---
title: Bloc d'alta disponibilitat
layout: home
nav_order: 4
---

# BLOC D'ALTA DISPONIBILITAT

## Infraestructura de hardware
### Servidor
Servidors: 2 Smart Selection PowerEdge R7515 Rack Servidor Premium
Foto no sé

#### Components

### Discs durs

#### Investigació

L'Hospital de Blanes dona cobertura, principalment, als municipis de Blanes, Lloret de Mar i Tossa (amb les seves urbanitzacions corresponents), per tant, això implica uns 86.000 pacients aproximadament. Podriem afegir, i considerar, també els turistes que pasen en aquesta zona les seves vacances, podriem fer una aproximació d'uns 200.000 pacients aproximadament (amb els turistes). 

Segons l'*"Informe anual del sistema nacional de salud, 2022" (pàgina 141)*, la freqüència amb la que els catalans van al metge són unes 7,8 vegades a l'any.
Per tant, podem calcular una aproximació de 86.000 pacients locals per 7,8 vegades a l'any, serien unes 654.000 visites a l'any de pacients locals. Podem afegir el doble d'aquestes pel que fa als turistes. En total seríen una mica més d'un milió aproximadament.

També segons l'*"Informe anual del sistema nacional de salud, 2022" (pàgina 145)* hi ha un total de 0,1 ingressos per persona i any a Espanya. Això implicaria unes 9.000 hospitalitzacions a l'any aproximadament.

L'any 2021 hi va haver 3.388.609 intervencions quirúrguiques en tot el país (*"Informe anual del sistema nacional de salud, 2022" (pàgina 147)*). Això significa que seria, aproximadament, respecte a 86.000 habitants unes 6020 intervencions quirúrguiques a l'any. Tenint consideració dels turistes podriem augmentar 1.000 aquestes intervencions a l'any per fer-nos una idea. Això faria unes 7.000 intervencions a l'any.

Per últim, pel que fa a consultes d'urgència d'atenció primària, van ser 29.718.224 (2021) segons l'*"Informe anual del sistema nacional de salud, 2022" (pàgina 151)*. Per tant, una aproximació a 86.000 d'habitants serien unes 53.234 visites d'urgència a l'any.

Tot això, si afegim totes les posibilitats que hem explicat aquí, ens situem en 1.070.000 aproximadament. Això implica una mica més de mil files de dades a l'any que s'introduiran a la base de dades. 

Segons el repte que van fer l'Anderson i la Maria del Mar sobre afegir mil milió de files dins d'una base de dades, que cada fila contenia 3 columnes d'informació, aquestes dades van ser d'aproximadament 50 Gb d'emmagatzematge. Tenint en compte que nosaltres, per a l'hospital, requerirem aproximadament de poc més d'1 milió de files a l'any que contenen 30 columnes cadascuna, podriem considerar que serien 5Gb d'emmagatzematge a l'any aproximadament (donat que hi ha columnes de la nostra base de dades tenen columnes amb molta més informació que la de mil milió de files).




### Armari Rack

### SAI


## Rèplica dels nodes

## Diagrama

## Manual d'instal·lació i d'administració

## Backups

### Codi de bash/python

### Explicació del codi

## Restauració de tota la base de dades

### Script

### Documentació


----

[^1]: [It can take up to 10 minutes for changes to your site to publish after you push the changes to GitHub](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/creating-a-github-pages-site-with-jekyll#creating-your-site).

[Just the Docs]: https://just-the-docs.github.io/just-the-docs/
[GitHub Pages]: https://docs.github.com/en/pages
[README]: https://github.com/just-the-docs/just-the-docs-template/blob/main/README.md
[Jekyll]: https://jekyllrb.com
[GitHub Pages / Actions workflow]: https://github.blog/changelog/2022-07-27-github-pages-custom-github-actions-workflows-beta/
[use this template]: https://github.com/just-the-docs/just-the-docs-template/generate
