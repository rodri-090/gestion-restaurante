// ============================================
// SERVIDOR BACKEND - Gestión Restaurante
// ============================================

require('dotenv').config();

const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const bodyParser = require('body-parser');

// Crear aplicación Express
const app = express();
const PORT = Number(process.env.PORT) || 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(express.static('.'));

// Configuración de conexión a MySQL
const db = mysql.createConnection({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD ?? '',
  database: process.env.DB_NAME || 'restaurante_db',
  port: Number(process.env.DB_PORT) || 3306
});

// Conectar a la base de datos
db.connect((err) => {
  if (err) {
    console.error('❌ Error conectando a MySQL:', err.message);
    process.exit(1);
  } else {
    console.log('✅ Conectado a MySQL - restaurante_db');
  }
});

// ============================================
// ENDPOINTS - API REST
// ============================================

// LOGIN
app.post('/api/login', (req, res) => {
  const { correo, password } = req.body;
  const query = 'SELECT * FROM usuarios WHERE correo = ? AND password = ? AND estado_usuario = "SI"';
  db.query(query, [correo, password], (err, results) => {
    if (err) {
      console.error('Error en login:', err);
      return res.status(500).json({ success: false, mensaje: 'Error en el servidor' });
    }
    if (results.length > 0) {
      const usuario = { ...results[0] };
      delete usuario.password;
      res.json({ success: true, usuario, mensaje: 'Login exitoso' });
    } else {
      res.status(401).json({ success: false, mensaje: 'Credenciales incorrectas o usuario inactivo' });
    }
  });
});

// MESAS
app.get('/api/mesas', (req, res) => {
  const query = 'SELECT * FROM mesas WHERE estado_mesa != "ELIMINADA"';
  db.query(query, (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

app.post('/api/mesas', (req, res) => {
  const { nombre_mesa, capacidad, fecha_disponibilidad, hora_disponibilidad, estado_mesa } = req.body;
  const query = 'INSERT INTO mesas (nombre_mesa, capacidad, fecha_disponibilidad, hora_disponibilidad, estado_mesa) VALUES (?, ?, ?, ?, ?)';
  db.query(query, [nombre_mesa, capacidad, fecha_disponibilidad, hora_disponibilidad, estado_mesa || 'LIBRE'], (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ success: true, id: results.insertId, mensaje: 'Mesa creada' });
  });
});

app.put('/api/mesas/:id', (req, res) => {
  const { nombre_mesa, capacidad, fecha_disponibilidad, hora_disponibilidad, estado_mesa } = req.body;
  const query = 'UPDATE mesas SET nombre_mesa = ?, capacidad = ?, fecha_disponibilidad = ?, hora_disponibilidad = ?, estado_mesa = ? WHERE id_mesa = ?';
  db.query(query, [nombre_mesa, capacidad, fecha_disponibilidad, hora_disponibilidad, estado_mesa, req.params.id], (err) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ success: true, mensaje: 'Mesa actualizada' });
  });
});

app.delete('/api/mesas/:id', (req, res) => {
  const query = 'UPDATE mesas SET estado_mesa = "ELIMINADA" WHERE id_mesa = ?';
  db.query(query, [req.params.id], (err) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ success: true, mensaje: 'Mesa eliminada' });
  });
});

