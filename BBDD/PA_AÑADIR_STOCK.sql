USE [ARCIPRESTE3]
GO
/****** Object:  StoredProcedure [dbo].[PA_AÑADIR_STOCK]    Script Date: 30/10/2020 12:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[PA_AÑADIR_STOCK]
(
	@ID_ARTICULO INT, 
	@CANTIDAD INT,

	@RETCODE INT OUTPUT,
	@MENSAJE VARCHAR(200) OUTPUT
)
AS
BEGIN
SET NOCOUNT ON;

	IF (@ID_ARTICULO = '')
	BEGIN
		
		SET @MENSAJE =  'Campo @ID_ARTICULO vacio'
		SET @RETCODE = 1
		RETURN
	END

	IF (@CANTIDAD = NULL)
	BEGIN
		 SET @MENSAJE = 'Campo @CANTIDAD vacio'
		 SET @RETCODE = 1
		 RETURN
	END

	/* Si el ID del articulo introducido no existe en la tabla de ARTICULOS */
	IF NOT EXISTS (SELECT ID_ARTICULO FROM ARTICULOS WHERE ID_ARTICULO = @ID_ARTICULO)
	BEGIN

		SET @MENSAJE =  'El articulo a modificar el stock no existe en la base de datos' 
		SET @RETCODE = 1
		RETURN

	END

	/* Si el ID del articulo introducido no existe en la tabla STOCK pero si en la de ARTICULOS crearemos la fila */
	IF NOT EXISTS (SELECT ID_ARTICULO FROM STOCK WHERE ID_ARTICULO = @ID_ARTICULO)
	BEGIN

		INSERT INTO STOCK 
		(
			ID_ARTICULO,
			CANTIDAD
		) 
		VALUES 
		(
			@ID_ARTICULO,
			@CANTIDAD
		)

		SET @MENSAJE =  'Stock modificado correctamente' 
		SET @RETCODE = 0
		RETURN

	END

	/* Si ya existe el ID del articulo simplemente haremos un update sumando las cantidades */
	ELSE
	BEGIN

		UPDATE STOCK SET CANTIDAD = ( CANTIDAD + @CANTIDAD ) WHERE ID_ARTICULO = @ID_ARTICULO

		SET @MENSAJE =  'Stock modificado correctamente' 
		SET @RETCODE = 0
		RETURN
	END

END
