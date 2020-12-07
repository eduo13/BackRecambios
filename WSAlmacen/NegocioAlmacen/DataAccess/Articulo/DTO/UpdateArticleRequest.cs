using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NegocioAlmacen.DataAccess.Articulo.DTO
{
    public class UpdateArticleRequest
    {
        public int ID_Articulo { get; set; }
        public string Nombre { get; set; }
        public int Stock { get; set; }
        public string Descripcion { get; set; }
        public string Fabricante { get; set; }
        public decimal Peso { get; set; }
        public decimal Alto { get; set; }
        public decimal Largo { get; set; }
        public decimal Ancho { get; set; }
        public decimal Precio { get; set; }
        public string Imagen { get; set; }
        public int Habilitado { get; set; }

    }
}
