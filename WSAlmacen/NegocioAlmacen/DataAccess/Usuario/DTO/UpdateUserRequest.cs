﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NegocioAlmacen.DataAccess.Usuario.DTO
{
    public class UpdateUserRequest
    {
        public int ID_Usuario { get; set; }
        public string Usuario { get; set; }
        public string Password { get; set; }
        public int Perfil { get; set; }
        public string Email { get; set; }
    }
}
