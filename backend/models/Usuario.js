const { getConnection } = require('../config/database');

class Usuario {
  constructor(id, nombre, contrasena, genero, edad, lugarNacimiento, fotoRuta, isAdmin, isBlocked) {
    this.id = id;
    this.nombre = nombre;
    this.contrasena = contrasena;
    this.genero = genero;
    this.edad = edad;
    this.lugarNacimiento = lugarNacimiento;
    this.fotoRuta = fotoRuta;
    this.isAdmin = isAdmin;
    this.isBlocked = isBlocked;
  }

  static async getAll() {
    const connection = await getConnection();
    try {
      const [rows] = await connection.execute('SELECT * FROM usuarios');
      return rows.map(row => new Usuario(
        row.id,
        row.nombre,
        row.contrasena,
        row.genero,
        row.edad,
        row.lugarNacimiento,
        row.fotoRuta,
        row.isAdmin,
        row.isBlocked
      ));
    } finally {
      connection.release();
    }
  }

  static async getByNombre(nombre) {
    const connection = await getConnection();
    try {
      const [rows] = await connection.execute(
        'SELECT * FROM usuarios WHERE nombre = ?',
        [nombre]
      );
      if (rows.length === 0) return null;

      const row = rows[0];
      return new Usuario(
        row.id,
        row.nombre,
        row.contrasena,
        row.genero,
        row.edad,
        row.lugarNacimiento,
        row.fotoRuta,
        row.isAdmin,
        row.isBlocked
      );
    } finally {
      connection.release();
    }
  }

  static async create(usuario) {
    const connection = await getConnection();
    try {
      const [result] = await connection.execute(
        `INSERT INTO usuarios 
        (nombre, contrasena, genero, edad, lugarNacimiento, fotoRuta, isAdmin) 
        VALUES (?, ?, ?, ?, ?, ?, ?)`,
        [
          usuario.nombre,
          usuario.contrasena,
          usuario.genero,
          usuario.edad,
          usuario.lugarNacimiento,
          usuario.fotoRuta,
          usuario.isAdmin
        ]
      );

      return new Usuario(
        result.insertId,
        usuario.nombre,
        usuario.contrasena,
        usuario.genero,
        usuario.edad,
        usuario.lugarNacimiento,
        usuario.fotoRuta,
        usuario.isAdmin,
        false
      );
    } finally {
      connection.release();
    }
  }
}

module.exports = Usuario;