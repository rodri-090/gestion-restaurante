-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-04-2026 a las 17:05:49
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `restaurante_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL,
  `nombre_categoria` varchar(30) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `estado_categoria` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id_categoria`, `nombre_categoria`, `descripcion`, `estado_categoria`) VALUES
(1, 'Entradas', 'Opciones para iniciar', 'SI'),
(2, 'Platos Fuertes', 'Platos principales', 'SI'),
(3, 'Bebidas', 'Bebidas', 'SI'),
(4, 'Postres', 'Postres', 'SI'),
(5, '', '-- Categorías\r\nINSERT INTO `categoria` (`id_categoria`, `nombre_categoria`, `descripcion`, `estado_categoria`) VALUES\r\n(1, \'Entradas\', \'Opciones ideales para iniciar.\', \'SI\'),\r\n(2, \'Platos Fuertes\', \'Platos principales.\', \'SI\'),\r\n(3, \'Bebidas\', \'Bebidas refrescantes.\', \'SI\'),\r\n(4, \'Postres\', \'Opciones dulces.\', \'SI\');\r\n\r\n-- Productos (con precios y tildes correctas)\r\nINSERT INTO `productos` (`id_producto`, `id_categoria`, `codigo_producto`, `nombre_producto`, `precio_producto`, `fecha_fabricacion`, `fecha_expiracion`, `img_producto`, `descripcion`, `estado_producto`) VALUES\r\n(1, 1, \'ENT001\', \'Pan con ajo\', 3.50, \'2026-01-01\', \'2026-12-31\', \'img/menu/panconajo.jpg\', \'Pan tostado con ajo.\', \'SI\'),\r\n(2, 1, \'ENT002\', \'Alitas BBQ\', 5.99, \'2026-01-01\', \'2026-12-31\', \'img/menu/alitas-bbq.jpg\', \'Alitas BBQ.\', \'SI\'),\r\n(3, 1, \'ENT003\', \'Dedos de queso\', 4.75, \'2026-01-01\', \'2026-12-31\', \'img/menu/dedos-queso.jpg\', \'Queso empanizado.\', \'SI\'),\r\n(4, 1, \'ENT004\', \'Nachos supremos\', 6.25, \'2026-01-01\', \'2026-12-31\', \'img/menu/nachos.jpg\', \'Nachos con queso.\', \'SI\'),\r\n(5, 2, \'PLA001\', \'Pasta Alfredo\', 8.99, \'2026-01-01\', \'2026-12-31\', \'img/menu/pasta-alfredo.jpg\', \'Pasta cremosa.\', \'SI\'),\r\n(6, 2, \'PLA002\', \'Hamburguesa clásica\', 7.50, \'2026-01-01\', \'2026-12-31\', \'img/menu/hamburguesa.jpg\', \'Hamburguesa.\', \'SI\'),\r\n(7, 2, \'PLA003\', \'Pizza personal\', 6.99, \'2026-01-01\', \'2026-12-31\', \'img/menu/pizza-personal.jpg\', \'Pizza individual.\', \'SI\'),\r\n(8, 2, \'PLA004\', \'Pollo crispy\', 8.25, \'2026-01-01\', \'2026-12-31\', \'img/menu/pollo-crispy.jpg\', \'Pollo crujiente.\', \'SI\'),\r\n(9, 3, \'BEB001\', \'Horchata artesanal\', 2.25, \'2026-01-01\', \'2026-12-31\', \'img/menu/horchata.jpg\', \'Horchata.\', \'SI\'),\r\n(10, 3, \'BEB002\', \'Limonada con menta\', 2.75, \'2026-01-01\', \'2026-12-31\', \'img/menu/limonada-menta.jpg\', \'Limonada.\', \'SI\'),\r\n(11, 3, \'BEB003\', \'Soda fría\', 1.75, \'2026-01-01\', \'2026-12-31\', \'img/menu/soda.jpg\', \'Soda.\', \'SI\'),\r\n(12, 3, \'BEB004\', \'Café\', 1.95, \'2026-01-01\', \'2026-12-31\', \'img/menu/cafe.jpg\', \'Café caliente.\', \'SI\'),\r\n(13, 4, \'POS001\', \'Pastel tres leches\', 3.25, \'2026-01-01\', \'2026-12-31\', \'img/menu/tres-leches.jpg\', \'Tres leches.\', \'SI\'),\r\n(14, 4, \'POS002\', \'Brownie con helado\', 4.50, \'2026-01-01\', \'2026-12-31\', \'img/menu/brownie-con-helado.jpg\', \'Brownie.\', \'SI\'),\r\n(15, 4, \'POS003\', \'Cheesecake\', 3.95, \'2026-01-01\', \'2026-12-31\', \'img/menu/cheesecake.jpg\', \'Cheesecake.\', \'SI\'),\r\n(16, 4, \'POS004\', \'Tiramisú\', 4.25, \'2026-01-01\', \'2026-12-31\', \'img/menu/tiramisu.jpg\', \'Tiramisú.\', \'SI\');', ''),
(6, '', '-- Categorías\r\nINSERT INTO `categoria` (`id_categoria`, `nombre_categoria`, `descripcion`, `estado_categoria`) VALUES\r\n(1, \'Entradas\', \'Opciones ideales para iniciar.\', \'SI\'),\r\n(2, \'Platos Fuertes\', \'Platos principales.\', \'SI\'),\r\n(3, \'Bebidas\', \'Bebidas refrescantes.\', \'SI\'),\r\n(4, \'Postres\', \'Opciones dulces.\', \'SI\');\r\n\r\n-- Productos (con precios y tildes correctas)\r\nINSERT INTO `productos` (`id_producto`, `id_categoria`, `codigo_producto`, `nombre_producto`, `precio_producto`, `fecha_fabricacion`, `fecha_expiracion`, `img_producto`, `descripcion`, `estado_producto`) VALUES\r\n(1, 1, \'ENT001\', \'Pan con ajo\', 3.50, \'2026-01-01\', \'2026-12-31\', \'img/menu/panconajo.jpg\', \'Pan tostado con ajo.\', \'SI\'),\r\n(2, 1, \'ENT002\', \'Alitas BBQ\', 5.99, \'2026-01-01\', \'2026-12-31\', \'img/menu/alitas-bbq.jpg\', \'Alitas BBQ.\', \'SI\'),\r\n(3, 1, \'ENT003\', \'Dedos de queso\', 4.75, \'2026-01-01\', \'2026-12-31\', \'img/menu/dedos-queso.jpg\', \'Queso empanizado.\', \'SI\'),\r\n(4, 1, \'ENT004\', \'Nachos supremos\', 6.25, \'2026-01-01\', \'2026-12-31\', \'img/menu/nachos.jpg\', \'Nachos con queso.\', \'SI\'),\r\n(5, 2, \'PLA001\', \'Pasta Alfredo\', 8.99, \'2026-01-01\', \'2026-12-31\', \'img/menu/pasta-alfredo.jpg\', \'Pasta cremosa.\', \'SI\'),\r\n(6, 2, \'PLA002\', \'Hamburguesa clásica\', 7.50, \'2026-01-01\', \'2026-12-31\', \'img/menu/hamburguesa.jpg\', \'Hamburguesa.\', \'SI\'),\r\n(7, 2, \'PLA003\', \'Pizza personal\', 6.99, \'2026-01-01\', \'2026-12-31\', \'img/menu/pizza-personal.jpg\', \'Pizza individual.\', \'SI\'),\r\n(8, 2, \'PLA004\', \'Pollo crispy\', 8.25, \'2026-01-01\', \'2026-12-31\', \'img/menu/pollo-crispy.jpg\', \'Pollo crujiente.\', \'SI\'),\r\n(9, 3, \'BEB001\', \'Horchata artesanal\', 2.25, \'2026-01-01\', \'2026-12-31\', \'img/menu/horchata.jpg\', \'Horchata.\', \'SI\'),\r\n(10, 3, \'BEB002\', \'Limonada con menta\', 2.75, \'2026-01-01\', \'2026-12-31\', \'img/menu/limonada-menta.jpg\', \'Limonada.\', \'SI\'),\r\n(11, 3, \'BEB003\', \'Soda fría\', 1.75, \'2026-01-01\', \'2026-12-31\', \'img/menu/soda.jpg\', \'Soda.\', \'SI\'),\r\n(12, 3, \'BEB004\', \'Café\', 1.95, \'2026-01-01\', \'2026-12-31\', \'img/menu/cafe.jpg\', \'Café caliente.\', \'SI\'),\r\n(13, 4, \'POS001\', \'Pastel tres leches\', 3.25, \'2026-01-01\', \'2026-12-31\', \'img/menu/tres-leches.jpg\', \'Tres leches.\', \'SI\'),\r\n(14, 4, \'POS002\', \'Brownie con helado\', 4.50, \'2026-01-01\', \'2026-12-31\', \'img/menu/brownie-con-helado.jpg\', \'Brownie.\', \'SI\'),\r\n(15, 4, \'POS003\', \'Cheesecake\', 3.95, \'2026-01-01\', \'2026-12-31\', \'img/menu/cheesecake.jpg\', \'Cheesecake.\', \'SI\'),\r\n(16, 4, \'POS004\', \'Tiramisú\', 4.25, \'2026-01-01\', \'2026-12-31\', \'img/menu/tiramisu.jpg\', \'Tiramisú.\', \'SI\');', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `id_comentarios` int(11) NOT NULL,
  `id_pago` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `calificacion` int(11) NOT NULL,
  `comentario` text DEFAULT NULL,
  `estado_comentario` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas`
--

CREATE TABLE `facturas` (
  `id_factura` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `total_factura` decimal(6,2) NOT NULL,
  `estado_factura` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas_productos`
--

CREATE TABLE `facturas_productos` (
  `id_contenido_factura` int(11) NOT NULL,
  `id_factura` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `total_producto` decimal(6,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mesas`
--

CREATE TABLE `mesas` (
  `id_mesa` int(10) UNSIGNED NOT NULL,
  `nombre_mesa` varchar(100) NOT NULL,
  `capacidad` int(10) UNSIGNED NOT NULL,
  `fecha_disponibilidad` date NOT NULL,
  `hora_disponibilidad` varchar(32) NOT NULL,
  `estado_mesa` varchar(20) NOT NULL DEFAULT 'LIBRE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `mesas`
--

INSERT INTO `mesas` (`id_mesa`, `nombre_mesa`, `capacidad`, `fecha_disponibilidad`, `hora_disponibilidad`, `estado_mesa`) VALUES
(1, 'Mesa 1', 4, '2026-03-25', '7:00 p.m.', 'OCUPADA'),
(2, 'Mesa 2', 2, '2026-03-28', '7:30 p.m.', 'OCUPADA'),
(3, 'Mesa 3', 6, '2026-03-25', '8:00 p.m.', 'LIBRE'),
(4, 'Mesa 4', 6, '2026-03-25', '12:30 p.m.', 'LIBRE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id_pago` int(11) NOT NULL,
  `id_factura` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `metodo_pago` varchar(30) NOT NULL,
  `total_pago` decimal(6,2) NOT NULL,
  `descuento` int(11) NOT NULL,
  `pago_cliente` decimal(6,2) NOT NULL,
  `total_vuelto` decimal(6,2) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `estado_pago` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `codigo_producto` varchar(10) NOT NULL,
  `nombre_producto` varchar(50) NOT NULL,
  `precio_producto` decimal(6,2) NOT NULL,
  `fecha_fabricacion` date NOT NULL,
  `fecha_expiracion` date NOT NULL,
  `img_producto` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `estado_producto` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `id_categoria`, `codigo_producto`, `nombre_producto`, `precio_producto`, `fecha_fabricacion`, `fecha_expiracion`, `img_producto`, `descripcion`, `estado_producto`) VALUES
(1, 1, 'E001', 'Pan con ajo', 5.00, '2026-01-01', '2026-12-31', 'img/menu/panconajo.jpg', 'Pan tostado con mantequilla de ajo', 'SI'),
(2, 1, 'E002', 'Alitas BBQ', 12.00, '2026-01-01', '2026-12-31', 'img/menu/alitas-bbq.jpg', 'Alitas con salsa BBQ', 'SI'),
(3, 1, 'E003', 'Dedos de queso', 95.00, '2026-01-01', '2026-12-31', 'img/menu/dedos-queso.jpg', 'Bastones de queso empanizados', 'SI'),
(4, 1, 'E004', 'Nachos', 10.00, '2026-01-01', '2026-12-31', 'img/menu/nachos.jpg', 'Nachos con queso y toppings', 'SI'),
(5, 2, 'P001', 'Pasta Alfredo', 18.00, '2026-01-01', '2026-12-31', 'img/menu/pasta-alfredo.jpg', 'Pasta en salsa cremosa con pollo', 'SI'),
(6, 2, 'P002', 'Hamburguesa', 15.00, '2026-01-01', '2026-12-31', 'img/menu/hamburguesa.jpg', 'Hamburguesa cl?sica', 'SI'),
(7, 2, 'P003', 'Pizza personal', 14.00, '2026-01-01', '2026-12-31', 'img/menu/pizza-personal.jpg', 'Pizza individual', 'SI'),
(8, 2, 'P004', 'Pollo crispy', 6.00, '2026-01-01', '2026-12-31', 'img/menu/pollo-crispy.jpg', 'Pollo crujiente', 'SI'),
(9, 3, 'B001', 'Horchata', 1.00, '2026-01-01', '2026-12-31', 'img/menu/horchata.jpg', 'Bebida tradicional', 'SI'),
(10, 3, 'B002', 'Limonada', 1.00, '2026-01-01', '2026-12-31', 'img/menu/limonada-menta.jpg', 'Limonada con menta', 'SI'),
(11, 3, 'B003', 'Soda', 1.50, '2026-01-01', '2026-12-31', 'img/menu/soda.jpg', 'Bebida gaseosa', 'SI'),
(12, 3, 'B004', 'Café', 0.50, '2026-01-01', '2026-12-31', 'img/menu/cafe.jpg', 'Caf? caliente', 'SI'),
(13, 4, 'D001', 'Tres leches', 4.00, '2026-01-01', '2026-12-31', 'img/menu/tres-leches.jpg', 'Pastel tres leches', 'SI'),
(14, 4, 'D002', 'Brownie', 5.00, '2026-01-01', '2026-12-31', 'img/menu/brownie-con-helado.jpg', 'Brownie con helado', 'SI'),
(15, 4, 'D003', 'Cheesecake', 5.00, '2026-01-01', '2026-12-31', 'img/menu/cheesecake.jpg', 'Cheesecake', 'SI'),
(16, 4, 'D004', 'Tiramis', 6.00, '2026-01-01', '2026-12-31', 'img/menu/tiramisu.jpg', 'Tiramis?', 'SI');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `id_reserva` int(10) UNSIGNED NOT NULL,
  `id_mesa` int(10) UNSIGNED NOT NULL,
  `fecha_reserva` date NOT NULL,
  `hora_reserva` varchar(32) NOT NULL,
  `nombre_cliente` varchar(200) NOT NULL,
  `telefono_cliente` varchar(50) NOT NULL,
  `estado_reserva` varchar(20) NOT NULL DEFAULT 'ACTIVA'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id_reserva`, `id_mesa`, `fecha_reserva`, `hora_reserva`, `nombre_cliente`, `telefono_cliente`, `estado_reserva`) VALUES
(1, 1, '2026-03-25', '12:30 p.m.', 'Carlos', '7866-4555', 'ACTIVA'),
(2, 2, '2026-03-25', '1:30 p.m.', 'Cesar', '7399-3345', 'ACTIVA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `id_rol` int(11) NOT NULL,
  `nombre_rol` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `estado_rol` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id_rol`, `nombre_rol`, `descripcion`, `estado_rol`) VALUES
(1, 'Administrador', NULL, ''),
(2, 'Usuario', NULL, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `dui` varchar(20) NOT NULL,
  `nit` varchar(20) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `correo` varchar(30) NOT NULL,
  `password` varchar(200) NOT NULL,
  `estado_usuario` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `id_rol`, `nombre_usuario`, `dui`, `nit`, `telefono`, `correo`, `password`, `estado_usuario`) VALUES
(1, 1, '', '', '', '', 'administrador@restaurante.com', 'Admin2026!', 'SI'),
(2, 2, '', '', '', '', 'usuario@restaurante.com', 'Usuario2026!', 'SI'),
(3, 2, '', '', '', '', 'juan@restaurante.com', 'Juan123!', 'SI'),
(4, 2, '', '', '', '', 'maria@restaurante.com', 'Maria456!', 'SI'),
(5, 2, '', '', '', '', 'carlos@restaurante.com', 'Carlos789!', 'SI');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`id_comentarios`),
  ADD KEY `FK_comentarios_pago` (`id_pago`);

