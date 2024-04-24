CREATE OR REPLACE VIEW view_visita AS 
    SELECT
        CONCAT(pepa.nombre, ' ', pepa.apellido1, ' ', pepa.apellido2) as "paciente",
        vi.fecha_hora, vi.motivo_visita,
        CONCAT(peme.nombre, ' ', peme.apellido1) as "medico"
    FROM visita vi 
    INNER JOIN paciente pa ON vi.tarjeta_sanitaria = pa.tarjeta_sanitaria
    INNER JOIN medico me ON vi.id_medico = me.id_empleado
    INNER JOIN persona pepa ON pepa.dni_nie = pa.dni_nie
	INNER JOIN empleado em ON em.id_empleado=me.id_empleado
    INNER JOIN persona peme ON peme.dni_nie = em.dni_nie;
	

CREATE OR REPLACE VIEW view_diagnostico AS 
    SELECT
        CONCAT(pers.nombre, ' ', pers.apellido1, ' ',pers.apellido2),
        diag.descripcion,
        pato.nombre AS "patologia"
    FROM diagnostico diag
    INNER JOIN patologia pato ON pato.id_patologia = diag.id_patologia
	INNER JOIN visita visi ON visi.id_diagnostico = diag.id_diagnostico
	INNER JOIN paciente paci ON paci.tarjeta_sanitaria = visi.tarjeta_sanitaria
	INNER JOIN persona pers ON pers.dni_nie = paci.dni_nie;

CREATE OR REPLACE  VIEW view_receta AS 
    SELECT

        CONCAT(pepa.nombre, pepa.apellido1, pepa.apellido2) as "paciente",
        medic.nombre_medicamento as "medicamento",
        rece.fecha_hora,
        rece.dosis,
        CONCAT(peme.nombre, peme.apellido1) as "medico"
    FROM receta rece
    INNER JOIN inv_medicamento inv_medi ON inv_medi.id_inv_medicamento = rece.id_inv_medicamento
	INNER JOIN medicamento medic ON medic.id_medicamento = inv_medi.id_medicamento
    INNER JOIN diagnostico diag ON diag.id_diagnostico = rece.id_diagnostico
	INNER JOIN visita visi ON visi.id_diagnostico = diag.id_diagnostico
	INNER JOIN paciente paci ON paci.tarjeta_sanitaria = visi.tarjeta_sanitaria
	INNER JOIN persona pepa ON pepa.dni_nie = paci.dni_nie
	INNER JOIN medico medi ON medi.id_empleado = visi.id_medico
	INNER JOIN empleado empl ON empl.id_empleado = medi.id_empleado
	INNER JOIN persona  peme ON peme.dni_nie = empl.dni_nie;
	
CREATE OR REPLACE  VIEW view_reserva_habitacion AS 
    SELECT
        CONCAT(pepa.nombre, pepa.apellido1, pepa.apellido2),
        reservhab.num_habitacion,
        reservhab.num_planta,
        reservhab.fecha_entrada_salida
    FROM reserva_habitacion reservhab
    INNER JOIN paciente pa ON reservhab.tarjeta_sanitaria = pa.tarjeta_sanitaria
    INNER JOIN persona pepa ON pepa.dni_nie = pa.dni_nie;

CREATE OR REPLACE  VIEW view_reserva_quirofano AS 
    SELECT 
        CONCAT(pepa.nombre, pepa.apellido1, pepa.apellido2) as "paciente", 
        reservquiro.num_quirofano, 
        reservquiro.num_planta, 
        CONCAT(peme.nombre, peme.apellido1) as "medico", 
        reservquiro.fecha_hora_entrada 
    FROM reserva_quirofano reservquiro
    INNER JOIN medico medi ON reservquiro.id_medico = medi.id_empleado
    INNER JOIN empleado empl ON medi.id_empleado = empl.id_empleado
    INNER JOIN persona peme ON peme.dni_nie = empl.dni_nie
    INNER JOIN paciente paci ON reservquiro.tarjeta_sanitaria = paci.tarjeta_sanitaria
    INNER JOIN persona pepa ON pepa.dni_nie = paci.dni_nie;

CREATE OR REPLACE  VIEW view_agenda AS
    SELECT 
        CONCAT(peme.nombre, peme.apellido1),
        agen.id_medico,
        agen.fecha
    FROM agenda agen
    INNER JOIN medico medi ON agen.id_medico = medi.id_empleado
    INNER JOIN empleado empl ON empl.id_empleado = medi.id_empleado
    INNER JOIN persona peme ON peme.dni_nie = empl.dni_nie;

CREATE OR REPLACE VIEW view_prueba AS
	SELECT
		CONCAT(pe.nombre, pe.apellido1, pe.apellido2) as "paciente",
		p.tipo
		FROM prueba p
	INNER JOIN diagnostico d ON d.id_diagnostico = p.id_diagnostico
	INNER JOIN visita v ON d.id_diagnostico=v.id_diagnostico
	INNER JOIN paciente pa ON v.tarjeta_sanitaria=pa.tarjeta_sanitaria
	INNER JOIN persona pe ON pa.dni_nie=pe.dni_nie;

CREATE OR REPLACE VIEW view_paciente AS
    SELECT 
        CONCAT(pers.nombre, ' ', pers.apellido1, ' ', pers.apellido2) as "Paciente",
        vis.fecha_hora,
        vis.motivo_visita,
        dia.descripcion AS "Diagnostico", 
        pato.nombre,
        rece.dosis,
        medi.nombre_medicamento
        FROM persona pers
    INNER JOIN paciente paci ON pers.dni_nie = paci.dni_nie
    INNER JOIN visita vis ON paci.tarjeta_sanitaria = vis.tarjeta_sanitaria
    INNER JOIN diagnostico dia ON vis.id_diagnostico = dia.id_diagnostico
    INNER JOIN patologia pato ON dia.id_patologia = pato.id_patologia
    INNER JOIN receta rece ON dia.id_diagnostico = rece.id_diagnostico
    INNER JOIN inv_medicamento invmed ON rece.id_inv_medicamento = invmed.id_inv_medicamento
    INNER JOIN medicamento medi ON  invmed.id_medicamento = medi.id_medicamento
    INNER JOIN reserva_quirofano resqui ON paci.tarjeta_sanitaria = resqui.tarjeta_sanitaria
    INNER JOIN reserva_habitacion reshab ON paci.tarjeta_sanitaria = reshab.tarjeta_sanitaria;