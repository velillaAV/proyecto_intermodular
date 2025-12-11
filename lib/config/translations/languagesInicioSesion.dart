class Languagesiniciosesion {
  static int idiomaSeleccionado = 0;

  static List<String> titulo = ['Pantalla Inicio sesión', 'Login screen','Écran de connexion'];
  static List<String> nombre  = ['Nombre', 'Name', 'Nom'];
  static List<String> contrasena = ['Contraseña', 'Password', 'Mot de passe'];
  static List<String> iniciarSesion = ['Iniciar Sesión', 'Log in', 'Se connecter'];
  static List<String> accederGoogle = ['Acceder con Google', 'Access with Google','Acceder avec Google'];
  static List<String> recuperarContrasena = ['Recuperar contraseña', 'Recover password','Récupérer le mot de passe'];
  static List<String> nombreUsuario = ['Nombre de usuario', 'User name','Nom de utilisateur'];
  static List<String> olvidasteContrasena = ['¿Olvidaste tu contraseña?', 'Forgot your password?','Mot de passe oublié ?'];
  static List<String> registrarse = ['Registrarse', 'Register','Registre'];
  static List<String> noExisteElUsuario = ['No existe el usuario', 'The user does not exist','Le utilisateur non existe pas.'];
  static List<String> tuContrasenaEs = ['Tu contraseña es: ', 'Your password is: ','Votre mot de passe est : '];
  static List<String> nombreVacio = ['El campo (nombre) está vacio', 'The (name) field is empty','Le champ (nom) est vide.'];
  static List<String> contrasenaVacio = ['El campo (contraseña) está vacio', 'The (password) field is empty','Le champ (mot de passe) est vide.'];
  static List<String> noExistenUsuarios = ['El campo (contraseña) está vacio', 'Dont be sly, there are no users.','Ne soyez pas sournois, il non y a pas de utilisateurs.'];
  static List<String> noUsuarioCredenciales = ['No existe ningún usuario con esas credenciales', 'No user exists with those credentials.','Aucun utilisateur ne possède ces identifiants'];
  static List<String> usuarioBloqueado = ['Tu usuario ha sido bloqueado', 'Your user has beenn blocked', 'Votre compte utilisateur a été bloqué'];
  static String getTexto(List<String> texto){
    return texto[idiomaSeleccionado];
  }
}