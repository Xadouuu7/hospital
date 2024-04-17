--- MEDICO
CREATE ROLE medico;
GRANT CONNECT, USAGE ON DATABASE hospital TO medico;
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
GRANT CONNECT, USAGE ON DATABASE hospital TO administrativo;
GRANT SELECT ON view_visita TO administrativo;
GRANT SELECT ON view_horariomedicos TO administrativo;
GRANT SELECT ON view_reserva_quirofano TO administrativo;
GRANT SELECT ON view_reserva_habitacion TO administrativo;


