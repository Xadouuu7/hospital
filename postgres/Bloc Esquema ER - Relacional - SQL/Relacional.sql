CIUDAD: (id_ciudad, nombre)
DIRECCION: (id_direccion, direccion, numero, piso, puerta, codigo_postal, id_ciudad)
    ON {id_ciudad} REFERENCES CIUDAD{id_ciudad}
PERSONA: (DNI_NIE, nombre, apellido1, apellido2, fecha_nacimiento, genero, telefono, correo_electronico, usuario, contraseña, id_direccion)
    ON {id_direccion} REFERENCES DIRECCION{id_direccion}
EMPLEADO: (id_empleado, DNI_NIE, num_ss, horario_trabajo, dias_vacaciones)
    ON {DNI_NIE} REFERENCES PERSONA{DNI_NIE}
PACIENTE: (tarjeta_sanitaria, DNI_NIE, sangre, altura, peso)
    ON {DNI_NIE} REFERENCES PERSONA{DNI_NIE}
VARIOS: (id_empleado, trabajo)
    ON {id_empleado} REFERENCES EMPLEADO{id_empleado}
FARMACEUTICO: (id_empleado, estudio, experiencia_previa, id_especialidad)
    ON {id_empleado} REFERENCES EMPLEADO{id_empleado}
    ON {id_especialidad} REFERENCES ESPECIALIDAD{id_especialidad}
ENFERMERO: (id_empleado, estudio, experiencia_previa, id_especialidad, id_planta, id_medico)
    ON {id_empleado} REFERENCES EMPLEADO{id_empleado}
    ON {id_especialidad} REFERENCES PLANTA{id_especialidad}
    ON {id_planta} REFERENCES ESPECIALIDAD{num_planta}
    ON {id_medico} REFERENCES MEDICO{id_empleado}
MEDICO: (id_empleado, estudio, experiencia_previa, id_especialidad)
    ON {id_empleado} REFERENCES EMPLEADO{id_empleado}
    ON {id_especialidad} REFERENCES ESPECIALIDAD{id_especialidad}
ADMINISTRATIVO: (id_empleado, estudio, experiencia_previa)
    ON {id_empleado} REFERENCES EMPLEADO{id_empleado}
CIENTIFICO: (id_empleado, estudio, experiencia_previa, id_especialidad, id_laboratorio, num_planta)
    ON {id_empleado} REFERENCES EMPLEADO{id_empleado}
    ON {id_especialidad} REFERENCES ESPECIALIDAD{id_especialidad}
    ON {id_laboratorio} REFERENCES laboratorio{id_laboratorio}
    ON {num_planta} REFERENCES laboratorio{num_planta}
ESPECIALIDAD: (id_especialidad, nombre)
VISITA: (id_visita, id_consulta, id_medico, id_paciente, id_diagnostico, id_triaje, fecha_hora, motivo_visita)
    ON {id_consulta} REFERENCES CONSULTA{id_consulta}
    ON {id_medico} REFERENCES MEDICO{id_medico}
    ON {id_paciente} REFERENCES PACIENTE{tarjeta_sanitaria}
    ON {id_triaje} REFERENCES TRIAJE{id_triaje}
DIAGNOSTICO: (id_diagnostico, id_patologia, descripcion)
    ON {id_consulta} REFERENCES CONSULTA{id_consulta}
PATOLOGIA: (id_patologia, nombre)
PRUEBA: (id_prueba, id_laboratorio, id_diagnostico)
    ON {id_laboratorio} REFERENCES LABORATORIO{id_laboratorio}
    ON {id_diagnostico} REFERENCES DIAGNOSTICO{id_diagnostico}
CONSULTA: (id_consulta, num_planta, tipo)
    ON {num_planta} REFERENCES PLANTA{num_planta}
HABITACION: (num_habitacion, num_planta, tipo)
    ON {num_planta} REFERENCES PLANTA{num_planta}
LABORATORIO: (id_laboratorio, num_planta)
    ON {num_planta} REFERENCES PLANTA{num_planta}
PLANTA: (num_planta, nombre)
TRIAJE: (num_sala_triaje, id_sala_urgencia, motivo_visita)
    ON {id_sala_urgencia} REFERENCES SALA_URGENCIA{id_sala_urgencua}
SALA_URGENCIA: (id_sala_urgencia, num_planta)
    ON {num_planta} REFERENCES PLANTA{num_planta}
RESERVA_HABITACION(id_reserva, tarjeta_sanitaria, num_habitacion, num_planta, id_administrativo, fecha_entrad, fecha_salida, total_camas)
    ON {tarjeta_sanitaria} REFERENCES PACIENTE{tarjeta_sanitaria}
    ON {num_habitacion, num_planta} REFERENCES HABITACION{num_habitacion, num_planta}
    ON {id_administrativo} REFERENCES ADMINISTRATIVO{id_empleado}
INV_MEDICAMENTO: (id_inv_medicamento, num_almacen, num_planta, id_medicamento)
    ON {num_almacen, num_planta} REFERENCES ALMACEN{num_almacen, num_planta}
MEDICAMENTO: (id_medicamento, nombre_medicamento)
INV_LABORATORIO: (id_inv_laboratorio, id_laboratorio, num_planta, id_material)
    ON {id_laboratorio, num_planta} REFERENCES LABORATORIO{id_laboratorio, num_planta}
MATERIAL_LABORATORIO: (id_material, nombre)
INV_MATERIAL_GENERAL: (id_inv_material_general, num_almacen, num_planta, id_material_general)
    ON {num_almacen, num_planta} ALMACEN{num_almacen, num_planta}
MATERIAL_GENERAL: (id_material_general, nombre)
QUIROFANO: (num_quirofano, num_planta)
    ON {num_planta} REFERENCES PLANTA{num_planta}
MATERIAL_QUIROFANO: (id_material_quirofano, nombre)
INV_MATERIAL_QUIROFANO: (id_inv_material_quirofano, num_almacen, num_quirofano, id_material_quirofano)
ALMACEN: (num_almacen, num_planta)
    ON {num_planta} REFERENCES PLANTA{num_planta}
RESERVA_QUIROFANO: (id_reserva, num_quirofano, num_planta,  id_medico, tarjeta_sanitaria, id_administrativo)
    ON {num_quirofano, num_planta} REFERENCES QUIROFANO{num_quirofano, num_planta}
    ON {id_medico} REFERENCES MEDICO{id_empleado}
    ON {tarjeta_sanitaria} REFERENCES PACIENTE{tarjeta_sanitaria}
    ON {id_administrativo} REFERENCES ADMINISTRATIVO{id_administrativo}