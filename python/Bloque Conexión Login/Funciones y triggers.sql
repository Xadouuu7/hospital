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

    EXECUTE CONCAT('CREATE USER', ' ', usuario, ' ', 'WITH PASSWORD', ' ', dni_persona);
	EXECUTE CONCAT('GRANT', ' ', rol_empleado, ' ', 'TO', ' ', usuario);
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