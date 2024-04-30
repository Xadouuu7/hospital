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
GRANT SELECT ON medicamento TO medico;   
GRANT SELECT ON patologia TO medico;  
GRANT SELECT ON view_contador_enfermeros TO medico   
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
GRANT SELECT ON view_contador_enfermeros TO administrativo;
GRANT SELECT ON ciudad TO administrativo;
GRANT SELECT, INSERT ON paciente TO administrativo;
GRANT SELECT, INSERT ON persona TO administrativo;
GRANT SELECT, INSERT ON direccion TO administrativo;
GRANT INSERT ON reserva_visita TO administrativo;
GRANT INSERT ON reserva_quirofano TO administrativo;
GRANT INSERT ON reserva_habitacion TO administrativo;
GRANT SELECT ON view_inv_quirofano TO administrativo;

--- CIENTÍFICO
CREATE ROLE cientifico;
GRANT CONNECT ON DATABASE hospital TO cientifico;
GRANT USAGE ON SCHEMA public TO cientifico;
GRANT SELECT ON view_prueba TO cientifico;
GRANT SELECT ON view_diagnostico TO cientifico;
GRANT SELECT, INSERT ON inv_laboratorio TO cientifico;
GRANT INSERT ON prueba TO cientifico; 

--- ENFERMERO
CREATE ROLE enfermero;
GRANT CONNECT ON DATABASE hospital TO enfermero;
GRANT USAGE ON SCHEMA public TO enfermero;
GRANT SELECT ON view_receta TO enfermero;
GRANT SELECT, INSERT ON material_general TO enfermero;
GRANT SELECT, INSERT ON inv_material_general TO enfermero;

--- FARMACÉUTICO
CREATE ROLE farmaceutico;
GRANT CONNECT ON DATABASE hospital TO farmaceutico;
GRANT USAGE ON SCHEMA public TO farmaceutico;
GRANT SELECT ON view_receta TO farmaceutico;
GRANT SELECT, INSERT ON medicamento TO farmaceutico;
GRANT SELECT, INSERT ON inv_medicamento TO farmaceutico;

--- RH
CREATE ROLE recursos_humanos CREATEROLE;
GRANT CONNECT ON DATABASE hospital TO recursos_humanos;
GRANT USAGE ON SCHEMA public TO recursos_humanos;
GRANT SELECT, INSERT ON empleado TO recursos_humanos
GRANT SELECT, INSERT ON medico TO recursos_humanos;
GRANT SELECT, INSERT ON enfermero TO recursos_humanos;
GRANT SELECT, INSERT ON farmaceutico TO recursos_humanos;
GRANT SELECT, INSERT ON cientifico TO recursos_humanos;
GRANT SELECT, INSERT ON administrativo TO recursos_humanos;
GRANT SELECT, INSERT ON informatico TO recursos_humanos;
GRANT SELECT ON especialidad TO recursos_humanos;
GRANT SELECT, INSERT ON persona TO recursos_humanos;
GRANT SELECT ON view_contador_planta TO recursos_humanos;
GRANT SELECT ON view_contador_planta TO recursos_humanos;
GRANT SELECT ON view_contador_empleados TO recursos_humanos;
GRANT SELECT ON view_contador_visitas TO recursos_humanos;
GRANT SELECT ON view_ranking_medicos TO recursos_humanos;
GRANT SELECT ON view_malalties_comuns TO recursos_humanos;

--- INFORMATICO
CREATE ROLE informatico;
GRANT ALL PRIVILEGES ON DATABASE hospital TO informatico;

--- PACIENTE
CREATE ROLE paciente;
GRANT CONNECT ON DATABASE hospital TO paciente;
GRANT USAGE ON SCHEMA public TO paciente;
GRANT SELECT ON view_visita TO paciente;