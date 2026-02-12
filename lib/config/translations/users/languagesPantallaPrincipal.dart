
import 'package:proyecto_intermodular/config/translations/languagesInicioSesion.dart';

class Languagespantallaprincipal {
  static int idiomaSeleccionado = Languagesiniciosesion.idiomaSeleccionado;

  static List<String> titulo = ['Bienvenido ', 'Welcome '];
  

  static String getTexto(List<String> texto){
      return texto[idiomaSeleccionado];
  }
}