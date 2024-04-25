CREATE OR REPLACE VIEW view_visita
 AS
 SELECT pa.tarjeta_sanitaria,
    concat(pepa.nombre, ' ', pepa.apellido1, ' ', pepa.apellido2) AS paciente,
    vi.fecha_hora,
    vi.motivo_visita,
    concat(peme.nombre, ' ', peme.apellido1) AS medico,
    em.num_ss
   FROM visita vi
     JOIN paciente pa ON vi.tarjeta_sanitaria::bpchar = pa.tarjeta_sanitaria
     JOIN medico me ON vi.id_medico = me.id_empleado
     JOIN persona pepa ON pepa.dni_nie = pa.dni_nie
     JOIN empleado em ON em.id_empleado = me.id_empleado
     JOIN persona peme ON peme.dni_nie = em.dni_nie;
	
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

CREATE OR REPLACE VIEW public.view_receta AS
    SELECT paci.tarjeta_sanitaria,
        CONCAT(pepa.nombre, ' ', pepa.apellido1, ' ', pepa.apellido2) AS paciente,
        medic.nombre_medicamento AS medicamento,
        diag.descripcion,
        rece.fecha_hora,
        rece.dosis,
        empl.num_ss,
        CONCAT(peme.nombre, ' ', peme.apellido1) AS medico
    FROM receta rece
    INNER JOIN inv_medicamento inv_medi ON inv_medi.id_inv_medicamento = rece.id_inv_medicamento
    INNER JOIN medicamento medic ON medic.id_medicamento = inv_medi.id_medicamento
    INNER JOIN diagnostico diag ON diag.id_diagnostico = rece.id_diagnostico
    INNER JOIN visita visi ON visi.id_diagnostico = diag.id_diagnostico
    INNER JOIN paciente paci ON paci.tarjeta_sanitaria = visi.tarjeta_sanitaria::bpchar
    INNER JOIN persona pepa ON pepa.dni_nie = paci.dni_nie
    INNER JOIN medico medi ON medi.id_empleado = visi.id_medico
     JOIN empleado empl ON empl.id_empleado = medi.id_empleado
     JOIN persona peme ON peme.dni_nie = empl.dni_nie;
	
CREATE OR REPLACE VIEW public.view_reserva_habitacion AS
    SELECT
        CONCAT(pepa.nombre, ' ', pepa.apellido1, ' ', pepa.apellido2) AS Paciente,
        reservhab.num_habitacion,
        reservhab.num_planta,
        reservhab.fecha_entrada_salida
    FROM reserva_habitacion reservhab
    INNER JOIN paciente pa ON reservhab.tarjeta_sanitaria = pa.tarjeta_sanitaria
    INNER JOIN persona pepa ON pepa.dni_nie = pa.dni_nie;

CREATE OR REPLACE VIEW view_reserva_quirofano AS
    SELECT
        CONCAT(pepa.nombre, ' ', pepa.apellido1, ' ', pepa.apellido2) AS Paciente,
        reservquiro.num_quirofano,
        reservquiro.num_planta,
        CONCAT(peme.nombre, ' ', peme.apellido1) AS Medico,
        ARRAY_AGG (perenf.nombre || ' ' || perenf.apellido1 || ' ' || perenf.apellido2) AS Enfermero,
        empl.num_ss,
        reservquiro.fecha_hora_entrada,
	    CONCAT(peradm.nombre, ' ', peradm.apellido1, ' ', peradm.apellido2) AS Administrativo
    FROM reserva_quirofano reservquiro
    INNER JOIN medico medi ON reservquiro.id_medico = medi.id_empleado
    INNER JOIN empleado empl ON medi.id_empleado = empl.id_empleado
    INNER JOIN persona peme ON peme.dni_nie = empl.dni_nie
    INNER JOIN paciente paci ON reservquiro.tarjeta_sanitaria = paci.tarjeta_sanitaria
    INNER JOIN persona pepa ON pepa.dni_nie = paci.dni_nie
	INNER JOIN empleado empadm ON empadm.id_empleado = reservquiro.id_administrativo
	INNER JOIN persona peradm ON empadm.dni_nie = peradm.dni_nie
    INNER JOIN enfermero enfer ON enfer.id_medico = medi.id_empleado
    INNER JOIN empleado empenf ON empenf.id_empleado=enfer.id_empleado
    INNER JOIN persona perenf ON empenf.dni_nie = perenf.dni_nie
	GROUP BY
        CONCAT(pepa.nombre, ' ', pepa.apellido1, ' ', pepa.apellido2),
        reservquiro.num_quirofano, reservquiro.num_planta,
        CONCAT(peme.nombre, ' ', peme.apellido1), 
        empl.num_ss,
        reservquiro.fecha_hora_entrada,
        CONCAT(peradm.nombre, ' ', peradm.apellido1, ' ', peradm.apellido2);

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
    
CREATE OR REPLACE VIEW view_rol AS
 SELECT r.rolname AS usuario,
    ARRAY( SELECT b.rolname
           FROM pg_auth_members m
             JOIN pg_roles b ON m.roleid = b.oid
          WHERE m.member = r.oid) AS grupos
    FROM pg_roles r
  WHERE r.rolname !~ '^pg_'::text AND r.rolname !~ '^postgres'::text
  ORDER BY r.rolname;

CREATE OR REPLACE VIEW view_inv_quirofano AS
    SELECT
        matqui.nombre AS material,
        invmatqui.num_planta_quirofano AS planta,
        invmatqui.num_quirofano AS quirofano
    FROM inv_material_quirofano invmatqui
    INNER JOIN material_quirofano matqui ON matqui.id_material_quirofano=invmatqui.id_material_quirofano;