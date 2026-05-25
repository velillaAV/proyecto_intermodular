const Usuario = require('../models/Usuario');
console.log("Gestionando Usuarios????")

// Obtener todos los usuarios
const getUsuarios = async (req, res) => {
  try {
    const usuarios = await Usuario.getAll();
    res.json(usuarios);
  } catch (error) {
    console.error('Error al obtener usuarios:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
};

// Obtener usuario por ID
const getUsuarioById = async (req, res) => {
  try {
    const { id } = req.params;
    const usuario = await Usuario.getById(id);
    if (!usuario) {
      return res.status(404).json({ error: 'Usuario no encontrado' });
    }
    res.json(usuario);
  } catch (error) {
    console.error('Error al obtener usuario:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
};

// Crear nuevo usuario
const createUsuario = async (req, res) => {
  try {
    const usuario = req.body;

    if (!usuario.nombre || !usuario.contrasena) {
      return res.status(400).json({ error: 'Nombre y contraseña son requeridos' });
    }

    const existente = await Usuario.getByNombre(usuario.nombre);
    if (existente) {
      return res.status(400).json({ error: 'El nombre de usuario ya existe' });
    }

    const nuevoUsuario = await Usuario.create(usuario);
    res.status(201).json(nuevoUsuario);
  } catch (error) {
    console.error('Error al crear usuario:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
};

const updateUsuario = async (req, res) => {
  try {
    const { id } = req.params;
    const { nombre, lugarNacimiento } = req.body;
    if (!nombre || !lugarNacimiento) {
      return res.status(400).json({ error: 'Nombre y lugar de nacimiento son requeridos' });
    }
    const usuario = await Usuario.update(id, nombre, lugarNacimiento);
    res.json(usuario);
  } catch (error) {
    console.error('Error al actualizar usuario:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
};

// Eliminar usuario
const deleteUsuario = async (req, res) => {
  try {
    const { id } = req.params;
    await Usuario.delete(id);
    res.json({ message: 'Usuario eliminado correctamente' });
  } catch (error) {
    console.error('Error al eliminar usuario:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
};

const login = async (req, res) => {
  try {
    const { nombre, contrasena } = req.body;

    const usuario = await Usuario.getByNombre(nombre);

    if (!usuario || usuario.contrasena !== contrasena) {
      return res.status(401).json({ error: 'Credenciales incorrectas' });
    }

    res.json(usuario);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = {
  getUsuarios,
  getUsuarioById,
  createUsuario,
  updateUsuario,
  deleteUsuario,
  login
};