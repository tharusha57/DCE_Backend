-- Creating Four Tables

CREATE TABLE `dce_schema`.`customer` (
  `userid` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(30) NOT NULL,
  `email` VARCHAR(20) NOT NULL,
  `Customercol` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(20) NOT NULL,
  `lastname` VARCHAR(20) NOT NULL,
  `createdon` DATETIME NOT NULL,
  `isactive` TINYINT NOT NULL,
  PRIMARY KEY (`userid`));


CREATE TABLE `dce_schema`.`order` (
  `orderid` INT NOT NULL AUTO_INCREMENT,
  `productid` INT NOT NULL,
  `orderstatus` INT(1) NOT NULL,
  `ordertype` INT(1) NOT NULL,
  `orderby` INT NOT NULL,
  `orderon` DATETIME NOT NULL,
  `shippedon` DATETIME NOT NULL,
  `isactive` TINYINT NOT NULL,
  PRIMARY KEY (`orderid`),
  INDEX `productid_idx` (`productid` ASC) VISIBLE,
  INDEX `orderby_idx` (`orderby` ASC) VISIBLE,
  CONSTRAINT `productid`
    FOREIGN KEY (`productid`)
    REFERENCES `dce_schema`.`product` (`productid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orderby`
    FOREIGN KEY (`orderby`)
    REFERENCES `dce_schema`.`customer` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `dce_schema`.`product` (
  `productid` INT NOT NULL AUTO_INCREMENT,
  `productname` VARCHAR(50) NOT NULL,
  `unitprice` DECIMAL NOT NULL,
  `supplierid` INT NOT NULL,
  `createdon` DATETIME NOT NULL,
  `isactive` TINYINT NOT NULL,
  PRIMARY KEY (`productid`),
  INDEX `supplierid_idx` (`supplierid` ASC) VISIBLE,
  CONSTRAINT `supplierid`
    FOREIGN KEY (`supplierid`)
    REFERENCES `dce_schema`.`supplier` (`supplierid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `dce_schema`.`supplier` (
  `createdon` DATETIME NOT NULL,
  `Suppliercol` VARCHAR(45) NULL,
  `supplierid` INT NOT NULL AUTO_INCREMENT,
  `suppliername` DATETIME NOT NULL,
  `isactive` TINYINT NOT NULL,
  PRIMARY KEY (`supplierid`));


-- Creating Stored Procedure

USE `dce_schema`;
DROP procedure IF EXISTS `active_orders`;

DELIMITER $$
USE `dce_schema`$$
CREATE PROCEDURE `active_orders` (IN user_id INT)
BEGIN
SELECT o.* FROM customer c JOIN orders o ON c.userid = o.orderby AND o.orderby = user_id;
END;$$

DELIMITER ;

