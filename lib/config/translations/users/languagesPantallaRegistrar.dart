import 'package:proyecto_intermodular/config/translations/languagesInicioSesion.dart';

class Languagespantallaregistrar {

   static int idiomaSeleccionado = Languagesiniciosesion.idiomaSeleccionado;

    static List<String> registrar = ['Registrarse', 'Register', ''];
    static List<String> tratamiento = ['Tratamiento', 'Treatment', ''];
    static List<String> nombre  = ['Nombre', 'Name', 'Nom'];
    static List<String> contrasena = ['Contraseña', 'Password', 'Mot de passe'];
    static List<String> repitecontrasena = ['Repite la Contraseña', 'Repeat the Password', 'Répéter le mot de passe'];
    static List<String> subeFoto = ['Sube una foto', 'Upload a Photo', 'Téléchargez une photo'];
    static List<String> galeria = ['Galeria', 'Gallery', 'Galerie'];
    static List<String> tomarFoto =  ['Tomar foto', 'Gallery', 'Galerie'];
    static List<String> edad = ['Edad', 'Gallery', 'Galerie'];
    static List<String> aceptarTerminos = ['Aceptar Terminos', 'Gallery', 'Galerie'];
    static List<String> lugarNacimiento = ['Lugar de Nacimiento', 'Gallery', 'Galerie'];
    static List<String> aceptar = ['Aceptar', 'Gallery', 'Galerie'];
    static List<String> cancelar = ['Cancelar', 'Gallery', 'Galerie'];




  static String getTexto(List<String> texto){
      return texto[idiomaSeleccionado];
  }
}