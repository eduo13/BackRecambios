USE [ARCIPRESTE3]
GO
/****** Object:  StoredProcedure [dbo].[PA_BORRAR_USUARIO]    Script Date: 21/10/2020 9:37:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[PA_BORRAR_USUARIO] 
(
	@ID_USUARIO INT,

	@RETCODE INT OUTPUT,
	@MENSAJE VARCHAR(200) OUTPUT
)
AS
BEGIN
SET NOCOUNT ON;
	
	IF (@ID_USUARIO = '')
	BEGIN
		
		SET @MENSAJE =  'No se ha introducido ningún ID'
		SET @RETCODE = 1
		RETURN
	END

	IF NOT EXISTS (SELECT ID_USUARIOS FROM USUARIOS WHERE ID_USUARIOS = @ID_USUARIO)
	BEGIN
		SET @MENSAJE =  'El usuario que se intenta eliminar no existe en la base de datos'
		SET @RETCODE = 1
		RETURN
	END

	ELSE

	BEGIN

		DELETE FROM USUARIOS WHERE ID_USUARIOS = @ID_USUARIO

		SET @MENSAJE =  'Usuario eliminado correctamente' 
		SET @RETCODE = 0

	END

	RETURN


END