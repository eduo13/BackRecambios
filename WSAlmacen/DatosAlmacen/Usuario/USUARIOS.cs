//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DatosAlmacen.Usuario
{
    using System;
    using System.Collections.Generic;
    
    public partial class USUARIOS
    {
        public int ID_USUARIOS { get; set; }
        public string USUARIO { get; set; }
        public byte[] PASSWORD { get; set; }
        public Nullable<int> PERFIL { get; set; }
        public string EMAIL { get; set; }
    }
}
