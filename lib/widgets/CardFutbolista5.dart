import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/constantes/colors.dart';
import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloOferta.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/models/liga.dart';
import 'package:proyecto_intermodular/services/LogicaUsuarios.dart';
import 'package:proyecto_intermodular/widgets/CardOfertas.dart';

//Carta de jugador que aparece al visualizar la plantilla de un usuario en una Liga Normal

class CardFutbolista5 extends StatefulWidget {
  const CardFutbolista5({
    super.key,
    required this.usuario,
    required this.jugador,
    required this.actualizar,
    required this.liga,
  });
  final Modelousuario usuario;
  final Modelojugador jugador;
  final Liga liga;
  final void Function() actualizar;
  @override
  State<CardFutbolista5> createState() => _CardFutbolista5State();
}

class _CardFutbolista5State extends State<CardFutbolista5> {
  Color colorPosicion = Colorcetes.porteroColor;

  void _ofertar() {
    final usuarioActualList = Logicausuario.usuarioActual.usuario_ligas
        .where((user) => user.ligaPerteneciente == widget.liga)
        .toList();
    if (usuarioActualList.isEmpty) return;
    Modelousuario usuarioActual = usuarioActualList.first;
    final snackBarValidadorValor = SnackBar(
      content: Text("Esa oferta supera tu saldo"),
    );
    final snackBarValidadorValor2 = SnackBar(
      content: Text("Ese valor es menor que el definido del jugador"),
    );
    double oferta = widget.jugador.valor_venta;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("¿Quieres ofertar por este jugador?"),
        content: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          onChanged: (value) => oferta = double.parse(value),
          decoration: InputDecoration(
            hintText: widget.jugador.valor_venta.toString(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => {
              if (usuarioActual.saldo < oferta)
                {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(snackBarValidadorValor),
                }
              else if (oferta < widget.jugador.valor_venta)
                {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(snackBarValidadorValor2),
                }
              else
                {
                  setState(() {
                    widget.jugador.oferta.add(Oferta(usuarioActual, oferta));
                    usuarioActual.restarSaldo(oferta);
                    widget.actualizar();
                    Navigator.pop(context);
                  }),
                },
            },
            child: Text("Aceptar"),
          ),
        ],
      ),
    );
  }

  void _clausulazo() {
    int pos = widget.usuario.alineacion.indexOf(widget.jugador);
    final usuarioActualList = Logicausuario.usuarioActual.usuario_ligas
        .where((user) => user.ligaPerteneciente == widget.liga)
        .toList();
    if (usuarioActualList.isEmpty) return;
    Modelousuario usuarioActual = usuarioActualList.first;
    double clausula = widget.jugador.valor_clausula;
    final snackBarValidadorValor3 = SnackBar(
      content: Text("Esa oferta supera tu saldo"),
    );
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("¿Quieres pagar la clausula de este jugador?"),
        content: TextButton(
          onPressed: () => {
            if (usuarioActual.saldo < clausula)
              {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(snackBarValidadorValor3),
              }
            else
              {
                setState(() {
                  widget.usuario.equipo.equipo.remove(widget.jugador);
                  if (widget.usuario.alineacion.contains(widget.jugador)) {
                    widget.usuario.alineacion.remove(widget.jugador);
                    widget.usuario.alineacion.insert(pos, null);
                  }
                  if (widget.usuario.equipo.suplentes.contains(
                    widget.jugador,
                  )) {
                    widget.usuario.equipo.suplentes.remove(widget.jugador);
                    usuarioActual.equipo.equipo.add(widget.jugador);
                    usuarioActual.equipo.suplentes.add(widget.jugador);
                    usuarioActual.restarSaldo(widget.jugador.valor_clausula);
                    widget.actualizar();
                    Navigator.pop(context);
                  }
                }),
              },
          },
          child: Text("Aceptar"),
        ),
      ),
    );
  }

  void _revisarOfertas() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text("OFERTAS"),
        content: Container(
          width: 1600,
          height: 1600,
          color: const Color.fromARGB(255, 95, 96, 96),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widget.jugador.oferta.length,
                  itemBuilder: (context, index) {
                    widget.actualizar();
                    return CardOfertas(
                      usuario: widget.usuario,
                      jugador: widget.jugador,
                      actualizar: widget.actualizar,
                      liga: widget.liga,
                      posicion: index,
                      ofertador: widget.jugador.oferta[index].usuario,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _aumentarClausula() {
    final snackBarValidadorValor4 = SnackBar(
      content: Text("Esa subida de clausula supera tu saldo"),
    );
    double sumaClausula = widget.jugador.valor_clausula;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("¿Quieres subir la clausula de este jugador?"),
        content: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          onChanged: (value) => sumaClausula = double.parse(value),
          decoration: InputDecoration(
            hintText: widget.jugador.valor_venta.toString(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => {
              if (widget.usuario.saldo < sumaClausula)
                {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(snackBarValidadorValor4),
                }
              else
                {
                  setState(() {
                     widget.jugador.aumentarClausula(sumaClausula);
                  Navigator.pop(context);
                  }),
                 
                },
            },
            child: Text("Aceptar"),
          ),
        ],
      ),
    );
  }

  void _ponerAlMercado() {
    int pos = widget.usuario.alineacion.indexOf(widget.jugador);
    final snackBarValidadorValor5 = SnackBar(
      content: Text("Ese valor de venta supera tu saldo"),
    );
    final snackBarValidadorValor6 = SnackBar(
      content: Text("Ese valor es menor que el definido del jugador"),
    );
    double valorVenta = widget.jugador.valor_venta;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("¿Quieres poner en el mercado a este jugador?"),
        content: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          onChanged: (value) => valorVenta = double.parse(value),
          decoration: InputDecoration(
            hintText: widget.jugador.valor_venta.toString(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => {
              if (widget.usuario.saldo < valorVenta)
                {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(snackBarValidadorValor5),
                }
              else if (valorVenta < widget.jugador.valor_venta)
                {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(snackBarValidadorValor6),
                }
              else
                {
                  setState(() {
                    widget.jugador.definirValorVenta(valorVenta);
                  widget.liga.mercado.jugadores.add(widget.jugador);
                  widget.usuario.equipo.equipo.remove(widget.jugador);

                  if (widget.usuario.alineacion.contains(widget.jugador))
                    {
                      widget.usuario.alineacion.remove(widget.jugador);
                      widget.usuario.alineacion.insert(pos, null);
                    }

                  if (widget.usuario.equipo.suplentes.contains(widget.jugador))
                    {widget.usuario.equipo.suplentes.remove(widget.jugador);}
                  widget.actualizar();
                  Navigator.pop(context);
                  }),
                  
                },
            },
            child: Text("Aceptar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.jugador.posicion == "DEF") {
      colorPosicion = Colorcetes.defenseColor;
    } else {
      if (widget.jugador.posicion == "CEN") {
        colorPosicion = Colorcetes.centroCampistaColor;
      } else {
        if (widget.jugador.posicion == "DEL") {
          colorPosicion = Colorcetes.delanteroColor;
        }
      }
    }

    widget.liga.comprobarSubastas();
    final usuarioActualList = Logicausuario.usuarioActual.usuario_ligas
        .where((user) => user.ligaPerteneciente == widget.liga)
        .toList();
    final usuarioActualLiga = usuarioActualList.isNotEmpty ? usuarioActualList.first : null;
    return Container(
      decoration: BoxDecoration(
        color: widget.jugador.isIcono == true ? Colors.amber : Colors.black,
        border: Border.all(color: Colors.white),
      ),

      child: Row(
        children: [
          Stack(
            children: [
              Container(width: 0, height: 0),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 10),

          // Info central
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: colorPosicion,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        widget.jugador.posicion,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        widget.jugador.nombre,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Valor venta",
                          style: TextStyle(fontSize: 10, color: Colors.white54),
                        ),
                        Text(
                          widget.jugador.valor_venta.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 15),
                  ],
                ),
              ],
            ),
          ),

          // Porcentaje
          SizedBox(height: 20),
          if (usuarioActualLiga != null && widget.usuario != usuarioActualLiga)
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'ofertar') {
                  _ofertar();
                } else if (value == 'clausulazo') {
                  _clausulazo();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(value: 'ofertar', child: Text('Ofertar')),
                if(widget.liga.hayClausulazos == true) 
                PopupMenuItem(value: 'clausulazo', child: Text('Clausular')),
              ],
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text("Acciones", style: TextStyle(color: Colors.black)),
              ),
            ),

          if (usuarioActualLiga != null && widget.usuario == usuarioActualLiga)
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'revisarOfertas') {
                  _revisarOfertas();
                } else if (value == 'aumentarClausula') {
                  _aumentarClausula();
                } else {
                  _ponerAlMercado();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'revisarOfertas',
                  child: Text('Revisar Ofertas'),
                ),
                if(widget.liga.hayClausulazos == true) 
                PopupMenuItem(
                  value: 'aumentarClausula',
                  child: Text('Aumentar Clausula'),
                ),
                PopupMenuItem(
                  value: 'venderAlMercado',
                  child: Text('Poner en el mercado'),
                ),
              ],
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text("Acciones", style: TextStyle(color: Colors.black)),
              ),
            ),
        ],
      ),
    );
  }
}
