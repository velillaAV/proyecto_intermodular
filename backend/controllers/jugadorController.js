const Jugador = require('../models/Jugador');
console.log("Gestionando Jugadores????")
// Obtener todos los jugadores
const getJugadores = async (req, res) => {
  try {
    const jugadores = await Jugador.getAll();
    console.log("jugadores obtenidos")
    res.status(200).json(jugadores);
  } catch (error) {
    console.error('Error al obtener jugadores:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
};

// Obtener jugadores por posición
const getJugadoresByPosicion = async (req, res) => {
  try {
    const { posicion } = req.params;
    const jugadores = await Jugador.getByPosicion(posicion);
    res.json(jugadores);
  } catch (error) {
    console.error('Error al obtener jugadores:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
};

const getJugadoresByPais = async (req, res) => {
  try {
    
    const { pais } = req.params;
    console.log(pais);
    const jugadores = await Jugador.getByPais(pais);
    res.status(200).json(jugadores);
  } catch (error) {
    console.error('Error al obtener jugadores:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
};

// Crear nuevo jugador
const createJugador = async (req, res) => {
  try {
    const jugador = req.body;
    if (!jugador.nombre || !jugador.posicion) {
      return res.status(400).json({ error: 'Nombre y posición son requeridos' });
    }
    const nuevoJugador = await Jugador.create(jugador);
    res.status(201).json(nuevoJugador);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message });
  }
};

const sumarPuntos = async (req, res) => {
  try {
    const {
    id_jugador,
    goles,
    asistencias,
    minutos,
    tarjetas_amarillas,
    tarjetas_rojas
  } = req.body;
   let puntos =
      goles * 5 +
      asistencias * 3 -
      tarjetas_amarillas -
      (tarjetas_rojas * 3);
      if (minutos >= 60) {
        puntos += 2;
      } else {
        puntos += 1;
      }
    await Jugador.actualizarPuntos(puntos, id_jugador);
    res.status(200).json({message: "Se ha actualizado perfectamente"});
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message });
  }
};

const obtenerPuntosJugador = async (req, res) => {
  try {
   

   const { id_jugador } = req.params;
    const puntos = await Jugador.getPuntos(id_jugador);
     res.json({
      "puntos": puntos
    });

  } catch (error) {
    console.error('Error al obtener jugadores:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }

    

   
  

};

// Generar equipo aleatorio
const generarEquipo = async (req, res) => {
  console.log("Intentando generar equipo")
  try {
    console.log("Obteniendo porteros...")
    const porteros = await Jugador.getByPosicion('POR');
    console.log("Porteros encontrados:", porteros.length)
    
    console.log("Obteniendo defensas...")
    const defensas = await Jugador.getByPosicion('DEF');
    console.log("Defensas encontrados:", defensas.length)
    
    console.log("Obteniendo centrocampistas...")
    const centrocampistas = await Jugador.getByPosicion('CEN');
    console.log("Centrocampistas encontrados:", centrocampistas.length)
    
    console.log("Obteniendo atacantes...")
    const atacantes = await Jugador.getByPosicion('DEL');
    console.log("Atacantes encontrados:", atacantes.length)

    if (porteros.length === 0 || defensas.length === 0 || centrocampistas.length === 0 || atacantes.length === 0) {
      console.log("Error: No hay suficientes jugadores en la base de datos");
      return res.status(400).json({ 
        error: 'No hay suficientes jugadores en la base de datos. Verifica que se ejecutó init_db.js correctamente.',
        debug: {
          porteros: porteros.length,
          defensas: defensas.length,
          centrocampistas: centrocampistas.length,
          atacantes: atacantes.length
        }
      });
    }

    const equipo = [];

    // Seleccionar 1 portero
    if (porteros.length > 0) {
      equipo.push(porteros[Math.floor(Math.random() * porteros.length)]);
    }

    // Seleccionar 5 defensas únicos
    const defensasSeleccionados = [];
    while (defensasSeleccionados.length < 5 && defensas.length > 0) {
      const randomIndex = Math.floor(Math.random() * defensas.length);
      const defensa = defensas[randomIndex];
      if (!defensasSeleccionados.find(d => d.id_jugador === defensa.id_jugador)) {
        defensasSeleccionados.push(defensa);
      }
    }
    equipo.push(...defensasSeleccionados);

    // Seleccionar 4 centrocampistas únicos
    const centrocampistasSeleccionados = [];
    while (centrocampistasSeleccionados.length < 4 && centrocampistas.length > 0) {
      const randomIndex = Math.floor(Math.random() * centrocampistas.length);
      const centrocampista = centrocampistas[randomIndex];
      if (!centrocampistasSeleccionados.find(c => c.id_jugador === centrocampista.id_jugador)) {
        centrocampistasSeleccionados.push(centrocampista);
      }
    }
    equipo.push(...centrocampistasSeleccionados);

    // Seleccionar 4 atacantes únicos
    const atacantesSeleccionados = [];
    while (atacantesSeleccionados.length < 4 && atacantes.length > 0) {
      const randomIndex = Math.floor(Math.random() * atacantes.length);
      const atacante = atacantes[randomIndex];
      if (!atacantesSeleccionados.find(a => a.id_jugador === atacante.id_jugador)) {
        atacantesSeleccionados.push(atacante);
      }
    }
    console.log("Equipo creado con " + equipo.length + " jugadores")
    equipo.push(...atacantesSeleccionados);
    console.log(equipo);

    res.status(200).json(equipo);
    
  } catch (error) {
    console.error('Error al generar equipo:', error);
    res.status(500).json({ error: 'Error al generar equipo: ' + error.message });
  }
};

module.exports = {
  getJugadores,
  getJugadoresByPosicion,
  getJugadoresByPais,
  sumarPuntos,
  obtenerPuntosJugador,
  createJugador,
  generarEquipo
};