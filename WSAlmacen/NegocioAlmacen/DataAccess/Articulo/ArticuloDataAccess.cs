using NegocioAlmacen.Helpers;
using DatosAlmacen.Articulos;
using NegocioAlmacen.DataAccess.Articulo.DTO;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Text;
using System.Security.Cryptography;
using System.IO;
using NegocioAlmacen.DataAccess.Pedido.DTO;

namespace NegocioAlmacen.DataAccess.Articulo
{
    public class ArticuloDataAccess
    {

        //MÉtODO DE CREAR ARTICULO
        public CreateArticleResponse CrearArticulo(CreateArticleRequest newArt)
         {
             try
             {
                 using (var context = new ArticulosEntities())
                 {
                     ObjectParameter RETCODE = new ObjectParameter("RETCODE", typeof(int));
                     ObjectParameter MENSAJE = new ObjectParameter("MENSAJE", typeof(string));


                    string cadenaImagen = newArt.Imagen.Replace("data:image/png;base64,", "").Replace("data:image/jpeg;base64,", "");
                    byte[] imgBinary = Convert.FromBase64String(cadenaImagen);

                    context.PA_AÑADIR_ARTICULO(newArt.Nombre, newArt.Descripcion, newArt.Fabricante, newArt.Peso, newArt.Alto, newArt.Largo, newArt.Ancho, newArt.Precio, imgBinary, RETCODE, MENSAJE);

                    //AÑADIMOS EL STOCK INICIAL
                    var consulta = context.ARTICULOS.Where(art => art.NOMBRE == newArt.Nombre).FirstOrDefault();
                    context.PA_AÑADIR_STOCK(consulta.ID_ARTICULO, newArt.Stock, RETCODE, MENSAJE);

                    if ((int)RETCODE.Value < 0)
                     {
                         throw new Exception("Error no controlado");
                     }

                     if ((int)RETCODE.Value > 0)
                     {
                         throw new Exception(MENSAJE.Value.ToString());
                     }

                     return new CreateArticleResponse()
                     {
                         Mensaje = MENSAJE.Value.ToString()
                     };
                 }
             }
             catch (Exception ex)
             {
                 return new CreateArticleResponse()
                 {
                     Mensaje = ex.Message
                 };
             }

         }

        //MÉtODO DE BORRAR ARTICULO
        public DeleteArticleResponse DeleteArticulo(DeleteArticleRequest delArt)
        {
            try
            {
                using (var context = new ArticulosEntities())
                {
                    ObjectParameter RETCODE = new ObjectParameter("RETCODE", typeof(int));
                    ObjectParameter MENSAJE = new ObjectParameter("MENSAJE", typeof(string));

                    var consulta = context.V_ARTICULOS_STOCK.Where(art => art.ID_ARTICULO == delArt.ID_Articulo).FirstOrDefault();

                    //COMPROBAMOS SI SE PUEDE ELIMINAR EL ARTICULO SEGUN SI TIENE STOCK O NO
                    if (consulta.CANTIDAD == 0)
                    {
                        context.PA_BORRAR_ARTICULO(delArt.ID_Articulo, RETCODE, MENSAJE);
                    }
                    else
                    {
                        throw new Exception("No se puede eliminar el articulo porque aun posee stock en el almacén");
                    }
                    

                    if ((int)RETCODE.Value < 0)
                    {
                        throw new Exception("Error no controlado");
                    }

                    if ((int)RETCODE.Value > 0)
                    {
                        throw new Exception(MENSAJE.Value.ToString());
                    }

                    return new DeleteArticleResponse()
                    {
                        Mensaje = MENSAJE.Value.ToString()
                    };
                }
            }
            catch (Exception ex)
            {
                return new DeleteArticleResponse()
                {
                    Mensaje = ex.Message
                };
            }

        }

