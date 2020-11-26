using NegocioAlmacen.DataAccess.Articulo;
using NegocioAlmacen.DataAccess.Articulo.DTO;
using NegocioAlmacen.DataAccess.Pedido.DTO;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;

namespace WSAlmacen.Controllers
{
    [EnableCors(origins: "http://localhost:4200", headers: "*", methods: "*")]

    [RoutePrefix("api/articulos")]
    public class ArticuloController : ApiController
    {

        //CREATE
        [HttpPost]
        [Route("createArticle")]
        public HttpResponseMessage createArticle(CreateArticleRequest newArt)
        {
            var articuloDA = new ArticuloDataAccess();
            var articuloCreado = articuloDA.CrearArticulo(newArt);
            return Request.CreateResponse(HttpStatusCode.OK, articuloCreado);
        }

        //UPDATE
        [HttpPost]
        [Route("updateArticle")]
        public HttpResponseMessage updateArticle(UpdateArticleRequest upArt)
        {
            var articuloDA = new ArticuloDataAccess();
            var articuloModificado = articuloDA.UpdateArticulo(upArt);
            return Request.CreateResponse(HttpStatusCode.OK, articuloModificado);
        }

        //LIST
        [HttpGet]
        [Route("listArticle")]
        public HttpResponseMessage listArticle()
        {
            var articuloDA = new ArticuloDataAccess();
            var listArticle = articuloDA.GetArticles();
            return Request.CreateResponse(HttpStatusCode.OK, listArticle);
        }

        //DELETE
        [HttpPost]
        [Route("deleteArticle")]
        public HttpResponseMessage deleteArticle(DeleteArticleRequest delArt)
        {
            var articuloDA = new ArticuloDataAccess();
            var articuloBorrado = articuloDA.DeleteArticulo(delArt);
            return Request.CreateResponse(HttpStatusCode.OK, articuloBorrado);
        }

        //AÑADIR STOCK
        [HttpPost]
        [Route("addStock")]
        public HttpResponseMessage addStock(ArticuloPedido stock)
        {
            var articuloDA = new ArticuloDataAccess();
            var stockActualizado = articuloDA.AñadirStock(stock);
            return Request.CreateResponse(HttpStatusCode.OK, stockActualizado);
        }

        //QUITAR STOCK
        [HttpPost]
        [Route("quitaStock")]
        public HttpResponseMessage QuitaStock(ArticuloStock stock)
        {
            var articuloDA = new ArticuloDataAccess();
            var stockActualizado = articuloDA.QuitarStock(stock);
            return Request.CreateResponse(HttpStatusCode.OK, stockActualizado);
        }

        //RECUPERAR STOCK
        [HttpPost]
        [Route("getStock")]
        public HttpResponseMessage GetStock(ArticuloPedido articulo)
        {
            var stockDA = new ArticuloDataAccess();
            var stock = stockDA.GetStock(articulo);
            return Request.CreateResponse(HttpStatusCode.OK, stock);
        }

        //ENCRIPTACIÓN GET
        [HttpGet]
        [Route("encryptGet/{dato}")]
        public HttpResponseMessage getDato(string dato)
        {
            var articuloDA = new ArticuloDataAccess();
            var datoDescifrado = articuloDA.GetDato(dato);
            return Request.CreateResponse(HttpStatusCode.OK, datoDescifrado);
        }

        //UPDATE ESTADO ARTICULO_PEDIDO
        [HttpPost]
        [Route("updateArticuloPedido")]
        public HttpResponseMessage updateEstado(EstadoArticuloRequest estado)
        {
            var updateEstadoDA = new ArticuloDataAccess();
            var res = updateEstadoDA.updateEstado(estado);
            return Request.CreateResponse(HttpStatusCode.OK, res);
        }


    }
}