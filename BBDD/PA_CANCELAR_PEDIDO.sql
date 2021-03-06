USE [ARCIPRESTE3]
GO
/****** Object:  StoredProcedure [dbo].[PA_CANCELAR_PEDIDO]    Script Date: 13/10/2020 16:55:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[PA_CANCELAR_PEDIDO] 
(
	@ID_PEDIDOS INT,

	@RETCODE INT OUTPUT,
	@MENSAJE VARCHAR(200) OUTPUT
)
AS
BEGIN
SET NOCOUNT ON;
	
	IF (ISNULL(@ID_PEDIDOS,'') = '')
	BEGIN
		
		SET @MENSAJE =  'No se ha introducido ning�n ID de pedido'
		SET @RETCODE = 1
		RETURN
	END

	IF NOT EXISTS (SELECT ID_PEDIDOS FROM PEDIDOS WHERE ID_PEDIDOS = @ID_PEDIDOS)
	BEGIN
		SET @MENSAJE =  'El ID introducido no existe en la base de datos'
		SET @RETCODE = 1
		RETURN
	END

	ELSE

	BEGIN

		DELETE FROM PEDIDOS WHERE ID_PEDIDOS = @ID_PEDIDOS

		SET @MENSAJE =  'Pedido cancelado correctamente' 
		SET @RETCODE = 0

	END

	RETURN


END