#####                                                                                  #####
#####                               LISTAS PARA LA DUMMY DATA                          #####
#####                                                                                  #####

## LISTA CON CIUDADES PARA AÑADIR A LAS EXPERIENCIAS PREVIAS DE LOS EMPLEADOS.

lista_hospitales = [ "Madrid", "Barcelona", "Valencia", "Sevilla", "Zaragoza", "Málaga", "Murcia", "Palma de Mallorca", 
                       "Las Palmas de Gran Canaria", "Bilbao", "Alicante", "Córdoba", "Valladolid","Vigo","Gijón"]

## LISTA CON LOS POSIBLES ESTUDIOS DE LOS/LAS MEDICOS. 

estudios_medicos = ['Grado en Medicina con especialidad en Anestesiología y reanimación', 'Grado en Medicina con especialidad en Anatomía Patológica',
                'Grado en Medicina con especialidad en Cardiología', 'Grado en Medicina con especialidad en Cirugía general',
                'Grado en Medicina con especialidad en Dermatología', 'Grado en Medicina con especialidad en Diagnostico para la imagen',
                'Grado en Medicina con especialidad en Digestología', 'Grado en Medicina con especialidad en Endocrinología',
                'Grado en Medicina con especialidad en Ginecología y obstetricia', 'Grado en Medicina con especialidad en Medicina del deporte']

## LISTA CON LOS POSIBLES ESSTUDIOS DE LOS/LAS ENFERMEROS/AS.

estudios_enfermeros = ['Grado de Enfermería con especialidad en Cirugía general', 'Grado de Enfermería con especialidad en Ginecología y obstetricia',
                'Grado de Enfermería con especialidad en Pediatría', 'Grado de Enfermería con especialidad en Trabajo Social',
                'Grado de Enfermería con especialidad en Salud Mental']

## LISTA CON LOS POSIBLES ESTUDIOS DE LOS EMPLEADOS DE RECURSOS HUMANOS.

estudios_recursos_humanos = ['Grado en Relaciones Laborales y Recursos Humanos', 'Grado en Psicología', 'Grado en Derecho', 
                        'Grado en Administración y Dirección de Empresas', 'Grado en Pedagogía', 'Grado en Economía', 'Grado en Sociología']

## LISTA Y DICCIONARIO CON LISTAS PARA CREAR EL MOTIVO DE LA VISITA.

palabras_clave = ["lesión", "enfermedad", "consulta", "examen", "tratamiento", "cirugía", "emergencia", "control", "seguimiento", "dolor"]

descripciones = {
    "lesión": ["fractura", "esguince", "contusión", "quemadura", "corte", "luxación", "deportiva", "en la espalda"],
    "enfermedad": ["resfriado", "gripe", "diabetes", "hipertensión", "asma", "cáncer", "VIH/SIDA", "enfermedad autoinmune"],
    "consulta": ["médica general", "especialista", "odontológica", "psicológica", "nutricional", "oftalmológica", "otorrinolaringológica", "dermatológica"],
    "examen": ["sangre", "orina", "rayos X", "ecografía", "resonancia magnética", "endoscopia", "colonoscopia", "electrocardiograma"],
    "tratamiento": ["fisioterapia", "quimioterapia", "radioterapia", "terapia hormonal", "psicoterapia", "antibiótico", "terapia de rehabilitación", "terapia ocupacional"],
    "cirugía": ["apendicectomía", "cesárea", "de corazón", "transplante", "colecistectomía", "de cataratas", "laparoscópica"],
    "emergencia": ["accidente automovilístico", "ataque al corazón", "accidente cerebrovascular", "intoxicación", "lesión grave", "hemorragia", "paro cardiorrespiratorio", "quemadura grave"],
    "control": ["diabetes", "presión arterial", "cáncer", "embarazo", "enfermedad crónica", "trastorno de ansiedad", "trastorno bipolar", "trastorno del sueño"],
    "seguimiento": ["post-operatorio", "de tratamiento", "de embarazo", "enfermedad crónica", "de lesión", "de cirugía", "de rehabilitación", "de quimioterapia"],
    "dolor": ["de cabeza", "abdominal", "de espalda", "muscular", "articular", "en el pecho", "en las articulaciones", "neuropático"]
}
