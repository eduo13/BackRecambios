using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NegocioAlmacen.DataAccess.Usuario.DTO
{
    public class CreateUserResponse
    {
        public string Usuario { get; set; }
        public int Id_usuario { get; set; }
        public string Mensaje { get; set; }
        public int Retcode { get; set; }
    }
}
