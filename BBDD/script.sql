USE [master]
GO
/****** Object:  Database [ARCIPRESTE3]    Script Date: 04/11/2020 13:14:30 ******/
CREATE DATABASE [ARCIPRESTE3]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ARCIPRESTE3', FILENAME = N'E:\MSSQL\DATA\ARCIPRESTE3\ARCIPRESTE3.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ARCIPRESTE3_log', FILENAME = N'E:\MSSQL\DATA\ARCIPRESTE3\ARCIPRESTE3_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ARCIPRESTE3] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ARCIPRESTE3].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ARCIPRESTE3] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ARCIPRESTE3] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ARCIPRESTE3] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ARCIPRESTE3] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ARCIPRESTE3] SET ARITHABORT OFF 
GO
ALTER DATABASE [ARCIPRESTE3] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ARCIPRESTE3] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ARCIPRESTE3] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ARCIPRESTE3] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ARCIPRESTE3] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ARCIPRESTE3] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ARCIPRESTE3] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ARCIPRESTE3] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ARCIPRESTE3] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ARCIPRESTE3] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ARCIPRESTE3] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ARCIPRESTE3] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ARCIPRESTE3] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ARCIPRESTE3] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ARCIPRESTE3] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ARCIPRESTE3] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ARCIPRESTE3] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ARCIPRESTE3] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ARCIPRESTE3] SET  MULTI_USER 
GO
ALTER DATABASE [ARCIPRESTE3] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ARCIPRESTE3] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ARCIPRESTE3] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ARCIPRESTE3] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ARCIPRESTE3] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ARCIPRESTE3', N'ON'
GO
ALTER DATABASE [ARCIPRESTE3] SET QUERY_STORE = OFF
GO
USE [ARCIPRESTE3]
GO
/****** Object:  User [ARCIPRESTE]    Script Date: 04/11/2020 13:14:31 ******/
CREATE USER [ARCIPRESTE] FOR LOGIN [ARCIPRESTE] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [db_executor]    Script Date: 04/11/2020 13:14:31 ******/
CREATE ROLE [db_executor]
GO
ALTER ROLE [db_executor] ADD MEMBER [ARCIPRESTE]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [ARCIPRESTE]
GO
ALTER ROLE [db_datareader] ADD MEMBER [ARCIPRESTE]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [ARCIPRESTE]
GO
/****** Object:  Schema [db_executor]    Script Date: 04/11/2020 13:14:31 ******/
CREATE SCHEMA [db_executor]
GO
/****** Object:  View [dbo].[V_ARTICULOS_STOCK]    Script Date: 04/11/2020 13:14:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_ARTICULOS_STOCK]
AS
SELECT        dbo.ARTICULOS.NOMBRE, dbo.STOCK.CANTIDAD, dbo.ARTICULOS.DESCRIPCION, dbo.ARTICULOS.FABRICANTE, dbo.ARTICULOS.PESO, dbo.ARTICULOS.ALTO, dbo.ARTICULOS.LARGO, dbo.ARTICULOS.ANCHO, 
                         dbo.ARTICULOS.PRECIO, dbo.ARTICULOS.IMAGEN, dbo.STOCK.ID_ARTICULO
FROM            dbo.STOCK INNER JOIN
                         dbo.ARTICULOS ON dbo.STOCK.ID_ARTICULO = dbo.ARTICULOS.ID_ARTICULO
GO
/****** Object:  View [dbo].[V_USUARIOS_PERFILES]    Script Date: 04/11/2020 13:14:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_USUARIOS_PERFILES]
AS
SELECT        U.ID_USUARIOS, U.USUARIO, P.ID_PERFIL, P.PERFIL, U.EMAIL
FROM            dbo.USUARIOS AS U LEFT OUTER JOIN
                         dbo.PERFILES AS P ON P.ID_PERFIL = U.PERFIL
GO
/****** Object:  Table [dbo].[ARTICULOS]    Script Date: 04/11/2020 13:14:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARTICULOS](
	[ID_ARTICULO] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[DESCRIPCION] [varchar](1000) NULL,
	[FABRICANTE] [varchar](1000) NOT NULL,
	[PESO] [decimal](12, 2) NOT NULL,
	[ALTO] [decimal](12, 2) NULL,
	[LARGO] [decimal](12, 2) NULL,
	[ANCHO] [decimal](12, 2) NULL,
	[PRECIO] [decimal](12, 2) NOT NULL,
	[IMAGEN] [varbinary](max) NULL,
 CONSTRAINT [PK_ARTICULOS] PRIMARY KEY CLUSTERED 
(
	[ID_ARTICULO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PEDIDOS]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PEDIDOS](
	[ID_PEDIDOS] [int] IDENTITY(1,1) NOT NULL,
	[CALLE] [varchar](1000) NULL,
	[PROVINCIA] [varchar](1000) NULL,
	[POBLACION] [int] NULL,
	[CODIGO_POSTAL] [int] NULL,
	[NUMERO] [varchar](1000) NULL,
	[PERSONA_CONTACTO] [varchar](1000) NULL,
	[TELEFONO] [varchar](1000) NULL,
 CONSTRAINT [PK_PEDIDOS] PRIMARY KEY CLUSTERED 
(
	[ID_PEDIDOS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PEDIDOS_ARTICULOS]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PEDIDOS_ARTICULOS](
	[ID_PEDIDO] [int] NOT NULL,
	[ID_ARTICULO] [int] IDENTITY(1,1) NOT NULL,
	[CANTIDAD] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PERFILES]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERFILES](
	[ID_PERFIL] [int] NOT NULL,
	[PERFIL] [varchar](1000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[STOCK]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STOCK](
	[ID_ARTICULO] [int] NOT NULL,
	[CANTIDAD] [int] NULL,
 CONSTRAINT [PK_STOCK] PRIMARY KEY CLUSTERED 
(
	[ID_ARTICULO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USUARIOS]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USUARIOS](
	[ID_USUARIOS] [int] IDENTITY(1,1) NOT NULL,
	[USUARIO] [varchar](1000) NULL,
	[PASSWORD] [varbinary](max) NULL,
	[PERFIL] [int] NULL,
	[EMAIL] [varchar](70) NULL,
 CONSTRAINT [PK_USUARIOS] PRIMARY KEY CLUSTERED 
(
	[ID_USUARIOS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UNIQUE_EMAIL]    Script Date: 04/11/2020 13:14:32 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNIQUE_EMAIL] ON [dbo].[USUARIOS]
(
	[EMAIL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[STOCK]  WITH CHECK ADD  CONSTRAINT [FK_STOCK_ARTICULOS] FOREIGN KEY([ID_ARTICULO])
REFERENCES [dbo].[ARTICULOS] ([ID_ARTICULO])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[STOCK] CHECK CONSTRAINT [FK_STOCK_ARTICULOS]
GO
/****** Object:  StoredProcedure [dbo].[PA_AÑADIR_ARTICULO]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PA_AÑADIR_ARTICULO] 
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
GO
/****** Object:  StoredProcedure [dbo].[PA_AÑADIR_PEDIDO]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PA_AÑADIR_PEDIDO] 
(
	@CALLE VARCHAR(1000), 
	@PROVINCIA VARCHAR(1000),
	@POBLACION INT,
	@CODIGO_POSTAL INT,
	@NUMERO VARCHAR(1000),
	@PERSONA_CONTACTO VARCHAR(1000),
	@TELEFONO VARCHAR(1000),

	@RETCODE INT OUTPUT,
	@MENSAJE VARCHAR(200) OUTPUT
)
AS
BEGIN
	
	IF (ISNULL(@CALLE,'') = '' OR 
	    ISNULL(@PROVINCIA,'') = '' OR
	    ISNULL(@POBLACION,'') = '' OR
	    ISNULL(@CODIGO_POSTAL,'') = '' OR
	    ISNULL(@NUMERO,'') = '' OR
	    ISNULL(@PERSONA_CONTACTO,'') = '' OR
	    ISNULL(@TELEFONO,'') = '')
	BEGIN
		
		SET @MENSAJE =  'Se han de introducir todos los datos'
		SET @RETCODE = 1
		RETURN
	END

	ELSE

	BEGIN

		INSERT INTO PEDIDOS 
		(
			CALLE, 
			PROVINCIA,
			POBLACION,
			CODIGO_POSTAL,
			NUMERO,
			PERSONA_CONTACTO,
			TELEFONO
		) 
		VALUES 
		(
			@CALLE, 
			@PROVINCIA,
			@POBLACION,
			@CODIGO_POSTAL,
			@NUMERO,
			@PERSONA_CONTACTO,
			@TELEFONO
		)

		SET @MENSAJE =  'Pedido agreagado correctamente' 
		SET @RETCODE = 0
		RETURN

	END

END
GO
/****** Object:  StoredProcedure [dbo].[PA_AÑADIR_STOCK]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PA_AÑADIR_STOCK]
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
GO
/****** Object:  StoredProcedure [dbo].[PA_BORRAR_ARTICULO]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PA_BORRAR_ARTICULO] 
(
	@ID_ARTICULO INT,

	@RETCODE INT OUTPUT,
	@MENSAJE VARCHAR(200) OUTPUT
)
AS
BEGIN
SET NOCOUNT ON;
	
	IF (@ID_ARTICULO = '')
	BEGIN
		
		SET @MENSAJE =  'No se ha introducido ningún ID de articulo'
		SET @RETCODE = 1
		RETURN
	END

	IF NOT EXISTS (SELECT ID_ARTICULO FROM ARTICULOS WHERE ID_ARTICULO = @ID_ARTICULO)
	BEGIN
		SET @MENSAJE =  'El ID introducido no existe en la base de datos'
		SET @RETCODE = 1
		RETURN
	END

	ELSE

	BEGIN

		DELETE FROM ARTICULOS WHERE ID_ARTICULO = @ID_ARTICULO

		SET @MENSAJE =  'Articulo eliminado correctamente' 
		SET @RETCODE = 0

	END

	RETURN


END
GO
/****** Object:  StoredProcedure [dbo].[PA_BORRAR_USUARIO]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PA_BORRAR_USUARIO] 
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
GO
/****** Object:  StoredProcedure [dbo].[PA_CANCELAR_PEDIDO]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PA_CANCELAR_PEDIDO] 
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
		
		SET @MENSAJE =  'No se ha introducido ningún ID de pedido'
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
GO
/****** Object:  StoredProcedure [dbo].[PA_CREAR_USUARIO]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PA_CREAR_USUARIO] 
(
	@USUARIO VARCHAR(1000), 
	@PASSWORD VARCHAR(70), 
	@PERFIL INT,
	@EMAIL VARCHAR(70),

	@RETCODE INT OUTPUT,
	@MENSAJE VARCHAR(200) OUTPUT
)
AS
BEGIN
SET NOCOUNT ON;

	IF (@USUARIO = '')
	BEGIN
		
		SET @MENSAJE =  'Campo @USUARIO vacio'
		SET @RETCODE = 1
		RETURN
	END

	IF (@PASSWORD = '')
	BEGIN
		 SET @MENSAJE = 'Campo @PASSWORD vacio'
		 RETURN
	END

	IF (@PERFIL <= 0)
	BEGIN
		SET @MENSAJE =  'Campo @PERFIL vacio'
		SET @RETCODE = 1
		RETURN
	END

	IF (@EMAIL = '')
	BEGIN
		SET @MENSAJE =  'Campo @EMAIL vacio'
		SET @RETCODE = 1
		RETURN
	END

	IF EXISTS (SELECT EMAIL FROM USUARIOS WHERE EMAIL = @EMAIL)
	BEGIN
		SET @MENSAJE =  'El email introducido ya esta asociado a un usuario'
		SET @RETCODE = 1
		RETURN
	END

	/*SET @PASSWORD = HASHBYTES('SHA2_256', @PASSWORD) + HASHBYTES('SHA1', @PASSWORD) + HASHBYTES('MD2', @PASSWORD);*/

	INSERT INTO USUARIOS 
	(
		USUARIO,
		[PASSWORD],
		PERFIL,
		EMAIL
	) 
	VALUES 
	(
		@USUARIO, 
		HASHBYTES('SHA2_256', @PASSWORD),
		@PERFIL,
		@EMAIL
	)

	SET @MENSAJE =  'Usuario creado correctamente' 
	SET @RETCODE = 0
	RETURN