// RESERVAS
app.get('/api/reservas', (req, res) => {
  const query = 'SELECT r.*, m.nombre_mesa FROM reservas r INNER JOIN mesas m ON r.id_mesa = m.id_mesa WHERE r.estado_reserva != "CANCELADA" ORDER BY r.fecha_reserva DESC, r.hora_reserva ASC';
  db.query(query, (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

app.post('/api/reservas', (req, res) => {
  const { id_mesa, fecha_reserva, hora_reserva, nombre_cliente, telefono_cliente, estado_reserva } = req.body;
  const checkQuery = 'SELECT * FROM reservas WHERE id_mesa = ? AND fecha_reserva = ? AND hora_reserva = ? AND estado_reserva != "CANCELADA"';
  db.query(checkQuery, [id_mesa, fecha_reserva, hora_reserva], (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    if (results.length > 0) {
      return res.status(400).json({ success: false, mensaje: 'Esta mesa ya está reservada' });
    }
    const insertQuery = 'INSERT INTO reservas (id_mesa, fecha_reserva, hora_reserva, nombre_cliente, telefono_cliente, estado_reserva) VALUES (?, ?, ?, ?, ?, ?)';
    db.query(insertQuery, [id_mesa, fecha_reserva, hora_reserva, nombre_cliente, telefono_cliente, estado_reserva || 'ACTIVA'], (err, results) => {
      if (err) return res.status(500).json({ error: err.message });
      const updateMesa = 'UPDATE mesas SET estado_mesa = "RESERVADA" WHERE id_mesa = ?';
      db.query(updateMesa, [id_mesa], () => {});
      res.json({ success: true, id: results.insertId, mensaje: 'Reserva creada' });
    });
  });
});

app.delete('/api/reservas/:id', (req, res) => {
  const selectQuery = 'SELECT id_mesa FROM reservas WHERE id_reserva = ?';
  db.query(selectQuery, [req.params.id], (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    if (results.length === 0) return res.status(404).json({ error: 'Reserva no encontrada' });
    const idMesa = results[0].id_mesa;
    const cancelQuery = 'UPDATE reservas SET estado_reserva = "CANCELADA" WHERE id_reserva = ?';
    db.query(cancelQuery, [req.params.id], (err) => {
      if (err) return res.status(500).json({ error: err.message });
      const liberarMesa = 'UPDATE mesas SET estado_mesa = "LIBRE" WHERE id_mesa = ? AND estado_mesa = "RESERVADA"';
      db.query(liberarMesa, [idMesa], () => {});
      res.json({ success: true, mensaje: 'Reserva cancelada' });
    });
  });
});

// ESTADÍSTICAS
app.get('/api/estadisticas', (req, res) => {
  const queries = {
    totalReservas: 'SELECT COUNT(*) as total FROM reservas WHERE DATE(fecha_reserva) = CURDATE() AND estado_reserva = "ACTIVA"',
    mesasOcupadas: 'SELECT COUNT(*) as total FROM mesas WHERE estado_mesa IN ("OCUPADA", "RESERVADA")',
    mesasLibres: 'SELECT COUNT(*) as total FROM mesas WHERE estado_mesa = "LIBRE"',
    totalMesas: 'SELECT COUNT(*) as total FROM mesas WHERE estado_mesa != "ELIMINADA"'
  };
  let stats = {};
  let completed = 0;
  Object.keys(queries).forEach(key => {
    db.query(queries[key], (err, results) => {
      if (!err && results[0]) {
        stats[key] = results[0].total;
      }
      completed++;
      if (completed === Object.keys(queries).length) {
        const total = stats.totalMesas || 1;
        const ocupadas = stats.mesasOcupadas || 0;
        stats.ocupacionPorcentaje = Math.round((ocupadas / total) * 100);
        res.json(stats);
      }
    });
  });
});

// CATEGORÍAS
app.get('/api/categorias', (req, res) => {
  const query = 'SELECT id_categoria as id, nombre_categoria as nombre, descripcion, estado_categoria as estado FROM categoria WHERE estado_categoria = "SI" ORDER BY id_categoria ASC';
  db.query(query, (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

// PRODUCTOS
app.get('/api/productos', (req, res) => {
  const query = 'SELECT p.id_producto as id, p.nombre_producto as nombre, p.precio_producto as precio, p.descripcion, p.img_producto as imagen, p.estado_producto as estado, p.id_categoria as categoria_id, c.nombre_categoria as categoria_nombre FROM productos p INNER JOIN categoria c ON p.id_categoria = c.id_categoria WHERE p.estado_producto = "SI" ORDER BY c.id_categoria, p.id_producto ASC';
  db.query(query, (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

// ============================================
// INICIAR SERVIDOR
// ============================================

app.listen(PORT, '0.0.0.0', () => {
  console.log('🚀 Servidor corriendo en http://localhost:' + PORT);
  console.log('📱 Acceso desde red: http://10.155.174.110:' + PORT);
});