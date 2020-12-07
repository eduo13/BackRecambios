using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NegocioAlmacen.DataAccess.Articulo.DTO
{
    public class CreateArticleResponse
    {
        public string Mensaje { get; set; }
        public int Retcode { get; set; }
        public int Id_articulo { get; set; }

    }
}
