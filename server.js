const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");
const path = require("path");

const app = express();

app.use(cors());
app.use(express.json());

// Servir archivos estáticos (HTML, CSS, JS)
app.use(express.static(__dirname));

// 🔹 CONFIGURACIÓN MYSQL
const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "restaurante_db"
});

db.connect(err => {
  if (err) {
    console.log("❌ Error de conexión:", err);
  } else {
    console.log("✅ Conectado a MySQL");
  }
});

// 🔹 LOGIN
app.post("/login", (req, res) => {
  const { usuario, password } = req.body;

  const sql = "SELECT * FROM usuarios WHERE usuario = ? AND password = ?";
  
  db.query(sql, [usuario, password], (err, result) => {
    if (err) return res.status(500).json(err);

    if (result.length > 0) {
      res.json({ success: true });
    } else {
      res.json({ success: false });
    }
  });
});

// 🔹 INICIAR SERVIDOR
app.listen(3000, () => {
  console.log("🚀 Servidor corriendo en http://localhost:3000");
});