END
GO
/****** Object:  StoredProcedure [dbo].[PA_LOGIN]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PA_LOGIN]
(
	@EMAIL VARCHAR(70), 
	@PASSWORD VARCHAR(70),

	@ID_USUARIOS INT OUTPUT,
	@RETCODE INT OUTPUT,
	@MENSAJE VARCHAR(200) OUTPUT
)
AS
BEGIN
SET NOCOUNT ON;

	IF (@EMAIL = '')
	BEGIN
		
		SET @MENSAJE =  'Campo @EMAIL vacio'
		SET @RETCODE = 1
		RETURN
	END

	IF (@PASSWORD = '')
	BEGIN
		 SET @MENSAJE = 'Campo @PASSWORD vacio'
		 SET @RETCODE = 1
		 RETURN
	END

	/*SET @PASSWORD = HASHBYTES('SHA2_256', @PASSWORD) + HASHBYTES('SHA1', @PASSWORD) + HASHBYTES('MD2', @PASSWORD);*/

	SELECT	@ID_USUARIOS = ID_USUARIOS
	FROM	USUARIOS 
	WHERE	EMAIL = @EMAIL 
	AND	[PASSWORD] = HASHBYTES('SHA2_256', @PASSWORD)

	IF @ID_USUARIOS IS NOT NULL
	BEGIN
		SET @RETCODE = 0
		SET @MENSAJE = 'Se ha logeado correctamente'
	END

	ELSE

	BEGIN
		SET @RETCODE = 1
		SET @MENSAJE = 'Email o contraseña incorrectos'
	END
	RETURN

END
GO
/****** Object:  StoredProcedure [dbo].[PA_MODIFICAR_ARTICULO]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PA_MODIFICAR_ARTICULO] 
(
	@ID_ARTICULO INT,
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
SET NOCOUNT ON;

	IF NOT EXISTS (SELECT ID_ARTICULO FROM ARTICULOS WHERE ID_ARTICULO = @ID_ARTICULO)
	BEGIN
		SET @MENSAJE =  'El ID introducido no existe en la base de datos'
		SET @RETCODE = 1
		RETURN
	END

	UPDATE ARTICULOS SET NOMBRE=ISNULL(@NOMBRE,NOMBRE),DESCRIPCION=ISNULL(@DESCRIPCION,DESCRIPCION),FABRICANTE=ISNULL(@FABRICANTE,FABRICANTE),PESO=ISNULL(@PESO,PESO),ALTO=ISNULL(@ALTO,ALTO),
	LARGO=ISNULL(@LARGO,LARGO), ANCHO=ISNULL(@ANCHO,ANCHO), PRECIO=ISNULL(@PRECIO,PRECIO), IMAGEN=ISNULL(@IMAGEN,IMAGEN)
	WHERE ID_ARTICULO = @ID_ARTICULO

	SET @MENSAJE =  'Articulo modificado correctamente' 
	SET @RETCODE = 0
	RETURN


END
GO
/****** Object:  StoredProcedure [dbo].[PA_MODIFICAR_USUARIO]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PA_MODIFICAR_USUARIO] 
(
	@ID_USUARIO INT,
	@USUARIO VARCHAR(1000), 
	@PASSWORD VARCHAR(70), 
	@PERFIL INT,
	@EMAIL VARCHAR(70),

	@RETCODE INT OUTPUT,
	@MENSAJE VARCHAR(200) OUTPUT
)
AS
BEGIN
SET NOCOUNT ON;
	
	IF (ISNULL(@ID_USUARIO,'') = '')
	BEGIN
		
		SET @MENSAJE =  'No se ha introducido ningún ID de usuario'
		SET @RETCODE = 1
		RETURN
	END

	IF NOT EXISTS (SELECT ID_USUARIOS FROM USUARIOS WHERE ID_USUARIOS = @ID_USUARIO)
	BEGIN
		SET @MENSAJE =  'El ID introducido no existe en la base de datos'
		SET @RETCODE = 1
		RETURN
	END

	UPDATE USUARIOS SET USUARIO=ISNULL(@USUARIO,USUARIO),PASSWORD=ISNULL(HASHBYTES('SHA2_256', @PASSWORD),PASSWORD),PERFIL=ISNULL(@PERFIL,PERFIL),EMAIL=ISNULL(@EMAIL,EMAIL)
	WHERE ID_USUARIOS = @ID_USUARIO

	/*UPDATE USUARIOS SET USUARIO = @USUARIO, PASSWORD = HASHBYTES('SHA2_256', @PASSWORD), PERFIL=@PERFIL, EMAIL = @EMAIL
	WHERE EMAIL = @EMAIL*/

	SET @MENSAJE =  'Usuario modificado correctamente' 
	SET @RETCODE = 0
	RETURN


