using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NegocioAlmacen.DataAccess.Pedido.DTO
{
    public class Pedidos
    {
        public int ID_Pedido { get; set; }
        public string Calle { get; set; }
        public string Provincia { get; set; }
        public string Poblacion { get; set; }
        public int? CodigoPostal { get; set; }
        public string Numero { get; set; }
        public string PersonaContacto { get; set; }
        public string Telefono { get; set; }
        public string Estado { get; set; }
        public List<ArticuloPedido> Articulos { get; set; }

    }
}
