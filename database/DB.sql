-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema RRHH
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema RRHH
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `RRHH` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci ;
USE `RRHH` ;

-- -----------------------------------------------------
-- Table `RRHH`.`persona`
-- -----------------------------------------------------
CREATE TABLE `personas` (
  `id_persona` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ap_paterno` varchar(150) COLLATE utf8_spanish_ci NOT NULL,
  `ap_materno` varchar(150) COLLATE utf8_spanish_ci NOT NULL,
  `nombres` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `provincia` varchar(300) COLLATE utf8_spanish_ci NOT NULL,
  `departamento` enum('Pando','Beni','Cochabamba','Santa Cruz','Tarija','Oruro','La Paz','Chuquisaca','Potosi') COLLATE utf8_spanish_ci NOT NULL,
  `CI` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `celular` int(11) NOT NULL,
  `estado_civil` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `domicilio` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `sexo` enum('M','F') COLLATE utf8_spanish_ci NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_persona`),
  UNIQUE KEY `CI` (`CI`)
) ENGINE=InnoDB AUTO_INCREMENT=220 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `RRHH`.`direccion`
-- -----------------------------------------------------
CREATE TABLE `direcciones` (
  `id_direccion` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nombre_direccion` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion_direccion` varchar(350) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id_direccion`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RRHH`.`unidad`
-- -----------------------------------------------------
CREATE TABLE `unidades` (
  `id_unidad` int(11) NOT NULL AUTO_INCREMENT,
  `id_direccion` int(11) unsigned NOT NULL,
  `nombre_unidad` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_unidad`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RRHH`.`cargo`
-- -----------------------------------------------------
CREATE TABLE `cargos` (
  `id_cargo` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_unidad` int(11) NOT NULL,
  `nombre_cargo` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_cargo`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RRHH`.`niveles`
-- -----------------------------------------------------
CREATE TABLE `niveles` (
  `id_nivel` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nombre_nivel` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `haber_basico` double(6,2) DEFAULT NULL,
  PRIMARY KEY (`id_nivel`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RRHH`.`tipo_memo`
-- -----------------------------------------------------
CREATE TABLE `tipo_memos` (
  `id_tipo_memo` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tipo_memo` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` varchar(500) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_tipo_memo`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RRHH`.`memos`
-- -----------------------------------------------------
CREATE TABLE `memos` (
  `id_memo` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_tipo_memo` int(11) unsigned NOT NULL,
  `id_persona` int(11) unsigned NOT NULL,
  `nro_memo` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion_memo` varchar(500) COLLATE utf8_spanish_ci NOT NULL,
  `fecha_memo` date NOT NULL,
  PRIMARY KEY (`id_memo`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RRHH`.`familiares`
-- -----------------------------------------------------
CREATE TABLE `familiares` (
  `id_familiar` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_persona` int(11) unsigned NOT NULL,
  `nombre_familiar` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `tipo_parentesco` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fecha_nacimiento` date NOT NULL,
  `CI_familiar` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_familiar`)
) ENGINE = InnoDB



-- -----------------------------------------------------
-- Table `RRHH`.`contrataciones`
-- -----------------------------------------------------
CREATE TABLE `contrataciones` (
  `id_contratacion` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_persona` int(11) unsigned NOT NULL,
  `id_requisito` int(11) unsigned NOT NULL,
  `id_nivel` int(11) unsigned NOT NULL,
  `id_cargo` int(11) unsigned NOT NULL,
  `id_horario` int(11) unsigned NOT NULL,
  `PIN` int(11) NOT NULL,
  `contrato` enum('FIJO','EVENTUAL') COLLATE utf8_spanish_ci DEFAULT NULL,
  `fecha_ingreso` date NOT NULL,
  `fecha_retiro` date DEFAULT NULL,
  `motivo_retiro` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_contratacion`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RRHH`.`formacion_academica`
-- -----------------------------------------------------
CREATE TABLE `formacion_academica` (
  `id_formacion` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_persona` int(11) unsigned NOT NULL,
  `nivel_academico` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `profesion_ocupacion` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_formacion`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RRHH`.`requisitos`
-- -----------------------------------------------------
CREATE TABLE `requisitos` (
  `id_requisito` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_persona` int(11) unsigned NOT NULL,
  `curriculum` tinyint(1) NOT NULL DEFAULT '1',
  `declaracion_jurada` tinyint(1) NOT NULL DEFAULT '1',
  `fecha_declaracion` date NOT NULL DEFAULT (_cp850'2019/01/05'),
  `incompatibilidad` tinyint(1) NOT NULL DEFAULT '1',
  `certificado_antecedentes` tinyint(1) NOT NULL DEFAULT '1',
  `libreta_militar` tinyint(1) DEFAULT '1',
  `patron_biometrico` tinyint(1) NOT NULL DEFAULT '1',
  `seguro_salud` tinyint(1) NOT NULL DEFAULT '1',
  `sippase` tinyint(1) NOT NULL DEFAULT '1',
  `AFP` enum('prevision','futuro') COLLATE utf8_spanish_ci NOT NULL DEFAULT (_cp850'futuro'),
  `idioma_nativo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_requisito`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RRHH`.`boletas`
-- -----------------------------------------------------
CREATE TABLE `boletas` (
  `id_boleta` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_persona` int(11) unsigned NOT NULL,
  `codigo` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `tipo_tramite` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `hora_salida` time NOT NULL,
  `hora_retorno` time NOT NULL,
  `fecha` date NOT NULL,
  `observacion` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_boleta`)
)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
