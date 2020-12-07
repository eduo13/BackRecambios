﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class ArticulosEntities : DbContext
    {
        public ArticulosEntities()
            : base("name=ArticulosEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<ARTICULOS> ARTICULOS { get; set; }
        public virtual DbSet<PEDIDOS> PEDIDOS { get; set; }
        public virtual DbSet<PEDIDOS_ARTICULOS> PEDIDOS_ARTICULOS { get; set; }
        public virtual DbSet<V_PEDIDOS_ARTICULOS_STOCK> V_PEDIDOS_ARTICULOS_STOCK { get; set; }
    
        public virtual int PA_AÑADIR_ARTICULO(string nOMBRE, string dESCRIPCION, string fABRICANTE, Nullable<decimal> pESO, Nullable<decimal> aLTO, Nullable<decimal> lARGO, Nullable<decimal> aNCHO, Nullable<decimal> pRECIO, byte[] iMAGEN, Nullable<int> hABILITADO, Nullable<int> sTOCK, ObjectParameter rETCODE, ObjectParameter mENSAJE)
        {
            var nOMBREParameter = nOMBRE != null ?
                new ObjectParameter("NOMBRE", nOMBRE) :
                new ObjectParameter("NOMBRE", typeof(string));
    
            var dESCRIPCIONParameter = dESCRIPCION != null ?
                new ObjectParameter("DESCRIPCION", dESCRIPCION) :
                new ObjectParameter("DESCRIPCION", typeof(string));
    
            var fABRICANTEParameter = fABRICANTE != null ?
                new ObjectParameter("FABRICANTE", fABRICANTE) :
                new ObjectParameter("FABRICANTE", typeof(string));
    
            var pESOParameter = pESO.HasValue ?
                new ObjectParameter("PESO", pESO) :
                new ObjectParameter("PESO", typeof(decimal));
    
            var aLTOParameter = aLTO.HasValue ?
                new ObjectParameter("ALTO", aLTO) :
                new ObjectParameter("ALTO", typeof(decimal));
    
            var lARGOParameter = lARGO.HasValue ?
                new ObjectParameter("LARGO", lARGO) :
                new ObjectParameter("LARGO", typeof(decimal));
    
            var aNCHOParameter = aNCHO.HasValue ?
                new ObjectParameter("ANCHO", aNCHO) :
                new ObjectParameter("ANCHO", typeof(decimal));
    
            var pRECIOParameter = pRECIO.HasValue ?
                new ObjectParameter("PRECIO", pRECIO) :
                new ObjectParameter("PRECIO", typeof(decimal));
    
            var iMAGENParameter = iMAGEN != null ?
                new ObjectParameter("IMAGEN", iMAGEN) :
                new ObjectParameter("IMAGEN", typeof(byte[]));
    
            var hABILITADOParameter = hABILITADO.HasValue ?
                new ObjectParameter("HABILITADO", hABILITADO) :
                new ObjectParameter("HABILITADO", typeof(int));
    
            var sTOCKParameter = sTOCK.HasValue ?
                new ObjectParameter("STOCK", sTOCK) :
                new ObjectParameter("STOCK", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("PA_AÑADIR_ARTICULO", nOMBREParameter, dESCRIPCIONParameter, fABRICANTEParameter, pESOParameter, aLTOParameter, lARGOParameter, aNCHOParameter, pRECIOParameter, iMAGENParameter, hABILITADOParameter, sTOCKParameter, rETCODE, mENSAJE);
        }
    
        public virtual int PA_AÑADIR_PEDIDO(string cALLE, string pROVINCIA, string pOBLACION, Nullable<int> cODIGO_POSTAL, string nUMERO, string pERSONA_CONTACTO, string tELEFONO, string eSTADO, ObjectParameter rETCODE, ObjectParameter mENSAJE, ObjectParameter iD_PEDIDOS)
        {
            var cALLEParameter = cALLE != null ?
                new ObjectParameter("CALLE", cALLE) :
                new ObjectParameter("CALLE", typeof(string));
    
            var pROVINCIAParameter = pROVINCIA != null ?
                new ObjectParameter("PROVINCIA", pROVINCIA) :
                new ObjectParameter("PROVINCIA", typeof(string));
    
            var pOBLACIONParameter = pOBLACION != null ?
                new ObjectParameter("POBLACION", pOBLACION) :
                new ObjectParameter("POBLACION", typeof(string));
    
            var cODIGO_POSTALParameter = cODIGO_POSTAL.HasValue ?
                new ObjectParameter("CODIGO_POSTAL", cODIGO_POSTAL) :
                new ObjectParameter("CODIGO_POSTAL", typeof(int));
    
            var nUMEROParameter = nUMERO != null ?
                new ObjectParameter("NUMERO", nUMERO) :
                new ObjectParameter("NUMERO", typeof(string));
    
            var pERSONA_CONTACTOParameter = pERSONA_CONTACTO != null ?
                new ObjectParameter("PERSONA_CONTACTO", pERSONA_CONTACTO) :
                new ObjectParameter("PERSONA_CONTACTO", typeof(string));
    
            var tELEFONOParameter = tELEFONO != null ?
                new ObjectParameter("TELEFONO", tELEFONO) :
                new ObjectParameter("TELEFONO", typeof(string));
    
            var eSTADOParameter = eSTADO != null ?
                new ObjectParameter("ESTADO", eSTADO) :
                new ObjectParameter("ESTADO", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("PA_AÑADIR_PEDIDO", cALLEParameter, pROVINCIAParameter, pOBLACIONParameter, cODIGO_POSTALParameter, nUMEROParameter, pERSONA_CONTACTOParameter, tELEFONOParameter, eSTADOParameter, rETCODE, mENSAJE, iD_PEDIDOS);
        }
    
        public virtual int PA_AÑADIR_PEDIDOS_ARTICULOS(Nullable<int> iD_PEDIDO, Nullable<int> iD_ARTICULO, Nullable<int> cANTIDAD, ObjectParameter rETCODE, ObjectParameter mENSAJE)
        {
            var iD_PEDIDOParameter = iD_PEDIDO.HasValue ?
                new ObjectParameter("ID_PEDIDO", iD_PEDIDO) :
                new ObjectParameter("ID_PEDIDO", typeof(int));
    
            var iD_ARTICULOParameter = iD_ARTICULO.HasValue ?
                new ObjectParameter("ID_ARTICULO", iD_ARTICULO) :
                new ObjectParameter("ID_ARTICULO", typeof(int));
    
            var cANTIDADParameter = cANTIDAD.HasValue ?
                new ObjectParameter("CANTIDAD", cANTIDAD) :
                new ObjectParameter("CANTIDAD", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("PA_AÑADIR_PEDIDOS_ARTICULOS", iD_PEDIDOParameter, iD_ARTICULOParameter, cANTIDADParameter, rETCODE, mENSAJE);
        }
    
        public virtual int PA_AÑADIR_STOCK(Nullable<int> iD_ARTICULO, Nullable<int> cANTIDAD, ObjectParameter rETCODE, ObjectParameter mENSAJE)
        {
            var iD_ARTICULOParameter = iD_ARTICULO.HasValue ?
                new ObjectParameter("ID_ARTICULO", iD_ARTICULO) :
                new ObjectParameter("ID_ARTICULO", typeof(int));
    
            var cANTIDADParameter = cANTIDAD.HasValue ?
                new ObjectParameter("CANTIDAD", cANTIDAD) :
                new ObjectParameter("CANTIDAD", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("PA_AÑADIR_STOCK", iD_ARTICULOParameter, cANTIDADParameter, rETCODE, mENSAJE);
        }
    
        public virtual int PA_BORRAR_ARTICULO(Nullable<int> iD_ARTICULO, ObjectParameter rETCODE, ObjectParameter mENSAJE)
        {
            var iD_ARTICULOParameter = iD_ARTICULO.HasValue ?
                new ObjectParameter("ID_ARTICULO", iD_ARTICULO) :
                new ObjectParameter("ID_ARTICULO", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("PA_BORRAR_ARTICULO", iD_ARTICULOParameter, rETCODE, mENSAJE);
        }
    
        public virtual int PA_CANCELAR_PEDIDO(Nullable<int> iD_PEDIDO, ObjectParameter rETCODE, ObjectParameter mENSAJE)
        {
            var iD_PEDIDOParameter = iD_PEDIDO.HasValue ?
                new ObjectParameter("ID_PEDIDO", iD_PEDIDO) :
                new ObjectParameter("ID_PEDIDO", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("PA_CANCELAR_PEDIDO", iD_PEDIDOParameter, rETCODE, mENSAJE);
        }
    
        public virtual int PA_MODIFICAR_ARTICULO(Nullable<int> iD_ARTICULO, string nOMBRE, string dESCRIPCION, string fABRICANTE, Nullable<decimal> pESO, Nullable<decimal> aLTO, Nullable<decimal> lARGO, Nullable<decimal> aNCHO, Nullable<decimal> pRECIO, byte[] iMAGEN, Nullable<int> hABILITADO, Nullable<int> sTOCK, ObjectParameter rETCODE, ObjectParameter mENSAJE)
        {
            var iD_ARTICULOParameter = iD_ARTICULO.HasValue ?
                new ObjectParameter("ID_ARTICULO", iD_ARTICULO) :
                new ObjectParameter("ID_ARTICULO", typeof(int));
    
            var nOMBREParameter = nOMBRE != null ?
                new ObjectParameter("NOMBRE", nOMBRE) :
                new ObjectParameter("NOMBRE", typeof(string));
    
            var dESCRIPCIONParameter = dESCRIPCION != null ?
                new ObjectParameter("DESCRIPCION", dESCRIPCION) :
                new ObjectParameter("DESCRIPCION", typeof(string));
    
            var fABRICANTEParameter = fABRICANTE != null ?
                new ObjectParameter("FABRICANTE", fABRICANTE) :
                new ObjectParameter("FABRICANTE", typeof(string));
    
            var pESOParameter = pESO.HasValue ?
                new ObjectParameter("PESO", pESO) :
                new ObjectParameter("PESO", typeof(decimal));
    
            var aLTOParameter = aLTO.HasValue ?
                new ObjectParameter("ALTO", aLTO) :
                new ObjectParameter("ALTO", typeof(decimal));
    
            var lARGOParameter = lARGO.HasValue ?
                new ObjectParameter("LARGO", lARGO) :
                new ObjectParameter("LARGO", typeof(decimal));
    
            var aNCHOParameter = aNCHO.HasValue ?
                new ObjectParameter("ANCHO", aNCHO) :
                new ObjectParameter("ANCHO", typeof(decimal));
    
            var pRECIOParameter = pRECIO.HasValue ?
                new ObjectParameter("PRECIO", pRECIO) :
                new ObjectParameter("PRECIO", typeof(decimal));
    
            var iMAGENParameter = iMAGEN != null ?
                new ObjectParameter("IMAGEN", iMAGEN) :
                new ObjectParameter("IMAGEN", typeof(byte[]));
    
            var hABILITADOParameter = hABILITADO.HasValue ?
                new ObjectParameter("HABILITADO", hABILITADO) :
                new ObjectParameter("HABILITADO", typeof(int));
    
            var sTOCKParameter = sTOCK.HasValue ?
                new ObjectParameter("STOCK", sTOCK) :
                new ObjectParameter("STOCK", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("PA_MODIFICAR_ARTICULO", iD_ARTICULOParameter, nOMBREParameter, dESCRIPCIONParameter, fABRICANTEParameter, pESOParameter, aLTOParameter, lARGOParameter, aNCHOParameter, pRECIOParameter, iMAGENParameter, hABILITADOParameter, sTOCKParameter, rETCODE, mENSAJE);
        }
    
        public virtual int PA_QUITAR_STOCK(Nullable<int> iD_ARTICULO, Nullable<int> cANTIDAD, ObjectParameter rETCODE, ObjectParameter mENSAJE)
        {
            var iD_ARTICULOParameter = iD_ARTICULO.HasValue ?
                new ObjectParameter("ID_ARTICULO", iD_ARTICULO) :
                new ObjectParameter("ID_ARTICULO", typeof(int));
    
            var cANTIDADParameter = cANTIDAD.HasValue ?
                new ObjectParameter("CANTIDAD", cANTIDAD) :
                new ObjectParameter("CANTIDAD", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("PA_QUITAR_STOCK", iD_ARTICULOParameter, cANTIDADParameter, rETCODE, mENSAJE);
        }
    }
}
