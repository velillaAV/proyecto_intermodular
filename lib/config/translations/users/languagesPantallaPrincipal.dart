
import 'package:proyecto_intermodular/config/translations/languagesInicioSesion.dart';

class Languagespantallaprincipal {
  static int idiomaSeleccionado = Languagesiniciosesion.idiomaSeleccionado;

  static List<String> titulo = ['Bienvenido ', 'Welcome ','Bienvenue '];
  static List<String> compras = ['Compras', 'Shopping','Achats'];
  static List<String> pedidos = ['Pedidos', 'Orders','Ordres'];
  static List<String> yo = ['Mi perfil', 'My profile','Mon profil'];

  static String getTexto(List<String> texto){
      return texto[idiomaSeleccionado];
  }
}