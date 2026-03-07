// ============================================
// SERVIDOR BACKEND - Gestión Restaurante
// ============================================

const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const bodyParser = require('body-parser');

// Crear aplicación Express
const app = express();
const PORT = 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(express.static('.'));

// Configuración de conexión a MySQL
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'restaurante_db',
  port: 3306
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
  const query = `
    SELECT u.*, r.nombre_rol 
    FROM usuarios u 
    INNER JOIN rol r ON u.id_rol = r.id_rol 
    WHERE u.correo = ? AND u.password = ? AND u.estado_usuario = 'SI'
  `;
  db.query(query, [correo, password], (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    if (results.length > 0) {
      res.json({ success: true, usuario: results[0], mensaje: 'Login exitoso' });
    } else {
      res.status(401).json({ success: false, mensaje: 'Credenciales incorrectas' });
    }
  });
});

// MESAS - Obtener todas
app.get('/api/mesas', (req, res) => {
  const query = 'SELECT * FROM mesas WHERE estado_mesa != "ELIMINADA"';
  db.query(query, (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

// MESAS - Obtener una por ID
app.get('/api/mesas/:id', (req, res) => {
  const query = 'SELECT * FROM mesas WHERE id_mesa = ?';
  db.query(query, [req.params.id], (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    if (results.length === 0) return res.status(404).json({ error: 'Mesa no encontrada' });
    res.json(results[0]);
  });
});

// MESAS - Crear nueva
app.post('/api/mesas', (req, res) => {
  const { nombre_mesa, capacidad, fecha_disponibilidad, hora_disponibilidad, estado_mesa } = req.body;
  const query = `
    INSERT INTO mesas (nombre_mesa, capacidad, fecha_disponibilidad, hora_disponibilidad, estado_mesa)
    VALUES (?, ?, ?, ?, ?)
  `;
  db.query(query, [nombre_mesa, capacidad, fecha_disponibilidad, hora_disponibilidad, estado_mesa || 'LIBRE'], (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ success: true, id: results.insertId, mensaje: 'Mesa creada' });
  });
});

// MESAS - Actualizar
app.put('/api/mesas/:id', (req, res) => {
  const { nombre_mesa, capacidad, fecha_disponibilidad, hora_disponibilidad, estado_mesa } = req.body;
  const query = `
    UPDATE mesas SET 
      nombre_mesa = ?, 
      capacidad = ?, 
      fecha_disponibilidad = ?, 
      hora_disponibilidad = ?, 
      estado_mesa = ? 
    WHERE id_mesa = ?
  `;
  db.query(query, [nombre_mesa, capacidad, fecha_disponibilidad, hora_disponibilidad, estado_mesa, req.params.id], (err) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ success: true, mensaje: 'Mesa actualizada' });
  });
});

// MESAS - Eliminar
app.delete('/api/mesas/:id', (req, res) => {
  const query = 'UPDATE mesas SET estado_mesa = "ELIMINADA" WHERE id_mesa = ?';
  db.query(query, [req.params.id], (err) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ success: true, mensaje: 'Mesa eliminada' });
  });
});

// RESERVAS - Obtener todas
app.get('/api/reservas', (req, res) => {
  const query = `
    SELECT r.*, m.nombre_mesa 
    FROM reservas r 
    INNER JOIN mesas m ON r.id_mesa = m.id_mesa 
    WHERE r.estado_reserva != 'CANCELADA'
    ORDER BY r.fecha_reserva DESC, r.hora_reserva ASC
  `;
  db.query(query, (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

// RESERVAS - Crear nueva
app.post('/api/reservas', (req, res) => {
  const { id_mesa, fecha_reserva, hora_reserva, nombre_cliente, telefono_cliente, estado_reserva } = req.body;
  const checkQuery = `
    SELECT * FROM reservas 
    WHERE id_mesa = ? AND fecha_reserva = ? AND hora_reserva = ? AND estado_reserva != 'CANCELADA'
  `;
  db.query(checkQuery, [id_mesa, fecha_reserva, hora_reserva], (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    if (results.length > 0) {
      return res.status(400).json({ success: false, mensaje: 'Esta mesa ya está reservada' });
    }
    const insertQuery = `
      INSERT INTO reservas (id_mesa, fecha_reserva, hora_reserva, nombre_cliente, telefono_cliente, estado_reserva)
      VALUES (?, ?, ?, ?, ?, ?)
    `;
    db.query(insertQuery, [id_mesa, fecha_reserva, hora_reserva, nombre_cliente, telefono_cliente, estado_reserva || 'ACTIVA'], (err, results) => {
      if (err) return res.status(500).json({ error: err.message });
      const updateMesa = 'UPDATE mesas SET estado_mesa = "RESERVADA" WHERE id_mesa = ?';
      db.query(updateMesa, [id_mesa], () => {});
      res.json({ success: true, id: results.insertId, mensaje: 'Reserva creada' });
    });
  });
});

// RESERVAS - Cancelar
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
    mesasOcupadas: 'SELECT COUNT(*) as total FROM mesas WHERE estado_mesa = "OCUPADA"',
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

// ============================================
// INICIAR SERVIDOR
// ============================================

app.listen(PORT, () => {
  console.log(` Servidor corriendo en http://localhost:${PORT}`);
});