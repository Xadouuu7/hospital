CREATE TABLE IF NOT EXISTS especialidad (
    id_especialidad SERIAL PRIMARY KEY,
    nombre VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS ciudad (
    id_ciudad SERIAL PRIMARY KEY,
    codigo_postal CHAR(5) NOT NULL,
    nombre VARCHAR(30) UNIQUE NOT NULL 
);

CREATE TABLE IF NOT EXISTS planta (
    num_planta SMALLINT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS quirofano (
    num_quirofano SERIAL,
    num_planta INTEGER NOT NULL,
    FOREIGN KEY (num_planta) REFERENCES planta(num_planta),
    PRIMARY KEY (num_quirofano, num_planta)
);

CREATE TABLE IF NOT EXISTS habitacion (
    num_habitacion SERIAL,
    num_planta SMALLINT NOT NULL,
	PRIMARY KEY (num_habitacion, num_planta),
    total_camas INTEGER NOT NULL,
    FOREIGN KEY (num_planta) REFERENCES planta(num_planta)
);

CREATE TABLE IF NOT EXISTS consulta (
    id_consulta SERIAL,
    num_planta SMALLINT NOT NULL,
    tipo VARCHAR(20),
    PRIMARY KEY (id_consulta,num_planta),
    FOREIGN KEY (num_planta) REFERENCES planta(num_planta)
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

CREATE TABLE IF NOT EXISTS material_quirofano (
    id_material_quirofano SERIAL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS almacen (
    num_almacen SERIAL,
    num_planta SMALLINT NOT NULL,
    FOREIGN KEY (num_planta) REFERENCES planta(num_planta),
    PRIMARY KEY (num_almacen, num_planta)
);

CREATE TABLE IF NOT EXISTS inv_material_quirofano (
    id_inv_material_quirofano SERIAL PRIMARY KEY,
    num_almacen INTEGER,
    num_planta_almacen SMALLINT,
    num_quirofano INTEGER,
    num_planta_quirofano SMALLINT,
    id_material_quirofano INTEGER NOT NULL,
    FOREIGN KEY (num_almacen, num_planta_almacen) REFERENCES almacen(num_almacen, num_planta),
    FOREIGN KEY (num_quirofano, num_planta_quirofano) REFERENCES quirofano(num_quirofano, num_planta),
    FOREIGN KEY (id_material_quirofano) REFERENCES material_quirofano(id_material_quirofano)
);

CREATE TABLE IF NOT EXISTS material_general (
    id_material_general SERIAL PRIMARY KEY,
    nombre VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS inv_material_general (
    id_inv_material_general SERIAL PRIMARY KEY,
    num_almacen INTEGER NOT NULL,
    num_planta SMALLINT,
    id_material_general INTEGER NOT NULL,
    FOREIGN KEY (num_almacen, num_planta) REFERENCES almacen(num_almacen, num_planta),
    FOREIGN KEY (id_material_general) REFERENCES material_general(id_material_general)
);

CREATE TABLE IF NOT EXISTS direccion (
    id_direccion SERIAL PRIMARY KEY,
    direccion VARCHAR(70) NOT NULL,
    numero VARCHAR(5) NOT NULL,
    piso VARCHAR(7),
    puerta CHAR(1),
    id_ciudad INTEGER NOT NULL,
    FOREIGN KEY (id_ciudad) REFERENCES ciudad (id_ciudad)
);

CREATE TABLE IF NOT EXISTS persona (
    dni_nie CHAR(9) PRIMARY KEY CHECK (dni_nie ~ '^[0-9]{8}[TRWAGMYFPDXBNJZSQVHLCKE]$' OR dni_nie ~ '^[XYZ][0-9]{7}[TRWAGMYFPDXBNJZSQVHLCKE]$'),
    nombre VARCHAR(30) NOT NULL CHECK (INITCAP(nombre) = nombre),
    apellido1 VARCHAR(30) NOT NULL CHECK (INITCAP(apellido1) = apellido1),
    apellido2 VARCHAR(30) CHECK (INITCAP(apellido2) = apellido2),
    fecha_nacimiento DATE NOT NULL,
    sexo CHAR(1) CHECK (sexo IN ('H','M')),
    teléfono CHAR(9) NOT NULL,
    correo_electrónico VARCHAR(40) CHECK (correo_electrónico ~ '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'),
    id_direccion INTEGER NOT NULL,
    FOREIGN KEY (id_direccion) REFERENCES direccion (id_direccion)
);

CREATE TABLE IF NOT EXISTS paciente (
    tarjeta_sanitaria CHAR(14) PRIMARY KEY CHECK (LENGTH(tarjeta_sanitaria) = 14),
    altura NUMERIC(3) NOT NULL,
    peso NUMERIC NOT NULL,
    grupo_sanguíneo VARCHAR(2) CHECK (grupo_sanguíneo IN ('A','B','AB','0')) NOT NULL,
    rh CHAR(1) CHECK (rh IN ('+','-')) NOT NULL,
    dni_nie CHAR(9) NOT NULL,
    FOREIGN KEY (dni_nie) REFERENCES persona (dni_nie)
);

CREATE TABLE IF NOT EXISTS empleado (
    id_empleado SERIAL PRIMARY KEY,
    horario_trabajo NUMRANGE NOT NULL,
    dias_vacaciones INTEGER NOT NULL,
    salario NUMERIC(7,2) NOT NULL,
    num_ss CHAR(12) CHECK (LENGTH(num_ss) = 12),
    dni_nie CHAR(9) NOT NULL,
    FOREIGN KEY (dni_nie) REFERENCES persona (dni_nie)
);

CREATE TABLE IF NOT EXISTS medico (
    id_empleado INTEGER PRIMARY KEY,
    estudio TEXT,
    experiencia_previa TEXT,
    id_especialidad INTEGER NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad)
);

CREATE TABLE IF NOT EXISTS cientifico (
    id_empleado INTEGER PRIMARY KEY,
    estudio TEXT,
    experiencia_previa TEXT,
    id_especialidad INTEGER NOT NULL,
    id_laboratorio INTEGER,
    num_planta SMALLINT,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad),
    FOREIGN KEY (id_laboratorio, num_planta) REFERENCES laboratorio(id_laboratorio, num_planta)
);

CREATE TABLE IF NOT EXISTS enfermero (
    id_empleado INTEGER PRIMARY KEY,
    estudio TEXT,
    experiencia_previa TEXT,
    id_especialidad INTEGER NOT NULL,
    num_planta SMALLINT,
    id_medico INTEGER,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_especialidad) REFERENCES especialidad (id_especialidad),
    FOREIGN KEY (num_planta) REFERENCES planta(num_planta),
    FOREIGN KEY (id_medico) REFERENCES medico(id_empleado)
);

CREATE TABLE IF NOT EXISTS farmaceutico (
    id_empleado INTEGER PRIMARY KEY,
    estudio TEXT,
    experiencia_previa TEXT,
    id_especialidad INTEGER NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad)
);

CREATE TABLE IF NOT EXISTS administrativo (
    id_empleado INTEGER PRIMARY KEY,
    estudio TEXT,
    experiencia_previa TEXT,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

CREATE TABLE IF NOT EXISTS recursos_humanos (
    id_empleado INTEGER PRIMARY KEY,
    estudio TEXT,
    experiencia_previa TEXT,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

CREATE TABLE IF NOT EXISTS reserva_quirofano (
    id_reserva SERIAL PRIMARY KEY,
    num_quirofano INTEGER NOT NULL,
    num_planta INTEGER NOT NULL,
    id_medico INTEGER NOT NULL,
    tarjeta_sanitaria CHAR(14) NOT NULL,
    id_administrativo INTEGER NOT NULL,
    fecha_hora_entrada TIMESTAMP NOT NULL,
    FOREIGN KEY (num_quirofano, num_planta) REFERENCES quirofano(num_quirofano, num_planta),
    FOREIGN KEY (id_medico) REFERENCES medico(id_empleado),
    FOREIGN KEY (tarjeta_sanitaria) REFERENCES paciente(tarjeta_sanitaria),
    FOREIGN KEY (id_administrativo) REFERENCES administrativo(id_empleado)
);

CREATE TABLE IF NOT EXISTS varios (
    id_empleado INTEGER PRIMARY KEY,
    trabajo VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

CREATE TABLE IF NOT EXISTS patologia (
    id_patologia VARCHAR(20) PRIMARY KEY,
    nombre TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS diagnostico (
    id_diagnostico SERIAL PRIMARY KEY,
    id_patologia VARCHAR(20) NOT NULL,
    descripcion TEXT NOT NULL,
    FOREIGN KEY (id_patologia) REFERENCES patologia(id_patologia)
);

CREATE TABLE IF NOT EXISTS prueba (
    id_prueba SERIAL PRIMARY KEY,
    id_laboratorio INTEGER NOT NULL,
    num_planta SMALLINT NOT NULL,
    id_diagnostico INTEGER NOT NULL,
    tipo VARCHAR(40),
    FOREIGN KEY (id_laboratorio, num_planta) REFERENCES laboratorio(id_laboratorio,num_planta),
    FOREIGN KEY (id_diagnostico) REFERENCES diagnostico(id_diagnostico)
);

CREATE TABLE IF NOT EXISTS medicamento (
    id_medicamento INTEGER PRIMARY KEY,
    nombre_medicamento VARCHAR(30)
);

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

CREATE TABLE IF NOT EXISTS receta (
    id_receta SERIAL PRIMARY KEY,
    id_diagnostico INTEGER,
    id_inv_medicamento INTEGER,
    fecha_hora TIMESTAMP,
    dosis VARCHAR(8),
    FOREIGN KEY (id_diagnostico) REFERENCES diagnostico(id_diagnostico),
    FOREIGN KEY (id_inv_medicamento) REFERENCES inv_medicamento(id_inv_medicamento)
);

CREATE TABLE IF NOT EXISTS visita (
    id_visita SERIAL PRIMARY KEY,
    id_medico INTEGER,
    tarjeta_sanitaria VARCHAR(14),
    id_diagnostico INTEGER,
    id_consulta INTEGER,
	num_planta SMALLINT,
    fecha_hora TIMESTAMP NOT NULL DEFAULT NOW(),
    motivo_visita TEXT NOT NULL,
    FOREIGN KEY (id_medico) REFERENCES medico(id_empleado),
    FOREIGN KEY (tarjeta_sanitaria) REFERENCES paciente(tarjeta_sanitaria),
    FOREIGN KEY (id_diagnostico) REFERENCES diagnostico(id_diagnostico),
    FOREIGN KEY (id_consulta,num_planta) REFERENCES consulta(id_consulta,num_planta)
);

CREATE TABLE IF NOT EXISTS reserva_habitacion (
    id_reserva  SERIAL PRIMARY KEY,
    tarjeta_sanitaria CHAR(14),
    num_habitacion INTEGER,
    num_planta INTEGER,
    id_administrativo INTEGER,
    fecha_entrada_salida TSRANGE,
    FOREIGN KEY (tarjeta_sanitaria) REFERENCES paciente(tarjeta_sanitaria),
    FOREIGN KEY (num_habitacion, num_planta) REFERENCES habitacion(num_habitacion, num_planta),
    FOREIGN KEY (id_administrativo) REFERENCES administrativo(id_empleado)
);

CREATE TABLE IF NOT EXISTS agenda (
    id_agenda SERIAL PRIMARY KEY,
    id_medico  INTEGER,
    fecha DATE,
    hora TIME,
    FOREIGN KEY (id_medico) REFERENCES medico(id_empleado)
);

CREATE TABLE IF NOT EXISTS reserva_visita (
    id_reserva_visita SERIAL PRIMARY KEY,
    id_medico INTEGER,
    tarjeta_sanitaria VARCHAR(14),
    fecha DATE,
    hora TIME,
    FOREIGN KEY (id_medico) REFERENCES medico(id_empleado),
    FOREIGN KEY (tarjeta_sanitaria) REFERENCES paciente(tarjeta_sanitaria)
);

CREATE TABLE IF NOT EXISTS informatico (
    id_empleado INTEGER PRIMARY KEY,
    estudio TEXT,
    experiencia_previa TEXT,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

CREATE TABLE IF NOT EXISTS auditoria_pacientes (
    usuario VARCHAR(30),
    fecha_hora TIMESTAMP,
    tarjeta_sanitaria VARCHAR(14),
    accion VARCHAR(10),
    PRIMARY KEY (usuario, fecha_hora),
    FOREIGN KEY (tarjeta_sanitaria) REFERENCES paciente(tarjeta_sanitaria)
);