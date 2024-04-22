SELECT anon.start_dynamic_masking();
SELECT anon.init();

SECURITY LABEL FOR anon ON ROLE administrativo IS 'MASKED';
SECURITY LABEL FOR anon ON ROLE científico IS 'MASKED';
SECURITY LABEL FOR anon ON ROLE farmaceutico IS 'MASKED';
SECURITY LABEL FOR anon ON ROLE recursos_humanos IS 'MASKED';
SECURITY LABEL FOR anon ON ROLE informatico IS 'MASKED';

SECURITY LABEL FOR anon ON COLUMN visita.tarjeta_sanitaria IS 'MASKED WITH VALUE ''PRIVADO'' ';
SECURITY LABEL FOR anon ON COLUMN visita.motivo_visita IS 'MASKED WITH VALUE ''PRIVADO'' ';
SECURITY LABEL FOR anon ON COLUMN diagnostico.descripcion IS 'MASKED WITH VALUE ''PRIVADO'' ';
SECURITY LABEL FOR anon ON COLUMN diagnostico.id_diagnostico IS 'MASKED WITH VALUE ''PRIVADO'' ';
SECURITY LABEL FOR anon ON COLUMN diagnostico.id_patologia IS 'MASKED WITH VALUE ''PRIVADO'' ';