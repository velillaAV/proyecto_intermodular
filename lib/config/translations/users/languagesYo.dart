import 'package:proyecto_intermodular/config/translations/languagesInicioSesion.dart';

class Languagesyo {
  static int idiomaSeleccionado = Languagesiniciosesion.idiomaSeleccionado;

  static List<String> contacto = ['Contacto', 'contact','contact'];
  static List<String> editarUsuario = ['Editar usuario', 'Edit user','Modifier le utilisateur'];
  
  static String getTexto(List<String> texto){
      return texto[idiomaSeleccionado];
  }
}