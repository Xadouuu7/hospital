CREATE DATABASE IF NOT EXISTS Hospital;

CREATE TABLE IF NOT EXISTS ciudad (
    id_ciudad SERIAL PRIMARY KEY,
    nombre VARCHAR(30) UNIQUE NOT NULL 
);

CREATE TABLE IF NOT EXISTS planta (
    núm_planta SMALLINT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
);

CREATE TABLE IF NOT EXISTS laboratorio (
    id_laboratorio SERIAL,
    num_planta SMALLINT NOT NULL,
    FOREIGN KEY (num_planta) REFERENCES planta(num_planta),
    PRIMARY KEY (id_laboratorio, num_planta)
);

CREATE TABLE IF NOT EXISTS material_laboratorio (
    id_material SERIAL PRIMARY KEY,
    nombre VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS inv_laboratorio (
    id_inv_laboratorio SERIAL PRIMARY KEY,
    id_laboratorio INTEGER NOT NULL,
    num_planta SMALLINT,
    id_material INTEGER NOT NULL,
    FOREIGN KEY (id_laboratorio, num_planta) REFERENCES laboratorio(id_laboratorio,num_planta),
    FOREIGN KEY (id_material) REFERENCES material_laboratorio(id_material)
);

CREATE TABLE IF NOT EXISTS dirección (
    id_dirección SERIAL PRIMARY KEY,
    dirección VARCHAR(40) NOT NULL,
    número VARCHAR(5) NOT NULL,
    piso VARCHAR(7),
    puerta CHAR(1),
    código_postal CHAR(5) NOT NULL,
    id_ciudad INTEGER NOT NULL,
    FOREIGN KEY (id_ciudad) REFERENCES ciudad (id_ciudad)
);

CREATE TABLE IF NOT EXISTS persona (
    dni_nie CHAR(9) PRIMARY KEY CHECK (LENGTH(DNI_NIE) = 9 AND ((RIGHT(dni_nie, 1) IN ('TRWAGMYFPDXBNJZSQVHLCKE')) OR (LEFT(dni_nie, 1) IN ('XYZ') AND (RIGHT(dni_nie, 1) IN ('TRWAGMYFPDXBNJZSQVHLCKE')) )))
    nombre VARCHAR(30) NOT NULL CHECK (INITCAP(nombre) = nombre),
    apellido1 VARCHAR(30) NOT NULL CHECK (INITCAP(apellido1) = apellido1),
    apellido2 VARCHAR(30) NOT NULL CHECK (INITCAP(apellido2) = apellido2),
    fecha_nacimiento DATE NOT NULL,
    sexo CHAR(1) CHECK (género IN ('H','M','O')),
    teléfono CHAR(9) NOT NULL,
    correo_electrónico VARCHAR(40) CHECK (correo_electrónico ~ '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'),
    usuario VARCHAR(20),
    contraseña VARCHAR(30),
    id_dirección INTEGER NOT NULL,
    FOREIGN KEY (id_dirección) REFERENCES dirección (id_dirección)
);

CREATE TABLE IF NOT EXISTS paciente (
    tarjeta_sanitaria CHAR(14) PRIMARY KEY CHECK (LENGTH(tarjeta_sanitaria) = 14),
    altura NUMERIC(4,1) NOT NULL,
    peso NUMERIC(5,2) NOT NULL,
    grupo_sanguíneo VARCHAR(2) CHECK (grupo_sanguíneo IN ('A','B','AB','0')) NOT NULL,
    rh CHAR(1) CHECK (RH IN ('+','-')) NOT NULL,
    dni_nie CHAR(9) NOT NULL,
    FOREIGN KEY (dni_nie) REFERENCES persona (dni_nie)
);

CREATE TABLE IF NOT EXISTS empleado (
    id_empleado SERIAL PRIMARY KEY,
    horario_trabajo TSRANGE NOT NULL,
    dias_vacaciones INTEGER NOT NULL,
    salario NUMERIC(7,2) NOT NULL,
    num_ss CHAR(12) CHECK (LENGTH(num_ss) = 12),
    dni_nie CHAR(9) NOT NULL,
    FOREIGN KEY (dni_nie) REFERENCES persona (dni_nie)
);

CREATE TABLE IF NOT EXISTS especialidad (
    id_especialidad SERIAL PRIMARY KEY,
    nombre VARCHAR(30) UNIQUE NOT NULL,
);

CREATE TABLE IF NOT EXISTS varios (
    id_empleado INTEGER PRIMARY KEY,
    trabajo VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado)
);

