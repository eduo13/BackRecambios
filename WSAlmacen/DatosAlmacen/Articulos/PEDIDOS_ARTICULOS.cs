//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DatosAlmacen.Articulos
{
    using System;
    using System.Collections.Generic;
    
    public partial class PEDIDOS_ARTICULOS
    {
        public int ID_PEDIDO { get; set; }
        public int ID_ARTICULO { get; set; }
        public int CANTIDAD { get; set; }
        public string ESTADO { get; set; }
    
        public virtual ARTICULOS ARTICULOS { get; set; }
        public virtual PEDIDOS PEDIDOS { get; set; }
    }
}