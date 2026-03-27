-- Base de datos completa: esquema + datos iniciales
-- Importar en phpMyAdmin (Importar) o: mysql -u root -p < database/restaurante_db.sql

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT EXISTS restaurante_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE restaurante_db;

CREATE TABLE IF NOT EXISTS rol (
  id_rol INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre_rol VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_rol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS usuarios (
  id_usuario INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_rol INT UNSIGNED NOT NULL,
  correo VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  estado_usuario ENUM('SI','NO') NOT NULL DEFAULT 'SI',
  PRIMARY KEY (id_usuario),
  UNIQUE KEY uk_correo (correo),
  CONSTRAINT fk_usuarios_rol FOREIGN KEY (id_rol) REFERENCES rol (id_rol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS mesas (
  id_mesa INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre_mesa VARCHAR(100) NOT NULL,
  capacidad INT UNSIGNED NOT NULL,
  fecha_disponibilidad DATE NOT NULL,
  hora_disponibilidad VARCHAR(32) NOT NULL,
  estado_mesa VARCHAR(20) NOT NULL DEFAULT 'LIBRE',
  PRIMARY KEY (id_mesa)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS reservas (
  id_reserva INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_mesa INT UNSIGNED NOT NULL,
  fecha_reserva DATE NOT NULL,
  hora_reserva VARCHAR(32) NOT NULL,
  nombre_cliente VARCHAR(200) NOT NULL,
  telefono_cliente VARCHAR(50) NOT NULL,
  estado_reserva VARCHAR(20) NOT NULL DEFAULT 'ACTIVA',
  PRIMARY KEY (id_reserva),
  KEY idx_mesa_fecha_hora (id_mesa, fecha_reserva, hora_reserva),
  CONSTRAINT fk_reservas_mesa FOREIGN KEY (id_mesa) REFERENCES mesas (id_mesa)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;

INSERT IGNORE INTO rol (id_rol, nombre_rol) VALUES
  (1, 'Administrador'),
  (2, 'Usuario');

INSERT IGNORE INTO usuarios (id_rol, correo, password, estado_usuario) VALUES
  (1, 'administrador@restaurante.com', 'Admin2026!', 'SI'),
  (2, 'usuario@restaurante.com', 'Usuario2026!', 'SI'),
  (2, 'juan@restaurante.com', 'Juan123!', 'SI'),
  (2, 'maria@restaurante.com', 'Maria456!', 'SI'),
  (2, 'carlos@restaurante.com', 'Carlos789!', 'SI');

INSERT INTO mesas (nombre_mesa, capacidad, fecha_disponibilidad, hora_disponibilidad, estado_mesa) VALUES
  ('Mesa 1', 4, CURDATE(), '7:00 p.m.', 'LIBRE'),
  ('Mesa 2', 2, CURDATE(), '7:30 p.m.', 'LIBRE'),
  ('Mesa 3', 6, CURDATE(), '8:00 p.m.', 'LIBRE');