CREATE TABLE IF NOT EXISTS farmacéutico (
    id_empleado INTEGER PRIMARY KEY,
    estudio TEXT,
    experiencia_previa TEXT,
    id_especialidad INTEGER NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado),
    FOREIGN KEY (id_especialidad) REFERENCES especialidad (id_especialidad)
);

CREATE TABLE IF NOT EXISTS administrativo (
    id_empleado INTEGER PRIMARY KEY,
    estudio TEXT,
    experiencia_previa TEXT,
    FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado)
);

CREATE TABLE IF NOT EXISTS médico (
    id_empleado INTEGER PRIMARY KEY,
    estudio TEXT,
    experiencia_previa TEXT,
    id_especialidad INTEGER NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado),
    FOREIGN KEY (id_especialidad) REFERENCES especialidad (id_especialidad)
);

CREATE TABLE IF NOT EXISTS científico (
    id_empleado INTEGER PRIMARY KEY,
    estudio TEXT,
    experiencia_previa TEXT,
    id_especialidad INTEGER NOT NULL,
    id_laboratorio INTEGER,
    num_planta SMALLINT,
    FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado),
    FOREIGN KEY (id_especialidad) REFERENCES especialidad (id_especialidad),
    FOREIGN KEY (id_laboratorio, num_planta) REFERENCES laboratorio (id_laboratorio, num_planta)
);

CREATE TABLE IF NOT EXISTS enfermero (
    id_empleado INTEGER PRIMARY KEY,
    estudio TEXT,
    experiencia_previa TEXT,
    id_especialidad INTEGER NOT NULL,
    num_planta SMALLINT,
    FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado),
    FOREIGN KEY (id_especialidad) REFERENCES especialidad (id_especialidad),
    FOREIGN KEY (num_planta) REFERENCES planta (núm_planta),
    FOREIGN KEY (id_empleado) REFERENCES médico (id_empleado)
);

## HASTA AQUÍ PERFE

CREATE TABLE IF NOT EXISTS patologia (
    id_patologia INTEGER PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
);

CREATE TABLE IF NOT EXISTS diagnostico (
    id_diagnostico SERIAL PRIMARY KEY,
    id_patologia INTEGER NOT NULL,
    descripción TEXT NOT NULL,
    FOREIGN KEY (id_patologia) REFERENCES patologia (id_patologia)
);

CREATE TABLE IF NOT EXISTS prueba (
    id_prueba SERIAL PRIMARY KEY,
    id_laboratorio INTEGER NOT NULL,
    num_planta SMALLINT,
    id_diagnostico INTEGER NOT NULL,
    FOREIGN KEY (id_laboratorio, num_planta) REFERENCES laboratorio(id_laboratorio,num_planta),
    FOREIGN KEY (id_diagnostico) REFERENCES diagnostico(id_diagnostico)
);

CREATE TABLE IF NOT EXISTS receta (
    id_receta SERIAL PRIMARY KEY,
    id_diagnostico INTEGER,
    id_inv_medicamento INTEGER,
    fecha_hora TIMESTAMP,
    dosis NUMERIC(6,2),
    FOREIGN KEY (id_diagnostico) REFERENCES diagnostico (id_diagnostico),
    FOREIGN KEY (id_inv_medicamento) REFERENCES inv_medicamento (id_inv_medicamento)
);

CREATE TABLE IF NOT EXISTS almacen (
    num_almacen SERIAL,
    num_planta  SMALLINT NOT NULL,
    FOREIGN KEY (num_planta) REFERENCES planta(num_planta),
    PRIMARY KEY (num_almacen, num_planta)
);

CREATE TABLE IF NOT EXISTS  material_general (
    id_material_general SERIAL PRIMARY KEY,
    nombre VARCHAR(30) UNIQUE NOT NULL
)

CREATE TABLE IF NOT EXISTS inv_material_general (
    id_inv_material_general SERIAL PRIMARY KEY,
    num_almacen INTEGER NOT NULL,
    num_planta SMALLINT,
    id_material_general INTEGER NOT NULL,
    FOREIGN KEY (num_almacen, num_planta) REFERENCES almacen(num_almacen, num_planta),
    FOREIGN KEY (id_material_general) REFERENCES material_general(id_material_general)
);