--
-- Indices de la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD PRIMARY KEY (`id_factura`),
  ADD KEY `FK_facturas_usuarios` (`id_usuario`);

--
-- Indices de la tabla `facturas_productos`
--
ALTER TABLE `facturas_productos`
  ADD PRIMARY KEY (`id_contenido_factura`),
  ADD KEY `FK_facturas_productos_facturas` (`id_factura`),
  ADD KEY `FK_facturas_productos_productos` (`id_producto`);

--
-- Indices de la tabla `mesas`
--
ALTER TABLE `mesas`
  ADD PRIMARY KEY (`id_mesa`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id_pago`),
  ADD KEY `FK_pago_facturas` (`id_factura`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `FK_productos_caterias` (`id_categoria`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id_reserva`),
  ADD KEY `idx_mesa_fecha_hora` (`id_mesa`,`fecha_reserva`,`hora_reserva`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `Fk_usuarios_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id_comentarios` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `facturas`
--
ALTER TABLE `facturas`
  MODIFY `id_factura` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `facturas_productos`
--
ALTER TABLE `facturas_productos`
  MODIFY `id_contenido_factura` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mesas`
--
ALTER TABLE `mesas`
  MODIFY `id_mesa` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id_pago` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id_reserva` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `FK_comentarios_pago` FOREIGN KEY (`id_pago`) REFERENCES `pagos` (`id_pago`);

--
-- Filtros para la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD CONSTRAINT `FK_facturas_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `facturas_productos`
--
ALTER TABLE `facturas_productos`
  ADD CONSTRAINT `FK_facturas_productos_facturas` FOREIGN KEY (`id_factura`) REFERENCES `facturas` (`id_factura`),
  ADD CONSTRAINT `FK_facturas_productos_productos` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`);

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `FK_pago_facturas` FOREIGN KEY (`id_factura`) REFERENCES `facturas` (`id_factura`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `FK_productos_caterias` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`);

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `fk_reservas_mesa` FOREIGN KEY (`id_mesa`) REFERENCES `mesas` (`id_mesa`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `Fk_usuarios_rol` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
