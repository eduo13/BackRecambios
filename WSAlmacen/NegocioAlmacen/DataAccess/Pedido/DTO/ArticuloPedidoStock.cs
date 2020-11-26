using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NegocioAlmacen.DataAccess.Pedido.DTO
{
    public class ArticuloPedidoStock
    {
        public int ID_Pedido { get; set; }
        public string Estado { get; set; }
        public int ID_Articulo { get; set; }
        public int CantidadPedida { get; set; }
        public int Cantidad { get; set; }
    }
}
