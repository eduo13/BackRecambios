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
    
    public partial class PEDIDOS
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public PEDIDOS()
        {
            this.PEDIDOS_ARTICULOS = new HashSet<PEDIDOS_ARTICULOS>();
        }
    
        public int ID_PEDIDO { get; set; }
        public string CALLE { get; set; }
        public string PROVINCIA { get; set; }
        public string POBLACION { get; set; }
        public Nullable<int> CODIGO_POSTAL { get; set; }
        public string NUMERO { get; set; }
        public string PERSONA_CONTACTO { get; set; }
        public string TELEFONO { get; set; }
        public string ESTADO { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PEDIDOS_ARTICULOS> PEDIDOS_ARTICULOS { get; set; }
    }
}
