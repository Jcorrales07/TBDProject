-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=1;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=1;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema proyecto_inventario
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema proyecto_inventario
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `proyecto_inventario` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
-- -----------------------------------------------------
-- Schema proyecto_proyecto_inventario
-- -----------------------------------------------------
USE `proyecto_inventario` ;

-- -----------------------------------------------------
-- Table `proyecto_inventario`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_inventario`.`usuario` (
  `id_usuario` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `username` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `proyecto_inventario`.`ajuste`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_inventario`.`ajuste` (
  `id_ajuste` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `comentario` TEXT NOT NULL,
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_ajuste`),
  INDEX `fk_ajuste_usuario_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_ajuste_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `proyecto_inventario`.`usuario` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto_inventario`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_inventario`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `fk_cliente_usuario_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `proyecto_inventario`.`usuario` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto_inventario`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_inventario`.`proveedor` (
  `id_proveedor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `nombre_contacto_principal` VARCHAR(45) NOT NULL,
  `estado` TINYINT NOT NULL,
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_proveedor`),
  INDEX `fk_proveedor_usuario_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_proveedor_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `proyecto_inventario`.`usuario` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto_inventario`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_inventario`.`compra` (
  `id_compra` INT NOT NULL,
  `id_proveedor` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `proveedor_compra` VARCHAR(45) NOT NULL,
  `total` DOUBLE NOT NULL,
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_compra`),
  INDEX `fk_proveedor_compra_p_idx` (`id_proveedor` ASC) VISIBLE,
  INDEX `fk_compra_usuario_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_proveedor_compra_p`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `proyecto_inventario`.`proveedor` (`id_proveedor`),
  CONSTRAINT `fk_compra_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `proyecto_inventario`.`usuario` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto_inventario`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_inventario`.`producto` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `costo` DOUBLE NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `precio` DOUBLE NOT NULL,
  `existencia_min` INT NOT NULL,
  `existencia_max` INT NOT NULL,
  `estado` TINYINT NOT NULL,
  PRIMARY KEY (`id_producto`),
  INDEX `fk_producto_usuario_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_producto_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `proyecto_inventario`.`usuario` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto_inventario`.`detalle_ajuste`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_inventario`.`detalle_ajuste` (
  `id_detalle_ajuste` INT NOT NULL AUTO_INCREMENT,
  `id_ajuste` INT NOT NULL,
  `id_producto` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `costo` DOUBLE NOT NULL,
  `subtotal` DOUBLE NOT NULL,
  PRIMARY KEY (`id_detalle_ajuste`, `id_ajuste`),
  INDEX `fk_ajuste_detalle_ajuste_idx` (`id_ajuste` ASC) VISIBLE,
  INDEX `fk_detalle_ajuste_producto_idx` (`id_producto` ASC) VISIBLE,
  CONSTRAINT `fk_ajuste_detalle_ajuste`
    FOREIGN KEY (`id_ajuste`)
    REFERENCES `proyecto_inventario`.`ajuste` (`id_ajuste`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_detalle_ajuste_producto`
    FOREIGN KEY (`id_producto`)
    REFERENCES `proyecto_inventario`.`producto` (`id_producto`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto_inventario`.`detalle_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_inventario`.`detalle_compra` (
  `id_detalle_compra` INT NOT NULL AUTO_INCREMENT,
  `id_compra` INT NOT NULL,
  `id_producto` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `costo` DOUBLE NOT NULL,
  `subtotal` DOUBLE NOT NULL,
  PRIMARY KEY (`id_detalle_compra`, `id_compra`),
  INDEX `fk_compra_detalle_compra_idx` (`id_compra` ASC) VISIBLE,
  INDEX `fk_detalle_compra_producto_idx` (`id_producto` ASC) VISIBLE,
  CONSTRAINT `fk_compra_detalle_compra`
    FOREIGN KEY (`id_compra`)
    REFERENCES `proyecto_inventario`.`compra` (`id_compra`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_detalle_compra_producto`
    FOREIGN KEY (`id_producto`)
    REFERENCES `proyecto_inventario`.`producto` (`id_producto`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto_inventario`.`factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_inventario`.`factura` (
  `id_factura` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `subtotal` DOUBLE NOT NULL,
  `impuesto` DOUBLE NOT NULL,
  `descuento` DOUBLE NOT NULL,
  `total` DOUBLE NOT NULL,
  PRIMARY KEY (`id_factura`),
  INDEX `fk_factura_cliente1_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `fk_factura_usuario_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_factura_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `proyecto_inventario`.`cliente` (`id_cliente`),
  CONSTRAINT `fk_factura_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `proyecto_inventario`.`usuario` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto_inventario`.`detalle_factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_inventario`.`detalle_factura` (
  `id_detalle_factura` INT NOT NULL AUTO_INCREMENT,
  `id_factura` INT NOT NULL,
  `id_producto` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precio` DOUBLE NOT NULL,
  `subtotal` DOUBLE NOT NULL,
  PRIMARY KEY (`id_detalle_factura`, `id_factura`),
  INDEX `fk_factura_detalle_factura_idx` (`id_factura` ASC) VISIBLE,
  INDEX `fk_detalle_factura_producto_idx` (`id_producto` ASC) VISIBLE,
  CONSTRAINT `fk_factura_detalle_factura`
    FOREIGN KEY (`id_factura`)
    REFERENCES `proyecto_inventario`.`factura` (`id_factura`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_detalle_factura_producto`
    FOREIGN KEY (`id_producto`)
    REFERENCES `proyecto_inventario`.`producto` (`id_producto`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto_inventario`.`kardex`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_inventario`.`kardex` (
  `id_kardex` INT NOT NULL AUTO_INCREMENT,
  `id_producto` INT NOT NULL,
  `usuario_editor` INT NOT NULL,
  `nombre_operacion` VARCHAR(45) NOT NULL,
  `producto` VARCHAR(45) NOT NULL,
  `cantidad` INT NOT NULL,
  `costo` DOUBLE NOT NULL,
  `precio` DOUBLE NOT NULL,
  `fecha` DATETIME NOT NULL,
  `proyecto_inventario_antes` INT NOT NULL,
  `proyecto_inventario_despues` INT NOT NULL,
  PRIMARY KEY (`id_kardex`),
  INDEX `fk_kardex_producto1_idx` (`id_producto` ASC) VISIBLE,
  INDEX `fk_kardex_usuario_idx` (`usuario_editor` ASC) VISIBLE,
  CONSTRAINT `fk_kardex_producto`
    FOREIGN KEY (`id_producto`)
    REFERENCES `proyecto_inventario`.`producto` (`id_producto`),
  CONSTRAINT `fk_kardex_usuario`
    FOREIGN KEY (`usuario_editor`)
    REFERENCES `proyecto_inventario`.`usuario` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto_inventario`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_inventario`.`rol` (
  `id_rol` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_inventario`.`privilegio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_inventario`.`privilegio` (
  `id_privilegio` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_privilegio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_inventario`.`usuario_rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_inventario`.`usuario_rol` (
  `id_usuario` INT NOT NULL,
  `id_rol` INT NOT NULL,
  PRIMARY KEY (`id_usuario`, `id_rol`),
  INDEX `fk_id_rol_usuario_idx` (`id_rol` ASC) VISIBLE,
  CONSTRAINT `fk_id_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `proyecto_inventario`.`usuario` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_id_rol_usuario`
    FOREIGN KEY (`id_rol`)
    REFERENCES `proyecto_inventario`.`rol` (`id_rol`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_inventario`.`rol_privilegio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_inventario`.`rol_privilegio` (
  `id_rol` INT NOT NULL,
  `id_privilegio` INT NOT NULL,
  PRIMARY KEY (`id_rol`, `id_privilegio`),
  INDEX `fk_id_privilegio_idx` (`id_privilegio` ASC) VISIBLE,
  CONSTRAINT `fk_id_rol_privilegio_r`
    FOREIGN KEY (`id_rol`)
    REFERENCES `proyecto_inventario`.`rol` (`id_rol`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_id_privilegio`
    FOREIGN KEY (`id_privilegio`)
    REFERENCES `proyecto_inventario`.`privilegio` (`id_privilegio`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
