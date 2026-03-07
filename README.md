
http://localhost/phpmyadmin




-- CREACION DE LA BD:
DROP DATABASE IF EXISTS restaurante_db;
CREATE DATABASE restaurante_db;

-- USO DE LA BD:
USE restaurante_db;
-- TABLA ROL      [1/8]
CREATE TABLE rol
(
    id_rol               INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre_rol           VARCHAR(50)        NOT NULL,
    descripcion          TEXT                   NULL,
    estado_rol           VARCHAR(10)        NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- TABLA USUARIOS [2/8]
CREATE TABLE usuarios
(
    id_usuario           INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    id_rol               INT                NOT NULL,
    nombre_usuario       VARCHAR(50)        NOT NULL,
    dui                  VARCHAR(20)        NOT NULL,
    nit                  VARCHAR(20)        NOT NULL,
    telefono             VARCHAR(15)        NOT NULL,
    correo               VARCHAR(30)        NOT NULL,
    password             VARCHAR(200)       NOT NULL,
    estado_usuario       CHAR(2)            NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- TABLA USUARIOS [3/8]
CREATE TABLE categoria
(
    id_categoria         INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre_categoria     VARCHAR(30)        NOT NULL,
    descripcion          TEXT               NULL,
    estado_categoria     VARCHAR(10)        NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- TABLA USUARIOS [4/8]
CREATE TABLE productos
(
    id_producto          INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    id_categoria         INT                NOT NULL,
    codigo_producto      VARCHAR(10)        NOT NULL,
    nombre_producto      VARCHAR(50)        NOT NULL,
    precio_producto      DECIMAL(6,2)       NOT NULL,
    fecha_fabricacion    DATE               NOT NULL,
    fecha_expiracion     DATE               NOT NULL,
    img_producto         VARCHAR(50)        NOT NULL,
    descripcion          TEXT               NULL,
    estado_producto      CHAR(2)            NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- TABLA USUARIOS [5/8]
CREATE TABLE facturas
(
    id_factura           INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    id_usuario           INT                NOT NULL,
    fecha                DATETIME           NOT NULL,
    total_factura        DECIMAL(6,2)       NOT NULL,
    estado_factura       CHAR(2)            NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- TABLA USUARIOS [6/8]
CREATE TABLE pagos
(
    id_pago              INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    id_factura           INT                NOT NULL,
    fecha                DATETIME           NOT NULL,
    metodo_pago          VARCHAR(30)        NOT NULL,
    total_pago           DECIMAL(6,2)       NOT NULL,
    descuento            INT                NOT NULL,
    pago_cliente         DECIMAL(6,2)       NOT NULL,
    total_vuelto         DECIMAL(6,2)       NOT NULL,
    descripcion          TEXT               NULL,
    estado_pago          CHAR(2)            NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- TABLA USUARIOS [7/8]
CREATE TABLE comentarios
(
    id_comentarios       INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    id_pago              INT                NOT NULL,
    fecha                DATETIME           NOT NULL,
    calificacion         INT                NOT NULL,
    comentario           TEXT               NULL,
    estado_comentario    CHAR(2)            NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- TABLA USUARIOS [8/8]
CREATE TABLE facturas_productos
(
    id_contenido_factura INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    id_factura           INT                NOT NULL,
    id_producto          INT                NOT NULL,
    cantidad             INT                NOT NULL,
    total_producto       DECIMAL(6,2)       NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- ----------------------------------------------
-- DEFINIMOS LAS RELACIONES DE LA BASE DE DATOS CON LAS TABLAS
-- ----------------------------------------------

-- RELACIONAMOS LA TABLA ROL CON LA TABLA USUARIOS
ALTER TABLE usuarios ADD CONSTRAINT Fk_usuarios_rol FOREIGN KEY(id_rol) REFERENCES rol(id_rol);

-- RELACIONAMOS LA TABLA USUARIO CON LA TABLA FACTURAS
ALTER TABLE facturas ADD CONSTRAINT FK_facturas_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario);

-- RELACIONAMOS LA TABLA FACTURAS_PRODUCTOS
-- CON LA TABLA FACTURAS
ALTER TABLE facturas_productos ADD CONSTRAINT FK_facturas_productos_facturas FOREIGN KEY (id_factura) REFERENCES facturas(id_factura);
-- CON LA TABLA PRODUCTOS
ALTER TABLE facturas_productos ADD CONSTRAINT FK_facturas_productos_productos FOREIGN KEY (id_producto) REFERENCES productos(id_producto);

-- RELACIONAMOS LA TABLA PAGOS CON LA TABLA FACTURAS
ALTER TABLE pagos ADD CONSTRAINT FK_pago_facturas FOREIGN KEY (id_factura) REFERENCES facturas(id_factura);

-- RELACIONAMOS LA TABLA PRODUCTOS CON LA TABLA CATEGORIA
ALTER TABLE productos ADD CONSTRAINT FK_productos_caterias FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria);

-- RELACIONAMOS LA TABLA COMENTARIO CON LA TABLA PAGOS
ALTER TABLE comentarios ADD CONSTRAINT FK_comentarios_pago FOREIGN KEY (id_pago) REFERENCES pagos(id_pago);

