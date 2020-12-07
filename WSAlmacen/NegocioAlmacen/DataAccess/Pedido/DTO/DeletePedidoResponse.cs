using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NegocioAlmacen.DataAccess.Pedido.DTO
{
    public class DeletePedidoResponse
    {
        public string Mensaje { get; set; }
        public int ID_Pedido { get; set; }
        public int Retcode { get; set; }
    }
}
