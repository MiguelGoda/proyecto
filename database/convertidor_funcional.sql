delimiter //
CREATE PROCEDURE AgregarBiometricoOficina()
BEGIN
	START TRANSACTION;

	-- CREANDO TABLA TEMPORAL PARA CREAR EL TEXTO DE FECHA
	CREATE TEMPORARY TABLE TEMPBIO1
	SELECT biometrico_id, pin, STR_TO_DATE(checktime, '%d/%m/%Y %H:%i') AS fecha from biometricobase;

	-- CREANDO LA TABLA TEMPORAL PARA SEPARAR LA FECHA Y LA HORA
	CREATE TEMPORARY TABLE TEMPBIO2(     
	SELECT biometrico_id, pin, 
	SUBSTRING_INDEX(SUBSTRING_INDEX(fecha, ' ', 1), ' ', -1) AS fecha,
	TRIM(SUBSTR(fecha, LOCATE(' ', fecha)) ) AS hora from TEMPBIO1);
     
	-- CREANDO TABLA TEMPORAL PARA ACTUALIZAR ANTES DE INSERTAR
	CREATE TEMPORARY TABLE TEMPBIO3 (biometrico_id int(11) not null, PIN int(11) not null, fecha date, hora time, observacion varchar (50), dia varchar(30));
	INSERT INTO TEMPBIO3 (biometrico_id, PIN, fecha, hora, dia)  
	select biometrico_id,PIN,fecha,hora,DAYNAME(fecha) from TEMPBIO2;
    
    
-- ACTUALIZANDO OBSERVACIONES HORARIO DE OFICINA
	UPDATE TEMPBIO3 tb
	JOIN contrataciones c on tb.PIN = c.PIN
	JOIN horarios h on h.id_horario = c.id_horario
	SET observacion = CASE 
		WHEN (tb.hora >= "06:00" AND tb.hora < CONVERT(h.entrada1, TIME))  THEN "A" 
		WHEN (tb.hora >= "08:00" AND tb.hora < AddTime(CONVERT(h.entrada1, TIME), "00:10:00")) THEN "F1"
		WHEN (tb.hora >= "08:10" AND tb.hora < AddTime(CONVERT(h.entrada1, TIME), "00:20:00")) THEN "F2"
		WHEN (tb.hora >= "08:20" AND tb.hora < AddTime(CONVERT(h.entrada1, TIME), "00:30:00")) THEN "F3"
		WHEN (tb.hora >= "11:00" AND tb.hora < CONVERT(h.salida1, TIME))  THEN NULL 
		WHEN (tb.hora >= "12:30" AND tb.hora < AddTime(CONVERT(h.salida1, TIME), "00:30:00")) THEN "F1"
		WHEN (tb.hora >= "14:00" AND tb.hora < CONVERT(h.entrada2, TIME))  THEN "A" 
		WHEN (tb.hora >= "15:00" AND tb.hora < AddTime(CONVERT(h.entrada2, TIME), "00:10:00")) THEN "F1"
		WHEN (tb.hora >= "15:10" AND tb.hora < AddTime(CONVERT(h.entrada2, TIME), "00:20:00")) THEN "F2"
		WHEN (tb.hora >= "15:20" AND tb.hora < AddTime(CONVERT(h.entrada2, TIME), "00:30:00")) THEN "F3"
		WHEN (tb.hora >= "18:00" AND tb.hora < CONVERT(h.salida2, TIME)) THEN NULL
		WHEN (tb.hora >= "18:30" AND tb.hora <= "22:00") THEN "A" 
		WHEN (tb.dia = "Saturday" AND tb.hora >= "07:30" AND tb.hora < "09:00")	THEN "A"
		WHEN (tb.dia = "Saturday" AND tb.hora >= "09:00" AND tb.hora < "09:10") THEN "F1"
		WHEN (tb.dia = "Saturday" AND tb.hora >= "09:10" AND tb.hora < "09:20") THEN "F2"
		WHEN (tb.dia = "Saturday" AND tb.hora >= "09:20" AND tb.hora < "09:30") THEN "F3"
		WHEN (tb.dia = "Saturday" AND tb.hora >= "09:30" AND tb.hora < "12:00") THEN NULL
		WHEN (tb.dia = "Saturday" AND tb.hora >= "12:00" AND tb.hora < "14:00") THEN "A"
		ELSE NULL end;     
    
-- solo falta hacer la validadicon de duplicado

	-- INSERTANDO DATOS A LA TABLA BIOMETRICO
	Insert into biometrico(PIN,fecha,hora,observacion)
	select tb3.pin,tb3.fecha,tb3.hora,tb3.observacion 
	from TEMPBIO3 tb3
	 
    
	 -- BORRANDO TABLAS TEMPORALES
	DROP TEMPORARY TABLE TEMPBIO3;
	DROP TEMPORARY TABLE TEMPBIO2;
	DROP TEMPORARY TABLE TEMPBIO1;
END //
DELIMITER ;
