USE [ARCIPRESTE3]
GO
/****** Object:  StoredProcedure [dbo].[PA_QUITAR_STOCK]    Script Date: 13/10/2020 16:15:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[PA_QUITAR_STOCK]
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

	IF (@CANTIDAD = '')
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

	/* Si el stock a quitar es mayor que el stock actual */
	IF (@CANTIDAD > (SELECT CANTIDAD FROM STOCK WHERE ID_ARTICULO = @ID_ARTICULO))
	BEGIN

		SET @MENSAJE = 'No hay suficiente stock disponible'
		SET @RETCODE = 1
		RETURN

	END

	UPDATE STOCK SET CANTIDAD = ( CANTIDAD - @CANTIDAD ) WHERE ID_ARTICULO = @ID_ARTICULO

	SET @MENSAJE =  'Stock modificado correctamente' 
	SET @RETCODE = 0
	RETURN

END