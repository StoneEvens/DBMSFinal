-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Store` (
  `Store_ID` INT NOT NULL,
  `Total_Row` INT NULL,
  `Total_Col` INT NULL,
  `Entrance_ID` INT NOT NULL,
  `Exit_ID` INT NOT NULL,
  PRIMARY KEY (`Store_ID`),
  UNIQUE INDEX `Store_ID_UNIQUE` (`Store_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Shelf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Shelf` (
  `Shelf_ID` INT NOT NULL,
  `AdjacentWalkway` VARCHAR(45) NULL,
  `Col_No` INT NULL,
  `Row_No` INT NULL,
  `Shelf_Row` INT NULL,
  `Store_Store_ID` INT NOT NULL,
  PRIMARY KEY (`Shelf_ID`, `Store_Store_ID`),
  INDEX `fk_Shelf_Store1_idx` (`Store_Store_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Shelf_Store1`
    FOREIGN KEY (`Store_Store_ID`)
    REFERENCES `mydb`.`Store` (`Store_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product` (
  `Shelf_ID` INT NOT NULL,
  `Product_ID` INT NOT NULL,
  `Product_Name` VARCHAR(45) NOT NULL,
  `Product_Price` INT NULL,
  `Product_Description` TEXT NULL,
  `Product_Pic` LONGBLOB NULL,
  PRIMARY KEY (`Shelf_ID`, `Product_ID`),
  INDEX `fk_Product_Shelf1_idx` (`Shelf_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Product_Shelf1`
    FOREIGN KEY (`Shelf_ID`)
    REFERENCES `mydb`.`Shelf` (`Shelf_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Intersection`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Intersection` (
  `Intersection_ID` INT NOT NULL,
  `Store_ID` INT NOT NULL,
  `Row_No` INT NULL,
  `Col_No` INT NULL,
  PRIMARY KEY (`Intersection_ID`, `Store_ID`),
  UNIQUE INDEX `Intersection_ID_UNIQUE` (`Intersection_ID` ASC) VISIBLE,
  INDEX `fk_Intersection_Store1_idx` (`Store_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Intersection_Store1`
    FOREIGN KEY (`Store_ID`)
    REFERENCES `mydb`.`Store` (`Store_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product_Price_History`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product_Price_History` (
  `Product_ID` INT NOT NULL,
  `Recorded_Time` DATETIME NULL,
  `Price` INT NULL,
  PRIMARY KEY (`Product_ID`),
  CONSTRAINT `fk_Product_Price_History_Product1`
    FOREIGN KEY (`Product_ID`)
    REFERENCES `mydb`.`Product` (`Product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Employee` (
  `Employee_ID` INT NOT NULL,
  PRIMARY KEY (`Employee_ID`),
  UNIQUE INDEX `Employee_ID_UNIQUE` (`Employee_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product_Promotion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product_Promotion` (
  `Discount` INT NULL,
  `Product_ID` INT NOT NULL,
  `Employee_ID` INT NOT NULL,
  `Promotion_Date` DATETIME NULL,
  PRIMARY KEY (`Product_ID`, `Employee_ID`),
  INDEX `fk_Product_Promotion_Product1_idx` (`Product_ID` ASC) VISIBLE,
  INDEX `fk_Product_Promotion_Employee1_idx` (`Employee_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Product_Promotion_Product1`
    FOREIGN KEY (`Product_ID`)
    REFERENCES `mydb`.`Product` (`Product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_Promotion_Employee1`
    FOREIGN KEY (`Employee_ID`)
    REFERENCES `mydb`.`Employee` (`Employee_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `Customer_ID` INT NOT NULL,
  `User_ID` VARCHAR(20) NULL,
  `Password` VARCHAR(20) NULL,
  PRIMARY KEY (`Customer_ID`),
  UNIQUE INDEX `Customer_ID_UNIQUE` (`Customer_ID` ASC) VISIBLE,
  UNIQUE INDEX `User_ID_UNIQUE` (`User_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product_Review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product_Review` (
  `Review_Info` VARCHAR(500) NULL,
  `Customer_ID` INT NOT NULL,
  `Product_ID` INT NOT NULL,
  PRIMARY KEY (`Customer_ID`, `Product_ID`),
  INDEX `fk_Product_Review_Customer1_idx` (`Customer_ID` ASC) VISIBLE,
  INDEX `fk_Product_Review_Product1_idx` (`Product_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Product_Review_Customer1`
    FOREIGN KEY (`Customer_ID`)
    REFERENCES `mydb`.`Customer` (`Customer_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_Review_Product1`
    FOREIGN KEY (`Product_ID`)
    REFERENCES `mydb`.`Product` (`Shelf_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Purchase_History`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Purchase_History` (
  `Customer_Customer_ID` INT NOT NULL,
  `Record_ID` INT NOT NULL,
  `Product_ID` INT NULL,
  PRIMARY KEY (`Customer_Customer_ID`, `Record_ID`),
  CONSTRAINT `fk_Purchase_History_Customer1`
    FOREIGN KEY (`Customer_Customer_ID`)
    REFERENCES `mydb`.`Customer` (`Customer_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`Store`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Store` (`Store_ID`, `Total_Row`, `Total_Col`, `Entrance_ID`, `Exit_ID`) VALUES (001, 7, 7, 1, 2);
INSERT INTO `mydb`.`Store` (`Store_ID`, `Total_Row`, `Total_Col`, `Entrance_ID`, `Exit_ID`) VALUES (002, 4, 4, 10, 11);
INSERT INTO `mydb`.`Store` (`Store_ID`, `Total_Row`, `Total_Col`, `Entrance_ID`, `Exit_ID`) VALUES (003, 4, 5, 14, 15);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Shelf`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Shelf` (`Shelf_ID`, `AdjacentWalkway`, `Col_No`, `Row_No`, `Shelf_Row`, `Store_Store_ID`) VALUES (1, 'TOP', 1, 1, NULL, DEFAULT);
INSERT INTO `mydb`.`Shelf` (`Shelf_ID`, `AdjacentWalkway`, `Col_No`, `Row_No`, `Shelf_Row`, `Store_Store_ID`) VALUES (2, 'TOP', 2, 1, NULL, DEFAULT);
INSERT INTO `mydb`.`Shelf` (`Shelf_ID`, `AdjacentWalkway`, `Col_No`, `Row_No`, `Shelf_Row`, `Store_Store_ID`) VALUES (3, 'TOP', 4, 1, NULL, DEFAULT);
INSERT INTO `mydb`.`Shelf` (`Shelf_ID`, `AdjacentWalkway`, `Col_No`, `Row_No`, `Shelf_Row`, `Store_Store_ID`) VALUES (4, 'TOP', 5, 1, NULL, DEFAULT);
INSERT INTO `mydb`.`Shelf` (`Shelf_ID`, `AdjacentWalkway`, `Col_No`, `Row_No`, `Shelf_Row`, `Store_Store_ID`) VALUES (5, 'BOTTOM', 1, 2, NULL, DEFAULT);
INSERT INTO `mydb`.`Shelf` (`Shelf_ID`, `AdjacentWalkway`, `Col_No`, `Row_No`, `Shelf_Row`, `Store_Store_ID`) VALUES (6, 'BOTTOM', 2, 2, NULL, DEFAULT);
INSERT INTO `mydb`.`Shelf` (`Shelf_ID`, `AdjacentWalkway`, `Col_No`, `Row_No`, `Shelf_Row`, `Store_Store_ID`) VALUES (7, 'BOTTOM', 4, 2, NULL, DEFAULT);
INSERT INTO `mydb`.`Shelf` (`Shelf_ID`, `AdjacentWalkway`, `Col_No`, `Row_No`, `Shelf_Row`, `Store_Store_ID`) VALUES (8, 'BOTTOM', 5, 2, NULL, DEFAULT);
INSERT INTO `mydb`.`Shelf` (`Shelf_ID`, `AdjacentWalkway`, `Col_No`, `Row_No`, `Shelf_Row`, `Store_Store_ID`) VALUES (9, 'TOP', 1, 4, NULL, DEFAULT);
INSERT INTO `mydb`.`Shelf` (`Shelf_ID`, `AdjacentWalkway`, `Col_No`, `Row_No`, `Shelf_Row`, `Store_Store_ID`) VALUES (10, 'TOP', 2, 4, NULL, DEFAULT);
INSERT INTO `mydb`.`Shelf` (`Shelf_ID`, `AdjacentWalkway`, `Col_No`, `Row_No`, `Shelf_Row`, `Store_Store_ID`) VALUES (11, 'TOP', 4, 4, NULL, DEFAULT);
INSERT INTO `mydb`.`Shelf` (`Shelf_ID`, `AdjacentWalkway`, `Col_No`, `Row_No`, `Shelf_Row`, `Store_Store_ID`) VALUES (12, 'TOP', 5, 4, NULL, DEFAULT);
INSERT INTO `mydb`.`Shelf` (`Shelf_ID`, `AdjacentWalkway`, `Col_No`, `Row_No`, `Shelf_Row`, `Store_Store_ID`) VALUES (13, 'BOTTOM', 1, 5, NULL, DEFAULT);
INSERT INTO `mydb`.`Shelf` (`Shelf_ID`, `AdjacentWalkway`, `Col_No`, `Row_No`, `Shelf_Row`, `Store_Store_ID`) VALUES (14, 'BOTTOM', 2, 5, NULL, DEFAULT);
INSERT INTO `mydb`.`Shelf` (`Shelf_ID`, `AdjacentWalkway`, `Col_No`, `Row_No`, `Shelf_Row`, `Store_Store_ID`) VALUES (15, 'BOTTOM', 4, 5, NULL, DEFAULT);
INSERT INTO `mydb`.`Shelf` (`Shelf_ID`, `AdjacentWalkway`, `Col_No`, `Row_No`, `Shelf_Row`, `Store_Store_ID`) VALUES (16, 'BOTTOM', 5, 5, NULL, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Product`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Product` (`Shelf_ID`, `Product_ID`, `Product_Name`, `Product_Price`, `Product_Description`, `Product_Pic`) VALUES (1, 101, 'Chips', 35, 'Crispy, savory potato chips', NULL);
INSERT INTO `mydb`.`Product` (`Shelf_ID`, `Product_ID`, `Product_Name`, `Product_Price`, `Product_Description`, `Product_Pic`) VALUES (2, 201, 'Milk', 53, 'Fresh, nutritious milk', NULL);
INSERT INTO `mydb`.`Product` (`Shelf_ID`, `Product_ID`, `Product_Name`, `Product_Price`, `Product_Description`, `Product_Pic`) VALUES (3, 301, 'Chocolate', 39, 'Rich, creamy chocolate', NULL);
INSERT INTO `mydb`.`Product` (`Shelf_ID`, `Product_ID`, `Product_Name`, `Product_Price`, `Product_Description`, `Product_Pic`) VALUES (4, 401, 'Cake', 40, 'Moist, delicious cake', NULL);
INSERT INTO `mydb`.`Product` (`Shelf_ID`, `Product_ID`, `Product_Name`, `Product_Price`, `Product_Description`, `Product_Pic`) VALUES (5, 501, 'Banana', 20, 'Sweet, nutritious bananas', NULL);
INSERT INTO `mydb`.`Product` (`Shelf_ID`, `Product_ID`, `Product_Name`, `Product_Price`, `Product_Description`, `Product_Pic`) VALUES (6, 601, 'Salmon', 200, 'Fresh, premium salmon', NULL);
INSERT INTO `mydb`.`Product` (`Shelf_ID`, `Product_ID`, `Product_Name`, `Product_Price`, `Product_Description`, `Product_Pic`) VALUES (7, 701, 'Mango sorbet', 35, 'Refreshing mango sorbet', NULL);
INSERT INTO `mydb`.`Product` (`Shelf_ID`, `Product_ID`, `Product_Name`, `Product_Price`, `Product_Description`, `Product_Pic`) VALUES (8, 801, 'Sandwich icecream', 80, 'Creamy ice cream', NULL);
INSERT INTO `mydb`.`Product` (`Shelf_ID`, `Product_ID`, `Product_Name`, `Product_Price`, `Product_Description`, `Product_Pic`) VALUES (9, 901, 'Stinky tofu', 35, 'Traditional fermented tofu', NULL);
INSERT INTO `mydb`.`Product` (`Shelf_ID`, `Product_ID`, `Product_Name`, `Product_Price`, `Product_Description`, `Product_Pic`) VALUES (10, 1001, 'Rice', 180, 'Versatile, high-quality rice', NULL);
INSERT INTO `mydb`.`Product` (`Shelf_ID`, `Product_ID`, `Product_Name`, `Product_Price`, `Product_Description`, `Product_Pic`) VALUES (11, 1101, 'Kimchi', 149, 'SSpicy, fermented Korean kimchi', NULL);
INSERT INTO `mydb`.`Product` (`Shelf_ID`, `Product_ID`, `Product_Name`, `Product_Price`, `Product_Description`, `Product_Pic`) VALUES (12, 1201, 'Jelly', 46, 'Sweet, fruity jelly', NULL);
INSERT INTO `mydb`.`Product` (`Shelf_ID`, `Product_ID`, `Product_Name`, `Product_Price`, `Product_Description`, `Product_Pic`) VALUES (13, 1301, 'Soy milk', 32, 'Smooth, nutritious soy milk', NULL);
INSERT INTO `mydb`.`Product` (`Shelf_ID`, `Product_ID`, `Product_Name`, `Product_Price`, `Product_Description`, `Product_Pic`) VALUES (14, 1401, 'Tissue', 198, 'Soft, absorbent tissues', NULL);
INSERT INTO `mydb`.`Product` (`Shelf_ID`, `Product_ID`, `Product_Name`, `Product_Price`, `Product_Description`, `Product_Pic`) VALUES (15, 1501, 'Instant noodle', 43, 'Quick and easy instant noodle', NULL);
INSERT INTO `mydb`.`Product` (`Shelf_ID`, `Product_ID`, `Product_Name`, `Product_Price`, `Product_Description`, `Product_Pic`) VALUES (16, 1601, 'Shampoo', 98, 'Nourishing shampoo', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Intersection`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Intersection` (`Intersection_ID`, `Store_ID`, `Row_No`, `Col_No`) VALUES (1, 001, 0, 0);
INSERT INTO `mydb`.`Intersection` (`Intersection_ID`, `Store_ID`, `Row_No`, `Col_No`) VALUES (2, 001, 0, 3);
INSERT INTO `mydb`.`Intersection` (`Intersection_ID`, `Store_ID`, `Row_No`, `Col_No`) VALUES (3, 001, 0, 6);
INSERT INTO `mydb`.`Intersection` (`Intersection_ID`, `Store_ID`, `Row_No`, `Col_No`) VALUES (4, 001, 3, 0);
INSERT INTO `mydb`.`Intersection` (`Intersection_ID`, `Store_ID`, `Row_No`, `Col_No`) VALUES (5, 001, 3, 3);
INSERT INTO `mydb`.`Intersection` (`Intersection_ID`, `Store_ID`, `Row_No`, `Col_No`) VALUES (6, 001, 3, 6);
INSERT INTO `mydb`.`Intersection` (`Intersection_ID`, `Store_ID`, `Row_No`, `Col_No`) VALUES (7, 001, 6, 0);
INSERT INTO `mydb`.`Intersection` (`Intersection_ID`, `Store_ID`, `Row_No`, `Col_No`) VALUES (8, 001, 6, 3);
INSERT INTO `mydb`.`Intersection` (`Intersection_ID`, `Store_ID`, `Row_No`, `Col_No`) VALUES (9, 001, 6, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Product_Price_History`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Product_Price_History` (`Product_ID`, `Recorded_Time`, `Price`) VALUES (1, '2024-05-30 08:30:21', 40);
INSERT INTO `mydb`.`Product_Price_History` (`Product_ID`, `Recorded_Time`, `Price`) VALUES (2, '2024-05-30 08:40:21', 40);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Employee` (`Employee_ID`) VALUES (321111);
INSERT INTO `mydb`.`Employee` (`Employee_ID`) VALUES (321112);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Product_Promotion`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Product_Promotion` (`Discount`, `Product_ID`, `Employee_ID`, `Promotion_Date`) VALUES (10, 4, 321111, '5/30');
INSERT INTO `mydb`.`Product_Promotion` (`Discount`, `Product_ID`, `Employee_ID`, `Promotion_Date`) VALUES (5, 8, 321111, '5/30');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Customer` (`Customer_ID`, `User_ID`, `Password`) VALUES (123111, 'user_phil_smith', 'apple');
INSERT INTO `mydb`.`Customer` (`Customer_ID`, `User_ID`, `Password`) VALUES (123112, 'user_jane_doe', 'pen');
INSERT INTO `mydb`.`Customer` (`Customer_ID`, `User_ID`, `Password`) VALUES (123113, 'user_john_wick', 'pineapple');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Product_Review`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Product_Review` (`Review_Info`, `Customer_ID`, `Product_ID`) VALUES ('I love it', 123111, 1);
INSERT INTO `mydb`.`Product_Review` (`Review_Info`, `Customer_ID`, `Product_ID`) VALUES ('Its gone bad', 123112, 4);
INSERT INTO `mydb`.`Product_Review` (`Review_Info`, `Customer_ID`, `Product_ID`) VALUES ('Not the best but good enough', 123111, 9);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Purchase_History`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Purchase_History` (`Customer_Customer_ID`, `Record_ID`, `Product_ID`) VALUES (123111, 133, 1);
INSERT INTO `mydb`.`Purchase_History` (`Customer_Customer_ID`, `Record_ID`, `Product_ID`) VALUES (123112, 134, 2);

COMMIT;

