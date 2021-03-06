﻿using DatosAlmacen.Articulos;
using NegocioAlmacen.DataAccess.Pedido.DTO;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NegocioAlmacen.DataAccess.Pedido
{
    public class PedidosDataAccess
    {
 
        //MÉtODO DE CREAR PEDIDO
        public CreatePedidoResponse CrearPedido(CreatePedidoRequest newP)
        {
            try
            {
                using (var context = new ArticulosEntities())
                {
                    ObjectParameter RETCODE = new ObjectParameter("RETCODE", typeof(int));
                    ObjectParameter MENSAJE = new ObjectParameter("MENSAJE", typeof(string));
                    ObjectParameter ID_PEDIDOS = new ObjectParameter("ID_PEDIDOS", typeof(int));

                    //COMPROBAMOS SI HAY STOCK
                    string Estado = "Estado inicial";

                    foreach (ArticuloPedido art in newP.Articulos)
                    {
                        var consulta = context.ARTICULOS.Where(id => id.ID_ARTICULO == art.ID_Articulo).FirstOrDefault();

                        if (consulta.STOCK < art.Cantidad)
                        {
                            Estado = "PENDIENTE";
                        }
                    }

                    Estado = (Estado == "Estado inicial") ? "ENVIADO" : Estado;

                    context.PA_AÑADIR_PEDIDO(newP.Calle, newP.Provincia, newP.Poblacion, newP.CodigoPostal, newP.Numero, newP.PersonaContacto, newP.Telefono, Estado, RETCODE, MENSAJE, ID_PEDIDOS);

                    //AÑADIMOS LOS ARTICULOS Y LA CANTIDAD
                    foreach (ArticuloPedido art in newP.Articulos)
                    {
                        context.PA_AÑADIR_PEDIDOS_ARTICULOS((int)ID_PEDIDOS.Value, art.ID_Articulo, art.Cantidad,  RETCODE, MENSAJE);
                    }

                    //COMPROBAMOS SI EL PEDIDO SE PUEDE ENVIAR DIRECTAMENTE
                    if (Estado == "ENVIADO")
                    {
                        foreach (ArticuloPedido art in newP.Articulos)
                        {
                            context.PA_QUITAR_STOCK(art.ID_Articulo, art.Cantidad, RETCODE, MENSAJE);
                        }
                    }

                    if ((int)RETCODE.Value < 0)
                    {
                        throw new Exception("Error no controlado");
                    }

                    if ((int)RETCODE.Value > 0)
                    {
                        throw new Exception(MENSAJE.Value.ToString());
                    }

                    return new CreatePedidoResponse()
                    {
                        Mensaje = MENSAJE.Value.ToString(),
                        Retcode = (int)RETCODE.Value,
                        ID_Pedido = (int)ID_PEDIDOS.Value,
                        Estado = Estado
                    };
                }
            }
            catch (Exception ex)
            {
                return new CreatePedidoResponse()
                {
                    Mensaje = ex.Message
                };
            }
        }


        //MÉTODO DE BORRAR PEDIDO
        public DeletePedidoResponse DeletePedido(DeletePedidoRequest delP)
        {
            try
            {
                using (var context = new ArticulosEntities())
                {
                    ObjectParameter RETCODE = new ObjectParameter("RETCODE", typeof(int));
                    ObjectParameter MENSAJE = new ObjectParameter("MENSAJE", typeof(string));

                    var consulta = context.PEDIDOS.Where(id => id.ID_PEDIDO == delP.ID_Pedido).FirstOrDefault();

                    context.PA_CANCELAR_PEDIDO(delP.ID_Pedido, RETCODE, MENSAJE);

                    if ((int)RETCODE.Value < 0)
                    {
                        throw new Exception("Error no controlado");
                    }

                    if ((int)RETCODE.Value > 0)
                    {
                        throw new Exception(MENSAJE.Value.ToString());
                    }

                    return new DeletePedidoResponse()
                    {
                        Mensaje = MENSAJE.Value.ToString(),
                        Retcode = (int)RETCODE.Value,
                        ID_Pedido = delP.ID_Pedido
                    };
                }
            }
            catch (Exception ex)
            {
                return new DeletePedidoResponse()
                {
                    Mensaje = ex.Message
                };
            }

        }

        //MÉTODO DE LISTADO DE TODOS LOS PEDIDOS
        public IEnumerable<DTO.Pedidos> listPedidos()
        {
            try
            {
                using (var context = new ArticulosEntities())
                {

                    List<DTO.Pedidos> listPedidos = (from PEDIDOS in context.PEDIDOS
                                                  select new DTO.Pedidos
                                                  {
                                                      ID_Pedido = PEDIDOS.ID_PEDIDO,
                                                      Calle = PEDIDOS.CALLE,
                                                      Provincia = PEDIDOS.PROVINCIA,
                                                      Poblacion = PEDIDOS.POBLACION,
                                                      CodigoPostal = PEDIDOS.CODIGO_POSTAL,
                                                      Numero = PEDIDOS.NUMERO,
                                                      PersonaContacto = PEDIDOS.PERSONA_CONTACTO,
                                                      Telefono = PEDIDOS.TELEFONO,
                                                      Estado = PEDIDOS.ESTADO

                                                  }).ToList<DTO.Pedidos>();

                    foreach(var pedido in listPedidos)
                    {
                        pedido.Articulos = (from p in context.PEDIDOS_ARTICULOS
                                            where p.ID_PEDIDO == (int)pedido.ID_Pedido
                                            select new DTO.ArticuloPedido
                                            {
                                                ID_Articulo = p.ID_ARTICULO,
                                                Cantidad = p.CANTIDAD,
                                                //Estado = p.ESTADO
                                               


                                            }).ToList<ArticuloPedido>();
                         
                    }
                    
                    
                    return listPedidos;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
    }
}