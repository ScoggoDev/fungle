-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-07-2020 a las 15:01:09
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `funmodel`
--
CREATE DATABASE IF NOT EXISTS `funmodel` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `funmodel`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `animal`
--

CREATE TABLE `animal` (
  `animal_id` int(11) NOT NULL,
  `animal_name` varchar(12) NOT NULL,
  `animal_statid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `blacklist`
--

CREATE TABLE `blacklist` (
  `blist_logid` int(11) NOT NULL,
  `blist_userid` int(11) NOT NULL,
  `blist_reason` varchar(100) NOT NULL DEFAULT 'NO REASON ESPECIFIED',
  `blist_status` varchar(12) NOT NULL DEFAULT 'SUSPENDED',
  `blist_when` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `blacklist_logid_seq`
--

CREATE TABLE `blacklist_logid_seq` (
  `next_not_cached_value` bigint(21) NOT NULL,
  `minimum_value` bigint(21) NOT NULL,
  `maximum_value` bigint(21) NOT NULL,
  `start_value` bigint(21) NOT NULL COMMENT 'start value when sequences is created or value if RESTART is used',
  `increment` bigint(21) NOT NULL COMMENT 'increment value',
  `cache_size` bigint(21) UNSIGNED NOT NULL,
  `cycle_option` tinyint(1) UNSIGNED NOT NULL COMMENT '0 if no cycles are allowed, 1 if the sequence should begin a new cycle when maximum_value is passed',
  `cycle_count` bigint(21) NOT NULL COMMENT 'How many cycles have been done'
) ENGINE=InnoDB;

--
-- Volcado de datos para la tabla `blacklist_logid_seq`
--

INSERT INTO `blacklist_logid_seq` (`next_not_cached_value`, `minimum_value`, `maximum_value`, `start_value`, `increment`, `cache_size`, `cycle_option`, `cycle_count`) VALUES
(1, 1, 9223372036854775806, 1, 1, 1000, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `friendlist`
--

CREATE TABLE `friendlist` (
  `flist_reqid` int(11) NOT NULL,
  `flist_sender` int(11) NOT NULL,
  `flist_receiver` int(11) NOT NULL,
  `flist_status` varchar(8) NOT NULL DEFAULT 'PENDING',
  `flist_when` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `friendslist_reqid_seq`
--

CREATE TABLE `friendslist_reqid_seq` (
  `next_not_cached_value` bigint(21) NOT NULL,
  `minimum_value` bigint(21) NOT NULL,
  `maximum_value` bigint(21) NOT NULL,
  `start_value` bigint(21) NOT NULL COMMENT 'start value when sequences is created or value if RESTART is used',
  `increment` bigint(21) NOT NULL COMMENT 'increment value',
  `cache_size` bigint(21) UNSIGNED NOT NULL,
  `cycle_option` tinyint(1) UNSIGNED NOT NULL COMMENT '0 if no cycles are allowed, 1 if the sequence should begin a new cycle when maximum_value is passed',
  `cycle_count` bigint(21) NOT NULL COMMENT 'How many cycles have been done'
) ENGINE=InnoDB;

--
-- Volcado de datos para la tabla `friendslist_reqid_seq`
--

INSERT INTO `friendslist_reqid_seq` (`next_not_cached_value`, `minimum_value`, `maximum_value`, `start_value`, `increment`, `cache_size`, `cycle_option`, `cycle_count`) VALUES
(1, 1, 9223372036854775806, 1, 1, 1000, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `groups`
--

CREATE TABLE `groups` (
  `grp_reqid` int(11) NOT NULL,
  `grp_id` int(11) NOT NULL,
  `grp_name` varchar(20) NOT NULL DEFAULT 'New Group',
  `grp_leader` int(11) NOT NULL,
  `grp_receiver` int(11) NOT NULL,
  `grp_status` varchar(8) NOT NULL DEFAULT 'PENDING',
  `grp_when` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `groups_reqid_seq`
--

CREATE TABLE `groups_reqid_seq` (
  `next_not_cached_value` bigint(21) NOT NULL,
  `minimum_value` bigint(21) NOT NULL,
  `maximum_value` bigint(21) NOT NULL,
  `start_value` bigint(21) NOT NULL COMMENT 'start value when sequences is created or value if RESTART is used',
  `increment` bigint(21) NOT NULL COMMENT 'increment value',
  `cache_size` bigint(21) UNSIGNED NOT NULL,
  `cycle_option` tinyint(1) UNSIGNED NOT NULL COMMENT '0 if no cycles are allowed, 1 if the sequence should begin a new cycle when maximum_value is passed',
  `cycle_count` bigint(21) NOT NULL COMMENT 'How many cycles have been done'
) ENGINE=InnoDB;

--
-- Volcado de datos para la tabla `groups_reqid_seq`
--

INSERT INTO `groups_reqid_seq` (`next_not_cached_value`, `minimum_value`, `maximum_value`, `start_value`, `increment`, `cache_size`, `cycle_option`, `cycle_count`) VALUES
(1, 1, 9223372036854775806, 1, 1, 1000, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stat`
--

CREATE TABLE `stat` (
  `stat_id` int(11) NOT NULL,
  `stat_name` int(10) NOT NULL,
  `stat_desc` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `usr_id` int(11) NOT NULL,
  `usr_name` varchar(20) NOT NULL,
  `usr_pwd` varchar(20) NOT NULL,
  `usr_animal` int(11) NOT NULL,
  `usr_phone` varchar(15) NOT NULL,
  `usr_group` int(11) DEFAULT NULL,
  `usr_status` varchar(10) NOT NULL DEFAULT 'ACTIVE',
  `usr_created` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_id_seq`
--

CREATE TABLE `users_id_seq` (
  `next_not_cached_value` bigint(21) NOT NULL,
  `minimum_value` bigint(21) NOT NULL,
  `maximum_value` bigint(21) NOT NULL,
  `start_value` bigint(21) NOT NULL COMMENT 'start value when sequences is created or value if RESTART is used',
  `increment` bigint(21) NOT NULL COMMENT 'increment value',
  `cache_size` bigint(21) UNSIGNED NOT NULL,
  `cycle_option` tinyint(1) UNSIGNED NOT NULL COMMENT '0 if no cycles are allowed, 1 if the sequence should begin a new cycle when maximum_value is passed',
  `cycle_count` bigint(21) NOT NULL COMMENT 'How many cycles have been done'
) ENGINE=InnoDB;

--
-- Volcado de datos para la tabla `users_id_seq`
--

INSERT INTO `users_id_seq` (`next_not_cached_value`, `minimum_value`, `maximum_value`, `start_value`, `increment`, `cache_size`, `cycle_option`, `cycle_count`) VALUES
(1, 1, 9223372036854775806, 1, 1, 1000, 0, 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `animal`
--
ALTER TABLE `animal`
  ADD PRIMARY KEY (`animal_id`),
  ADD KEY `animal_stats` (`animal_statid`);

--
-- Indices de la tabla `blacklist`
--
ALTER TABLE `blacklist`
  ADD PRIMARY KEY (`blist_logid`),
  ADD KEY `blist_user` (`blist_userid`);

--
-- Indices de la tabla `friendlist`
--
ALTER TABLE `friendlist`
  ADD PRIMARY KEY (`flist_reqid`),
  ADD KEY `flist_sender_usr` (`flist_sender`),
  ADD KEY `flist_receiver_usr` (`flist_receiver`);

--
-- Indices de la tabla `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`grp_reqid`),
  ADD KEY `grp_leader_usr` (`grp_leader`),
  ADD KEY `grp_receiver_usr` (`grp_receiver`);

--
-- Indices de la tabla `stat`
--
ALTER TABLE `stat`
  ADD PRIMARY KEY (`stat_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`usr_id`),
  ADD KEY `usr_group` (`usr_group`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `animal`
--
ALTER TABLE `animal`
  MODIFY `animal_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `blacklist`
--
ALTER TABLE `blacklist`
  MODIFY `blist_logid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `friendlist`
--
ALTER TABLE `friendlist`
  MODIFY `flist_reqid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `groups`
--
ALTER TABLE `groups`
  MODIFY `grp_reqid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `stat`
--
ALTER TABLE `stat`
  MODIFY `stat_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `usr_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `animal`
--
ALTER TABLE `animal`
  ADD CONSTRAINT `animal_stats` FOREIGN KEY (`animal_statid`) REFERENCES `stat` (`stat_id`);

--
-- Filtros para la tabla `blacklist`
--
ALTER TABLE `blacklist`
  ADD CONSTRAINT `blist_user` FOREIGN KEY (`blist_userid`) REFERENCES `users` (`usr_id`);

--
-- Filtros para la tabla `friendlist`
--
ALTER TABLE `friendlist`
  ADD CONSTRAINT `flist_receiver_usr` FOREIGN KEY (`flist_receiver`) REFERENCES `users` (`usr_id`),
  ADD CONSTRAINT `flist_sender_usr` FOREIGN KEY (`flist_sender`) REFERENCES `users` (`usr_id`);

--
-- Filtros para la tabla `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `grp_leader_usr` FOREIGN KEY (`grp_leader`) REFERENCES `users` (`usr_id`),
  ADD CONSTRAINT `grp_receiver_usr` FOREIGN KEY (`grp_receiver`) REFERENCES `users` (`usr_id`);

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `usr_group` FOREIGN KEY (`usr_group`) REFERENCES `groups` (`grp_reqid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
