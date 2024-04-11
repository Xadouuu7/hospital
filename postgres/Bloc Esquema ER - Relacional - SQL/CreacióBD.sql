CREATE DATABASE IF NOT EXISTS Hospital;

CREATE TABLE IF NOT EXISTS ciudad (
    id_ciudad SERIAL PRIMARY KEY,
    nombre VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS dirección (
    id_dirección SERIAL PRIMARY KEY,
    dirección VARCHAR(30),
    número VARCHAR(5) ,
    piso VARCHAR(7),
    puerta CHAR(1),
    código_postal CHAR(5),
    id_ciudad INTEGER,
    FOREIGN KEY (id_ciudad) REFERENCES ciudad (id_ciudad)
);

CREATE TABLE IF NOT EXISTS persona (
    dni_nie CHAR(9) PRIMARY KEY,
    nombre VARCHAR(30),
    apellido1 VARCHAR(30),
    apellido2 VARCHAR(30),
    fecha_nacimiento DATE,
    género CHAR(1) CHECK (género IN ('H','M','O')),
    teléfono CHAR(9),
    correo_electrónico VARCHAR(40) CHECK (correo_electrónico ~ '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'),
    usuario VARCHAR(20),
    contraseña VARCHAR(30),
    id_dirección INTEGER,
    FOREIGN KEY (id_dirección) REFERENCES dirección (id_dirección)
);

CREATE TABLE IF NOT EXISTS paciente (
    tarjeta_sanitaria CHAR(14) PRIMARY KEY CHECK (LENGTH(tarjeta_sanitaria) = 14),
    altura NUMERIC(4,1),
    peso NUMERIC(5,2),
    grupo_sanguíneo VARCHAR(2) CHECK (grupo_sanguíneo IN ('A','B','AB','0')),
    rh CHAR(1) CHECK (rh IN ('+','-')),
    dni_nie CHAR(9),
    FOREIGN KEY (dni_nie) REFERENCES persona (dni_nie)
);

CREATE TABLE IF NOT EXISTS empleado (
    id_empleado SERIAL PRIMARY KEY,
    horario_trabajo TIMESTAMP,
    dias_vacaciones INTEGER ,
    salario NUMERIC(7,2),
    num_ss CHAR(12) CHECK (LENGTH(num_ss) = 12),
    dni_nie CHAR(9),
    FOREIGN KEY (dni_nie) REFERENCES persona (dni_nie)
);

CREATE TABLE IF NOT EXISTS especialidad (
    id_especialidad SERIAL PRIMARY KEY,
    nombre VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS varios (
    id_empleado INTEGER PRIMARY KEY,
    trabajo VARCHAR(30),
    FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado)
);

CREATE TABLE IF NOT EXISTS farmacéutico (
    id_empleado INTEGER PRIMARY KEY,
    estudio TEXT,
    experiencia_previa TEXT,
    id_especialidad INTEGER,
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
    id_especialidad INTEGER,
    FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado),
    FOREIGN KEY (id_especialidad) REFERENCES especialidad (id_especialidad)
);

CREATE TABLE IF NOT EXISTS científico (
    id_empleado INTEGER PRIMARY KEY,
    estudio TEXT,
    experiencia_previa TEXT,
    id_especialidad INTEGER,
    id_laboratorio INTEGER,
    FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado),
    FOREIGN KEY (id_especialidad) REFERENCES especialidad (id_especialidad),
    FOREIGN KEY (id_laboratorio) REFERENCES laboratorio (id_laboratorio)
);

CREATE TABLE IF NOT EXISTS planta (
    núm_planta SMALLINT PRIMARY KEY,
    nombre VARCHAR(50)
);





