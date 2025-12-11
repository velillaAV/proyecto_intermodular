
import 'package:proyecto_intermodular/config/translations/languagesInicioSesion.dart';

class Languageseditarusuario {
  static int idiomaSeleccionado = Languagesiniciosesion.idiomaSeleccionado;

  static List<String> nombreNuevo = ['Nombre nuevo', 'new name','nouveau nom'];
  static List<String> titulo = ['Editar usuario', 'Edit user','Modifier le utilisateur'];
  static List<String> contraNueva = ['Contraseña nueva', 'New password','Nouveau mot de passe'];
  static List<String> generoNuevo = ['Género nuevo', 'New genre','Nouveau genre'];
  static List<String> edadNueva = ['Edad nueva', 'New age','nouvel âge'];
  static List<String> lugarNacimiento = ['Lugar de Nacimiento', 'Place of birth','Lieu de naissance'];
  static List<String> guardarCambios = ['Guardar cambios', 'Save changes','Enregistrer les modifications'];

  static String getTexto(List<String> texto){
      return texto[idiomaSeleccionado];
  }
}