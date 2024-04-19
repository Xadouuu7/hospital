CREATE VIEW view_visita AS 
    SELECT
        CONCAT(pepa.nombre, pepa.apellido1, pepa.apellido2),
        vi.fecha_hora, vi.motivo_visita,
        CONCAT(peme.nombre, peme.apellido1)
    FROM visita vi 
    INNER JOIN paciente pa ON vi.id_paciente = pa.tarjeta_sanitaria
    INNER JOIN medico me ON vi.id_medico = me.id_empleado
    INNER JOIN persona pepa ON pepa.dni_nie = pa.dni_nie
    INNER JOIN persona peme ON peme.dni_nie = me.dni_nie;

CREATE VIEW view_diagnostico AS 
    SELECT
        pepa.nombre,
        pepa.apellido1,
        pepa.apellido2,
        diag.descripcion,
        pato.nombre
    FROM diagnostico diag
    INNER JOIN patologia pato ON pato.id_patologia = diag.id_patologia
    INNER JOIN persona pepa ON pepa.dni_nie = pa.dnie_nie;

CREATE VIEW view_receta AS 
    SELECT
        CONCAT(pepa.nombre, pepa.apellido1, pepa.apellido2),
        medi.nombre,
        rece.fecha_hora,
        rece.dosis,
        CONCAT(peme.nombre, peme.apellido)
    FROM receta rece
    INNER JOIN medicamento medi ON medi.id_medicamento = rece.id_medicamento
    INNER JOIN diagnostico diag ON diagnostico.id_diagnostico = rece.diagnostico 
    INNER JOIN paciente pa ON rece.id_paciente = pa.tarjeta_sanitaria
    INNER JOIN medico me ON rece.id_medico = me.id_empleado
    INNER JOIN persona pepa ON pepa.dni_nie = pa.dni_nie
    INNER JOIN persona peme ON peme.dni_nie = me.dni_nie;

CREATE VIEW view_reserva_habitacion AS 
    SELECT
        CONCAT(pepa.nombre, pepa.apellido1, pepa.apellido2),
        reservhab.num_habitacion,
        reservhab.num_planta,
        rerservhab.fecha_entrada_salida
    FROM reserva_habitacion reservhab
    INNER JOIN paciente pa ON reservhab.id_paciente = pa.tarjeta_sanitaria
    INNER JOIN persona pepa ON pepa.dni_nie = pa.dni_nie;

CREATE VIEW view_reserva_quirofano AS 
    SELECT 
        CONCAT(pepa.nombre, pepa.apellido1, pepa.apellido2), 
        reservquiro.num_quirofano, 
        reservquiro.num_planta, 
        CONCAT(peme.nombre, peme.apellido1), 
        reservquiro.fecha_entrada 
    FROM reserva_quirofano 
    INNER JOIN medico me ON reservquiro.id_medico = me.id_medico
    INNER JOIN empleado em ON me.id_medico = em.id_medico
    INNER JOIN persona peme ON peme.dni_nie = me.dni_nie
    INNER JOIN paciente pa ON reservquiro.id_paciente = pa.tarjeta_sanitaria
    INNER JOIN persona pepa ON pepa.dni_nie = pa.dni_nie;

CREATE VIEW view_agenda AS
    SELECT 
        CONCAT(peme.nombre, peme.apellido1),
        ag.id_medico,
        ag.fecha,
        ag.fecha
    FROM agenda agaaaa
    INNER JOIN medico me ON ag.id_medico = me.id_medico
    INNER JOIN empleado em ON em.id_empleado = me.id_medico
    INNER JOIN persona peme ON peme.dni_nie = me.dni_nie;

CREATE VIEW view_prueba AS
    SELECT 
        CONCAT(pepa.nombre, pepa.apellido1, pepa.apellido2),
        p.tipo
    FROM prueba p 
    INNER JOIN diagnostico d ON d.id_diagnostico=p.id_diagnostico
    INNER JOIN visita v ON d.id_diagnostico=v.id_diagnostico
    INNER JOIN paciente pa ON reservquiro.id_paciente = pa.tarjeta_sanitaria
    INNER JOIN persona peme ON peme.dni_nie = me.dni_nie;