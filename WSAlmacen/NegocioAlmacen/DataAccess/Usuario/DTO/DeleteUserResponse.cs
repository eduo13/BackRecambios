using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NegocioAlmacen.DataAccess.Usuario.DTO
{
     public class DeleteUserResponse
    {
        public string Usuario { get; set; }
        public string Mensaje { get; set; }
        public int Retcode { get; set; }
    }
}