END
GO
/****** Object:  StoredProcedure [dbo].[PA_QUITAR_STOCK]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PA_QUITAR_STOCK]
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
GO
/****** Object:  StoredProcedure [dbo].[PAB]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =================================================================================================
-- Author: Bruno Ramos Silva
-- Create date: 03/03/2015
-- Description:	PA que devuelve todos los objetos que tengan parametro de entrada TEXTO_BUSCAR

-- Modificacion: Edgar
-- Fecha:	11/05/2017
-- Descripcion: Reestructuración del PA para que nos muestre los JOBS y el TEXTO_ICPL (si procede).

-- Modificación: Edgar
-- Fecha: 27/06/2017
-- Descripción: Ahora se puede hacer búsquedas de hasta 2 elementos:
-- Ejemplo:	 PAB '@TEXTO_BUSCAR','ID__TEMPORAL__OBJECT_ID'

-- Modificación: Javier Rod
-- Fecha: 07/02/2018
-- Descripción: Unificación de ambos PAB y búsquedas de hasta 5 elementos

-- Modificación: Cecilia N.Pri
-- Fecha: 04/10/2018
-- Descripción: Añado Replace para que en la búsqueda el guíon bajo no sea un comodín
-- =================================================================================================

CREATE PROCEDURE [dbo].[PAB]
	@TEXTO_BUSCAR	AS VARCHAR (1000),
	@TEXTO_BUSCAR_2 AS VARCHAR (1000) = @TEXTO_BUSCAR,
	@TEXTO_BUSCAR_3 AS VARCHAR (1000) = @TEXTO_BUSCAR,
	@TEXTO_BUSCAR_4 AS VARCHAR (1000) = @TEXTO_BUSCAR,
	@TEXTO_BUSCAR_5 AS VARCHAR (1000) = @TEXTO_BUSCAR

AS
BEGIN
	--VARIABLE PARA CONTROLAR LA BÚSQUEDA SEGÚN LA BASE DE DATOS TENGA LA TABLA 'N_TAREAS_PROGRAMADAS' O NO
	DECLARE @TAREAS AS BIT = 0
	IF EXISTS (SELECT [NAME] FROM SYS.tables WHERE [NAME] = 'N_TAREAS_PROGRAMADAS') SET @TAREAS = 1



	SET @TEXTO_BUSCAR = REPLACE(@TEXTO_BUSCAR,'_','[_]')
	SET @TEXTO_BUSCAR_2 = REPLACE(@TEXTO_BUSCAR_2,'_','[_]')
	SET @TEXTO_BUSCAR_3 = REPLACE(@TEXTO_BUSCAR_3,'_','[_]')
	SET @TEXTO_BUSCAR_4 = REPLACE(@TEXTO_BUSCAR_4,'_','[_]')
	SET @TEXTO_BUSCAR_5 = REPLACE(@TEXTO_BUSCAR_5,'_','[_]')
	

-- Creamos una tabla temporal y le añadimos un índice para acelerar el pab, ya que ahora es más grande que antes.
		CREATE TABLE #T
		(
			ID		INTEGER	,
			[OBJECT_ID]	INTEGER,
			TIPO		VARCHAR(10),
			ELEMENTO	VARCHAR(100),
			[SP_HELPTEXT]   VARCHAR(150),
			CODIGO		VARCHAR(MAX)
		)

	
		CREATE TABLE #T2
		(
			ID		INTEGER	,
			[OBJECT_ID]	INTEGER,
			TIPO		VARCHAR(10),
			ELEMENTO	VARCHAR(100),
			[SP_HELPTEXT]   VARCHAR(150),
			CODIGO		VARCHAR(MAX)
		)



-- METO PRIMERO EN UNA TEMPORAL LOS RESULTADOS QUE SIEMPRE HA DADO EL PAB:
	INSERT INTO #T2(TIPO,ELEMENTO,[SP_HELPTEXT],CODIGO,[OBJECT_ID],ID)
		SELECT 
			B.TIPO, 
			B.ELEMENTO, 
			B.SP_HELPTEXT, 
			B.CODIGO, 
			B.object_id, 
			B.ID 
		FROM
			(
			SELECT 
			       SYSOBJ.XTYPE             [TIPO] ,
			       SYSOBJ.NAME              [ELEMENTO],
			       'PAH ' + '''' + SYSOBJ.NAME + ''''  [SP_HELPTEXT] ,
			       MODU.DEFINITION 		[CODIGO],
			       MODU.OBJECT_ID,
			       SYSOBJ.ID			       
			FROM 
				SYSOBJECTS  AS SYSOBJ WITH(NOLOCK)

				INNER JOIN 
				SYS.OBJECTS AS SYS_OBJ WITH (NOLOCK) 
				ON SYSOBJ.ID = SYS_OBJ.OBJECT_ID

				INNER JOIN 
				SYS.SQL_MODULES AS MODU WITH (NOLOCK) 
				ON SYS_OBJ.OBJECT_ID = MODU.OBJECT_ID

				INNER JOIN 
				SYS.SYSUSERS AS USERS WITH (NOLOCK) 
				ON SYSOBJ.UID = USERS.UID
			WHERE 
				MODU.OBJECT_ID = SYSOBJ.ID

			GROUP BY 
				SYSOBJ.XTYPE,
				SYSOBJ.NAME,
				MODU.DEFINITION,
			   	SYS_OBJ.OBJECT_ID,
				USERS.NAME,
				MODU.OBJECT_ID,
				SYSOBJ.ID
			) B OPTION (RECOMPILE)
	PRINT 'A1'			
	INSERT INTO #T(TIPO,ELEMENTO,[SP_HELPTEXT],CODIGO,[OBJECT_ID],ID)
	SELECT 
			TIPO, 
			ELEMENTO, 
			SP_HELPTEXT, 
			CODIGO,
			object_id, 
			ID 
	FROM #T2
	WHERE			CODIGO 	LIKE '%' + @TEXTO_BUSCAR + '%'
				AND CODIGO LIKE '%' + @TEXTO_BUSCAR_2 + '%'
				AND CODIGO LIKE '%' + @TEXTO_BUSCAR_3 + '%'
				AND CODIGO LIKE '%' + @TEXTO_BUSCAR_4 + '%'
				AND CODIGO LIKE '%' + @TEXTO_BUSCAR_5 + '%'
PRINT 'A2'
	INSERT INTO #T(TIPO,ELEMENTO,[SP_HELPTEXT],CODIGO,[OBJECT_ID],ID)
	select 'CLR',assembly_method,'CLR','CLR',-1,-1 from sys.assembly_modules where assembly_method LIKE '%' + @TEXTO_BUSCAR + '%'
				AND assembly_method LIKE '%' + @TEXTO_BUSCAR_2 + '%'
				AND assembly_method LIKE '%' + @TEXTO_BUSCAR_3 + '%'
				AND assembly_method LIKE '%' + @TEXTO_BUSCAR_4 + '%'
				AND assembly_method LIKE '%' + @TEXTO_BUSCAR_5 + '%'
PRINT 'A3'	
--LO CONSULTO Y LE AÑADO LOS JOBS:

	IF @TAREAS = 1
		BEGIN
			SELECT 
				TIPO, 
				ELEMENTO, [SP_HELPTEXT],
				CODIGO
			FROM 
				(
					SELECT 
						TIPO             [TIPO] ,
						ELEMENTO              [ELEMENTO],
						'PAH ' + '''' + ELEMENTO + ''''  [SP_HELPTEXT] ,
						LEFT(CODIGO,100) +'....................USA PAH PARA VER MÁS' [CODIGO]  
					FROM 
						#T 
					
					UNION
					SELECT 
						C1.TIPO, 
						C1.ELEMENTO, 
						C1.[SP_HELPTEXT], 
						C1.CODIGO 
					FROM 
						--JOBS
						(
							SELECT DISTINCT
								'JOB' TIPO,
								ISNULL(SYSJOBS.NAME,'') ELEMENTO,
								'' SP_HELPTEXT,
								SYSJOBSS.COMMAND CODIGO
							FROM  
								MSDB.DBO.SYSJOBSTEPS AS SYSJOBSS WITH(NOLOCK) 

								INNER JOIN 
								MSDB.DBO.SYSJOBS AS SYSJOBS WITH(NOLOCK) 
								ON SYSJOBS.JOB_ID = SYSJOBSS.JOB_ID
							WHERE  
								SYSJOBSS.COMMAND LIKE '%'	+ @TEXTO_BUSCAR	 + '%'
								AND SYSJOBSS.COMMAND LIKE '%'	+ @TEXTO_BUSCAR_2 + '%'
								AND SYSJOBSS.COMMAND LIKE '%'	+ @TEXTO_BUSCAR_3 + '%'
								AND SYSJOBSS.COMMAND LIKE '%'	+ @TEXTO_BUSCAR_4 + '%'
								AND SYSJOBSS.COMMAND LIKE '%'	+ @TEXTO_BUSCAR_5 + '%'
								OR (
								 SYSJOBS.NAME  LIKE '%' +		@TEXTO_BUSCAR	 + '%'
								AND SYSJOBS.NAME  LIKE '%' +	@TEXTO_BUSCAR_2	 + '%'
								AND SYSJOBS.NAME  LIKE '%' +	@TEXTO_BUSCAR_3	 + '%'
								AND SYSJOBS.NAME  LIKE '%' +	@TEXTO_BUSCAR_4	 + '%'
								AND SYSJOBS.NAME  LIKE '%' +	@TEXTO_BUSCAR_5	 + '%'
								)
						)C1					

					UNION 
					
					SELECT 
						ICPL1.TIPO, 
						ICPL1.ELEMENTO, 
						ICPL1.[SP_HELPTEXT], 
						ICPL1.CODIGO 
					FROM
						-- AÑADO TEXTO_ICPL
						(
							SELECT DISTINCT
								'ICPL' TIPO,
								CONVERT(VARCHAR,ID_TAREA) +' - '+ ISNULL(PROGRAMADAS.DESCRIPCION_TAREA,'') ELEMENTO,
								'' SP_HELPTEXT,
								PROGRAMADAS.TEXTO_ICPL CODIGO
							FROM  
								N_TAREAS_PROGRAMADAS AS PROGRAMADAS WITH(NOLOCK) 
							WHERE 
								TEXTO_ICPL LIKE '%' +		@TEXTO_BUSCAR	 + '%'
								AND TEXTO_ICPL LIKE '%' +	@TEXTO_BUSCAR_2	 + '%'
								AND TEXTO_ICPL LIKE '%' +	@TEXTO_BUSCAR_3	 + '%'
								AND TEXTO_ICPL LIKE '%' +	@TEXTO_BUSCAR_4	 + '%'
								AND TEXTO_ICPL LIKE '%' +	@TEXTO_BUSCAR_5	 + '%'
							
						) ICPL1
				) T
			ORDER BY 
				CASE 
					WHEN TIPO = 'P' THEN 1
					WHEN TIPO = 'FN' THEN 2
					WHEN TIPO = 'TR' THEN 3
					WHEN TIPO = 'V' THEN 4
					WHEN TIPO = 'JOB' THEN 5
					WHEN TIPO = 'ICPL' THEN 6
					ELSE 7 
				END ASC-- ORDENO PARA QUE APAREZCA LO QUE YO QUIERA PRIMERO
				PRINT 'A4'
		END
	ELSE
		BEGIN
			SELECT 
				TIPO, 
				ELEMENTO, [SP_HELPTEXT],
				CODIGO
			FROM 
				(
					SELECT 
						TIPO             [TIPO] ,
						ELEMENTO              [ELEMENTO],
						'PAH ' + '''' + ELEMENTO + ''''  [SP_HELPTEXT] ,
						LEFT(CODIGO,100) +'....................USA PAH PARA VER MÁS' [CODIGO]  
 					FROM 
						#T 
					
					UNION
					SELECT 
						C1.TIPO, 
						C1.ELEMENTO, 
						C1.[SP_HELPTEXT], 
						C1.CODIGO 
					FROM 
						--JOBS
						(
							SELECT DISTINCT
								'JOB' TIPO,
								ISNULL(SYSJOBS.NAME,'') ELEMENTO,
								'' SP_HELPTEXT,
								SYSJOBSS.COMMAND CODIGO
							FROM  
								MSDB.DBO.SYSJOBSTEPS AS SYSJOBSS WITH(NOLOCK)

								INNER JOIN 
								MSDB.DBO.SYSJOBS AS SYSJOBS WITH(NOLOCK)
								ON SYSJOBS.JOB_ID = SYSJOBSS.JOB_ID
							WHERE  
								SYSJOBSS.COMMAND LIKE '%' +	@TEXTO_BUSCAR	+ '%'
								AND SYSJOBSS.COMMAND LIKE '%' + @TEXTO_BUSCAR_2	+ '%'
								AND SYSJOBSS.COMMAND LIKE '%' + @TEXTO_BUSCAR_3	+ '%'
								AND SYSJOBSS.COMMAND LIKE '%' + @TEXTO_BUSCAR_4	+ '%'
								AND SYSJOBSS.COMMAND LIKE '%' + @TEXTO_BUSCAR_5	+ '%'
								OR
								(
								SYSJOBS.NAME  LIKE '%' +	@TEXTO_BUSCAR	 + '%'
								AND SYSJOBS.NAME  LIKE '%' +	@TEXTO_BUSCAR_2	 + '%'
								AND SYSJOBS.NAME  LIKE '%' +	@TEXTO_BUSCAR_3	 + '%'
								AND SYSJOBS.NAME  LIKE '%' +	@TEXTO_BUSCAR_4	 + '%'
								AND SYSJOBS.NAME  LIKE '%' +	@TEXTO_BUSCAR_5	 + '%'
								)
						)C1					
				) T 
			ORDER BY 
				CASE 
					WHEN TIPO = 'P' THEN 1
					WHEN TIPO = 'FN' THEN 2
					WHEN TIPO = 'TR' THEN 3
					WHEN TIPO = 'V' THEN 4
					WHEN TIPO = 'JOB' THEN 5
					WHEN TIPO = 'ICPL' THEN 6
					ELSE 7 
				END ASC-- ORDENO PARA QUE APAREZCA LO QUE YO QUIERA PRIMERO
				PRINT 'A5'
		END
END

GO
/****** Object:  StoredProcedure [dbo].[PAC]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- 07/05/16. O.RODRIGO
-- Da información sobre un campo (haciendo like)

CREATE PROCEDURE [dbo].[PAC] (@CAMPO VARCHAR(100)) AS
BEGIN
	SELECT 
		CAMPO,
		TABLA,
		DESCRIPCION,
		POSICION,
		TIPO,
		DIMENSION, 
		PERMITE_NULOS,
		DEFECTO,
		CLAVE,
		INDICES,
		[COLLATE],
		GRUPO_FICHEROS,
		KBYTES,
		MBYTES,
		GROWTH,
		N_FILES,
		name,
		object_id,
		data_space_id
	FROM 
		V_SQL WHERE CAMPO LIKE '%' + @CAMPO +  '%' 
	ORDER BY 
		CASE 
			WHEN CAMPO = @CAMPO THEN 1 
					    ELSE 2
		END,
		CAMPO,
		TABLA
	
END



GO
/****** Object:  StoredProcedure [dbo].[PAF]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Autor: Edgar García
-- Fecha: 10/04/2018
-- Mapeo: Javier Rodriguez

CREATE PROCEDURE [dbo].[PAF]
(
	@ENTRADA VARCHAR(800) = ''
)
AS


DECLARE @AUX INT = 0
DECLARE @SQLSTRING NVARCHAR(MAX) = N''

DECLARE @SALIDA1 NVARCHAR(800)
DECLARE @SALIDA2 NVARCHAR(800)
DECLARE @SALIDA3 NVARCHAR(800)
DECLARE @SALIDA4 NVARCHAR(800)
DECLARE @SALIDA5 NVARCHAR(800)
DECLARE @SALIDA6 NVARCHAR(800)

CREATE TABLE #FUENTE
(	INDICE INT IDENTITY(1,1),
	COMENTARIO NVARCHAR(2),
	A NVARCHAR(20),
	B NVARCHAR(20),
	C NVARCHAR(20),
	D NVARCHAR(20),
	E NVARCHAR(20),
	F NVARCHAR(20),
	G NVARCHAR(20),
	H NVARCHAR(20),
	I NVARCHAR(20),
	J NVARCHAR(20),
	K NVARCHAR(20),
	L NVARCHAR(20),
	M NVARCHAR(20),
	N NVARCHAR(20),
	Ñ NVARCHAR(20),
	O NVARCHAR(20),
	P NVARCHAR(20),
	Q NVARCHAR(20),
	R NVARCHAR(20),
	S NVARCHAR(20),
	T NVARCHAR(20),
	U NVARCHAR(20),
	V NVARCHAR(20),
	W NVARCHAR(20),
	X NVARCHAR(20),
	Y NVARCHAR(20),
	Z NVARCHAR(20),
	[0] NVARCHAR(20),
	[1] NVARCHAR(20),
	[2] NVARCHAR(20),
	[3] NVARCHAR(20),
	[4] NVARCHAR(20),
	[5] NVARCHAR(20),
	[6] NVARCHAR(20),
	[7] NVARCHAR(20),
	[8] NVARCHAR(20),
	[9] NVARCHAR(20),
	[!] NVARCHAR(20),
	[#] NVARCHAR(20),
	[$] NVARCHAR(20),
	[%] NVARCHAR(20),
	[&] NVARCHAR(20),
	[(] NVARCHAR(20),
	[)] NVARCHAR(20),
	[*] NVARCHAR(20),
	[,] NVARCHAR(20),
	[-] NVARCHAR(20),
	[.] NVARCHAR(20),
	[/] NVARCHAR(20),
	[:] NVARCHAR(20),
	[;] NVARCHAR(20),
	[<] NVARCHAR(20),
	[>] NVARCHAR(20),
	[?] NVARCHAR(20),
	[@] NVARCHAR(20),
	[_] NVARCHAR(20),
	[ ] NVARCHAR(20),
	[=] NVARCHAR(20),
	[^] NVARCHAR(20)
) 

INSERT INTO #FUENTE (COMENTARIO,A,B,C,D,E,F,G,H,I,J,K,L,M,N,[Ñ],O,P,Q,R,S,T,U,V,W,X,Y,Z,[0],[1],[2],[3],[4],[5],[6],[7],[8],[9],[!],[#],[$],[%],[&],[(],[)],[*],[,],[-],[.],[/],[:],[;],[<],[>],[?],[@],[_],[ ],[=], [^]) 
	SELECT N'--', N' █████╗ ' A, N'██████╗ 'B, N' ██████╗' C, N'██████╗ 'D, N'███████╗'E, N'███████╗'F, N' ██████╗ 'G, N'██╗  ██╗'H, N'██╗'I, N'     ██╗'J, N'██╗  ██╗'K, N'██╗     'L, N'███╗   ███╗'M, N'███╗   ██╗'N,N'   ████╗  ' Ñ, N' ██████╗ 'O, N'██████╗ 'P, N' ██████╗ 'Q, N'██████╗ 'R, N'███████╗'S, N'████████╗'T, N'██╗   ██╗'U, N'██╗   ██╗'V, N'██╗    ██╗'W, N'██╗  ██╗'X, N'██╗   ██╗'Y, N'███████╗' Z, N' ██████╗ '[0], N' ██╗'[1], N'██████╗ '[2], N'██████╗ '[3], N'██╗  ██╗'[4], N'███████╗'[5], N' ██████╗ '[6], N'███████╗' [7], N' █████╗ ' [8], N' █████╗ ' [9], N'██╗' [!], N' ██╗ ██╗ ' [#], N'▄▄███▄▄·' [$], N'██╗ ██╗' [%], N'   ██╗   ' [$], N' ██╗' [(], N'██╗ ' [)], N'      ' [*], N'   ' [,], N'      ' [-], N'   ' [.], N'    ██╗' [/], N'   '[:], N'   ' [;], N'  ██╗' [<], N'██╗  '[>], N'██████╗ ' [?], N' ██████╗ '[@],  N'        ' [_], N'		' [ ],N'        ' [=],N'   ██╗   ' [^]
	UNION ALL																																																																																																								    		      	    
	SELECT N'--', N'██╔══██╗' A, N'██╔══██╗'B, N'██╔════╝' C, N'██╔══██╗'D, N'██╔════╝'E, N'██╔════╝'F, N'██╔════╝ 'G, N'██║  ██║'H, N'██║'I, N'     ██║'J, N'██║ ██╔╝'K, N'██║     'L, N'████╗ ████║'M, N'████╗  ██║'N,N'████╗═╝██╗' Ñ, N'██╔═══██╗'O, N'██╔══██╗'P, N'██╔═══██╗'Q, N'██╔══██╗'R, N'██╔════╝'S, N'╚══██╔══╝'T, N'██║   ██║'U, N'██║   ██║'V, N'██║    ██║'W, N'╚██╗██╔╝'X, N'╚██╗ ██╔╝'Y, N'╚══███╔╝' Z, N'██╔═████╗'[0], N'███║'[1], N'╚════██╗'[2], N'╚════██╗'[3], N'██║  ██║'[4], N'██╔════╝'[5], N'██╔════╝ '[6], N'╚════██║' [7], N'██╔══██╗' [8], N'██╔══██╗' [9],	N'██║' [!], N'████████╗' [#], N'██╔════╝' [$], N'╚═╝██╔╝' [%], N'   ██║   ' [$], N'██╔╝' [(], N'╚██╗' [)], N'▄ ██╗▄' [*], N'   ' [,], N'      ' [-], N'   ' [.], N'   ██╔╝' [/], N'██╗'[:], N'██╗' [;], N' ██╔╝' [<], N'╚██╗ '[>], N'╚════██╗' [?], N'██╔═══██╗'[@], N'        ' [_], N'		' [ ],N'███████╗' [=],N' ██╔═██╗ ' [^]
	UNION ALL																																																																																																								    		      	         
	SELECT N'--', N'███████║' A, N'██████╔╝'B, N'██║     ' C, N'██║  ██║'D, N'█████╗  'E, N'█████╗  'F, N'██║  ███╗'G, N'███████║'H, N'██║'I, N'     ██║'J, N'█████╔╝ 'K, N'██║     'L, N'██╔████╔██║'M, N'██╔██╗ ██║'N,N'██╔██╗ ██║' Ñ, N'██║   ██║'O, N'██████╔╝'P, N'██║   ██║'Q, N'██████╔╝'R, N'███████╗'S, N'   ██║   'T, N'██║   ██║'U, N'██║   ██║'V, N'██║ █╗ ██║'W, N' ╚███╔╝ 'X, N' ╚████╔╝ 'Y, N'  ███╔╝ ' Z, N'██║██╔██║'[0], N'╚██║'[1], N' █████╔╝'[2], N' █████╔╝'[3], N'███████║'[4], N'███████╗'[5], N'███████╗ '[6], N'    ██╔╝' [7], N'╚█████╔╝' [8], N'╚██████║' [9],	N'██║' [!], N'╚██╔═██╔╝' [#], N'███████╗' [$], N'  ██╔╝ ' [%], N'████████╗' [$], N'██║ ' [(], N' ██║' [)], N' ████╗' [*], N'   ' [,], N'█████╗' [-], N'   ' [.], N'  ██╔╝ ' [/], N'╚═╝'[:], N'╚═╝' [;], N'██╔╝ ' [<], N' ╚██╗'[>], N'  ▄███╔╝' [?], N'██║██╗██║'[@], N'        ' [_], N'		' [ ],N'╚══════╝' [=],N'██╔╝ ╚██╗' [^]
	UNION ALL																																																																																																								    		      	    
	SELECT N'--', N'██╔══██║' A, N'██╔══██╗'B, N'██║     ' C, N'██║  ██║'D, N'██╔══╝  'E, N'██╔══╝  'F, N'██║   ██║'G, N'██╔══██║'H, N'██║'I, N'██   ██║'J, N'██╔═██╗ 'K, N'██║     'L, N'██║╚██╔╝██║'M, N'██║╚██╗██║'N,N'██║╚██╗██║' Ñ, N'██║   ██║'O, N'██╔═══╝ 'P, N'██║▄▄ ██║'Q, N'██╔══██╗'R, N'╚════██║'S, N'   ██║   'T, N'██║   ██║'U, N'╚██╗ ██╔╝'V, N'██║███╗██║'W, N' ██╔██╗ 'X, N'  ╚██╔╝  'Y, N' ███╔╝  ' Z, N'████╔╝██║'[0], N' ██║'[1], N'██╔═══╝ '[2], N' ╚═══██╗'[3], N'╚════██║'[4], N'╚════██║'[5], N'██╔═══██╗'[6], N'   ██╔╝ ' [7], N'██╔══██╗' [8], N' ╚═══██║' [9],	N'╚═╝' [!], N'████████╗' [#], N'╚════██║' [$], N' ██╔╝  ' [%], N'██╔═██╔═╝' [$], N'██║ ' [(], N' ██║' [)], N'▀╚██╔▀' [*], N'   ' [,], N'╚════╝' [-], N'   ' [.], N' ██╔╝  ' [/], N'██╗'[:], N'▄█╗' [;], N'╚██╗ ' [<], N' ██╔╝'[>], N'  ▀▀══╝ ' [?], N'██║██║██║'[@], N'        ' [_], N'		' [ ],N'███████╗' [=],N'╚═╝   ╚═╝' [^]
	UNION ALL																																																																																																								    		      	         
	SELECT N'--', N'██║  ██║' A, N'██████╔╝'B, N'╚██████╗' C, N'██████╔╝'D, N'███████╗'E, N'██║     'F, N'╚██████╔╝'G, N'██║  ██║'H, N'██║'I, N'╚█████╔╝'J, N'██║  ██╗'K, N'███████╗'L, N'██║ ╚═╝ ██║'M, N'██║ ╚████║'N,N'██║ ╚████║' Ñ, N'╚██████╔╝'O, N'██║     'P, N'╚██████╔╝'Q, N'██║  ██║'R, N'███████║'S, N'   ██║   'T, N'╚██████╔╝'U, N' ╚████╔╝ 'V, N'╚███╔███╔╝'W, N'██╔╝ ██╗'X, N'   ██║   'Y, N'███████╗' Z, N'╚██████╔╝'[0], N' ██║'[1], N'███████╗'[2], N'██████╔╝'[3], N'     ██║'[4], N'███████║'[5], N'╚██████╔╝'[6], N'   ██║  ' [7], N'╚█████╔╝' [8], N' █████╔╝' [9],	N'██╗' [!], N'╚██╔═██╔╝' [#], N'███████║' [$], N'██╔╝██╗' [%], N'██████║  ' [$], N'╚██╗' [(], N'██╔╝' [)], N'  ╚═╝ ' [*], N'▄█╗' [,], N'      ' [-], N'██╗' [.], N'██╔╝   ' [/], N'╚═╝'[:], N'▀═╝' [;], N' ╚██╗' [<], N'██╔╝ '[>], N'  ██╗   ' [?], N'╚█║████╔╝'[@], N'███████╗' [_], N'		' [ ],N'╚══════╝' [=],N'	   ' [^]
	UNION ALL																																																																																																								     		      	
	SELECT N'--', N'╚═╝  ╚═╝' A, N'╚═════╝ 'B, N' ╚═════╝' C, N'╚═════╝ 'D, N'╚══════╝'E, N'╚═╝     'F, N' ╚═════╝ 'G, N'╚═╝  ╚═╝'H, N'╚═╝'I, N' ╚════╝ 'J, N'╚═╝  ╚═╝'K, N'╚══════╝'L, N'╚═╝     ╚═╝'M, N'╚═╝  ╚═══╝'N,N'╚═╝  ╚═══╝' Ñ, N' ╚═════╝ 'O, N'╚═╝     'P, N' ╚══▀▀═╝ 'Q, N'╚═╝  ╚═╝'R, N'╚══════╝'S, N'   ╚═╝   'T, N' ╚═════╝ 'U, N'  ╚═══╝  'V, N' ╚══╝╚══╝ 'W, N'╚═╝  ╚═╝'X, N'   ╚═╝   'Y, N'╚══════╝' Z, N' ╚═════╝ '[0], N' ╚═╝'[1], N'╚══════╝'[2], N'╚═════╝ '[3], N'     ╚═╝'[4], N'╚══════╝'[5], N' ╚═════╝ '[6], N'   ╚═╝  ' [7], N' ╚════╝ ' [8], N' ╚════╝ ' [9],	N'╚═╝' [!], N' ╚═╝ ╚═╝ ' [#], N'╚═▀▀▀══╝' [$], N'╚═╝ ╚═╝' [%], N'╚═════╝  ' [$], N' ╚═╝' [(], N'╚═╝ ' [)], N'      ' [*], N'╚═╝' [,], N'      ' [-], N'╚═╝' [.], N'╚═╝    ' [/], N'   '[:], N'   ' [;], N'  ╚═╝' [<], N'╚═╝  '[>], N'  ╚═╝   ' [?], N' ╚╝╚═══╝ '[@], N'╚══════╝' [_], N'		' [ ],N'	' [=],N'	   ' [^]



SET @AUX = LEN(@ENTRADA)


DECLARE @TOTALCHAR INT = LEN(@ENTRADA)
DECLARE @CONT INT = @TOTALCHAR

BEGIN TRY

WHILE @CONT >= 1
BEGIN

    IF @CONT % 1 = 0 AND @CONT + 1 <= @TOTALCHAR
    BEGIN
	SET @ENTRADA = STUFF(@ENTRADA, @CONT + 1, 0, ']+[')
    END

    SET @CONT = @CONT - 1
END


SET @SQLSTRING = N'SELECT COMENTARIO + ['+ @ENTRADA + '] FROM #FUENTE'
PRINT @SQLSTRING
EXEC SP_EXECUTESQL @SQLSTRING

END TRY
BEGIN CATCH
	SELECT 'ALGUNO DE LOS CARACTERES ESPECIALES NO ESTÁ MAPEADO, PRUEBE A QUITARLOS'
END CATCH


GO
/****** Object:  StoredProcedure [dbo].[PAH]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Edgar
-- Create date: 06/06/2017
-- Description:	PA que devuelve un procedimiento con las líneas sin los fallos de SP_HELPTEXT
-- =============================================


CREATE PROCEDURE [dbo].[PAH](@TEXTO VARCHAR(100))
AS
     BEGIN
     
     SET NOCOUNT ON;

         DECLARE @OBJNAME NVARCHAR(776)= @TEXTO;
         DECLARE @OBJECTTEXT NVARCHAR(MAX)= '';
         DECLARE @SYSCOMTEXT NVARCHAR(MAX);
         DECLARE @LINELEN INT;
         DECLARE @LINEEND BIT= 0;
         DECLARE @COMMENTTEXT TABLE
         (LINEID INT IDENTITY(1, 1),
          TEXT   NVARCHAR(MAX)
         );
	
	IF NOT EXISTS (SELECT 1/0
		FROM SYS.SYSCOMMENTS
		WHERE ID = OBJECT_ID(@OBJNAME)
		AND ENCRYPTED = 0)
	BEGIN
		SELECT @TEXTO + ' NO EXISTE EN ' + @@SERVERNAME +'.'+ DB_NAME()
		RETURN 0
	END
          
         DECLARE MS_CRS_SYSCOM CURSOR LOCAL
         FOR
             SELECT TEXT
             FROM SYS.SYSCOMMENTS
             WHERE ID = OBJECT_ID(@OBJNAME)
                   AND ENCRYPTED = 0
             ORDER BY NUMBER,
                      COLID
         FOR READ ONLY;
         OPEN MS_CRS_SYSCOM;
         FETCH NEXT FROM MS_CRS_SYSCOM INTO @SYSCOMTEXT;
         WHILE @@FETCH_STATUS >= 0
             BEGIN
                 SET @LINELEN = CHARINDEX(CHAR(10), @SYSCOMTEXT);
                 WHILE @LINELEN > 0
                     BEGIN
                         SELECT @OBJECTTEXT+=LEFT(@SYSCOMTEXT, @LINELEN),
                                @SYSCOMTEXT = SUBSTRING(@SYSCOMTEXT, @LINELEN+1, 4000),
                                @LINELEN = CHARINDEX(CHAR(10), @SYSCOMTEXT),
                                @LINEEND = 1;
                         INSERT INTO @COMMENTTEXT(TEXT)
                         VALUES(@OBJECTTEXT);
                         SET @OBJECTTEXT = '';
                     END;
                 IF @LINELEN = 0
                     SET @OBJECTTEXT+=@SYSCOMTEXT;
                     ELSE
                 SELECT @OBJECTTEXT = @SYSCOMTEXT,
                        @LINELEN = 0;
                 FETCH NEXT FROM MS_CRS_SYSCOM INTO @SYSCOMTEXT;
             END;
         CLOSE MS_CRS_SYSCOM;
         DEALLOCATE MS_CRS_SYSCOM;
         INSERT INTO @COMMENTTEXT(TEXT)
                SELECT @OBJECTTEXT;
         
	 SELECT TEXT
         FROM @COMMENTTEXT
         ORDER BY LINEID;
     
     END;

GO
/****** Object:  StoredProcedure [dbo].[PAP]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------------------------------------------------------   
-- PA QUE ME MONTA CADENA DE PRUEBAS DE PAS  
-- AUTOR: JJ   
-- FECHA: 27/3/2007  
------------------------------------------------------------------------------------------------------------------------------------  
-- ROBERTO RAMIRO  
-- 28/01/2015  
-- DEVOLVEMOS MAX SI MAX_LENGTH ES -1. NO DECLARAMOS @RETCODE SI YA ESTA ENTRE LOS PARAMETROS DEL PA  
------------------------------------------------------------------------------------------------------------------------------------  
-- EDGAR
-- 17/09/2020
-- ARREGLOS VARIOS: ENTRE ELLOS YA NO SACARÁ EXEC ' @RETCODE = ' CUANDO HAYA UN PARÁMETRO RETCODE DE SALIDA
------------------------------------------------------------------------------------------------------------------------------------

-- █████╗ ██╗   ██╗██╗███████╗ ██████╗ 		██╗███╗   ███╗██████╗  ██████╗ ██████╗ ████████╗ █████╗ ███╗   ██╗████████╗███████╗
--██╔══██╗██║   ██║██║██╔════╝██╔═══██╗		██║████╗ ████║██╔══██╗██╔═══██╗██╔══██╗╚══██╔══╝██╔══██╗████╗  ██║╚══██╔══╝██╔════╝
--███████║██║   ██║██║███████╗██║   ██║		██║██╔████╔██║██████╔╝██║   ██║██████╔╝   ██║   ███████║██╔██╗ ██║   ██║   █████╗  
--██╔══██║╚██╗ ██╔╝██║╚════██║██║   ██║		██║██║╚██╔╝██║██╔═══╝ ██║   ██║██╔══██╗   ██║   ██╔══██║██║╚██╗██║   ██║   ██╔══╝  
--██║  ██║ ╚████╔╝ ██║███████║╚██████╔╝		██║██║ ╚═╝ ██║██║     ╚██████╔╝██║  ██║   ██║   ██║  ██║██║ ╚████║   ██║   ███████╗
--╚═╝  ╚═╝  ╚═══╝  ╚═╝╚══════╝ ╚═════╝ 		╚═╝╚═╝     ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝
--CUALQUIER CAMBIO REALIZADO EN ESTE PA SERÁ AUTOMÁTICAMENTE REEMPLAZADO DESDE ICPM EN ISERVER1, POR LO QUE SE PERDERÁ.
------------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[PAP]
	(
		@NOMBRE_PA AS VARCHAR(200)   
	)
AS  
  
DECLARE @ID_PA AS INTEGER  
DECLARE @CADENA_PA AS VARCHAR(8000)  
DECLARE @CADENA_PA2 AS VARCHAR(8000)  
DECLARE @CADENA_PA3 AS VARCHAR(8000)  
DECLARE @CADENA_PA4 AS VARCHAR(8000)  
DECLARE @NOMBRE AS VARCHAR(30)  
DECLARE @TIPO AS VARCHAR(30)  
DECLARE @DIMENSION AS VARCHAR(30)  
DECLARE @VALOR_DEFECTO AS VARCHAR(30)  
DECLARE @OUT AS VARCHAR(30)  
DECLARE @ORDER AS INTEGER  
DECLARE @AUX AS VARCHAR(30)  
DECLARE @TIENE_RETCODE AS BIT  
DECLARE @TIENE_RETCODE_OUTPUT AS BIT = 0
   
  
SET @CADENA_PA = ''  
SET @CADENA_PA2 = ''  
SET @CADENA_PA3 = 'EXEC @RETCODE = ' + @NOMBRE_PA + ' ' + CHAR(10)  
SET @CADENA_PA4 = ''  
  
SET @TIENE_RETCODE = 0  
   
SELECT @ID_PA = OBJECT_ID,   
	@TIPO  =  TYPE  
FROM 
	SYS.ALL_OBJECTS  
WHERE 
	OBJECT_ID = OBJECT_ID(@NOMBRE_PA)  
  
   
SET @NOMBRE = ''  

SELECT  TOP 1  
	@NOMBRE = NAME,  
	@OUT = CASE  
	WHEN IS_OUTPUT = 1 THEN 'OUTPUT'  
		ELSE ''  
	END,  
	@TIPO = UPPER(TYPE_NAME (USER_TYPE_ID)),    
	@DIMENSION = CASE  
	WHEN TYPE_NAME (USER_TYPE_ID) IN ('VARCHAR', 'CHAR', 'NVARCHAR') THEN '(' + CASE WHEN MAX_LENGTH = -1 THEN 'MAX' ELSE CAST(MAX_LENGTH AS VARCHAR(30)) END +')'   
		WHEN TYPE_NAME (USER_TYPE_ID) IN ('VARBINARY') THEN '(MAX)'
		ELSE ''  
	END,  
	@VALOR_DEFECTO = CASE  
	WHEN TYPE_NAME (USER_TYPE_ID) IN ('VARCHAR', 'CHAR', 'NVARCHAR') THEN  CHAR(39) + CHAR(39)       
		WHEN TYPE_NAME (USER_TYPE_ID) IN ('DATETIME', 'SMALLDATETIME') THEN 'NULL'
		WHEN TYPE_NAME (USER_TYPE_ID) IN ('XML') THEN CHAR(39) +'<ROOT></ROOT>'+ CHAR(39)     
		ELSE '0'  
	END,  
	@ORDER = PARAMETER_ID   
FROM 
	SYS.ALL_PARAMETERS   
WHERE 
	OBJECT_ID = @ID_PA  
ORDER BY 
	PARAMETER_ID  
  
  
WHILE @NOMBRE <> ''  
BEGIN  
	IF @NOMBRE like '%RETCODE%' SET @TIENE_RETCODE = 1  
	
	IF @NOMBRE like '%RETCODE%'AND @OUT = 'OUTPUT'
	BEGIN
		SET @TIENE_RETCODE_OUTPUT = 1
	END

	DECLARE @TABULACIONES VARCHAR(MAX) = ''
	DECLARE @LONGITUD_MAX INT = 0
	DECLARE @VUELTAS INT = 0

	SELECT 
		@LONGITUD_MAX = MAX(LEN(NAME))
	FROM 
		SYS.ALL_PARAMETERS   
	WHERE 
		OBJECT_ID = @ID_PA 

	SET @VUELTAS = 0
	SET @TABULACIONES = ''

	WHILE @VUELTAS < @LONGITUD_MAX - LEN(@NOMBRE)
	BEGIN
		SET @TABULACIONES = @TABULACIONES + CHAR(32)
		SET @VUELTAS = @VUELTAS +1
	END

	SET @CADENA_PA = @CADENA_PA + 'DECLARE ' + @NOMBRE +' '+ @TABULACIONES + @TIPO + @DIMENSION + CHAR(10)  
	SET @CADENA_PA2 = @CADENA_PA2 + 'SET ' + @NOMBRE + ' = ' + @VALOR_DEFECTO + CHAR(10)  
	SET @CADENA_PA3 = @CADENA_PA3 + CHAR(9)+@NOMBRE + ' ' + @OUT + ',' + CHAR(10)  
	
	IF @OUT <> ''  
	BEGIN  
		SET @AUX = REPLACE(@NOMBRE, '@', '')  
		SET @AUX = REPLACE(@AUX, '_', ' ')  
		SET @CADENA_PA4 = @CADENA_PA4 + 'PRINT ' + CHAR(39) + @AUX  + ': ' + CHAR(39) + ' + CAST(' +  @NOMBRE + ' AS VARCHAR(MAX))' + CHAR(10)  
	END  
      
  
	SET @NOMBRE = ''  

	SELECT  TOP 1  
		@NOMBRE = NAME,  
		@OUT = CASE  
		WHEN IS_OUTPUT = 1 THEN 'OUTPUT'  
			ELSE ''  
		END,  
		@TIPO = UPPER(TYPE_NAME (USER_TYPE_ID)),  
		@DIMENSION = CASE  
		WHEN TYPE_NAME (USER_TYPE_ID) IN ('VARCHAR', 'CHAR', 'NVARCHAR') THEN '(' + CASE WHEN MAX_LENGTH = -1 THEN 'MAX' ELSE CAST(MAX_LENGTH AS VARCHAR(30)) END +')'   
		WHEN TYPE_NAME (USER_TYPE_ID) IN ('VARBINARY') THEN '(MAX)'		
			ELSE ''  
		END,  
		@VALOR_DEFECTO = CASE  
		WHEN TYPE_NAME (USER_TYPE_ID) IN ('VARCHAR', 'CHAR', 'NVARCHAR') THEN  CHAR(39) + CHAR(39)       
		WHEN TYPE_NAME (USER_TYPE_ID) IN ('DATETIME', 'SMALLDATETIME') THEN 'NULL'
		WHEN TYPE_NAME (USER_TYPE_ID) IN ('XML') THEN CHAR(39) +'<ROOT></ROOT>'+ CHAR(39)
			ELSE '0'  
		END,  
		@ORDER = PARAMETER_ID  
	FROM 
		SYS.ALL_PARAMETERS   
	WHERE 
		OBJECT_ID = @ID_PA  
		AND PARAMETER_ID > @ORDER  
	ORDER BY 
		PARAMETER_ID  
 


END  
 

SET @VUELTAS = 0
SET @TABULACIONES = ''

WHILE @VUELTAS < @LONGITUD_MAX - LEN('@RETCODE')
BEGIN
	SET @TABULACIONES = @TABULACIONES + CHAR(32)
	SET @VUELTAS = @VUELTAS +1
END


IF  @TIENE_RETCODE_OUTPUT = 1
BEGIN
	SET @CADENA_PA3 = REPLACE(@CADENA_PA3,'EXEC @RETCODE = ','EXEC ')
END

IF @TIENE_RETCODE_OUTPUT = 0 SET @CADENA_PA4 = @CADENA_PA4 + 'PRINT ' + CHAR(39) + 'RETCODE: ' + CHAR(39) + ' + CAST(@RETCODE AS VARCHAR(10))' + CHAR(10)  
	SET @CADENA_PA3 = LEFT(@CADENA_PA3, LEN(@CADENA_PA3) - 2)  
IF @TIENE_RETCODE = 0  
	SET @CADENA_PA = @CADENA_PA + 'DECLARE @RETCODE'+' '+ @TABULACIONES+'INT ' + CHAR(10) + CHAR(10)  
ELSE  
	SET @CADENA_PA = @CADENA_PA + CHAR(10)  

SET @CADENA_PA = @CADENA_PA + @CADENA_PA2 + CHAR(10) + @CADENA_PA3 + CHAR(10) + CHAR(10) + @CADENA_PA4  
 
  
PRINT @CADENA_PA  
  


GO
/****** Object:  StoredProcedure [dbo].[PASE]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*-----------------------------------------------------------------------------------------------------------------------------------------------------

	NOMBRE DEL PROCEDIMIENTO:	PASE
	FECHA DE CREACIÓN: 		26/02/2020
	AUTOR:				EDGAR
	VSS:				RUTA VISUAL SOURCESAFE EJ: 

	FUNCIONAMIENTO:			FUNCIONAMIENTO

	PARAMETROS:			(OPCIONAL)
		PARAMETRO1 		INPUT	EXPLICACION
		PARAMETRO2 		OUTPUT	EXPLICACION

-------------------------------------------------------------------------------------------------------------------------------------------------------
--	FECHA DE MODIFICACIÓN:
--	AUTOR:
--	EXPLICACIÓN:	
------------------------------------------------------------------------------------------------------------------------------------------------------*/


