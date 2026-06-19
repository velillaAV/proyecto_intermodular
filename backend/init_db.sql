CREATE TABLE IF NOT EXISTS usuarios (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    genero VARCHAR(50),
    edad INTEGER,
    lugarNacimiento VARCHAR(255),
    fotoRuta VARCHAR(255),
    isAdmin BOOLEAN DEFAULT FALSE,
    isBlocked BOOLEAN DEFAULT FALSE
);


CREATE TABLE IF NOT EXISTS ligas (
    id_liga INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE,
    cod_invitacion INTEGER NOT NULL UNIQUE,
    propietario_id INTEGER,
    tipo VARCHAR(50) DEFAULT 'normal',
    cap_de_participantes INTEGER NOT NULL,
    fase VARCHAR(255) DEFAULT 'Fase de Grupos: Jornada 1',
    clausulas BOOLEAN
    CONSTRAINT fk_ligas_usuario
        FOREIGN KEY (propietario_id)
        REFERENCES usuarios(id)
);

CREATE TABLE IF NOT EXISTS jugadores (
    id_jugador INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    pais VARCHAR(255),
    valor_clausula BIGINT,
    valor_venta BIGINT,
    posicion VARCHAR(10) NOT NULL,
    puntos INTEGER DEFAULT 0
);







CREATE TABLE IF NOT EXISTS mercado_diario (
    id_mercado INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_liga INTEGER NOT NULL UNIQUE,
    jugadores_json JSONB NOT NULL,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_proximo_cambio TIMESTAMP NOT NULL,
    CONSTRAINT fk_mercado_liga
        FOREIGN KEY (id_liga)
        REFERENCES ligas(id_liga)
        ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS liga_participantes (
    id_liga INTEGER NOT NULL,
    id_usuario INTEGER NOT NULL,
    puntos INT,
    saldo FLOAT8,
    alineación JSON,
    equipo JSON,
    PRIMARY KEY (id_liga, id_usuario),
    CONSTRAINT fk_lp_liga
        FOREIGN KEY (id_liga)
        REFERENCES ligas(id_liga)
        ON DELETE CASCADE,
    CONSTRAINT fk_lp_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id)
        ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS mercado_diario (
    id_mercado INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_liga INTEGER NOT NULL UNIQUE,
    jugadores_json JSONB NOT NULL,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_proximo_cambio TIMESTAMP NOT NULL,
    CONSTRAINT fk_mercado_liga
        FOREIGN KEY (id_liga)
        REFERENCES ligas(id_liga)
        ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS liga_especial (
    id_liga INTEGER NOT NULL,
    selecciones JSON
    PRIMARY KEY (id_liga),
    CONSTRAINT fk_lp_liga
        FOREIGN KEY (id_liga)
        REFERENCES ligas(id_liga)
        ON DELETE CASCADE
);