CREATE TABLE IF NOT EXISTS medicamento (
    id_medicamento INTEGER PRIMARY KEY,
    nombre_medicamento VARCHAR(30)
)

CREATE TABLE IF NOT EXISTS inv_medicamento (
    id_inv_medicamento SERIAL PRIMARY KEY,
    num_almacen INTEGER,
    num_planta SMALLINT,
    id_farmaceutico INTEGER,
    id_medicamento INTEGER,
    FOREIGN KEY (num_almacen, num_planta) REFERENCES almacen(num_almacen, num_planta),
    FOREIGN KEY (id_farmaceutico) REFERENCES farmaceutico(id_empleado),
    FOREIGN KEY (id_medicamento) REFERENCES medicamento(id_medicamento)
);

CREATE TABLE IF NOT EXISTS quirofano (
    num_quirofano SERIAL,
    num_planta INTEGER NOT NULL,
    FOREIGN KEY (num_planta) REFERENCES planta(num_planta),
    PRIMARY KEY (num_quirofano, num_planta)
);

CREATE TABLE IF NOT EXISTS material_quirofano (
    id_material_quirófano SERIAL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS inv_material_quirofano (
    id_inv_material_quirofano SERIAL PRIMARY KEY,
    num_almacen INTEGER,
    num_planta SMALLINT,
    num_quirofano INTEGER,
    id_material_quirofano INTEGER,
    FOREIGN KEY (num_almacen, num_planta) REFERENCES almacen(num_almacen, num_planta),
    FOREIGN KEY (num_quirofano) REFERENCES quirofano(num_quirofano),
    FOREIGN KEY (id_material_quirofano) REFERENCES material_quirofano(id_material_quirofano)
);

CREATE TABLE IF NOT EXISTS visita (
    id_visita SERIAL PRIMARY KEY,
    id_médico INTEGER,
    tarjeta_sanitaria VARCHAR(14),
    id_diagnostico INTEGER,
    id_triaje INTEGER,
    fecha_hora DATE NOT NULL,
    motivo_visita TEXT NOT NULL,
    FOREIGN KEY (id_medico) REFERENCES médico(id_empleado),
    FOREIGN KEY (tarjeta_sanitaria) REFERENCES paciente(tarjeta_sanitaria),
    FOREIGN KEY (id_diagnostico) REFERENCES diagnostico(id_diagnostico),
    FOREIGN KEY (id_triaje) REFERENCES triaje(id_triaje)
);

CREATE TABLE IF NOT EXISTS sala_urgencia (
    id_sala_urgencia SERIAL PRIMARY KEY,
    num_planta SMALLINT,
    FOREIGN KEY (num_planta) REFERENCES planta(num_planta)
);

CREATE TABLE IF NOT EXISTS triaje (
    num_sala_triaje SERIAL PRIMARY KEY,
    id_sala_urgencia INTEGER NOT NULL,
    motivo_visita TEXT,
    FOREIGN KEY (id_sala_urgencia) REFERENCES sala_urgencia(id_sala_urgencia)
);

CREATE TABLE IF NOT EXISTS habitacion (
    num_habitacion SERIAL PRIMARY KEY,
    num_planta SMALLINT NOT NULL,
    total_camas INTEGER NOT NULL,
    FOREIGN KEY (num_planta) REFERENCES planta(num_planta)
);

CREATE TABLE IF NOT EXISTS consulta (
    id_consulta SERIAL PRIMARY KEY,
    num_planta SMALLINT NOT NULL,
    tipo VARCHAR(15),
    FOREIGN KEY (num_planta) REFERENCES planta(num_planta)
);

CREATE TABLE IF NOT EXISTS reserva_quirofano (
    id_reserva SERIAL PRIMARY KEY,
    num_quirofano INTEGER NOT NULL,
    num_planta INTEGER NOT NULL,
    id_medico INTEGER NOT NULL,
    tarjeta_sanitaria CHAR(14) NOT NULL,
    id_administrativo INTEGER NOT NULL,
    FOREIGN KEY (num_quirofano) REFERENCES quirofano(num_quirofano),
    FOREIGN KEY(num_planta) REFERENCES planta(num_planta),
    FOREIGN KEY (id_medico) REFERENCES medico(id_empleado),
    FOREIGN KEY (tarjeta_sanitaria) REFERENCES paciente(tarjeta_sanitaria),
    FOREIGN KEY (id_administrativo) REFERENCES administrativo(id_empleado)
);