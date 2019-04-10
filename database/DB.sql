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
CREATE TABLE IF NOT EXISTS `RRHH`.`persona` (
  `id_persona` INT NOT NULL AUTO_INCREMENT,
  `ap_paterno` VARCHAR(150) NOT NULL,
  `ap_materno` VARCHAR(150) NOT NULL,
  `nombres` VARCHAR(250) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `provincia` VARCHAR(300) NOT NULL,
  `departamento` VARCHAR(250) NOT NULL,
  `CI` VARCHAR(15) NOT NULL,
  `celular` INT(11) NOT NULL,
  `estado_civil` VARCHAR(45) NOT NULL,
  `domicilio` VARCHAR(250) NOT NULL,
  `sexo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_persona`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RRHH`.`direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RRHH`.`direccion` (
  `id_direccion` INT NOT NULL AUTO_INCREMENT,
  `nombre_direccion` VARCHAR(250) NOT NULL,
  `descripcion_direccion` VARCHAR(350) NULL,
  PRIMARY KEY (`id_direccion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RRHH`.`unidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RRHH`.`unidad` (
  `id_unidad` INT NOT NULL AUTO_INCREMENT,
  `nombre_unidad` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `direccion_id_direccion` INT NOT NULL,
  PRIMARY KEY (`id_unidad`),
  INDEX `fk_unidad_direccion1_idx` (`direccion_id_direccion` ASC) VISIBLE,
  CONSTRAINT `fk_unidad_direccion1`
    FOREIGN KEY (`direccion_id_direccion`)
    REFERENCES `RRHH`.`direccion` (`id_direccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RRHH`.`cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RRHH`.`cargo` (
  `id_cargo` INT NOT NULL AUTO_INCREMENT,
  `nombre_cargo` VARCHAR(250) NOT NULL,
  `descricion` VARCHAR(45) NOT NULL,
  `unidad_id_unidad` INT NOT NULL,
  PRIMARY KEY (`id_cargo`),
  INDEX `fk_cargo_unidad1_idx` (`unidad_id_unidad` ASC) VISIBLE,
  CONSTRAINT `fk_cargo_unidad1`
    FOREIGN KEY (`unidad_id_unidad`)
    REFERENCES `RRHH`.`unidad` (`id_unidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RRHH`.`niveles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RRHH`.`niveles` (
  `id_niveles` INT NOT NULL AUTO_INCREMENT,
  `nombre_nivel` VARCHAR(250) NOT NULL,
  `haber_basico` INT NOT NULL,
  PRIMARY KEY (`id_niveles`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RRHH`.`tipo_memo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RRHH`.`tipo_memo` (
  `id_tipo_memo` INT NOT NULL AUTO_INCREMENT,
  `tipo_memo` VARCHAR(250) NOT NULL,
  `descripcion` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id_tipo_memo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RRHH`.`memos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RRHH`.`memos` (
  `id_memos` INT NOT NULL AUTO_INCREMENT,
  `nro_memo` VARCHAR(45) NOT NULL,
  `descripcion_memo` VARCHAR(500) NOT NULL,
  `fecha_memo` DATE NOT NULL,
  `tipo_memo_id_tipo_memo` INT NOT NULL,
  `persona_id_persona` INT NOT NULL,
  PRIMARY KEY (`id_memos`),
  INDEX `fk_memos_tipo_memo1_idx` (`tipo_memo_id_tipo_memo` ASC) VISIBLE,
  INDEX `fk_memos_persona1_idx` (`persona_id_persona` ASC) VISIBLE,
  CONSTRAINT `fk_memos_tipo_memo1`
    FOREIGN KEY (`tipo_memo_id_tipo_memo`)
    REFERENCES `RRHH`.`tipo_memo` (`id_tipo_memo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_memos_persona1`
    FOREIGN KEY (`persona_id_persona`)
    REFERENCES `RRHH`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RRHH`.`familiares`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RRHH`.`familiares` (
  `id_familiares` INT NOT NULL AUTO_INCREMENT,
  `nombre_familiar` VARCHAR(250) NOT NULL,
  `tipo_parentesco` VARCHAR(250) NULL,
  `fecha_nacimiento` DATE NULL,
  `CI_familiar` VARCHAR(15) NULL,
  `persona_id_persona` INT NOT NULL,
  PRIMARY KEY (`id_familiares`),
  INDEX `fk_familiares_persona1_idx` (`persona_id_persona` ASC) VISIBLE,
  CONSTRAINT `fk_familiares_persona1`
    FOREIGN KEY (`persona_id_persona`)
    REFERENCES `RRHH`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `RRHH`.`contrataciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RRHH`.`contrataciones` (
  `id_contratacion` INT NOT NULL AUTO_INCREMENT,
  `fecha_ingreso` DATE NOT NULL,
  `fecha_retiro` DATE NULL,
  `año_servicio` DATE NULL,
  `motivo_retiro` VARCHAR(250) NULL,
  `persona_id_persona` INT NOT NULL,
  `niveles_id_niveles` INT NOT NULL,
  `cargo_id_cargo` INT NOT NULL,
  PRIMARY KEY (`id_contratacion`),
  INDEX `fk_contrataciones_persona1_idx` (`persona_id_persona` ASC) VISIBLE,
  INDEX `fk_contrataciones_niveles1_idx` (`niveles_id_niveles` ASC) VISIBLE,
  INDEX `fk_contrataciones_cargo1_idx` (`cargo_id_cargo` ASC) VISIBLE,
  CONSTRAINT `fk_contrataciones_persona1`
    FOREIGN KEY (`persona_id_persona`)
    REFERENCES `RRHH`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contrataciones_niveles1`
    FOREIGN KEY (`niveles_id_niveles`)
    REFERENCES `RRHH`.`niveles` (`id_niveles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contrataciones_cargo1`
    FOREIGN KEY (`cargo_id_cargo`)
    REFERENCES `RRHH`.`cargo` (`id_cargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RRHH`.`formacion_academica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RRHH`.`formacion_academica` (
  `id_formacion` INT NOT NULL AUTO_INCREMENT,
  `nivel_academico` VARCHAR(250) NOT NULL,
  `profesion_ocupacion` VARCHAR(250) NOT NULL,
  `persona_id_persona` INT NOT NULL,
  PRIMARY KEY (`id_formacion`),
  INDEX `fk_formacion_academica_persona1_idx` (`persona_id_persona` ASC) VISIBLE,
  CONSTRAINT `fk_formacion_academica_persona1`
    FOREIGN KEY (`persona_id_persona`)
    REFERENCES `RRHH`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RRHH`.`requisitos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RRHH`.`requisitos` (
  `id_requisitos` INT NOT NULL AUTO_INCREMENT,
  `curriculum` TINYINT NOT NULL,
  `declaracion jurada` TINYINT NOT NULL,
  `fecha_declaracion` DATE NOT NULL,
  `incompatibilidad` TINYINT NOT NULL,
  `certificado_antecedentes` TINYINT NOT NULL,
  `libreta_militar` TINYINT NOT NULL,
  `patron_biometrico` TINYINT NOT NULL,
  `seguro_salud` TINYINT NOT NULL,
  `sippase` TINYINT NOT NULL,
  `AFP` VARCHAR(45) NOT NULL,
  `idioma_nativo` TINYINT NOT NULL,
  `persona_id_persona` INT NOT NULL,
  PRIMARY KEY (`id_requisitos`),
  INDEX `fk_requisitos_persona1_idx` (`persona_id_persona` ASC) VISIBLE,
  CONSTRAINT `fk_requisitos_persona1`
    FOREIGN KEY (`persona_id_persona`)
    REFERENCES `RRHH`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RRHH`.`boletas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RRHH`.`boletas` (
  `id_boleta` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(45) NOT NULL,
  `tipo_tramite` TIME NOT NULL,
  `hora_salida` TIME NOT NULL,
  `fecha` DATE NOT NULL,
  `observacion` VARCHAR(250) NOT NULL,
  `persona_id_persona` INT NOT NULL,
  PRIMARY KEY (`id_boleta`, `codigo`),
  INDEX `fk_boletas_persona_idx` (`persona_id_persona` ASC) VISIBLE,
  CONSTRAINT `fk_boletas_persona`
    FOREIGN KEY (`persona_id_persona`)
    REFERENCES `RRHH`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
