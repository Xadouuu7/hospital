--- MÉDICO
CREATE ROLE medico;
GRANT CONNECT ON DATABASE hospital TO medico;
GRANT USAGE SCHEMA public TO medico;
GRANT SELECT ON view_visita TO medico;
GRANT SELECT ON view_diagnostico TO medico;
GRANT SELECT ON view_receta TO medico;
GRANT SELECT ON view_medicamento TO medico;
GRANT SELECT ON view_patologia TO medico;
GRANT SELECT ON view_reserva_habitacion TO medico;
GRANT SELECT ON view_reserva_quirofano TO medico;
GRANT INSERT ON visita TO medico;
GRANT INSERT ON diagnostico TO medico;
GRANT INSERT ON receta TO medico;

--- ADMINISTRATIVO
CREATE ROLE administrativo;
GRANT CONNECT ON DATABASE hospital TO administrativo;
GRANT USAGE SCHEMA public TO administrativo;
GRANT SELECT ON view_visita TO administrativo;
GRANT SELECT ON view_horariomedico TO administrativo;
GRANT SELECT ON view_reserva_quirofano TO administrativo;
GRANT SELECT ON view_reserva_habitacion TO administrativo;
GRANT INSERT ON visita TO administrativo;
GRANT INSERT ON reserva_quirofano TO administrativo;
GRANT INSERT ON reserva_habitacion TO administrativo;

--- CIENTÍFICO
CREATE ROLE científico;
GRANT CONNECT ON DATABASE hospital TO cientifico;
GRANT USAGE SCHEMA public TO cientifico;
GRANT SELECT ON view_prueba TO cientifico;
GRANT SELECT ON view_diagnostico TO cientifico;
GRANT SELECT ON view_inv_laboratorio TO cientifico;
GRANT INSERT ON prueba TO cientifico;
GRANT INSERT ON inv_laboratorio TO cientifico;

--- ENFERMERO
CREATE ROLE enfermero;
GRANT CONNECT ON DATABASE hospital TO enfermero;
GRANT USAGE SCHEMA public TO enfermero;
GRANT SELECT ON view_receta TO enfermero;
GRANT SELECT ON view_inv_general TO enfermero;
GRANT SELECT ON view_material_general TO enfermero;
GRANT SELECT ON view_triaje TO enfermero;
GRANT INSERT ON inv_material_general TO enfermero;
GRANT INSERT ON triaje TO enfermero;

--- FARMACÉUTICO
CREATE ROLE farmaceutico;
GRANT CONNECT ON DATABASE hospital TO farmaceutico;
GRANT USAGE SCHEMA public TO farmaceutico;
GRANT SELECT ON view_receta TO farmaceutico;
GRANT SELECT ON view_medicamento TO farmaceutico;
GRANT SELECT ON view_inv_medicamento TO farmaceutico;
GRANT INSERT ON inv_medicamento TO farmaceutico;

--- RH
CREATE ROLE recursos_humanos;
GRANT CONNECT ON DATABASE hospital TO recursos_humanos;
GRANT USAGE SCHEMA public TO recursos_humanos;
GRANT SELECT ON view_empleados TO recursos_humanos;
GRANT INSERT ON empleados TO recursos_humanos;
