DROP DATABASE `peruretouch`;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema PeruRetouch
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PeruRetouch` DEFAULT CHARACTER SET utf16 ;
USE `PeruRetouch` ;

-- -----------------------------------------------------
-- Table `PeruRetouch`.`Profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PeruRetouch`.`Profile` (
  `idProfile` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(200) NULL,
  `state` VARCHAR(50) NULL,
  PRIMARY KEY (`idProfile`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PeruRetouch`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PeruRetouch`.`User` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `userLogin` VARCHAR(50) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `idProfile` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `lastName` VARCHAR(50) NOT NULL,
  `address` VARCHAR(200) NULL,
  `country` VARCHAR(50) NULL,
  `birthDay` DATE NULL,
  `telephone` VARCHAR(50) NULL,
  `cellphone` VARCHAR(50) NULL,
  `email` VARCHAR(50) NOT NULL,
  `webPage` VARCHAR(200) NOT NULL,
  `state` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idUser`),
  INDEX `fk_User_Profile_idx` (`idProfile` ASC),
  CONSTRAINT `fk_User_Profile`
    FOREIGN KEY (`idProfile`)
    REFERENCES `PeruRetouch`.`Profile` (`idProfile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PeruRetouch`.`Orden`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PeruRetouch`.`Orden` (
  `idOrder` INT NOT NULL AUTO_INCREMENT,
  `idClient` INT NOT NULL,
  `orderName` VARCHAR(100) NULL,
  `dateTimeClientRequest` TIMESTAMP NULL,
  `specifications` TEXT NULL,
  `total` DECIMAL(18,2) NULL,
  `state` VARCHAR(50) NULL,
  PRIMARY KEY (`idOrder`),
  INDEX `fk_Order_User1_idx` (`idClient` ASC),
  CONSTRAINT `fk_Order_User1`
    FOREIGN KEY (`idClient`)
    REFERENCES `PeruRetouch`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PeruRetouch`.`Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PeruRetouch`.`Status` (
  `idStatus` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(200) NULL,
  `state` VARCHAR(50) NULL,
  PRIMARY KEY (`idStatus`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PeruRetouch`.`OrderXStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PeruRetouch`.`OrderXStatus` (
  `idOrder` INT NOT NULL AUTO_INCREMENT,
  `idStatus` INT NOT NULL,
  INDEX `fk_OrderXStatus_Order1_idx` (`idOrder` ASC),
  INDEX `fk_OrderXStatus_Status1_idx` (`idStatus` ASC),
  PRIMARY KEY (`idOrder`, `idStatus`),
  CONSTRAINT `fk_OrderXStatus_Order1`
    FOREIGN KEY (`idOrder`)
    REFERENCES `PeruRetouch`.`Orden` (`idOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderXStatus_Status1`
    FOREIGN KEY (`idStatus`)
    REFERENCES `PeruRetouch`.`Status` (`idStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PeruRetouch`.`SpecificationType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PeruRetouch`.`SpecificationType` (
  `idSpecificationType` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(200) NULL,
  `state` VARCHAR(50) NULL,
  PRIMARY KEY (`idSpecificationType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PeruRetouch`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PeruRetouch`.`Product` (
  `idProduct` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` TEXT NULL,
  `abreviation` VARCHAR(10) NULL,
  `price` DECIMAL(18,2) NULL,
  `state` VARCHAR(50) NULL,
  PRIMARY KEY (`idProduct`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PeruRetouch`.`Retouch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PeruRetouch`.`Retouch` (
  `idRetouch` INT NOT NULL AUTO_INCREMENT,
  `idOrder` INT NOT NULL,
  `idProduct` INT NOT NULL,
  `idArtist` INT NULL,
  `idSupervisor` INT NULL,
  `dateTimeArtistRequest` TIMESTAMP NULL,
  `dateTimeUploadRetouch` TIMESTAMP NULL,
  `fileNombre` VARCHAR(200) NULL,
  `photoId` INT NULL,
  PRIMARY KEY (`idRetouch`),
  INDEX `fk_Retouch_Order1_idx` (`idOrder` ASC),
  INDEX `fk_Retouch_Product1_idx` (`idProduct` ASC),
  INDEX `fk_Retouch_User1_idx` (`idArtist` ASC),
  INDEX `fk_Retouch_User2_idx` (`idSupervisor` ASC),
  CONSTRAINT `fk_Retouch_Order1`
    FOREIGN KEY (`idOrder`)
    REFERENCES `PeruRetouch`.`Orden` (`idOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Retouch_Product1`
    FOREIGN KEY (`idProduct`)
    REFERENCES `PeruRetouch`.`Product` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Retouch_User1`
    FOREIGN KEY (`idArtist`)
    REFERENCES `PeruRetouch`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Retouch_User2`
    FOREIGN KEY (`idSupervisor`)
    REFERENCES `PeruRetouch`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PeruRetouch`.`RetouchXStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PeruRetouch`.`RetouchXStatus` (
  `idRetouch` INT NOT NULL AUTO_INCREMENT,
  `idStatus` INT NOT NULL,
  INDEX `fk_RetouchXStatus_Retouch1_idx` (`idRetouch` ASC),
  INDEX `fk_RetouchXStatus_Status1_idx` (`idStatus` ASC),
  PRIMARY KEY (`idRetouch`, `idStatus`),
  CONSTRAINT `fk_RetouchXStatus_Retouch1`
    FOREIGN KEY (`idRetouch`)
    REFERENCES `PeruRetouch`.`Retouch` (`idRetouch`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RetouchXStatus_Status1`
    FOREIGN KEY (`idStatus`)
    REFERENCES `PeruRetouch`.`Status` (`idStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PeruRetouch`.`RetouchXSpecification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PeruRetouch`.`RetouchXSpecification` (
  `idRetouchXSpecification` INT NOT NULL AUTO_INCREMENT,
  `idRetouch` INT NOT NULL,
  `idSpecificationType` INT NOT NULL,
  `idAutor` INT NOT NULL,
  `dateTimeSpecification` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `specification` TEXT NULL,
  INDEX `fk_RetouchXSpecification_Retouch1_idx` (`idRetouch` ASC),
  INDEX `fk_RetouchXSpecification_SpecificationType1_idx` (`idSpecificationType` ASC),
  INDEX `fk_RetouchXSpecification_User1_idx` (`idAutor` ASC),
  PRIMARY KEY (`idRetouchXSpecification`),
  CONSTRAINT `fk_RetouchXSpecification_Retouch1`
    FOREIGN KEY (`idRetouch`)
    REFERENCES `PeruRetouch`.`Retouch` (`idRetouch`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RetouchXSpecification_SpecificationType1`
    FOREIGN KEY (`idSpecificationType`)
    REFERENCES `PeruRetouch`.`SpecificationType` (`idSpecificationType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RetouchXSpecification_User1`
    FOREIGN KEY (`idAutor`)
    REFERENCES `PeruRetouch`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `PeruRetouch` ;

-- -----------------------------------------------------
-- procedure spI_RetouchXSpecification
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spI_RetouchXSpecification` (
_idRetouch int,
_idSpecificationType int,
_idAutor int,
_dateTimeSpecification datetime,
_specification text
)
BEGIN
INSERT INTO `retouchxspecification`(
`idRetouch`,
`idSpecificationType`,
`idAutor`,
`dateTimeSpecification`,
`specification`
)
VALUES (
_idRetouch,
_idSpecificationType,
_idAutor,
_dateTimeSpecification,
_specification
);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spU_Profile
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spU_Profile` (
_idProfile int,
_name varchar(50),
_description varchar(200),
_state varchar(50)
)
BEGIN

UPDATE profile
SET 
	`name` = _name,
	`description` = _description,
	`state` = _state
WHERE
    `idProfile` = _idProfile
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_Profile_all
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_Profile_all` ()
BEGIN

SELECT
    p.idProfile,
    p.name,
    p.description,
	p.state
FROM
    profile p;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_Profile
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_Profile` (
	_idProfile int
)
BEGIN

SELECT
    p.idProfile,
    p.name,
    p.description,
	p.state
FROM
    profile p
WHERE
	p.idProfile = _idProfile
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spD_Profile
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spD_Profile` (
_idProfile int
)
BEGIN

DELETE FROM profile
WHERE idProfile = _idProfile
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spD_SpecificationType
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spD_SpecificationType` (
_idSpecificationType int
)
BEGIN

DELETE FROM specificationtype
WHERE idSpecificationType = _idSpecificationType
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_SpecificationType
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_SpecificationType` (
_idSpecificationType int
)
BEGIN

SELECT
    p.idSpecificationType,
    p.name,
    p.description,
	p.state
FROM
    specificationtype p
WHERE
	p.idSpecificationType = _idSpecificationType
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_SpecificationType_all
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_SpecificationType_all` ()
BEGIN

SELECT
    p.idSpecificationType,
    p.name,
    p.description,
	p.state
FROM
    specificationtype p
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spI_SpecificationType
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spI_SpecificationType` (
_name varchar(50),
_description varchar(200),
_state varchar(50)
)
BEGIN
INSERT INTO `specificationtype`(
   `name`,
   `description`,
   `state`
)
VALUES (
   _name,
   _description,
   _state
);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spU_SpecificationType
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spU_SpecificationType` (
_idSpecificationType int,
_name varchar(50),
_description varchar(200),
_state varchar(50)
)
BEGIN

UPDATE specificationtype
SET 
	`name` = _name,
	`description` = _description,
	`state` = _state
WHERE
    `idSpecificationType` = _idSpecificationType
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spD_Status
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spD_Status` (
_idStatus int
)
BEGIN

DELETE FROM status
WHERE idStatus = _idStatus
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_Status
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_Status` (
	_idStatus int
)
BEGIN

SELECT
    p.idStatus,
    p.name,
    p.description,
	p.state
FROM
    status p
WHERE
	p.idStatus = _idStatus
;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_Status_all
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_Status_all` ()
BEGIN

SELECT
    p.idStatus,
    p.name,
    p.description,
	p.state
FROM
    status p;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spI_Status
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spI_Status` (
_name varchar(50),
_description varchar(200),
_state varchar(50)
)
BEGIN
INSERT INTO `status`(
   `name`,
   `description`,
   `state`
)
VALUES (
   _name,
   _description,
   _state
);


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spU_Status
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spU_Status` (
_idStatus int,
_name varchar(50),
_description varchar(200),
_state varchar(50)
)
BEGIN

UPDATE status
SET 
	`name` = _name,
	`description` = _description,
	`state` = _state
WHERE
    `idStatus` = _idStatus
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spD_Product
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spD_Product` (
_idProduct int
)
BEGIN

DELETE FROM product
WHERE idProduct = _idProduct
;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_Product
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_Product` (
	_idProduct int
)
BEGIN

SELECT
    p.idProduct,
    p.name,
    p.description,
	p.abreviation,
	p.price,
	p.state
FROM
    product p
WHERE
	p.idProduct = _idProduct
;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_Product_all
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_Product_all` ()
BEGIN

SELECT
    p.idProduct,
    p.name,
    p.description,
	p.abreviation,
	p.price,
	p.state
FROM
    product p;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spI_Product
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spI_Product` (
_name varchar(50),
_description text,
_abreviation varchar(10),
_price decimal(18,2),
_state varchar(50)
)
BEGIN
INSERT INTO `product`(
   `name`,
   `description`,
	`abreviation`,
	`price`,
   `state`
)
VALUES (
   _name,
   _description,
   _abreviation,
   _price,
   _state
);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spU_Product
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spU_Product` (
_idProduct int,
_name varchar(50),
_description text,
_abreviation varchar(10),
_price decimal(18,2),
_state varchar(50))
BEGIN

UPDATE product
SET 
	`name` = _name,
	`description` = _description,
	`abreviation` = _abreviation,
	`price` = _price,
	`state` = _state
WHERE
    `idProduct` = _idProduct
;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spD_User
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spD_User` (
_idUser int
)
BEGIN

DELETE FROM user
WHERE idUser = _idUser
;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_User
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_User` (
	_idUser int
)
BEGIN

SELECT
	p.idUser,
	p.userLogin,
	p.password,
	p.idProfile,
    p.name,
	p.lastName,
	p.address,
	p.country,
    p.birthDay,
	p.telephone,
	p.cellphone,
	p.email,
	p.webPage,
	p.state
FROM
    user p
WHERE
	p.idUser = _idUser
;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_User_all
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_User_all` (
)
BEGIN

SELECT
	p.idUser,
	p.userLogin,
	p.password,
	p.idProfile,
    p.name,
	p.lastName,
	p.address,
	p.country,
    p.birthDay,
	p.telephone,
	p.cellphone,
	p.email,
	p.webPage,
	p.state
FROM
    user p
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spI_User
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spI_User` (
_userLogin varchar(50),
_password varchar(50),
_idProfile int,
_name varchar(50),
_lastName varchar(50),
_address varchar(200),
_country varchar(50),
_birthDay date,
_telephone varchar(50),
_cellphone varchar(50),
_email varchar(50),
_webPage varchar(20),
_state varchar(50)
)
BEGIN
INSERT INTO `user`(
   `userLogin`,
   `password`,
   `idProfile`,
   `name`,
   `lastName`,
   `address`,
   `country`,
   `birthDay`,
   `telephone`,
   `cellphone`,
   `email`,
   `webPage`,
   `state`
)
VALUES (
   _userLogin,
   _password,
   _idProfile,
   _name,
   _lastName,
   _address,
   _country,
   _birthDay,
   _telephone,
   _cellphone,
   _email,
   _webPage,
   _state
);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spU_User
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spU_User` (
_idUser int,
_userLogin varchar(50),
_password varchar(50),
_idProfile int,
_name varchar(50),
_lastName varchar(50),
_address varchar(200),
_country varchar(50),
_birthDay date,
_telephone varchar(50),
_cellphone varchar(50),
_email varchar(50),
_webPage varchar(200),
_state varchar(50)
)
BEGIN

UPDATE user
SET 
`userLogin` = _userLogin,
`password` = _password,
`idProfile` = _idProfile,
`name` = _name,
`lastName` = _lastName,
`address` = _address,
`country` = _country,
`birthDay` = _birthDay,
`telephone` = _telephone,
`cellphone` = _cellphone,
`email` = _email,
`webPage` = _webPage,
`state` = _state
WHERE
    `idUser` = _idUser
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spD_Order
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spD_Order` (
_idOrder int
)
BEGIN

DELETE FROM orden
WHERE idOrder = _idOrder
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_Order
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_Order` (
	_idOrder int
)
BEGIN

SELECT
	p.idOrder,
    p.idClient,
	p.orderName,
    p.dateTimeClientRequest,
	p.specifications,
	p.total,
	p.state
FROM
    orden p
WHERE
	p.idOrder = _idOrder
;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_Order_all
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_Order_all` ()
BEGIN

SELECT
	p.idOrder,
    p.idClient,
	p.orderName,
    p.dateTimeClientRequest,
	p.specifications,
	p.total,
	p.state

FROM
    orden p;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spI_Order
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spI_Order` (
_idClient int,
_orderName varchar(100),
_dateTimeClientRequest datetime,
_specifications text,
_total decimal(18,2),
_state varchar(50)
)
BEGIN
INSERT INTO `orden`(
   `idClient`,
	`orderName`,
   `dateTimeClientRequest`,
	`specifications`,
	`total`,
   `state`
)
VALUES (
   _idClient,
	_orderName,
   _dateTimeClientRequest,
	_specifications,
	_total,
   _state
);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_OrdersByClient
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_OrdersByClient` (
	_idClient int
)
BEGIN

SELECT
	p.idOrder,
    p.idClient,
	p.orderName,
    p.dateTimeClientRequest,
	p.specifications,	
	p.total,
	p.state
FROM
    orden p
WHERE
	p.idClient = _idClient
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spD_Retouch
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spD_Retouch` (
_idRetouch int
)
BEGIN

DELETE FROM retouch
WHERE idRetouch = _idRetouch
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_Retouch
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_Retouch` (
	_idRetouch int
)
BEGIN

SELECT
	p.idRetouch,
    p.idOrder,
	p.idProduct,
	p.idArtist,
	p.idSupervisor,
    p.dateTimeArtistRequest,
	p.dateTimeUploadRetouch,
	p.fileNombre,
	p.photoId
FROM
    retouch p
WHERE
	p.idRetouch = _idRetouch
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_Retouch_all
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_Retouch_all` (
)
BEGIN

SELECT
	p.idRetouch,
    p.idOrder,
	p.idProduct,
	p.idArtist,
	p.idSupervisor,
    p.dateTimeArtistRequest,
	p.dateTimeUploadRetouch,
	p.fileNombre,
	p.photoId
FROM
    retouch p
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spI_Retouch
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spI_Retouch` (
_idOrder int,
_idProduct int,
_idArtist int,
_idSupervisor int,
_dateTimeArtistRequest datetime,
_dateTimeUploadRetouch datetime,
_fileNombre varchar(200),
_photoId int
)
BEGIN
INSERT INTO `retouch`(
`idOrder`,
`idProduct`,
`idArtist`,
`idSupervisor`,
`dateTimeArtistRequest`,
`dateTimeUploadRetouch`,
`fileNombre`,
`photoId`
)
VALUES (
_idOrder,
_idProduct,
_idArtist,
_idSupervisor,
_dateTimeArtistRequest,
_dateTimeUploadRetouch,
_fileNombre,
_photoId
);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spU_Retouch
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spU_Retouch` (
_idRetouch int,
_idOrder int,
_idProduct int,
_idArtist int,
_idSupervisor int,
_dateTimeArtistRequest datetime,
_dateTimeUploadRetouch datetime,
_fileNombre varchar(200),
_photoId int
)
BEGIN

UPDATE retouch
SET 
`idOrder` = _idOrder,
`idProduct` = _idProduct,
`idArtist` = _idArtist,
`idSupervisor` = _idSupervisor,
`dateTimeArtistRequest` = _dateTimeArtistRequest,
`dateTimeUploadRetouch` = _dateTimeUploadRetouch,
`fileNombre` = _fileNombre,
`photoId` = _photoId
WHERE
    `idRetouch` = _idRetouch
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spD_RetouchXSpecification
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spD_RetouchXSpecification` (
_idRetouchXSpecification int
)
BEGIN

DELETE FROM retouchxspecification
WHERE idRetouchXSpecification = _idRetouchXSpecification
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_RetouchXSpecification
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_RetouchXSpecification` (
	_idRetouchXSpecification int
)
BEGIN

SELECT
	p.idRetouchXSpecification,
    p.idRetouch,
    p.idSpecificationType,
	p.idAutor,
	p.dateTimeSpecification,
	p.specification
FROM
    retouchxspecification p
WHERE
	p.idRetouchXSpecification = _idRetouchXSpecification
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_RetouchXSpecification_all
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_RetouchXSpecification_all` (
)
BEGIN

SELECT
	p.idRetouchXSpecification,
    p.idRetouch,
    p.idSpecificationType,
	p.idAutor,
	p.dateTimeSpecification,
	p.specification
FROM
    retouchxspecification p
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spU_RetouchXSpecification
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spU_RetouchXSpecification` (
_idRetouchXSpecification int,
_idRetouch int,
_idSpecificationType int,
_idAutor int,
_dateTimeSpecification datetime,
_specification text
)
BEGIN

UPDATE retouchxspecification
SET 
`idRetouch` = _idRetouch,
`idSpecificationType` = _idSpecificationType,
`idAutor` = _idAutor,
`dateTimeSpecification` = _dateTimeSpecification,
`specification` = _specification
WHERE
    `idRetouchXSpecification` = _idRetouchXSpecification
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spI_Profile
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spI_Profile` (
_name varchar(50),
_description varchar(200),
_state varchar(50)
)
BEGIN
INSERT INTO `profile`(
   `name`,
   `description`,
   `state`
)
VALUES (
   _name,
   _description,
   _state
);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spD_OrderXStatus
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spD_OrderXStatus` (
_idOrder int,
_idStatus int
)
BEGIN

DELETE FROM orderxstatus
WHERE idOrder = _idOrder and idStatus = _idStatus
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_OrderXStatus
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_OrderXStatus` (
_idOrder int,
_idStatus int
)
BEGIN

SELECT
    p.idOrder,
    p.idStatus
FROM
    orderxstatus p
WHERE
	p.idOrder = _idOrder and p.idStatus = _idStatus
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_OrderXStatus_all
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_OrderXStatus_all` (
_idOrder int,
_idStatus int
)
BEGIN

SELECT
    p.idOrder,
    p.idStatus
FROM
    orderxstatus p
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spI_OrderXStatus
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spI_OrderXStatus` (
_idOrder int,
_idStatus int
)
BEGIN
INSERT INTO `orderxstatus`(
`idOrder`,
`idStatus`
)
VALUES (
_idOrder,
_idStatus
);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spU_OrderXStatus
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spU_OrderXStatus` (
_idOrder int,
_idStatus int
)
BEGIN
UPDATE orderxstatus
SET 
	`idOrder` = _idOrder,
	`idStatus` = _idStatus
WHERE
    `idOrder` = _idOrder and `idStatus` = _idStatus
;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_UsuarioAutenticar
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_UsuarioAutenticar` (
_userLogin varchar(50),
_password varchar(50)
)
BEGIN

SELECT
	p.idUser,
	p.userLogin,
	p.password,
	p.idProfile,
    p.name,
	p.lastName,
	p.address,
	p.country,
    p.birthDay,
	p.telephone,
	p.cellphone,
	p.email,
	p.webPage,
	p.state
FROM
    user p
WHERE
	p.userLogin = _userLogin and p.password = _password
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spU_Order
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spU_Order` (
_idOrder int,
_idClient int,
_orderName varchar(100),
_dateTimeClientRequest datetime,
_specifications text,
_total decimal(18,2),
_state varchar(50)
)
BEGIN

UPDATE orden
SET 
	`idClient` = _idClient,
	`orderName` = _orderName,
	`dateTimeClientRequest` = _dateTimeClientRequest,
	`specifications` = _specifications,
	`total` = _total,
	`state` = _state
WHERE
    `idOrder` = _idOrder
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spI_Order_2
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spI_Order_2` (
INOUT _idOrder INT,
_idClient int,
_orderName varchar(100),
_dateTimeClientRequest datetime,
_specifications text,
_total decimal(18,2),
_state varchar(50)
)
BEGIN
INSERT INTO `orden`(
   `idClient`,
	`orderName`,
   `dateTimeClientRequest`,
	`specifications`,
	`total`,
   `state`
)
VALUES (
   _idClient,
	_orderName,
   _dateTimeClientRequest,
	_specifications,
	_total,
   _state
);
SELECT LAST_INSERT_ID() into _idOrder; 

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spI_Retouch_2
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spI_Retouch_2` (
INOUT _idRetouch INT,
_idOrder int,
_idProduct int,
_idArtist int,
_idSupervisor int,
_dateTimeArtistRequest datetime,
_dateTimeUploadRetouch datetime,
_fileNombre varchar(200),
_photoId int
)
BEGIN
INSERT INTO `retouch`(
`idOrder`,
`idProduct`,
`idArtist`,
`idSupervisor`,
`dateTimeArtistRequest`,
`dateTimeUploadRetouch`,
`fileNombre`,
`photoId`
)
VALUES (
_idOrder,
_idProduct,
_idArtist,
_idSupervisor,
_dateTimeArtistRequest,
_dateTimeUploadRetouch,
_fileNombre,
_photoId
);
SELECT LAST_INSERT_ID() into _idRetouch; 

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_OrderXStatusByOrder
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_OrderXStatusByOrder` (
_idOrder int
)
BEGIN

SELECT
    p.idOrder,
    p.idStatus
FROM
    orderxstatus p
WHERE
	p.idOrder = _idOrder
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_RetouchByOrderAndClient
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_RetouchByOrderAndClient` (
	_idOrder int,
	_idClient int
)
BEGIN

SELECT
	p.idRetouch,
    p.idOrder,
	p.idProduct,
	p.idArtist,
	p.idSupervisor,
    p.dateTimeArtistRequest,
	p.dateTimeUploadRetouch,
	p.fileNombre,
	p.photoId
FROM
    retouch p join orden o on p.idOrder = o.idOrder
WHERE
	p.idOrder = _idOrder and o.idClient = _idClient
;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_RetouchXStatus
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_RetouchXStatus` (
_idRetouch int,
_idStatus int
)
BEGIN

SELECT
    p.idRetouch,
    p.idStatus
FROM
    retouchxstatus p
WHERE
	p.idRetouch = _idRetouch and p.idStatus = _idStatus
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spD_RetouchXStatus
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spD_RetouchXStatus` (
_idRetouch int,
_idStatus int
)
BEGIN

DELETE FROM retouchxstatus
WHERE idRetouch = _idRetouch and idStatus = _idStatus
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spI_RetouchXStatus
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spI_RetouchXStatus` (
_idRetouch int,
_idStatus int
)
BEGIN
INSERT INTO `retouchxstatus`(
`idRetouch`,
`idStatus`
)
VALUES (
_idRetouch,
_idStatus
);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spU_RetouchXStatus
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spU_RetouchXStatus` (
_idRetouch int,
_idStatus int
)
BEGIN
UPDATE retouchxstatus
SET 
	`idRetouch` = _idRetouch,
	`idStatus` = _idStatus
WHERE
    `idRetouch` = _idRetouch and `idStatus` = _idStatus
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_RetouchXStatus_all
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_RetouchXStatus_all` (
)
BEGIN

SELECT
    p.idRetouch,
    p.idStatus
FROM
    retouchxstatus p
;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_RetouchXStatusByRetouch
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_RetouchXStatusByRetouch` (
_idRetouch int
)
BEGIN

SELECT
    p.idRetouch,
    p.idStatus
FROM
    retouchxstatus p
WHERE
	p.idRetouch = _idRetouch
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_RetouchByArtist
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_RetouchByArtist` (
	_idArtist int
)
BEGIN

SELECT
	p.idRetouch,
    p.idOrder,
	p.idProduct,
	p.idArtist,
	p.idSupervisor,
    p.dateTimeArtistRequest,
	p.dateTimeUploadRetouch,
	p.fileNombre,
	p.photoId
FROM
    retouch p join retouchxstatus rxs on p.idRetouch=rxs.idRetouch
WHERE
	p.idArtist = _idArtist and (rxs.idStatus = 1 or rxs.idStatus = 11)
ORDER BY p.idRetouch
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_OrdersNoAssigned
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_OrdersNoAssigned` (
)
BEGIN

SELECT
	p.idOrder,
    p.idClient,
	p.orderName,
    p.dateTimeClientRequest,
	p.specifications,
	p.total,
	p.state
FROM
    orden p join orderxstatus oxs on p.idOrder = oxs.idOrder
WHERE
	oxs.idStatus = 10
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_OrderNumberOfPhotos
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_OrderNumberOfPhotos`(
	_idOrder int
)
BEGIN

SELECT
	COUNT(p.idRetouch) as 'NumberOfPhotos'
FROM
    retouch p
WHERE
	p.idOrder = _idOrder and p.idProduct != 1
GROUP BY p.idOrder
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_OrderNumberOfReferences
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_OrderNumberOfReferences`(
	_idOrder int
)
BEGIN

SELECT
	COUNT(p.idRetouch) as 'NumberOfReferences'
FROM
    retouch p
WHERE
	p.idOrder = _idOrder and p.idProduct = 1
GROUP BY p.idOrder
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_OrderProductType
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_OrderProductType` (
	_idOrder int
)
BEGIN

SELECT
	p.idProduct as 'OrderProductType'
FROM
    retouch p
WHERE
	p.idProduct != 1 and p.idOrder = _idOrder
LIMIT 1
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_RetouchByFileNombre
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_RetouchByFileNombre` (
	_fileNombre varchar(200)
)
BEGIN

SELECT
	p.idRetouch,
    p.idOrder,
	p.idProduct,
	p.idArtist,
	p.idSupervisor,
    p.dateTimeArtistRequest,
	p.dateTimeUploadRetouch,
	p.fileNombre,
	p.photoId
FROM
    retouch p
WHERE
	p.fileNombre = _fileNombre
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_UserGet
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_UserGet` (
	_userLogin varchar(50)
)
BEGIN

SELECT
	p.idUser,
	p.userLogin,
	p.password,
	p.idProfile,
    p.name,
	p.lastName,
	p.address,
	p.country,
    p.birthDay,
	p.telephone,
	p.cellphone,
	p.email,
	p.webPage,
	p.state
FROM
    user p
WHERE
	p.userLogin = _userLogin
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_RetouchPendienteByFileNombreAndArtist
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_RetouchPendienteByFileNombreAndArtist` (
	_fileNombre varchar(200),
	_idArtist int
)
BEGIN

SELECT
	p.idRetouch,
    p.idOrder,
	p.idProduct,
	p.idArtist,
	p.idSupervisor,
    p.dateTimeArtistRequest,
	p.dateTimeUploadRetouch,
	p.fileNombre,
	p.photoId
FROM
    retouch p join retouchxstatus rxs on p.idRetouch = rxs.idRetouch
WHERE
	p.fileNombre = _fileNombre and p.idArtist = _idArtist and (rxs.idStatus = 1 or rxs.idStatus = 4)
;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_RetouchXSpecificationByAutor
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_RetouchXSpecificationByAutor` (
	_idRetouch int,
	_idAutor int
)
BEGIN

SELECT
	p.idRetouchXSpecification,
    p.idRetouch,
    p.idSpecificationType,
	p.idAutor,
	p.dateTimeSpecification,
	p.specification
FROM
    retouchxspecification p
WHERE
	p.idRetouch = _idRetouch and p.idAutor = _idAutor
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_RetouchXSpecificationByRetouch
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_RetouchXSpecificationByRetouch` (
	_idRetouch int
)
BEGIN

SELECT
	p.idRetouchXSpecification,
    p.idRetouch,
    p.idSpecificationType,
	p.idAutor,
	p.dateTimeSpecification,
	p.specification
FROM
    retouchxspecification p
WHERE
	p.idRetouch = _idRetouch
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_RetouchByOrder
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_RetouchByOrder` (
	_idOrder int
)
BEGIN

SELECT
	p.idRetouch,
    p.idOrder,
	p.idProduct,
	p.idArtist,
	p.idSupervisor,
    p.dateTimeArtistRequest,
	p.dateTimeUploadRetouch,
	p.fileNombre,
	p.photoId
FROM
    retouch p
WHERE
	p.idOrder = _idOrder
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_RetouchPendienteByOrder
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_RetouchPendienteByOrder` (
	_idArtist int,
	_idOrder int
)
BEGIN

SELECT
	p.idRetouch,
    p.idOrder,
	p.idProduct,
	p.idArtist,
	p.idSupervisor,
    p.dateTimeArtistRequest,
	p.dateTimeUploadRetouch,
	p.fileNombre,
	p.photoId
FROM
    retouch p join retouchxstatus rxs on p.idRetouch = rxs.idRetouch
WHERE
	p.idOrder = _idOrder and p.idArtist = _idArtist and (rxs.idStatus = 1 or rxs.idStatus = 4 or rxs.idStatus = 11)
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_RetouchReworkByArtist
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_RetouchReworkByArtist` (
	_idArtist int
)
BEGIN

SELECT
	p.idRetouch,
    p.idOrder,
	p.idProduct,
	p.idArtist,
	p.idSupervisor,
    p.dateTimeArtistRequest,
	p.dateTimeUploadRetouch,
	p.fileNombre,
	p.photoId
FROM
    retouch p join retouchxstatus rxs on p.idRetouch=rxs.idRetouch
WHERE
	p.idArtist = _idArtist and rxs.idStatus = 4
ORDER BY p.idRetouch
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_UserByEmail
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_UserByEmail` (
	_email varchar(50)
)
BEGIN

SELECT
	p.idUser,
	p.userLogin,
	p.password,
	p.idProfile,
    p.name,
	p.lastName,
	p.address,
	p.country,
    p.birthDay,
	p.telephone,
	p.cellphone,
	p.email,
	p.webPage,
	p.state
FROM
    user p
WHERE
	p.email = _email
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_OrdersNoPayed
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_OrdersNoPayed` (
)
BEGIN

SELECT
	p.idOrder,
    p.idClient,
	p.orderName,
    p.dateTimeClientRequest,
	p.specifications,
	p.total,
	p.state
FROM
    orden p join orderxstatus oxs on p.idOrder = oxs.idOrder
WHERE
	oxs.idStatus = 6 and p.state = "Active"
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_ArtistPhotoReferencesOfApprovedOrders
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_ArtistPhotoReferencesOfApprovedOrders` (
	_idArtist int
)
BEGIN

SELECT
	p.idRetouch,
    p.idOrder,
	p.idProduct,
	p.idArtist,
	p.idSupervisor,
    p.dateTimeArtistRequest,
	p.dateTimeUploadRetouch,
	p.fileNombre,
	p.photoId
FROM
    retouch p join retouchxstatus rxs on p.idRetouch=rxs.idRetouch
			  join orden o on p.idOrder = o.idOrder
			  join orderxstatus oxs on o.idOrder = oxs.idOrder
WHERE
	p.idArtist = _idArtist and (oxs.idStatus = 6 or oxs.idStatus = 7) and rxs.idStatus = 11
ORDER BY p.idRetouch
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_OrdersNoAprroved
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_OrdersNoAprroved` (
)
BEGIN

SELECT
	p.idOrder,
    p.idClient,
    p.dateTimeClientRequest,
	p.specifications,
	p.total,
	p.state
FROM
    orden p join orderxstatus oxs on p.idOrder = oxs.idOrder
WHERE
	(oxs.idStatus != 6 or oxs.idStatus != 7) and p.state = "Active"
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_RetouchApprovedOfTheArtistByProduct
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_RetouchApprovedOfTheArtistByProduct` (
	_idArtist int,
	_idProduct int
)
BEGIN

SELECT
	p.idRetouch,
    p.idOrder,
	p.idProduct,
	p.idArtist,
	p.idSupervisor,
    p.dateTimeArtistRequest,
	p.dateTimeUploadRetouch,
	p.fileNombre,
	p.photoId
FROM
    retouch p join retouchxstatus rxs on p.idRetouch=rxs.idRetouch
WHERE
	p.idArtist = _idArtist and (rxs.idStatus = 6 or rxs.idStatus = 7) and p.idProduct = _idProduct
ORDER BY p.idRetouch
;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spF_OrdersBetweenDates
-- -----------------------------------------------------

DELIMITER $$
USE `PeruRetouch`$$
CREATE PROCEDURE `spF_OrdersBetweenDates` (
	_idUser int,
	_dateFrom date,
	_dateTo date
)
BEGIN

SELECT
	p.idOrder,
    p.idClient,
	p.orderName,
    p.dateTimeClientRequest,
	p.specifications,
	p.total,
	p.state
FROM
    orden p
WHERE
	p.idClient = _idUser and p.dateTimeClientRequest >= _dateFrom and p.dateTimeClientRequest <= _dateTo + interval 1 day
;

END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `PeruRetouch`.`Profile`
-- -----------------------------------------------------
START TRANSACTION;
USE `PeruRetouch`;
INSERT INTO `PeruRetouch`.`Profile` (`idProfile`, `name`, `description`, `state`) VALUES (1, 'SA', 'Maneja toda la data', 'Active');
INSERT INTO `PeruRetouch`.`Profile` (`idProfile`, `name`, `description`, `state`) VALUES (2, 'Manager', 'Solicita ordenproductos a la empresa', 'Active');
INSERT INTO `PeruRetouch`.`Profile` (`idProfile`, `name`, `description`, `state`) VALUES (3, 'Supervisor', 'Encargado de revisar el trabajo de los artistas', 'Active');
INSERT INTO `PeruRetouch`.`Profile` (`idProfile`, `name`, `description`, `state`) VALUES (4, 'Artist', 'Encargado de retocar las fotos de los clientes', 'Active');
INSERT INTO `PeruRetouch`.`Profile` (`idProfile`, `name`, `description`, `state`) VALUES (5, 'Client', 'Solicita ordenproductos a la empresa', 'Active');

COMMIT;


-- -----------------------------------------------------
-- Data for table `PeruRetouch`.`User`
-- -----------------------------------------------------
START TRANSACTION;
USE `PeruRetouch`;
INSERT INTO `PeruRetouch`.`User` (`idUser`, `userLogin`, `password`, `idProfile`, `name`, `lastName`, `address`, `country`, `birthDay`, `telephone`, `cellphone`, `email`, `webPage`, `state`) VALUES (1, 'Artist not assigned', '202cb962ac59075b964b07152d234b70', 3, 'Artist not assigned', 'Artist not assigned', 'none', 'none', '1990-01-01', 'none', 'none', 'none', '', 'Active');
INSERT INTO `PeruRetouch`.`User` (`idUser`, `userLogin`, `password`, `idProfile`, `name`, `lastName`, `address`, `country`, `birthDay`, `telephone`, `cellphone`, `email`, `webPage`, `state`) VALUES (2, 'Supervisor not assigned', '202cb962ac59075b964b07152d234b70', 2, 'Supervisor not assigned', 'Supervisor not assigned', 'none', 'none', '1990-01-01', 'none', 'none', 'none', '', 'Active');
INSERT INTO `PeruRetouch`.`User` (`idUser`, `userLogin`, `password`, `idProfile`, `name`, `lastName`, `address`, `country`, `birthDay`, `telephone`, `cellphone`, `email`, `webPage`, `state`) VALUES (3, 'Rool', '202cb962ac59075b964b07152d234b70', 1, 'Roy', 'Taza Rojas', 'Av. Jorge Chavez 562', 'Peru', '1994-04-02', '2952136', '947778021', 'roytazarojas@gmail.com', '', 'Active');
INSERT INTO `PeruRetouch`.`User` (`idUser`, `userLogin`, `password`, `idProfile`, `name`, `lastName`, `address`, `country`, `birthDay`, `telephone`, `cellphone`, `email`, `webPage`, `state`) VALUES (4, 'Luis', '202cb962ac59075b964b07152d234b70', 2, 'Luis Miguel', 'Deudor Saavedra', 'Av. Pachacutec 444', 'Peru', '1990-10-31', '2952123', '998786654', 'luisdeudor1492@yahoo.es', '', 'Active');
INSERT INTO `PeruRetouch`.`User` (`idUser`, `userLogin`, `password`, `idProfile`, `name`, `lastName`, `address`, `country`, `birthDay`, `telephone`, `cellphone`, `email`, `webPage`, `state`) VALUES (5, 'Johe', '202cb962ac59075b964b07152d234b70', 3, 'Jose Miguel', 'Herrera Yacsavilca', 'Mz. W Lt. 19 Jaime Yosillama', 'Peru', '1995-07-01', '2226796', '989496531', 'josemiguel_0107@yahoo.com', '', 'Active');
INSERT INTO `PeruRetouch`.`User` (`idUser`, `userLogin`, `password`, `idProfile`, `name`, `lastName`, `address`, `country`, `birthDay`, `telephone`, `cellphone`, `email`, `webPage`, `state`) VALUES (6, 'Nemo', '202cb962ac59075b964b07152d234b70', 4, 'Nehemias', 'Estrella Chavez', 'Calle Los Girasoles 444', 'Peru', '1990-10-31', '2226796', '989496531', 'nemo@none.com', '', 'Active');
INSERT INTO `PeruRetouch`.`User` (`idUser`, `userLogin`, `password`, `idProfile`, `name`, `lastName`, `address`, `country`, `birthDay`, `telephone`, `cellphone`, `email`, `webPage`, `state`) VALUES (7, 'Willi', '202cb962ac59075b964b07152d234b70', 5, 'William Alberto', 'Carmona Fernandez', 'Valle Los Teclados 562', 'Peru', '1990-10-31', '2226796', '989496531', 'wicafe77@yahoo.com', '', 'Active');
INSERT INTO `PeruRetouch`.`User` (`idUser`, `userLogin`, `password`, `idProfile`, `name`, `lastName`, `address`, `country`, `birthDay`, `telephone`, `cellphone`, `email`, `webPage`, `state`) VALUES (8, 'Test', '202cb962ac59075b964b07152d234b70', 5, 'Test', 'Test', 'Test', 'Test', '1990-10-31', '2226796', '989496531', 'roytazarojas@gmail.com', '', 'Active');

COMMIT;


-- -----------------------------------------------------
-- Data for table `PeruRetouch`.`Status`
-- -----------------------------------------------------
START TRANSACTION;
USE `PeruRetouch`;
INSERT INTO `PeruRetouch`.`Status` (`idStatus`, `name`, `description`, `state`) VALUES (1, 'Working', 'The photo or order is being worked', 'Active');
INSERT INTO `PeruRetouch`.`Status` (`idStatus`, `name`, `description`, `state`) VALUES (2, 'Review', 'A normal specification', 'Active');
INSERT INTO `PeruRetouch`.`Status` (`idStatus`, `name`, `description`, `state`) VALUES (3, 'Waiting for an answer', 'Needs the client answer', 'Active');
INSERT INTO `PeruRetouch`.`Status` (`idStatus`, `name`, `description`, `state`) VALUES (4, 'Reworking', 'Is being reworked', 'Active');
INSERT INTO `PeruRetouch`.`Status` (`idStatus`, `name`, `description`, `state`) VALUES (5, 'Reworked', 'Has alreadey been reworked', 'Active');
INSERT INTO `PeruRetouch`.`Status` (`idStatus`, `name`, `description`, `state`) VALUES (6, 'Approved', 'Has been approved by the client', 'Active');
INSERT INTO `PeruRetouch`.`Status` (`idStatus`, `name`, `description`, `state`) VALUES (7, 'Payed', 'Has been payed by the client', 'Active');
INSERT INTO `PeruRetouch`.`Status` (`idStatus`, `name`, `description`, `state`) VALUES (8, 'Canceled', 'A cancelation, like inactive', 'Active');
INSERT INTO `PeruRetouch`.`Status` (`idStatus`, `name`, `description`, `state`) VALUES (9, 'Active', 'Active', 'Active');
INSERT INTO `PeruRetouch`.`Status` (`idStatus`, `name`, `description`, `state`) VALUES (10, 'New', 'The photo has just been apluded by the client', 'Active');
INSERT INTO `PeruRetouch`.`Status` (`idStatus`, `name`, `description`, `state`) VALUES (11, 'Reference', 'The photo is just a reference', 'Active');

COMMIT;


-- -----------------------------------------------------
-- Data for table `PeruRetouch`.`SpecificationType`
-- -----------------------------------------------------
START TRANSACTION;
USE `PeruRetouch`;
INSERT INTO `PeruRetouch`.`SpecificationType` (`idSpecificationType`, `name`, `description`, `state`) VALUES (1, 'Specification', 'A normal specification', 'Active');
INSERT INTO `PeruRetouch`.`SpecificationType` (`idSpecificationType`, `name`, `description`, `state`) VALUES (2, 'Rework', 'The photo needs a rework', 'Active');
INSERT INTO `PeruRetouch`.`SpecificationType` (`idSpecificationType`, `name`, `description`, `state`) VALUES (3, 'Reference', 'A normal specification', 'Active');

COMMIT;


-- -----------------------------------------------------
-- Data for table `PeruRetouch`.`Product`
-- -----------------------------------------------------
START TRANSACTION;
USE `PeruRetouch`;
INSERT INTO `PeruRetouch`.`Product` (`idProduct`, `name`, `description`, `abreviation`, `price`, `state`) VALUES (1, 'Reference', 'Reference', 'Ref', 0.00, 'Active');
INSERT INTO `PeruRetouch`.`Product` (`idProduct`, `name`, `description`, `abreviation`, `price`, `state`) VALUES (2, 'Basic Retouch', 'Remove tan lines, Remove blemishes, Remove under eye bags, Remove facial glare, Whitening teeth and eyes, Remove stray hairs around heads, Remove sensor dust, Fix spots in background, Overall skin smoothing', 'BR', 2.50, 'Active');
INSERT INTO `PeruRetouch`.`Product` (`idProduct`, `name`, `description`, `abreviation`, `price`, `state`) VALUES (3, 'Plus Retouch', '“Basic retouch”, Smoothing background wrinkles and creases, Braces removal, Eyeglass glare removal, Head swap, Opening eyes, Extending the background, Moderate Lense Flare / Hot Spots, Background removal (original solid color replacement only), Spot Coloring (all B&W except 1 object), Remove doble chin.', 'PR', 5.00, 'Active');
INSERT INTO `PeruRetouch`.`Product` (`idProduct`, `name`, `description`, `abreviation`, `price`, `state`) VALUES (4, 'Special Retouch', '“Basic retouch” and “plus retouch”, Change color of clothing, Background change (new background image), Add or Remove people, Remove buildings, cars, etc., Extreme Lense Flare / Hot Spots, Take off 10 years, 20 lbs, etc., Anything not covered by complete or complete plus', 'SR', 10.00, 'Active');

COMMIT;