        //MÉtODO DE MODIFICAR ARTICULO
        public UpdateArticleResponse UpdateArticulo(UpdateArticleRequest upArt)
        {
            try
            {
                using (var context = new ArticulosEntities())
                {
                    ObjectParameter RETCODE = new ObjectParameter("RETCODE", typeof(int));
                    ObjectParameter MENSAJE = new ObjectParameter("MENSAJE", typeof(string));


                    string cadenaImagen = upArt.Imagen.Replace("data:image/png;base64,", "").Replace("data:image/jpeg;base64,", "");
                    byte[] imgBinary = Convert.FromBase64String(cadenaImagen);

                    context.PA_MODIFICAR_ARTICULO(upArt.ID_Articulo, upArt.Nombre, upArt.Descripcion, upArt.Fabricante, upArt.Peso, upArt.Alto, upArt.Largo, upArt.Ancho, upArt.Precio, imgBinary, RETCODE, MENSAJE);

                    //COMPROBAMOS SI SE HA DE AÑADIR O QUITRA STOCK
                    if (upArt.Stock < 0)
                    {
                        //QUITAMOS EL NEGATIVO AL STOCK PARA REALIZAR LA OPERACIÓN
                        upArt.Stock = upArt.Stock * -1;
                        context.PA_QUITAR_STOCK(upArt.ID_Articulo, upArt.Stock, RETCODE, MENSAJE);
                    }
                    else
                    //AÑADIMOS STOCK Y COMPROBAMOS SI HAY ALGÚN PEDIDO EN ESPERA QUE REQUIERA EL ARTICULO AÑADIDO
                    {
                        //RECOGEMOS TODOS LOS PEDIDOS QUE ESTÉN EN ESPERA Y SOLO LOS ARTICULOS QUE NO HAYA SUFICIENTE CANTIDAD
                        var pedidosPendientes = context.V_PEDIDOS_ARTICULOS_STOCK.ToList();

                        foreach(var p in pedidosPendientes)
                        {

                        }

                        context.PA_AÑADIR_STOCK(upArt.ID_Articulo, upArt.Stock, RETCODE, MENSAJE);
                    }

                    if ((int)RETCODE.Value < 0)
                    {
                        throw new Exception("Error no controlado");
                    }

                    if ((int)RETCODE.Value > 0)
                    {
                        throw new Exception(MENSAJE.Value.ToString());
                    }

                    return new UpdateArticleResponse()
                    {
                        Mensaje = MENSAJE.Value.ToString()
                    };
                }
            }
            catch (Exception ex)
            {
                return new UpdateArticleResponse()
                {
                    Mensaje = ex.Message
                };
            }

        }

