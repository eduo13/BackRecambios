using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NegocioAlmacen.DataAccess.Usuario.DTO
{
    public class LoginResponse
    {
        public string Usuario { get; set; }
        public int IdUsuarios { get; set; }
        public int? IdPerfil { get; set; }
        public string Perfil { get; set; }
        public string Email { get; set; }
        public string Mensaje { get; set; }
        public string Token { get; set; }
    }
}
