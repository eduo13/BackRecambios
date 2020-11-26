using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NegocioAlmacen.DataAccess.Pedido.DTO
{
    public class ArticuloStock
    {
        public int ID_Articulo { get; set; }
        public int Cantidad { get; set; }

        public ArticuloStock(int ID_Articulo = 0, int Cantidad = 0)
        {
            this.ID_Articulo = ID_Articulo;
            this.Cantidad = Cantidad;
        }

    }


}