        //MÉTODO DE LISTADO DE TODOS LOS ARTICULOS
        public IEnumerable<Article> GetArticles()
        {
            try
            {
                using (var context = new ArticulosEntities())
                {

                    List<Article> listArticles = (from V_ARTICULOS_STOCK in context.V_ARTICULOS_STOCK
                                                  select new Article
                                                  {
                                                      ID_Articulo = V_ARTICULOS_STOCK.ID_ARTICULO,
                                                      Nombre = V_ARTICULOS_STOCK.NOMBRE,
                                                      Stock = V_ARTICULOS_STOCK.CANTIDAD,
                                                      Descripcion = V_ARTICULOS_STOCK.DESCRIPCION,
                                                      Fabricante = V_ARTICULOS_STOCK.FABRICANTE,
                                                      Peso = V_ARTICULOS_STOCK.PESO,
                                                      Alto = V_ARTICULOS_STOCK.ALTO,
                                                      Largo = V_ARTICULOS_STOCK.LARGO,
                                                      Ancho = V_ARTICULOS_STOCK.ANCHO,
                                                      Precio = V_ARTICULOS_STOCK.PRECIO,
                                                      ImagenTemp = V_ARTICULOS_STOCK.IMAGEN

                                                  }).ToList<Article>();

                    foreach (Article articulo in listArticles)
                    {
                        articulo.Imagen = (articulo.ImagenTemp != null) ? new ImageConverter().byteTobase64(articulo.ImagenTemp) : null;
                        articulo.ImagenTemp = null;
                    }

                    return listArticles;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        //MÉTODO QUITAR STOCK
        public UpdateArticleResponse QuitarStock(ArticuloStock newStock)
        {
            try
            {
                using (var context = new ArticulosEntities())
                {
                    ObjectParameter RETCODE = new ObjectParameter("RETCODE", typeof(int));
                    ObjectParameter MENSAJE = new ObjectParameter("MENSAJE", typeof(string));

                    //COMPROBAMOS QUE EL STOCK NO VENGA EN NEGATIVO
                    if (newStock.Cantidad < 0)
                    {
                        throw new Exception("No se permiten números negativos");
                    }

                    context.PA_QUITAR_STOCK(newStock.ID_Articulo, newStock.Cantidad, RETCODE, MENSAJE);

                    if ((int)RETCODE.Value < 0)
                    {
                        throw new Exception("Error no controlado");
                    }

                    if ((int)RETCODE.Value > 0)
                    {
                        throw new Exception(MENSAJE.Value.ToString());
                    }

                    var consulta = context.V_ARTICULOS_STOCK.Where(id => id.ID_ARTICULO == newStock.ID_Articulo).FirstOrDefault();

                    return new UpdateArticleResponse()
                    {
                        Retcode = (int)RETCODE.Value,
                        Mensaje = MENSAJE.Value.ToString(),
                        Stock = (int)consulta.CANTIDAD
                    };
                }
            }
            catch (Exception ex)
            {
                return new UpdateArticleResponse()
                {
                    Mensaje = ex.Message
                };
            }
        }

        //MÉTODO RECUPERAR STOCK
        public UpdateArticleResponse GetStock(ArticuloPedido newStock)
        {
            try
            {
                using (var context = new ArticulosEntities())
                {


                    var consulta = context.V_ARTICULOS_STOCK.Where(id => id.ID_ARTICULO == newStock.ID_Articulo).FirstOrDefault();

                    return new UpdateArticleResponse()
                    {
                        Stock = (int)consulta.CANTIDAD
                    };
                }
            }
            catch (Exception ex)
            {
                return new UpdateArticleResponse()
                {
                    Mensaje = ex.Message
                };
            }
        }

        //MÉTODO AÑADIR STOCK
        public UpdateArticleResponse AñadirStock(ArticuloPedido newStock)
        {
            try
            {
                using (var context = new ArticulosEntities())
                {
                    ObjectParameter RETCODE = new ObjectParameter("RETCODE", typeof(int));
                    ObjectParameter MENSAJE = new ObjectParameter("MENSAJE", typeof(string));

                    //COMPROBAMOS QUE EL STOCK NO VENGA EN NEGATIVO
                    if (newStock.Cantidad < 0)
                    {
                        throw new Exception("No se permiten números negativos");
                    }

                    context.PA_AÑADIR_STOCK(newStock.ID_Articulo, newStock.Cantidad, RETCODE, MENSAJE);

                    if ((int)RETCODE.Value < 0)
                    {
                        throw new Exception("Error no controlado");
                    }

                    if ((int)RETCODE.Value > 0)
                    {
                        throw new Exception(MENSAJE.Value.ToString());
                    }
                    //RECUPERAMOS PEDIDOS PENDIENTES  
                    List<ArticuloPedidoStock> listPedidos = (from V_PEDIDOS_ARTICULOS_STOCK in context.V_PEDIDOS_ARTICULOS_STOCK
                                                     where V_PEDIDOS_ARTICULOS_STOCK.ESTADO == "PENDIENTE"
                                                     select new ArticuloPedidoStock
                                                     {
                                                         ID_Pedido = V_PEDIDOS_ARTICULOS_STOCK.ID_PEDIDO,
                                                         Estado = V_PEDIDOS_ARTICULOS_STOCK.ESTADO,
                                                         ID_Articulo = (int)V_PEDIDOS_ARTICULOS_STOCK.ID_ARTICULO,
                                                         CantidadPedida = (int)V_PEDIDOS_ARTICULOS_STOCK.CANTIDADPEDIDA,
                                                         Cantidad = (int)V_PEDIDOS_ARTICULOS_STOCK.CANTIDAD


                                                     }).ToList<ArticuloPedidoStock>();

                    //COMPROBAMOS SI SE PUEDE NEVIAR ALGUN PEDIDO PENDIENTE

                    var completo = true;
                    var id_pedido_actual = 0;
                    var total = listPedidos.Count();
                    var count = 0;
                    List<ArticuloStock> articles = new List<ArticuloStock>();
                    //RECORREMOS PEDIDOS PENDIENTES
                    foreach (var pedido in listPedidos)
                    {   //SI ES EL MISMO PEDIDO Y DE MOMENTO SE PUEDE ENVIAR
                        count++;
                        if(pedido.ID_Pedido == id_pedido_actual)
                        {   
                            if (completo)
                            {
                                completo = checkStockArticulo(pedido, articles);

                                id_pedido_actual = pedido.ID_Pedido;
                            }
                        }
                        else//SI ES PEDIDO NUEVO
                        {   //SI NO HAY MAS ARTICULOS EN PEDIDO
                            //COMPROBAMOS SI SE PUEDE ENVIAR EL ACTUAL
                            if(id_pedido_actual != 0) {
                                if (completo)
                                {
                                    enviarPedido(pedido, context, articles);
                                }
                                else
                                {
                                    articles.Clear();
                                    completo = true;
                                }

                            }

                            completo = checkStockArticulo(pedido, articles);

                            id_pedido_actual = pedido.ID_Pedido;
                        }
                        if(count == total)
                        {
                            if (completo)
                            {

                                enviarPedido(pedido, context, articles);

                            }
                        }
                    }

                    var consulta = context.V_ARTICULOS_STOCK.Where(id => id.ID_ARTICULO == newStock.ID_Articulo).FirstOrDefault();

                    return new UpdateArticleResponse()
                    {
                        Retcode = (int)RETCODE.Value,
                        Mensaje = MENSAJE.Value.ToString(),
                        Stock = (int)consulta.CANTIDAD
                    };
                }
            }
            catch (Exception ex)
            {
                return new UpdateArticleResponse()
                {
                    Mensaje = ex.Message
                };
            }
        }
        
        //METODO PARA ENVIO DE PEDIDO
        private void enviarPedido(ArticuloPedidoStock pedido, ArticulosEntities context, List<ArticuloStock> articles)
        {
            var estadopedido = context.PEDIDOS.Where(id => id.ID_PEDIDO == pedido.ID_Pedido).FirstOrDefault();

            estadopedido.ESTADO = "ENVIADO";
            context.SaveChanges();

            foreach (var articulo in articles)
            {
                this.QuitarStock(articulo);
            }
        }

        //METODO PARA CHEQUEAR EL STOCK DEL ARTICULO EN EL PEDIDO
        private bool checkStockArticulo(ArticuloPedidoStock pedido, List<ArticuloStock> articles)
        {
            var completo = (pedido.Cantidad >= pedido.CantidadPedida) ? true : false;

            if (completo)
            {
                articles.Add(new ArticuloStock(ID_Articulo: pedido.ID_Articulo, Cantidad: pedido.CantidadPedida));
            }
            return completo;
        }

        /*
         * 
         * 
         *  ENCRIPTACIÓN GET
         * 
         * 
         */
        public string GetDato(string dato)
        {

            var datoSaneado = transformarCadena(dato);

            var datoDesencriptado = DecryptStringAES(datoSaneado);

            return datoDesencriptado;
        }

        public string transformarCadena(string dato)
        {
            var nuevaCadena = "";
            for (var i = 0; i < dato.Length; i++)
            {
                var temp = dato[i];
                switch (temp)
                {
                    case '_':
                        temp = '+';
                        break;
                    case '|':
                        temp = '=';
                        break;
                    case '`':
                        temp = '/';
                        break;
                }
                nuevaCadena += temp;
            }
            return nuevaCadena;
        }

        public string DecryptStringAES(string encryptedValue)
        {
            var keybytes = Encoding.UTF8.GetBytes("123456789abcdefg");
            var iv = Encoding.UTF8.GetBytes("123456789abcdefg");

            //DECRYPT FROM CRIPTOJS
            var encrypted = Convert.FromBase64String(encryptedValue);
            var decriptedFromJavascript = DecryptStringFromBytes(encrypted, keybytes, iv);

            return decriptedFromJavascript;
        }

        private static string DecryptStringFromBytes(byte[] cipherText, byte[] key, byte[] iv)
        {
            // Check arguments.
            if (cipherText == null || cipherText.Length <= 0)
            {
                throw new ArgumentNullException("cipherText");
            }
            if (key == null || key.Length <= 0)
            {
                throw new ArgumentNullException("key");
            }
            if (iv == null || iv.Length <= 0)
            {
                throw new ArgumentNullException("key");
            }

            // Declare the string used to hold
            // the decrypted text.
            string plaintext = null;

            // Create an RijndaelManaged object
            // with the specified key and IV.
            using (var rijAlg = new RijndaelManaged())
            {
                //Settings
                rijAlg.Mode = CipherMode.CBC;
                rijAlg.Padding = PaddingMode.PKCS7;
                rijAlg.FeedbackSize = 128;

                rijAlg.Key = key;
                rijAlg.IV = iv;

                // Create a decrytor to perform the stream transform.
                var decryptor = rijAlg.CreateDecryptor(rijAlg.Key, rijAlg.IV);

                // Create the streams used for decryption.
                using (var msDecrypt = new MemoryStream(cipherText))
                {
                    using (var csDecrypt = new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read))
                    {
                        using (var srDecrypt = new StreamReader(csDecrypt))
                        {
                            // Read the decrypted bytes from the decrypting stream
                            // and place them in a string.
                            plaintext = srDecrypt.ReadToEnd();
                        }
                    }
                }
            }

            return plaintext;
        }

        //UPDATE ESTADO ARTICULO_PEDIDO
        public EstadoArticuloResponse updateEstado(EstadoArticuloRequest estado)
        {
            try
            {
                using (var context = new ArticulosEntities())
                {
                    var resultado = "";
                    var consulta = context.PEDIDOS_ARTICULOS.Where(id => id.ID_ARTICULO == estado.ID_Articulo).FirstOrDefault();

                    if(consulta.ESTADO != estado.Estado)
                    {
                        consulta.ESTADO = estado.Estado;
                        context.SaveChanges();
                        resultado = "OK";
                    }

                    return new EstadoArticuloResponse()
                    {
                        Mensaje = resultado,
                        NuevoEstado = consulta.ESTADO
                    };
                }
            }
            catch (Exception ex)
            {
                return new EstadoArticuloResponse()
                {
                    Mensaje = ex.Message,
                    NuevoEstado = ""
                };
            }
        }

    }
}
