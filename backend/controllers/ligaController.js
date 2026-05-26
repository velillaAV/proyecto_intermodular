const Liga = require('../models/Liga');
const fs = require('fs');

const getLigas = async (req, res) => {
  try {
    const ligas = await Liga.getAll();
    res.status(200).json(ligas);
  } catch (error) {
    console.error('Error al obtener ligas:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
};

const getLigaById = async (req, res) => {
  try {
    const { id } = req.params;
    const liga = await Liga.getById(id);
    if (!liga) {
      return res.status(404).json({ error: 'Liga no encontrada' });
    }
    res.json(liga);
  } catch (error) {
    console.error('Error al obtener liga por ID:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
};

const getLigaByNombre = async (req, res) => {
  try {
    const { nombre } = req.params;
    const liga = await Liga.getByNombre(nombre);
    if (!liga) {
      return res.status(404).json({ error: 'Liga no encontrada' });
    }
    res.json(liga);
  } catch (error) {
    console.error('Error al obtener liga por nombre:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
};

const getLigasByUsuario = async (req, res) => {
  try {
    const { id } = req.params;
    const ligas = await Liga.getLigasByUsuario(id);
    res.json(ligas);
  } catch (error) {
    console.error('Error al obtener ligas del usuario:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
};

const joinLiga = async (req, res) => {
  try {
    const { id } = req.params;
    const { id_usuario } = req.body;

    if (!id_usuario) {
      return res.status(400).json({ error: 'id_usuario es requerido para unirse a la liga' });
    }

    const liga = await Liga.getById(id);
    if (!liga) {
      return res.status(404).json({ error: 'Liga no encontrada' });
    }

    const participaciones = await Liga.getParticipantCount(id);
    if (participaciones >= liga.cap_de_participantes) {
      return res.status(400).json({ error: 'La liga ya está llena' });
    }

    const joined = await Liga.joinLiga(id, id_usuario);
    if (!joined) {
      return res.status(400).json({ error: 'El usuario ya está en esta liga' });
    }

    res.json({ message: 'Usuario unido a la liga' });
  } catch (error) {
    console.error('Error al unir usuario a la liga:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
};

const createLiga = async (req, res) => {
  try {
    const liga = req.body;
    const cap = liga.cap_de_participantes ?? liga.cap_participantes;
    console.log('POST /ligas body:', JSON.stringify(liga));
    try {
      const raw = req.rawBody || JSON.stringify(liga);
      fs.appendFileSync('ligas_debug.log', `--- ${new Date().toISOString()} REQUEST RAW: ${raw}\n`);
    } catch (e) {
      // ignore logging errors
    }
    if (!liga.nombre || !liga.cod_invitacion || cap == null) {
      return res.status(400).json({ error: 'Nombre, código de invitación y capacidad de participantes son requeridos' });
    }

    const nuevoLiga = await Liga.create({
      nombre: liga.nombre,
      cod_invitacion: liga.cod_invitacion,
      propietario_id: liga.propietario_id || null,
      tipo: liga.tipo || 'normal',
      cap_participantes: cap,
      cap_de_participantes: cap,
      fase: liga.fase || 'Fase de Grupos: Jornada 1'
    });

    res.status(201).json(nuevoLiga);
  } catch (error) {
    try {
      fs.appendFileSync('ligas_debug.log', `ERROR ${new Date().toISOString()}: ${error.stack || error.toString()}\n\n`);
    } catch (e) {}
    console.error('Error al crear liga:', error);
    res.status(500).json({ error: error.message });
  }
};

const updateLiga = async (req, res) => {
  try {
    const { id } = req.params;
    const liga = req.body;
    const cap = liga.cap_de_participantes ?? liga.cap_participantes;
    const ligaActualizada = await Liga.update(id, {
      nombre: liga.nombre,
      cod_invitacion: liga.cod_invitacion,
      propietario_id: liga.propietario_id || null,
      tipo: liga.tipo || 'normal',
      cap_participantes: cap,
      cap_de_participantes: cap,
      fase: liga.fase || 'Fase de Grupos: Jornada 1'
    });
    if (!ligaActualizada) {
      return res.status(404).json({ error: 'Liga no encontrada' });
    }
    res.json(ligaActualizada);
  } catch (error) {
    console.error('Error al actualizar liga:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
};

const deleteLiga = async (req, res) => {
  try {
    const { id } = req.params;
    await Liga.delete(id);
    res.json({ message: 'Liga eliminada correctamente' });
  } catch (error) {
    console.error('Error al eliminar liga:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
};

module.exports = {
  getLigas,
  getLigaById,
  getLigaByNombre,
  getLigasByUsuario,
  joinLiga,
  createLiga,
  updateLiga,
  deleteLiga
};
