import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/translations/languagesInicioSesion.dart';
import 'package:proyecto_intermodular/services/LogicaUsuarios.dart';

class Pantallainiciosesion extends StatefulWidget {
  const Pantallainiciosesion({super.key});

  @override
  State<Pantallainiciosesion> createState() => _PantallainiciosesionState();
}

class _PantallainiciosesionState extends State<Pantallainiciosesion> {
  void _inicioSesion() {
    if (_nombre.isEmpty) {
      print(Languagesiniciosesion.getTexto(Languagesiniciosesion.nombreVacio));
      final snackBarNombre = SnackBar(
        content: Text(Languagesiniciosesion.getTexto(Languagesiniciosesion.nombreVacio)),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBarNombre);
    } else if (_contrasena.isEmpty) {
      print(Languagesiniciosesion.getTexto(Languagesiniciosesion.contrasenaVacio));
      final snackBarContrasena = SnackBar(
        content: Text(Languagesiniciosesion.getTexto(Languagesiniciosesion.contrasenaVacio)),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBarContrasena);
    } else if (Logicausuario.getListaUsuarios().isEmpty) {
      print(Languagesiniciosesion.getTexto(Languagesiniciosesion.noExistenUsuarios));
      final snackBarNoHayUsuarios = SnackBar(
        content: Text(Languagesiniciosesion.getTexto(Languagesiniciosesion.noExistenUsuarios)),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBarNoHayUsuarios);

    } else if (Logicausuario.confirmarUsuarios(_nombre, _contrasena) == false &&
        Logicausuario.confirmarAdmins(_nombre, _contrasena) == false &&
        Logicausuario.confirmarAdmin(_nombre, _contrasena) == false) {
      print(Languagesiniciosesion.getTexto(Languagesiniciosesion.noUsuarioCredenciales));
      final snackBarValidador = SnackBar(
        content: Text(Languagesiniciosesion.getTexto(Languagesiniciosesion.noUsuarioCredenciales)),
      );

    } else if (Logicausuario.confirmarBloqueo(_nombre, _contrasena) == true) {
      print(Languagesiniciosesion.getTexto(Languagesiniciosesion.usuarioBloqueado));
      final snackBarValidador = SnackBar(
        content: Text(Languagesiniciosesion.getTexto(Languagesiniciosesion.usuarioBloqueado)),

      );
      ScaffoldMessenger.of(context).showSnackBar(snackBarValidador);
     } else if (Logicausuario.confirmarUsuarios(_nombre, _contrasena) == false && Logicausuario.confirmarAdmins(_nombre, _contrasena) == false && Logicausuario.confirmarAdmin(_nombre, _contrasena) == false) {
      print(Languagesiniciosesion.getTexto(Languagesiniciosesion.noUsuarioCredenciales));
      final snackBarValidador = SnackBar(
        content: Text(Languagesiniciosesion.getTexto(Languagesiniciosesion.noUsuarioCredenciales)),

      );
      ScaffoldMessenger.of(context).showSnackBar(snackBarValidador);
    } else if (Logicausuario.confirmarAdmins(_nombre, _contrasena) == true ||
        Logicausuario.confirmarAdmin(_nombre, _contrasena) == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPrincipalAdmin()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
      );
    }
  }

  void _registrar() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PantallaRegistrar()),
    );
  }

  void _contrasenaRecuperada(String valor) {
   String? _contrasenaRecu = Logicausuario.recuperarContrasena(valor);

    if (_contrasenaRecu.isEmpty) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(title: Text("Languagesiniciosesion.getTexto(Languagesiniciosesion.noExisteElUsuario)")),
      );
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(title: Row(
              children: [
                Text(
                  "Languagesiniciosesion.getTexto(Languagesiniciosesion.tuContrasenaEs)"
                ),
                Text(_contrasenaRecu!)
              ],
            )),
      );
    }
  }


  void _inicioSesionGoogle(userCredential) async {
    if (userCredential != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
      );
    }
  }

  void _cambiarIdioma(int nuevoIdioma){
    setState(() {
      Languagesiniciosesion.idiomaSeleccionado = nuevoIdioma;
    });

  }

  
  
  String _nombre = "";
  String _contrasena = "";
  String? _contrasenaRecu = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(181, 226, 66, 66),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SizedBox(width: 10),
            Text(
              "Languagesiniciosesion.getTexto(Languagesiniciosesion.titulo)",
              style: TextStyle(color: Color.fromARGB(255, 240, 240, 240)),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 8, 113, 212),
        actions: [
          DropdownButton<int>(
            icon: Icon(Icons.language),
            items: [
              DropdownMenuItem(
                value: 0,
                child: Text("Español", style: TextStyle(color: Colors.black),)
              ),
              DropdownMenuItem(
                value: 1,
                child: Text("English", style: TextStyle(color: Colors.black),)
              ),
            ], 
            onChanged: (value){
              _cambiarIdioma(value!);
            }
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset("images/logoEmpresa.png",
                                width: 200,
                                height: 200,),
            SizedBox(height: 30),
            Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Languagesiniciosesion.getTexto(Languagesiniciosesion.nombre)",
                          helperMaxLines: 5,
                        ),
                        onChanged: (value) {
                          _nombre = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hoverColor: Color.fromARGB(255, 8, 113, 212),
                          border: OutlineInputBorder(),
                          labelText: "Languagesiniciosesion.getTexto(Languagesiniciosesion.contrasena)",
                          helperMaxLines: 5,
                        ),
                        onChanged: (value) {
                          _contrasena = value;
                        },
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _inicioSesion,
                  style: CustomStyles.estiloBotones,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Languagesiniciosesion.getTexto(Languagesiniciosesion.iniciarSesion)")]),
                ),
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () async {
                    final userCredential = await UserControllers.loginGoogle();
                    _inicioSesionGoogle(userCredential);
                  },
                  style: CustomStyles.estiloBotones,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text(Languagesiniciosesion.getTexto(Languagesiniciosesion.accederGoogle))]),
                ),
                SizedBox(height: 5),
              ],
            ),
            ElevatedButton(
              onPressed: _registrar,
              style: CustomStyles.estiloBotones,
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Languagesiniciosesion.getTexto(Languagesiniciosesion.registrarse)")]),
            ),
            //Aquí introducimos la opción de recuperar la contraseña incluyendo dos Alert Dialog, uno para pedir el usuario y otro para mostrar la contraseña en caso de que el usuario
            //sea correcto
            SizedBox(height: 20),
            TextButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text("Languagesiniciosesion.getTexto(Languagesiniciosesion.recuperarContrasena)"),
                  content: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Languagesiniciosesion.getTexto(Languagesiniciosesion.nombreUsuario)",
                    ),
                    onFieldSubmitted: (value) {
                      _contrasenaRecuperada(value);
                    },
                  ),
                ),
              ),

              child: Text("Languagesiniciosesion.getTexto(Languagesiniciosesion.olvidasteContrasena)"),
            ),
          ],
        ),
      ),
    );
  }
}