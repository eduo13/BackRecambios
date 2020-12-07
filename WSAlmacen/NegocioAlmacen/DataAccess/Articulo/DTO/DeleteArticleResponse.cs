using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NegocioAlmacen.DataAccess.Articulo.DTO
{
    public class DeleteArticleResponse
    {
        public int Id_articulo { get; set; }
        public int Retcode { get; set; }
        public string Mensaje { get; set; }
    }
}
