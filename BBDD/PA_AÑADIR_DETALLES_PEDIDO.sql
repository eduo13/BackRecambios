USE [ARCIPRESTE3]
GO
/****** Object:  StoredProcedure [dbo].[PA_A�ADIR_PEDIDO]    Script Date: 11/11/2020 10:46:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PA_A�ADIR_DETALLES_PEDIDO] 
(
	@ID_PEDIDO INT,
	@ID_ARTICULO INT,
	@CANTIDAD INT,
	@ESTADO VARCHAR(20),

	@RETCODE INT OUTPUT,
	@MENSAJE VARCHAR(200) OUTPUT
)
AS
BEGIN
	
	IF (ISNULL(@ID_PEDIDO,'') = '' OR 
	    ISNULL(@ID_ARTICULO,'') = '' OR
	    ISNULL(@CANTIDAD,'') = '' OR
	    ISNULL(@ESTADO,'') = '')
	 
	BEGIN
		
		SET @MENSAJE =  'Se han de introducir todos los datos'
		SET @RETCODE = 1
		RETURN
	END

	INSERT INTO PEDIDOS_ARTICULOS
	(
		ID_PEDIDO, 
		ID_ARTICULO,
		CANTIDAD
	) 
	VALUES 
	(
		@ID_PEDIDO, 
		@ID_ARTICULO,
		@CANTIDAD
	)

	INSERT INTO PEDIDOS_ESTADOS
	(
		ID_PEDIDO,
		ESTADO
	)
	VALUES
	(
		@ID_PEDIDO,
		@ESTADO
	)

	SET @MENSAJE =  'Pedido agreagado correctamente' 
	SET @RETCODE = 0
	RETURN

	

END