CREATE PROCEDURE [dbo].[PASE] (@TABLA VARCHAR(100))
AS
DECLARE @CAMPOS VARCHAR(MAX) = ''

IF OBJECT_ID (N'v_sql', N'V') IS NULL 
BEGIN
	PRINT 'No existe V_SQL'
	RETURN -1
END
ELSE
BEGIN
	SELECT   
		@CAMPOS += CHAR(9)+C.COLUMN_NAME +','+CHAR(10) 

	FROM     
		INFORMATION_SCHEMA.COLUMNS C
		INNER JOIN INFORMATION_SCHEMA.TABLES T
		ON C.TABLE_NAME = T.TABLE_NAME
		AND C.TABLE_SCHEMA = T.TABLE_SCHEMA
		AND T.TABLE_TYPE = 'BASE TABLE'
	WHERE 
		C.TABLE_NAME = @TABLA
		AND C.COLUMN_NAME NOT LIKE '%PASS%' 
		AND C.COLUMN_NAME NOT LIKE '%PWD%' 
		AND C.COLUMN_NAME NOT LIKE '%CONTRASE_A%' 
	ORDER BY 
		ORDINAL_POSITION
	OPTION (RECOMPILE)
END

IF ISNULL(@CAMPOS ,'') = ''
BEGIN
	PRINT 'No existe la tabla '+ @TABLA
	RETURN -1
