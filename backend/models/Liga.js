const { getConnection } = require('../config/database');

class Liga {
  constructor(id_liga, nombre, cod_invitacion, propietario_id, tipo, cap_de_participantes, fase) {
    this.id_liga = id_liga;
    this.nombre = nombre;
    this.cod_invitacion = cod_invitacion;
    this.propietario_id = propietario_id;
    this.tipo = tipo;
    this.cap_de_participantes = cap_de_participantes;
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
        row.cap_de_participantes,
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
        row.cap_de_participantes,
        row.fase
      );
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
        row.cap_de_participantes,
        row.fase
      );
    } finally {
      connection.release();
    }
  }

  static async create(liga) {
    const connection = await getConnection();
    try {
      const [result] = await connection.execute(
        'INSERT INTO ligas (nombre, cod_invitacion, propietario_id, tipo, cap_de_participantes, fase) VALUES (?, ?, ?, ?, ?, ?)',
        [liga.nombre, liga.cod_invitacion, liga.propietario_id, liga.tipo, liga.cap_de_participantes, liga.fase || 'Fase de Grupos: Jornada 1']
      );
      return new Liga(
        result.insertId,
        liga.nombre,
        liga.cod_invitacion,
        liga.propietario_id,
        liga.tipo,
        liga.cap_de_participantes,
        liga.fase || 'Fase de Grupos: Jornada 1'
      );
    } finally {
      connection.release();
    }
  }

  static async update(id_liga, liga) {
    const connection = await getConnection();
    try {
      await connection.execute(
        'UPDATE ligas SET nombre = ?, cod_invitacion = ?, propietario_id = ?, tipo = ?, cap_de_participantes = ?, fase = ? WHERE id_liga = ?',
        [liga.nombre, liga.cod_invitacion, liga.propietario_id, liga.tipo, liga.cap_de_participantes, liga.fase || 'Fase de Grupos: Jornada 1', id_liga]
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
