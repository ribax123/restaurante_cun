-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-03-2025 a las 21:06:22
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `restaurante_cun`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `clave` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `admin`
--

INSERT INTO `admin` (`id`, `usuario`, `clave`) VALUES
(1, 'admincun', 'scrypt:32768:8:1$IHUWbS9ls1m8N89C$fee41e34b498c6c62b10c039ef78f5e9812ac39aa0f9ec94fe3abaa4f15b491bb0157e5914292bef02a7e3300521c6f56232fa1fe5cebfd5fcb4d253d586ec1c');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menus`
--

CREATE TABLE `menus` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `ingredientes` text NOT NULL,
  `tipo_menu` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `menus`
--

INSERT INTO `menus` (`id`, `nombre`, `ingredientes`, `tipo_menu`) VALUES
(1, 'Pollo Asado', 'Pollo, papas fritas, ensalada, jugo', 'Ejecutivo'),
(2, 'Bistec a Caballo', 'Carne asada, arroz, huevo frito, patacón', 'Ejecutivo'),
(3, 'Pechuga a la Plancha', 'Pechuga, puré de papa, ensalada fresca', 'Ejecutivo'),
(4, 'Chuleta de Cerdo', 'Chuleta, frijoles, arroz, arepa', 'Ejecutivo'),
(5, 'Carne Sudada', 'Carne en salsa, arroz, papa, yuca', 'Ejecutivo'),
(6, 'Filete de Salmón', 'Salmón, puré de papa, vegetales salteados, vino blanco', 'Gourmet'),
(7, 'Risotto de Camarones', 'Arroz cremoso, camarones, queso parmesano', 'Gourmet'),
(8, 'Pato a la Naranja', 'Pato, salsa de naranja, puré de zanahoria', 'Gourmet'),
(9, 'Entrecot al Vino', 'Entrecot, salsa de vino tinto, papas gratinadas', 'Gourmet'),
(10, 'Langosta Thermidor', 'Langosta, crema, champiñones, gratinada', 'Gourmet'),
(11, 'Ensalada Mediterránea', 'Lechuga, tomate, aceitunas, garbanzos, vinagreta', 'Vegetariano'),
(12, 'Curry de Garbanzos', 'Garbanzos, leche de coco, especias', 'Vegetariano'),
(13, 'Lasaña de Verduras', 'Pasta, berenjena, calabacín, salsa bechamel', 'Vegetariano'),
(14, 'Hamburguesa Vegana', 'Pan integral, soya, aguacate, tomate, lechuga', 'Vegetariano'),
(15, 'Pasta Alfredo Vegetariana', 'Fettuccine, crema, champiñones, queso parmesano', 'Vegetariano'),
(16, 'Tacos Especiales', 'Tortilla, carne desmechada, guacamole, pico de gallo', 'Especial'),
(17, 'Churrasco Argentino', 'Carne angus, chimichurri, papas rústicas', 'Especial'),
(18, 'Paella Mixta', 'Arroz, camarones, pollo, pimentón, azafrán', 'Especial'),
(19, 'Sushi Variado', 'Rollos de atún, salmón, aguacate, salsa de soya', 'Especial'),
(20, 'Cochinita Pibil', 'Cerdo marinado, tortillas, cebolla morada', 'Especial'),
(21, 'Mousse de Chocolate', 'Chocolate amargo, crema batida, frambuesas', 'Postre'),
(22, 'Tarta de Manzana', 'Masa crujiente, manzana caramelizada, canela', 'Postre'),
(23, 'Cheesecake de Fresa', 'Queso crema, fresas frescas, base de galleta', 'Postre'),
(24, 'Brownie con Helado', 'Chocolate, nueces, helado de vainilla', 'Postre'),
(25, 'Tiramisú', 'Bizcocho, café, mascarpone, cacao', 'Postre'),
(26, 'Mojito', 'Ron, hierbabuena, azúcar, limón, soda', 'Cócteles'),
(27, 'Piña colada', 'Ron, piña, crema de coco, hielo', 'Cócteles'),
(28, 'Margarita', 'Tequila, triple sec, limón, sal', 'Cócteles'),
(29, 'Caipirinha', 'Cachaça, azúcar, limón, hielo', 'Cócteles'),
(30, 'Martini de manzana', 'Vodka, licor de manzana, hielo', 'Cócteles');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL,
  `menu_nombre` varchar(255) NOT NULL,
  `nombre_comensal` varchar(255) NOT NULL,
  `correo_comensal` varchar(255) NOT NULL,
  `telefono_comensal` varchar(50) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `comentarios` text DEFAULT NULL,
  `fecha_pedido` timestamp NOT NULL DEFAULT current_timestamp(),
  `cedula` varchar(20) DEFAULT NULL,
  `tipo_consumo` enum('para llevar','en el lugar') DEFAULT 'en el lugar',
  `numero_mesa` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`id`, `menu_nombre`, `nombre_comensal`, `correo_comensal`, `telefono_comensal`, `cantidad`, `comentarios`, `fecha_pedido`, `cedula`, `tipo_consumo`, `numero_mesa`) VALUES
(1, 'Pollo Asado', 'FABIAN CADENA', 'fabia@gmail.com', '3223154627', 0, '', '2025-03-14 19:52:32', NULL, 'en el lugar', NULL),
(2, 'Pollo Asado', 'FABIAN CADENA carpio', 'fabia@gmail.com', '3223154627', 0, '', '2025-03-14 19:55:24', NULL, 'en el lugar', NULL),
(3, 'Bistec a Caballo', 'FABIAN CARPIO', 'fabia@gmail.com', '3223154627', 0, '', '2025-03-14 19:58:34', NULL, 'en el lugar', NULL),
(4, 'Pechuga a la Plancha', 'JUAN PEREZ', 'fabia@gmail.com', '3223154627', 0, '123', '2025-03-14 19:59:11', NULL, 'en el lugar', NULL),
(5, 'Carne Sudada', 'JUAN PEREZ', 'fabia@gmail.com', '3223154627', 0, '', '2025-03-14 19:59:36', NULL, 'en el lugar', NULL),
(6, 'Chuleta de Cerdo', 'CARALOS BASTIDAS', 'fabia@gmail.com', '3223154627', 0, '', '2025-03-14 20:02:13', NULL, 'en el lugar', NULL),
(7, 'Pechuga a la Plancha', 'CARALOS BASTIDAS', 'fabia@gmail.com', '3223154627', 0, '', '2025-03-14 20:02:34', NULL, 'en el lugar', NULL),
(8, 'Bistec a Caballo', 'CARALOS BASTIDAS', 'fabia@gmail.com', '3223154627', 0, '', '2025-03-14 20:03:12', NULL, 'en el lugar', NULL),
(9, 'Pechuga a la Plancha', 'CARALOS BASTIDAS', 'fabia@gmail.com', '3223154627', 0, '', '2025-03-14 20:05:18', NULL, 'en el lugar', NULL),
(23, 'Bistec a Caballo', 'JULIAN MATEUS', 'CASDAS@GMIL.COM', '651616ASDAS', 12, '', '2025-03-15 18:47:51', '3518625', 'en el lugar', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
