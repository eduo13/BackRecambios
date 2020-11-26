using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NegocioAlmacen.DataAccess.Pedido.DTO
{
    public class ArticuloPedido
    {
        public int ID_Articulo { get; set; }
        //public string Nombre { get; set; }
        public int Cantidad { get; set; }
        //public string Estado { get; set; }
/*
        public ArticuloPedido(int ID_Articulo, int Cantidad, string Estado)
        {
            this.ID_Articulo = ID_Articulo;
            //this.Nombre = Nombre;
            this.Cantidad = Cantidad;
            this.Estado = Estado;
        }
*/

    }
}