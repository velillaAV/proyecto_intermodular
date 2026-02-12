import 'package:proyecto_intermodular/config/translations/languagesInicioSesion.dart';

class Languagespantallaregistrar {

   static int idiomaSeleccionado = Languagesiniciosesion.idiomaSeleccionado;

    static List<String> registrar = ['Registrarse', 'Register'];
    static List<String> tratamiento = ['Tratamiento', 'Treatment'];
    static List<String> nombre  = ['Nombre', 'Name'];
    static List<String> contrasena = ['Contraseña', 'Password'];
    static List<String> repitecontrasena = ['Repite la Contraseña', 'Repeat the Password'];
    static List<String> subeFoto = ['Sube una foto', 'Upload a Photo'];
    static List<String> galeria = ['Galeria', 'Gallery'];
    static List<String> tomarFoto =  ['Tomar foto', 'Gallery'];
    static List<String> edad = ['Edad', 'Age'];
    static List<String> aceptarTerminos = ['Aceptar Terminos', 'Acept Terms'];
    static List<String> lugarNacimiento = ['Lugar de Nacimiento', 'Place of Birth'];
    static List<String> aceptar = ['Aceptar', 'Acept'];
    static List<String> cancelar = ['Cancelar', 'Cancel'];




  static String getTexto(List<String> texto){
      return texto[idiomaSeleccionado];
  }
}