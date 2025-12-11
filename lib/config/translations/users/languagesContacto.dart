import 'package:proyecto_intermodular/config/translations/languagesInicioSesion.dart';

class Languagescontacto {
  static int idiomaSeleccionado = Languagesiniciosesion.idiomaSeleccionado;

  static List<String> telefonoContacto = ['Teléfono de contacto', 'Contact phone','Téléphone de contact'];

  static String getTexto(List<String> texto){
      return texto[idiomaSeleccionado];
  }
}