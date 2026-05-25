const express = require('express');
const router = express.Router();
const {
  getLigas,
  getLigaById,
  getLigaByNombre,
  getLigasByUsuario,
  joinLiga,
  createLiga,
  updateLiga,
  deleteLiga
} = require('../controllers/ligaController');

// GET /ligas - Obtener todas las ligas
router.get('/', getLigas);

// GET /ligas/usuario/:id - Obtener ligas de un usuario
router.get('/usuario/:id', getLigasByUsuario);

// GET /ligas/nombre/:nombre - Obtener liga por nombre
router.get('/nombre/:nombre', getLigaByNombre);

// GET /ligas/:id - Obtener liga por ID
router.get('/:id', getLigaById);

// POST /ligas/:id/unirse - Unirse a una liga
router.post('/:id/unirse', joinLiga);

// POST /ligas - Crear nueva liga
router.post('/', createLiga);

// PUT /ligas/:id - Actualizar liga
router.put('/:id', updateLiga);

// DELETE /ligas/:id - Eliminar liga
router.delete('/:id', deleteLiga);

module.exports = router;