END

SET @CAMPOS = LEFT(@CAMPOS, LEN(@CAMPOS) - 2) + CHAR(10)

SELECT 'SELECT '+CHAR(10)+@CAMPOS+ 'FROM '+ CHAR(10) +CHAR(9)+@TABLA +' WITH(NOLOCK)' 'SELECT'



GO
/****** Object:  StoredProcedure [dbo].[PAT]    Script Date: 04/11/2020 13:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 07/05/16. O.RODRIGO
-- Da información sobre una tabla (haciendo like)

CREATE PROCEDURE [dbo].[PAT] (@TABLA VARCHAR(100)) AS
BEGIN
	SELECT 
		TABLA,
		CAMPO,
		DESCRIPCION,
		POSICION,
		TIPO,
		DIMENSION, 
		PERMITE_NULOS,
		DEFECTO,
		CLAVE,
		INDICES,
		[COLLATE],
		GRUPO_FICHEROS,
		KBYTES,
		MBYTES,
		GROWTH,
		N_FILES,
		name,
		object_id,
		data_space_id

	FROM 
		V_SQL WHERE TABLA LIKE '%' + @TABLA +  '%' 
	ORDER BY 
		CASE 
			WHEN TABLA = @TABLA THEN 1 
					    ELSE 2
		END,
		TABLA,
		POSICION
		

	IF (SELECT COUNT(1) FROM V_SQL WHERE TABLA = @TABLA) > 0  
	BEGIN
		EXEC PA_INF_TABLA @TABLA
	END
	


	SELECT '['+CONVERT(VARCHAR, CAMPO) + ']' +REPLICATE(' ',(SELECT MAX(LEN(CAMPO)) FROM V_SQL WHERE TABLA = @TABLA)+1 - LEN(CAMPO))+ UPPER(CONVERT(VARCHAR,TIPO)) + REPLACE('('+ CONVERT(VARCHAR,DIMENSION) +') ','(0)','') + 
CASE 
       WHEN PERMITE_NULOS = 1 AND CAMPO = (SELECT TOP 1 CAMPO FROM V_SQL WHERE TABLA = @TABLA ORDER BY POSICION DESC) THEN 'NULL'
       WHEN PERMITE_NULOS <> 1 AND CAMPO = (SELECT TOP 1 CAMPO FROM V_SQL WHERE TABLA = @TABLA ORDER BY POSICION DESC) THEN 'NOT NULL' 
       WHEN PERMITE_NULOS = 1 THEN 'NULL,'
       WHEN PERMITE_NULOS <> 1 THEN 'NOT NULL,' 
END 'TABLA TEMPORAL' FROM V_SQL WHERE TABLA = @TABLA
ORDER BY POSICION

END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "STOCK"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 246
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ARTICULOS"
            Begin Extent = 
               Top = 6
               Left = 284
               Bottom = 136
               Right = 492
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_ARTICULOS_STOCK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_ARTICULOS_STOCK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "U"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 246
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "P"
            Begin Extent = 
               Top = 34
               Left = 342
               Bottom = 130
               Right = 550
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_USUARIOS_PERFILES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_USUARIOS_PERFILES'
GO
USE [master]
GO
ALTER DATABASE [ARCIPRESTE3] SET  READ_WRITE 
GO
