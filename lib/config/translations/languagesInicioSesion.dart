class Languagesiniciosesion {
  static int idiomaSeleccionado = 0;

  static List<String> titulo = ['Pantalla Inicio sesión', 'Login screen'];
  static List<String> nombre  = ['Nombre', 'Name'];
  static List<String> contrasena = ['Contraseña', 'Password'];
  static List<String> iniciarSesion = ['Iniciar Sesión', 'Log in'];
  static List<String> accederGoogle = ['Acceder con Google', 'Access with Google'];
  static List<String> recuperarContrasena = ['Recuperar contraseña', 'Recover password'];
  static List<String> nombreUsuario = ['Nombre de usuario', 'User name','Nom de utilisateur'];
  static List<String> olvidasteContrasena = ['¿Olvidaste tu contraseña?', 'Forgot your password?'];
  static List<String> registrarse = ['Registrarse', 'Register','Registre'];
  static List<String> noExisteElUsuario = ['No existe el usuario', 'The user does not exist'];
  static List<String> tuContrasenaEs = ['Tu contraseña es: ', 'Your password is: '];
  static List<String> nombreVacio = ['El campo (nombre) está vacio', 'The (name) field is empty'];
  static List<String> contrasenaVacio = ['El campo (contraseña) está vacio', 'The (password) field is empty'];
  static List<String> noExistenUsuarios = ['El campo (contraseña) está vacio', 'Dont be sly, there are no users.'];
  static List<String> noUsuarioCredenciales = ['No existe ningún usuario con esas credenciales', 'No user exists with those credentials.'];
  static List<String> usuarioBloqueado = ['Tu usuario ha sido bloqueado', 'Your user has beenn blocked'];
  static String getTexto(List<String> texto){
    return texto[idiomaSeleccionado];
  }
}