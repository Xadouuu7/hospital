---                                            ---
--- FUNCIÓN PARA CREAR EL USUARIO DEL EMPLEADO ---
---                                            ---

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
    IF rol_empleado = 'recursos_humanos' OR rol_empleado = 'administrativo' THEN 
        EXECUTE FORMAT('CREATE USER %I WITH PASSWORD %L CREATEROLE', usuario, dni_persona);
        EXECUTE FORMAT('GRANT %I TO %I', rol_empleado, usuario); 
    ELSE 
        EXECUTE FORMAT('CREATE USER %I WITH PASSWORD %L', usuario, dni_persona);
        EXECUTE FORMAT('GRANT %I TO %I', rol_empleado, usuario);
    END IF;
    RETURN NEW;
END;
$$

---                           ---
--- TRIGGERS DE CREAR USUARIO ---
---                           ---

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

---                                                             ---
--- FUNCIÓN PARA ELIMINAR USUARIO CUANDO SE ELIMINE UN EMPLEADO ---
---                                                             ---

CREATE OR REPLACE FUNCTION eliminar_usuario_empleado()
    RETURNS TRIGGER 
    LANGUAGE plpgsql
AS $$
DECLARE
    ssn_empleado TEXT;
    rol_empleado TEXT;
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
    INTO ssn_empleado, rol_empleado
    FROM empleado
    WHERE id_empleado = OLD.id_empleado;
    EXECUTE 'REVOKE ' || rol_empleado || ' FROM ' || quote_ident(ssn_empleado);

    EXECUTE 'DROP USER IF EXISTS ' || quote_ident(ssn_empleado);

    RETURN OLD;
END;
$$;

---                                     ---
--- TRIGGERS PARA ELIMINAR LOS USUARIOS ---
---                                     ---

CREATE OR REPLACE TRIGGER eliminar_medico_trigger
AFTER DELETE ON medico
FOR EACH ROW EXECUTE FUNCTION eliminar_usuario_empleado();

CREATE OR REPLACE TRIGGER eliminar_administrativo_trigger
AFTER DELETE ON administrativo
FOR EACH ROW EXECUTE FUNCTION eliminar_usuario_empleado();

CREATE OR REPLACE TRIGGER eliminar_enfermero_trigger
AFTER DELETE ON enfermero
FOR EACH ROW EXECUTE FUNCTION eliminar_usuario_empleado();

CREATE OR REPLACE TRIGGER eliminar_cientifico_trigger
AFTER DELETE ON cientifico
FOR EACH ROW EXECUTE FUNCTION eliminar_usuario_empleado();

CREATE OR REPLACE TRIGGER eliminar_farmaceutico_trigger
AFTER DELETE ON farmaceutico
FOR EACH ROW EXECUTE FUNCTION eliminar_usuario_empleado();

CREATE OR REPLACE TRIGGER eliminar_rh_trigger
AFTER DELETE ON recursos_humanos
FOR EACH ROW EXECUTE FUNCTION eliminar_usuario_empleado();

CREATE OR REPLACE TRIGGER eliminar_informatico_trigger
AFTER DELETE ON informatico
FOR EACH ROW EXECUTE FUNCTION eliminar_usuario_empleado();

---                               ---
--- CREAR USUARIOS PARA PACIENTES ---
---                               ---

CREATE OR REPLACE FUNCTION crear_usuario_paciente() 
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS $$
DECLARE
    usuario TEXT;
    contrasena TEXT;
    dni_persona TEXT;
    rol_persona TEXT := 'paciente';
    user_exists BOOLEAN;
BEGIN
    SELECT
        pac.tarjeta_sanitaria,
        pac.dni_nie
    INTO usuario, dni_persona
    FROM paciente pac
    WHERE pac.tarjeta_sanitaria = NEW.tarjeta_sanitaria;

    PERFORM 1
    FROM pg_catalog.pg_roles
    WHERE rolname = usuario;

    user_exists := FOUND;

    IF NOT user_exists THEN
        EXECUTE FORMAT('CREATE USER %I WITH PASSWORD %L', usuario, dni_persona);
        EXECUTE FORMAT('GRANT %I TO %I', rol_persona, usuario);
    END IF;
    RETURN NEW;
END;
$$

---         ---
--- TRIGGER ---
---         ---

CREATE TRIGGER trigger_crear_usuario
    AFTER INSERT ON paciente
    FOR EACH ROW EXECUTE FUNCTION crear_usuario_paciente();

---                    ---
--- ELIMINAR PACIENTES ---
---                    ---

CREATE OR REPLACE FUNCTION eliminar_usuario_paciente()
    RETURNS TRIGGER 
    LANGUAGE plpgsql
AS $$
DECLARE
    tarjeta_sanitaria TEXT;
    rol_paciente TEXT := 'paciente';
BEGIN
    SELECT tarjeta_sanitaria
    INTO tarjeta_sanitaria
    FROM empleado
    WHERE tarjeta_sanitaria = OLD.tarjeta_sanitaria;

    EXECUTE 'REVOKE ' || rol_paciente || ' FROM ' || quote_ident(tarjeta_sanitaria);

    EXECUTE 'DROP USER IF EXISTS ' || quote_ident(tarjeta_sanitaria);

    RETURN OLD;
END;
$$;

---         ---
--- TRIGGER ---
---         ---

CREATE TRIGGER trigger_eliminar_usuario
    AFTER DELETE ON paciente
    FOR EACH ROW EXECUTE FUNCTION eliminar_usuario_paciente();

---                                                                                         ---
--- FUNCIÓN ELIMINAR TODOS LOS USUARIOS DE LA BASE DE DATOS QUE SE HAYAN CREADO MANUALMENTE ---
---                                                                                         ---

CREATE OR REPLACE PROCEDURE eliminar_usuario()
LANGUAGE plpgsql
AS $$
DECLARE
    usuario RECORD;
BEGIN
    FOR usuario IN
        SELECT usename
        FROM pg_user
        WHERE LENGTH(usename) = 14 OR LENGTH(usename) = 12
    LOOP
        EXECUTE format('DROP USER %I;', usuario.usename);
    END LOOP;
END
$$;

---                                                                                  ---
--- FUNCIONES PARA LOS LOGS DE LOS USUARIOS QUE ACCEDEN A LOS DATOS DE LOS PACIENTES ---
---                                                                                  ---

CREATE OR REPLACE FUNCTION log_informacion_pacientes()
RETURNS TRIGGER 
LANGUAGE PLPGSQL
AS
$$
BEGIN
	IF TG_OP = 'INSERT' THEN
        INSERT INTO auditoria_pacientes (usuario, fecha_hora, tarjeta_sanitaria, accion) VALUES
            (current_user, now(), NEW.tarjeta_sanitaria, 'Insertar paciente');
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO auditoria_pacientes (usuario, fecha_hora, tarjeta_sanitaria, accion) VALUES
            (current_user, now(), OLD.tarjeta_sanitaria, 'Eliminar paciente');
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO auditoria_pacientes (usuario, fecha_hora, tarjeta_sanitaria, accion) VALUES
            (current_user, now(), tarjeta_sanitaria, 'Cambiar paciente');
        RETURN NEW; 
    END IF;
END;
$$

---                                 ---
--- TRIGGER PARA LA FUNCIÓN DEL LOG ---
---                                 ---

CREATE TRIGGER trigger_info_pacientes
    AFTER INSERT OR DELETE OR UPDATE ON paciente
    FOR EACH ROW EXECUTE FUNCTION log_informacion_pacientes();