const express = require('express');
const router = express.Router();
const {
  getJugadores,
  getJugadoresByPais,
  getJugadoresByPosicion,
  createJugador,
  generarEquipo
} = require('../controllers/jugadorController');

// GET /jugadores - Obtener todos los jugadores
router.get('/', getJugadores);

// GET /jugadores/pais/:pais - Obtener jugadores por pais
router.get('/pais/:pais', getJugadoresByPais);

// GET /jugadores/posicion/:posicion - Obtener jugadores por posición
router.get('/posicion/:posicion', getJugadoresByPosicion);


// POST /jugadores - Crear nuevo jugador
router.post('/', createJugador);

// GET /jugadores/generar-equipo - Generar equipo aleatorio
router.get('/generar-equipo', generarEquipo);

module.exports = router;