--- MÉDICO
CREATE ROLE medico;
GRANT CONNECT ON DATABASE hospital TO medico;
GRANT USAGE ON SCHEMA public TO medico;
GRANT SELECT ON view_visita TO medico;      
GRANT SELECT ON view_diagnostico TO medico;
GRANT SELECT ON view_receta TO medico;
GRANT SELECT ON view_reserva_habitacion TO medico;
GRANT SELECT ON view_reserva_quirofano TO medico;
GRANT SELECT ON view_prueba TO medico;
GRANT SELECT ON medicamento TO medico;   -- Aquí he puesto que sea la tabla en sí porque no hay nada más importante como para crear una vista con inner joins.
GRANT SELECT ON patologia TO medico;     -- Lo mismo que el anterior
GRANT INSERT ON visita TO medico;
GRANT INSERT ON diagnostico TO medico;
GRANT INSERT ON prueba TO medico;
GRANT INSERT ON receta TO medico;

--- ADMINISTRATIVO
CREATE ROLE administrativo;
GRANT CONNECT ON DATABASE hospital TO administrativo;
GRANT USAGE ON SCHEMA public TO administrativo;
GRANT SELECT ON view_visita TO administrativo;
GRANT SELECT ON view_reserva_quirofano TO administrativo;
GRANT SELECT ON view_reserva_habitacion TO administrativo;
GRANT SELECT ON view_agenda TO administrativo;
GRANT INSERT ON reserva_visita TO administrativo;
GRANT INSERT ON visita TO administrativo; -- Aquí hay que cambiar, tendríamos que darle acceso a la nueva tabla de "reserva de visitas"
GRANT INSERT ON reserva_quirofano TO administrativo;
GRANT INSERT ON reserva_habitacion TO administrativo;

--- CIENTÍFICO
CREATE ROLE científico;
GRANT CONNECT ON DATABASE hospital TO cientifico;
GRANT USAGE ON SCHEMA public TO cientifico;
GRANT SELECT ON view_prueba TO cientifico;
GRANT SELECT ON view_diagnostico TO cientifico;
GRANT SELECT, INSERT ON inv_laboratorio TO cientifico;
GRANT INSERT ON prueba TO cientifico; -- Esto la idea es que pueda meter cosas si ponemos algo como "resultado", pero sin eso no tiene mucho sentido TT

--- ENFERMERO
CREATE ROLE enfermero;
GRANT CONNECT ON DATABASE hospital TO enfermero;
GRANT USAGE ON SCHEMA public TO enfermero;
GRANT SELECT ON view_receta TO enfermero;
GRANT SELECT, INSERT ON material_general TO enfermero;
GRANT SELECT, INSERT ON triaje TO enfermero;
GRANT SELECT, INSERT ON inv_material_general TO enfermero;

--- FARMACÉUTICO
CREATE ROLE farmaceutico;
GRANT CONNECT ON DATABASE hospital TO farmaceutico;
GRANT USAGE ON SCHEMA public TO farmaceutico;
GRANT SELECT ON view_receta TO farmaceutico;
GRANT SELECT, INSERT ON medicamento TO farmaceutico;
GRANT SELECT, INSERT ON inv_medicamento TO farmaceutico;

--- RH
CREATE ROLE recursos_humanos;
GRANT CONNECT ON DATABASE hospital TO recursos_humanos;
GRANT USAGE ON SCHEMA public TO recursos_humanos;
GRANT SELECT, INSERT ON empleados TO recursos_humanos;

--- INFORMATICO
CREATE ROLE informatico;
GRANT ALL PRIVILEGES ON DATABASE hospital TO informatico;