using NegocioAlmacen.DataAccess.Usuario;
using NegocioAlmacen.DataAccess.Usuario.DTO;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;

namespace WSAlmacen.Controllers
{
    [EnableCors(origins: "http://localhost:4200", headers: "*", methods: "*")]

    [RoutePrefix("api/usuario")]
    public class UsuarioController : ApiController
    {
        //LOGIN
        [HttpPost]
        [Route("loginPOST")]
        public HttpResponseMessage login(LoginRequest User)
        {
            var usuarioDA = new UsuarioDataAccess();
            var usuarioLogado = usuarioDA.login(User);

            if(usuarioLogado.IdPerfil > 0)
            {
                var token = TokenGenerator.GenerateTokenJwt(User.Email, usuarioLogado.Perfil);
                usuarioLogado.Token = token;
            }

            return Request.CreateResponse(HttpStatusCode.OK, usuarioLogado);
        }

        //CREATE
        [HttpPost]
        [Route("createUser")]
        public HttpResponseMessage createUser(CreateUserRequest newUser)
        {
            var usuarioDA = new UsuarioDataAccess();
            var usuarioCreado = usuarioDA.CreateUser(newUser);
            return Request.CreateResponse(HttpStatusCode.OK, usuarioCreado);
        }

        //UPDATE
        [HttpPost]
        [Route("updateUser")]
        public HttpResponseMessage UpdateUser(UpdateUserRequest upUser)
        {
            var usuarioDA = new UsuarioDataAccess();
            var usuarioUpdateado = usuarioDA.UpdateUser(upUser);
            return Request.CreateResponse(HttpStatusCode.OK, usuarioUpdateado);
        }

        //DELETE
        [HttpPost]
        [Route("deleteUser")]
        public HttpResponseMessage deleteUser(DeleteUserRequest delUser)
        {
            var usuarioDA = new UsuarioDataAccess();
            var usuarioEliminado = usuarioDA.DeleteUser(delUser);
            return Request.CreateResponse(HttpStatusCode.OK, usuarioEliminado);
        }

        //LIST
        [HttpGet]
        [Route("listUser")]
        public HttpResponseMessage listUsers()
        {
            var usuarioDA = new UsuarioDataAccess();
            var listUsers = usuarioDA.GetUsers();
            return Request.CreateResponse(HttpStatusCode.OK, listUsers);
        }
    }
}
