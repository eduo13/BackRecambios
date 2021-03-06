USE [ARCIPRESTE3]
GO
/****** Object:  StoredProcedure [dbo].[PA_AÑADIR_ARTICULO]    Script Date: 03/11/2020 9:17:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[PA_AÑADIR_ARTICULO] 
(
	@NOMBRE VARCHAR(100),
	@DESCRIPCION VARCHAR(1000), 
	@FABRICANTE VARCHAR(1000),
	@PESO decimal(12, 2),
	@ALTO decimal(12, 2),
	@LARGO decimal(12, 2),
	@ANCHO decimal(12, 2),
	@PRECIO decimal(12, 2),
	@IMAGEN VARBINARY (MAX),

	@RETCODE INT OUTPUT,
	@MENSAJE VARCHAR(200) OUTPUT
)
AS
BEGIN
	IF (@NOMBRE = '')
	BEGIN
		
		SET @MENSAJE =  'Campo @NOMBRE vacio'
		SET @RETCODE = 1
		RETURN
	END

	IF (@FABRICANTE = '')
	BEGIN
		
		SET @MENSAJE =  'Campo @FABRICANTE vacio'
		SET @RETCODE = 1
		RETURN
	END

	IF (@PESO = NULL)
	BEGIN
		
		SET @MENSAJE =  'Campo @PESO vacio'
		SET @RETCODE = 1
		RETURN
	END

	IF (@PRECIO = NULL)
	BEGIN
		 SET @MENSAJE = 'Campo @PRECIO vacio'
		 SET @RETCODE = 1
		 RETURN
	END

	IF EXISTS (SELECT NOMBRE FROM ARTICULOS WHERE NOMBRE = @NOMBRE)
	BEGIN
		SET @MENSAJE =  'El articulo que se intenta introducir a la base de datos ya existe'
		SET @RETCODE = 1
		RETURN
	END

	INSERT INTO ARTICULOS 
	(
		NOMBRE,
		DESCRIPCION,
		FABRICANTE,
		PESO,
		ALTO,
		LARGO,
		ANCHO,
		PRECIO,
		IMAGEN
	) 
	VALUES 
	(
		@NOMBRE,
		@DESCRIPCION,
		@FABRICANTE,
		@PESO,
		@ALTO,
		@LARGO,
		@ANCHO,
		@PRECIO,
		@IMAGEN
	)

	SET @MENSAJE =  'Articulo agreagado correctamente' 
	SET @RETCODE = 0
	RETURN


END