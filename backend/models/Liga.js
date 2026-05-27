const { getConnection } = require('../config/database');

class Liga {
  constructor(id_liga, nombre, cod_invitacion, propietario_id, tipo, cap_de_participantes, fase) {
    this.id_liga = id_liga;
    this.nombre = nombre;
    this.cod_invitacion = cod_invitacion;
    this.propietario_id = propietario_id;
    this.tipo = tipo;
    this.cap_de_participantes = cap_de_participantes;
    this.cap_participantes = cap_de_participantes;
    this.fase = fase;
  }

  static async getAll() {
    const connection = await getConnection();
    try {
      const [rows] = await connection.execute('SELECT * FROM ligas');
      return rows.map(row => new Liga(
        row.id_liga,
        row.nombre,
        row.cod_invitacion,
        row.propietario_id,
        row.tipo,
        row.cap_participantes ?? row.cap_de_participantes,
        row.fase
      ));
    } finally {
      connection.release();
    }
  }

  static async getById(id_liga) {
    const connection = await getConnection();
    try {
      const [rows] = await connection.execute(
        'SELECT * FROM ligas WHERE id_liga = ?',
        [id_liga]
      );
      if (rows.length === 0) return null;
      const row = rows[0];
      return new Liga(
        row.id_liga,
        row.nombre,
        row.cod_invitacion,
        row.propietario_id,
        row.tipo,
        row.cap_participantes ?? row.cap_de_participantes,
        row.fase
      );
    } finally {
      connection.release();
    }
  }

  static async getLigasByUsuario(usuarioId) {
    const connection = await getConnection();
    try {
      const [rows] = await connection.execute(
        'SELECT l.*, u.nombre AS propietario_nombre FROM ligas l JOIN liga_participantes lp ON l.id_liga = lp.id_liga LEFT JOIN usuarios u ON l.propietario_id = u.id WHERE lp.id_usuario = ?',
        [usuarioId]
      );
      return rows;
    } finally {
      connection.release();
    }
  }

  static async getParticipantCount(id_liga) {
    const connection = await getConnection();
    try {
      const [rows] = await connection.execute(
        'SELECT COUNT(*) as count FROM liga_participantes WHERE id_liga = ?',
        [id_liga]
      );
      return rows[0].count || 0;
    } finally {
      connection.release();
    }
  }

  static async getParticipants(id_liga) {
    const connection = await getConnection();
    try {
      const [rows] = await connection.execute(
        'SELECT u.* FROM usuarios u JOIN liga_participantes lp ON u.id = lp.id_usuario WHERE lp.id_liga = ?',
        [id_liga]
      );
      return rows;
    } finally {
      connection.release();
    }
  }

  static async isUserInLiga(id_liga, id_usuario) {
    const connection = await getConnection();
    try {
      const [rows] = await connection.execute(
        'SELECT * FROM liga_participantes WHERE id_liga = ? AND id_usuario = ?',
        [id_liga, id_usuario]
      );
      return rows.length > 0;
    } finally {
      connection.release();
    }
  }

  static async joinLiga(id_liga, id_usuario) {
    const connection = await getConnection();
    try {
      const alreadyJoined = await Liga.isUserInLiga(id_liga, id_usuario);
      if (alreadyJoined) return false;
      await connection.execute(
        'INSERT INTO liga_participantes (id_liga, id_usuario) VALUES (?, ?)',
        [id_liga, id_usuario]
      );
      return true;
    } finally {
      connection.release();
    }
  }

  static async getByNombre(nombre) {
    const connection = await getConnection();
    try {
      const [rows] = await connection.execute(
        'SELECT * FROM ligas WHERE LOWER(nombre) = LOWER(?)',
        [nombre.trim()]
      );
      if (rows.length === 0) return null;
      const row = rows[0];
      return new Liga(
        row.id_liga,
        row.nombre,
        row.cod_invitacion,
        row.propietario_id,
        row.tipo,
        row.cap_participantes ?? row.cap_de_participantes,
        row.fase
      );
    } finally {
      connection.release();
    }
  }

  static async create(liga) {
    const connection = await getConnection();
    try {
      const cap = liga.cap_de_participantes ?? liga.cap_participantes;
      const [result] = await connection.execute(
        'INSERT INTO ligas (nombre, cod_invitacion, propietario_id, tipo, cap_participantes, fase) VALUES (?, ?, ?, ?, ?, ?)',
        [liga.nombre, liga.cod_invitacion, liga.propietario_id, liga.tipo, cap, liga.fase || 'Fase de Grupos: Jornada 1']
      );
      const insertId = result.insertId;
      if (liga.propietario_id) {
        await connection.execute(
          'INSERT INTO liga_participantes (id_liga, id_usuario) VALUES (?, ?)',
          [insertId, liga.propietario_id]
        );
      }
      return new Liga(
        insertId,
        liga.nombre,
        liga.cod_invitacion,
        liga.propietario_id,
        liga.tipo,
        cap,
        liga.fase || 'Fase de Grupos: Jornada 1'
      );
    } finally {
      connection.release();
    }
  }

  static async update(id_liga, liga) {
    const connection = await getConnection();
    try {
      const cap = liga.cap_de_participantes ?? liga.cap_participantes;
      await connection.execute(
        'UPDATE ligas SET nombre = ?, cod_invitacion = ?, propietario_id = ?, tipo = ?, cap_participantes = ?, fase = ? WHERE id_liga = ?',
        [liga.nombre, liga.cod_invitacion, liga.propietario_id, liga.tipo, cap, liga.fase || 'Fase de Grupos: Jornada 1', id_liga]
      );
      return await Liga.getById(id_liga);
    } finally {
      connection.release();
    }
  }

  static async delete(id_liga) {
    const connection = await getConnection();
    try {
      await connection.execute('DELETE FROM ligas WHERE id_liga = ?', [id_liga]);
    } finally {
      connection.release();
    }
  }
}

module.exports = Liga;
