using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NegocioAlmacen.DataAccess.Articulo.DTO
{
    public class EstadoArticuloRequest
    {
        public int ID_Articulo { get; set; }
        public string Estado { get; set; }
    }
}
