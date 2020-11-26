using NegocioAlmacen.DataAccess.Articulo;
using NegocioAlmacen.DataAccess.Pedidos;
using NegocioAlmacen.DataAccess.Pedidos.DTO;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;

namespace WSAlmacen.Controllers
{
    [EnableCors(origins: "http://localhost:4200", headers: "*", methods: "*")]

    [RoutePrefix("api/pedidos")]
    public class PedidosController : ApiController
    {

        //CREATE
        [HttpPost]
        [Route("createPedido")]
        public HttpResponseMessage createPedido(CreatePedidoRequest newP)
        {
            var pedidoDA = new PedidosDataAccess();
            var pedidoCreado = pedidoDA.CrearPedido(newP);
            return Request.CreateResponse(HttpStatusCode.OK, pedidoCreado);
        }

        //DELETE
        [HttpPost]
        [Route("deletePedido")]
        public HttpResponseMessage deletePedido(DeletePedidoRequest delP)
        {
            var pedidoDA = new PedidosDataAccess();
            var pedidoBorrado = pedidoDA.DeletePedido(delP);
            return Request.CreateResponse(HttpStatusCode.OK, pedidoBorrado);
        }

        //LIST
        [HttpGet]
        [Route("listPedidos")]
        public HttpResponseMessage listP()
        {
            var pedidoDA = new PedidosDataAccess();
            var listPedido = pedidoDA.listPedidos();
            return Request.CreateResponse(HttpStatusCode.OK, listPedido);
        }
    }
}