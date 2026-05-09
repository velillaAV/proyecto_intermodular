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

// Generar equipo aleatorio
const generarEquipo = async (req, res) => {
  console.log("Intentando generar equipo")
  try {
    const porteros = await Jugador.getByPosicion('POR');
    const defensas = await Jugador.getByPosicion('DEF');
    const centrocampistas = await Jugador.getByPosicion('CEN');
    const atacantes = await Jugador.getByPosicion('DEL');

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
    console.log("Equipo creado")
    equipo.push(...atacantesSeleccionados);
    console.log(equipo);

    res.status(200).json(equipo);
    
  } catch (error) {
    console.error('Error al generar equipo:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
};

module.exports = {
  getJugadores,
  getJugadoresByPosicion,
  getJugadoresByPais,
  createJugador,
  generarEquipo
};