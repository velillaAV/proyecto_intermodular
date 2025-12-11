import 'package:proyecto_intermodular/config/translations/languagesInicioSesion.dart';

class Languagespedidoswidget {
  static int idiomaSeleccionado = Languagesiniciosesion.idiomaSeleccionado;

  static List<String> noEncuentraPedido = ['No se ha encontrado nigún pedido', 'No order found','Aucune commande trouvée'];
  static List<String> numPedido = ['Numero de pedido: ', 'Order number: ','Numéro de commande: '];
  static List<String> estado = ['Estado: ', 'State: ','État:'];
  static List<String> generoNuevo = ['Género nuevo', 'New genre','Nouveau genre'];
  static List<String> edadNueva = ['Edad nueva', 'New age','nouvel âge'];
  static List<String> lugarNacimiento = ['Lugar de Nacimiento', 'Place of birth','Lieu de naissance'];
  static List<String> guardarCambios = ['Guardar cambios', 'Save changes','Enregistrer les modifications'];

  static String getTexto(List<String> texto){
      return texto[idiomaSeleccionado];
}
}