using NegocioAlmacen.DataAccess.Usuario.DTO;
using DatosAlmacen.Usuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data.Entity.Core.Objects;

namespace NegocioAlmacen.DataAccess.Usuario
{
    public class UsuarioDataAccess
    {

        //MÉTODO DE LOGIN
        public LoginResponse login(LoginRequest login)
        {
            try
            {
                using (var context = new UsuariosEntities3())
                {
                    ObjectParameter RETCODE = new ObjectParameter("RETCODE", typeof(int));
                    ObjectParameter ID_USUARIOS = new ObjectParameter("ID_USUARIOS", typeof(int));
                    ObjectParameter MENSAJE = new ObjectParameter("MENSAJE", typeof(string));

                    context.PA_LOGIN(login.Email, login.Password, ID_USUARIOS, RETCODE, MENSAJE);

                    if ((int)RETCODE.Value < 0)
                    {
                        throw new Exception("Error no controlado");
                    }

                    if ((int)RETCODE.Value > 0)
                    {
                        throw new Exception(MENSAJE.Value.ToString());
                    }
                                                           
                    var consulta = context.USUARIOS.Where(user => user.ID_USUARIOS == (int)ID_USUARIOS.Value).FirstOrDefault();

                    return new LoginResponse()
                    {
                        Usuario = consulta.USUARIO,
                        IdUsuarios = consulta.ID_USUARIOS,
                        IdPerfil = consulta.PERFIL,
                        Email = consulta.EMAIL,
                        Mensaje = MENSAJE.Value.ToString()
                    };
                }
            }
            catch (Exception ex)
            {
                return new LoginResponse()
                {
                    Mensaje = ex.Message
                };
            }

        }

        //MÉTODO DE CREAR USUARIO
        public CreateUserResponse CreateUser (CreateUserRequest newUser)
        {
            try
            {
                using (var context = new UsuariosEntities3())
                {
                    ObjectParameter RETCODE = new ObjectParameter("RETCODE", typeof(int));
                    ObjectParameter MENSAJE = new ObjectParameter("MENSAJE", typeof(string));

                    context.PA_CREAR_USUARIO(newUser.Usuario, newUser.Password, newUser.Perfil, newUser.Email, RETCODE, MENSAJE);

                    if ((int)RETCODE.Value < 0)
                    {
                        throw new Exception("Error no controlado");
                    }

                    if ((int)RETCODE.Value > 0)
                    {
                        throw new Exception(MENSAJE.Value.ToString());
                    }

                    var consulta = context.USUARIOS.Where(email => email.EMAIL == newUser.Email).FirstOrDefault();

                    return new CreateUserResponse()
                    {
                        Usuario = consulta.USUARIO,
                        Mensaje = MENSAJE.Value.ToString()
                    };
                }
            }
            catch (Exception ex)
            {
                return new CreateUserResponse()
                {
                    Mensaje = ex.Message
                };
            }
            
        }

        //MÉTODO DE BORRAR USUARIO
        public DeleteUserResponse DeleteUser(DeleteUserRequest delUser)
        {
            try
            {
                using (var context = new UsuariosEntities3())
                {
                    ObjectParameter RETCODE = new ObjectParameter("RETCODE", typeof(int));
                    ObjectParameter MENSAJE = new ObjectParameter("MENSAJE", typeof(string));

                   var consulta = context.USUARIOS.Where(user => user.ID_USUARIOS == delUser.ID_Usuario).FirstOrDefault();

                    context.PA_BORRAR_USUARIO(delUser.ID_Usuario, RETCODE, MENSAJE);

                    if ((int)RETCODE.Value < 0)
                    {
                        throw new Exception("Error no controlado");
                    }

                    if ((int)RETCODE.Value > 0)
                    {
                        throw new Exception(MENSAJE.Value.ToString());
                    }

                    return new DeleteUserResponse()
                    {
                     //   Usuario = consulta.USUARIO,
                        Mensaje = MENSAJE.Value.ToString()
                    };
                }
            }
            catch (Exception ex)
            {
                return new DeleteUserResponse()
                {
                    Mensaje = ex.Message
                };
            }

        }

        //MÉTODO DE ACTUALIZAR USUARIO
        public UpdateUserResponse UpdateUser(UpdateUserRequest upUser)
        {
            try
            {
                using (var context = new UsuariosEntities3())
                {
                    ObjectParameter RETCODE = new ObjectParameter("RETCODE", typeof(int));
                    ObjectParameter MENSAJE = new ObjectParameter("MENSAJE", typeof(string));

                    context.PA_MODIFICAR_USUARIO(upUser.ID_Usuario, upUser.Usuario, upUser.Password, upUser.Perfil, upUser.Email, RETCODE, MENSAJE);

                    if ((int)RETCODE.Value < 0)
                    {
                        throw new Exception("Error no controlado");
                    }

                    if ((int)RETCODE.Value > 0)
                    {
                        throw new Exception(MENSAJE.Value.ToString());
                    }

                    var consulta = context.USUARIOS.Where(user => user.ID_USUARIOS == upUser.ID_Usuario).FirstOrDefault();

                    return new UpdateUserResponse()
                    {
                        Usuario = consulta.USUARIO,
                        Mensaje = MENSAJE.Value.ToString()
                    };
                }
            }
            catch (Exception ex)
            {
                return new UpdateUserResponse()
                {
                    Mensaje = ex.Message
                };
            }

        }

        //MÉTODO DE LISTADO DE TODOS LOS USUARIOS
        public IEnumerable<User> GetUsers()
        {
            try{
                using(var context = new UsuariosEntities3())
                {
                    List<User> listUsuarios = (from V_USUARIOS_PERFILES in context.V_USUARIOS_PERFILES
                                               select new User
                                               {
                                                   ID_Usuario = V_USUARIOS_PERFILES.ID_USUARIOS,
                                                   Usuario = V_USUARIOS_PERFILES.USUARIO,
                                                   Perfil = V_USUARIOS_PERFILES.PERFIL,
                                                   Email = V_USUARIOS_PERFILES.EMAIL

                                               }).ToList<User>();
                    return listUsuarios;
                }
            }catch(Exception ex)
            {
                throw ex;
            }
            
        }

    }
}
