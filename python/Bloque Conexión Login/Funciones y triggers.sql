--- FUNCIÓN PARA CREAR EL USUARIO DEL EMPLEADO

CREATE OR REPLACE FUNCTION crear_usuario_empleado() 
	RETURNS TRIGGER
	LANGUAGE plpgsql
AS $$
DECLARE
    usuario TEXT;
    contrasena TEXT;
    dni_persona TEXT;
    rol_empleado TEXT;
BEGIN
    SELECT
        e.num_ss,
        p.dni_nie,
        CASE
            WHEN TG_TABLE_NAME = 'medico' THEN 'medico'
            WHEN TG_TABLE_NAME = 'enfermero' THEN 'enfermero'
            WHEN TG_TABLE_NAME = 'administrativo' THEN 'administrativo'
	       	WHEN TG_TABLE_NAME = 'cientifico' THEN 'cientifico'
	        WHEN TG_TABLE_NAME = 'farmaceutico' THEN 'farmaceutico'
	        WHEN TG_TABLE_NAME = 'recursos_humanos' THEN 'recursos_humanos'
	        WHEN TG_TABLE_NAME = 'informatico' THEN 'informatico'
        END
    INTO usuario, dni_persona, rol_empleado
    FROM empleado e
    JOIN persona p ON e.dni_nie = p.dni_nie
    WHERE e.id_empleado = NEW.id_empleado;

    EXECUTE FORMAT('CREATE USER %I WITH PASSWORD %L', usuario, dni_persona);
    EXECUTE FORMAT('GRANT %I TO %I', rol_empleado, usuario);
END;
$$

---TRIGGERS DE CREAR USUARIO

CREATE TRIGGER crear_medico_trigger
AFTER INSERT ON medico
FOR EACH ROW EXECUTE FUNCTION crear_usuario_empleado();

CREATE TRIGGER crear_administrativo_trigger
AFTER INSERT ON administrativo
FOR EACH ROW EXECUTE FUNCTION crear_usuario_empleado();

CREATE TRIGGER crear_enfermero_trigger
AFTER INSERT ON enfermero
FOR EACH ROW EXECUTE FUNCTION crear_usuario_empleado();

CREATE TRIGGER crear_cientifico_trigger
AFTER INSERT ON cientifico
FOR EACH ROW EXECUTE FUNCTION crear_usuario_empleado();

CREATE TRIGGER crear_farmaceutico_trigger
AFTER INSERT ON farmaceutico
FOR EACH ROW EXECUTE FUNCTION crear_usuario_empleado();

CREATE TRIGGER crear_rh_trigger
AFTER INSERT ON recursos_humanos
FOR EACH ROW EXECUTE FUNCTION crear_usuario_empleado();

CREATE TRIGGER crear_informatico_trigger
AFTER INSERT ON informatico
FOR EACH ROW EXECUTE FUNCTION crear_usuario_empleado();

--- FUNCIÓN PARA ELIMINAR USUARIO CUANDO SE ELIMINE UN EMPLEADO

CREATE OR REPLACE FUNCTION eliminar_usuario_empleado()
    RETURNS TRIGGER 
    LANGUAGE plpgsql
AS $$
DECLARE
    ssn_empleado TEXT;
    tabla_empleado TEXT;
BEGIN
    SELECT num_ss, 
        CASE
            WHEN TG_TABLE_NAME = 'medico' THEN 'medico'
            WHEN TG_TABLE_NAME = 'enfermero' THEN 'enfermero'
            WHEN TG_TABLE_NAME = 'administrativo' THEN 'administrativo'
            WHEN TG_TABLE_NAME = 'cientifico' THEN 'cientifico'
            WHEN TG_TABLE_NAME = 'farmaceutico' THEN 'farmaceutico'
            WHEN TG_TABLE_NAME = 'recursos_humanos' THEN 'recursos_humanos'
            WHEN TG_TABLE_NAME = 'informatico' THEN 'informatico'
        END 
    INTO ssn_empleado, tabla_empleado
    FROM empleado
    WHERE id_empleado = OLD.id_empleado;

    EXECUTE 'REVOKE ' || tabla_empleado || ' FROM ' || quote_ident(ssn_empleado);

    EXECUTE 'DROP USER IF EXISTS ' || quote_ident(ssn_empleado);

    RETURN OLD;
END;
$$;

--- TRIGGERS PARA ELIMINAR LOS USUARIOS

CREATE TRIGGER eliminar_medico_trigger
AFTER DELETE ON medico
FOR EACH ROW EXECUTE FUNCTION eliminar_usuario_empleado();

CREATE TRIGGER eliminar_administrativo_trigger
AFTER DELETE ON administrativo
FOR EACH ROW EXECUTE FUNCTION eliminar_usuario_empleado();

CREATE TRIGGER eliminar_enfermero_trigger
AFTER DELETE ON enfermero
FOR EACH ROW EXECUTE FUNCTION eliminar_usuario_empleado();

CREATE TRIGGER eliminar_cientifico_trigger
AFTER DELETE ON cientifico
FOR EACH ROW EXECUTE FUNCTION eliminar_usuario_empleado();

CREATE TRIGGER eliminar_farmaceutico_trigger
AFTER DELETE ON farmaceutico
FOR EACH ROW EXECUTE FUNCTION eliminar_usuario_empleado();

CREATE TRIGGER eliminar_rh_trigger
AFTER DELETE ON recursos_humanos
FOR EACH ROW EXECUTE FUNCTION eliminar_usuario_empleado();

CREATE TRIGGER eliminar_informatico_trigger
AFTER DELETE ON informatico
FOR EACH ROW EXECUTE FUNCTION eliminar_usuario_empleado();

--- FUNCIONES PARA LOS LOGS DE LOS USUARIOS QUE ACCEDEN A LOS DATOS DE LOS PACIENTES

CREATE OR REPLACE FUNCTION log_informacion_pacientes()
RETURNS TRIGGER 
LANGUAGE PLPGSQL
AS
$$
BEGIN
	IF TG_OP = 'INSERT' THEN
        INSERT INTO auditoria_pacientes (usuario, fecha_hora, tarjeta_sanitaria, accion) VALUES
            (current_user, now(), NEW.tarjeta_sanitaria, 'Insertar');
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO auditoria_pacientes (usuario, fecha_hora, tarjeta_sanitaria, accion) VALUES
            (current_user, now(), OLD.tarjeta_sanitaria, 'Eliminar');
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO auditoria_pacientes (usuario, fecha_hora, tarjeta_sanitaria, accion) VALUES
            (current_user, now(), tarjeta_sanitaria, 'Cambiar');
        RETURN NEW;
    END IF;
END;
$$

--- TRIGGER PARA LA FUNCIÓN DEL LOG

CREATE TRIGGER trigger_info_pacientes
    AFTER INSERT OR DELETE OR UPDATE ON paciente
    FOR EACH ROW EXECUTE FUNCTION log_informacion_pacientes();