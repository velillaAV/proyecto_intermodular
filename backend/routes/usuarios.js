const express = require('express');
const router = express.Router();
const {
  getUsuarios,
  getUsuarioById,
  createUsuario,
  updateUsuario,
  deleteUsuario
} = require('../controllers/usuarioController');

// GET /usuarios - Obtener todos los usuarios
router.get('/', getUsuarios);

// GET /usuarios/:id - Obtener usuario por ID
router.get('/:id', getUsuarioById);

// POST /usuarios - Crear nuevo usuario
router.post('/', createUsuario);

// PUT /usuarios/:id - Actualizar usuario
router.put('/:id', updateUsuario);

// DELETE /usuarios/:id - Eliminar usuario
router.delete('/:id', deleteUsuario);

module.exports = router;