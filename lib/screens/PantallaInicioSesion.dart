import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/translations/languagesInicioSesion.dart';
import 'package:proyecto_intermodular/config/utils/estiloBotones.dart';
import 'package:proyecto_intermodular/controllers/GoogleControllers.dart';
import 'package:proyecto_intermodular/screens/PantallaPrincipal.dart';
import 'package:proyecto_intermodular/screens/PantallaRegistrar.dart';
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
      final snackBarValidador1 = SnackBar(
        content: Text(Languagesiniciosesion.getTexto(Languagesiniciosesion.noUsuarioCredenciales)),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBarValidador1);
    } else if (Logicausuario.confirmarBloqueo(_nombre, _contrasena) == true) {
      print(Languagesiniciosesion.getTexto(Languagesiniciosesion.usuarioBloqueado));
      final snackBarValidador2 = SnackBar(
        content: Text(Languagesiniciosesion.getTexto(Languagesiniciosesion.usuarioBloqueado)),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBarValidador2);
     } else if (Logicausuario.confirmarUsuarios(_nombre, _contrasena) == false && Logicausuario.confirmarAdmins(_nombre, _contrasena) == false && Logicausuario.confirmarAdmin(_nombre, _contrasena) == false) {
      print(Languagesiniciosesion.getTexto(Languagesiniciosesion.noUsuarioCredenciales));
      final snackBarValidador3 = SnackBar(
        content: Text(Languagesiniciosesion.getTexto(Languagesiniciosesion.noUsuarioCredenciales)),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBarValidador3);
    } else if (Logicausuario.confirmarAdmins(_nombre, _contrasena) == true ||
        Logicausuario.confirmarAdmin(_nombre, _contrasena) == true) {
      // Lógica para admins (actualmente vacía en tu código original)
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
         (route) => false,
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

    if (_contrasenaRecu == null) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(title: Text(Languagesiniciosesion.getTexto(Languagesiniciosesion.noExisteElUsuario))),
      );
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(title: Row(
              children: [
                Text(
                  Languagesiniciosesion.getTexto(Languagesiniciosesion.tuContrasenaEs)
                ),
                Text(_contrasenaRecu)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(181, 255, 255, 255),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [Color.fromARGB(255, 6, 58, 231), Colors.red, Colors.green],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "ROAD TO THE FIFA WORLD CUP 26 APP",
          style: TextStyle(color: Color.fromARGB(255, 240, 240, 240), fontSize: 16),
        ),
        actions: [
          DropdownButton<int>(
            icon: const Icon(Icons.language, color: Colors.white),
            items: const [
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo with subtle 3D effect and rounded corners
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    "images/logoMundial2026.png",
                    width: 180,
                    height: 180,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
              SizedBox(
                width: 250, 
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelText: Languagesiniciosesion.getTexto(Languagesiniciosesion.nombre),
                      ),
                      onChanged: (value) {
                        _nombre = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelText: Languagesiniciosesion.getTexto(Languagesiniciosesion.contrasena),
                      ),
                      onChanged: (value) {
                        _contrasena = value;
                      },
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              
              ElevatedButton(
                onPressed: _inicioSesion,
                style: CustomStyles.estiloBotonInicioSesion,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [Text(Languagesiniciosesion.getTexto(Languagesiniciosesion.iniciarSesion), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))],
                ),
              ),
              const SizedBox(height: 15),
              
              ElevatedButton(
                onPressed: () async {
                  final userCredential = await GoogleControllers.loginGoogle();
                  _inicioSesionGoogle(userCredential);
                },
                style: CustomStyles.estiloBotonGoogle,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [Text(Languagesiniciosesion.getTexto(Languagesiniciosesion.accederGoogle), style: const TextStyle(fontWeight: FontWeight.w500))],
                ),
              ),
              const SizedBox(height: 15),

              ElevatedButton(
                onPressed: _registrar,
                style: CustomStyles.estiloBotonRegistrarse,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [Text(Languagesiniciosesion.getTexto(Languagesiniciosesion.registrarse), style: const TextStyle(fontWeight: FontWeight.bold))],
                ),
              ),
              
              const SizedBox(height: 25),
              
              TextButton(
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(Languagesiniciosesion.getTexto(Languagesiniciosesion.recuperarContrasena)),
                    content: TextFormField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: Languagesiniciosesion.getTexto(Languagesiniciosesion.nombreUsuario),
                      ),
                      onFieldSubmitted: (value) {
                        _contrasenaRecuperada(value);
                      },
                    ),
                  ),
                ),
                child: Text(
                  Languagesiniciosesion.getTexto(Languagesiniciosesion.olvidasteContrasena),
                  style: const TextStyle(color: Color.fromARGB(255, 6, 58, 231), fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}