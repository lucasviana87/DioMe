/*
 Navicat Premium Data Transfer

 Source Server         : MYSql Local
 Source Server Type    : MySQL
 Source Server Version : 80042
 Source Host           : localhost:3306
 Source Schema         : ecommerce

 Target Server Type    : MySQL
 Target Server Version : 80042
 File Encoding         : 65001

 Date: 15/06/2025 22:05:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `idCategory` int NOT NULL AUTO_INCREMENT,
  `nameCategory` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `abbrCategory` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `atvCategory` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`idCategory`) USING BTREE,
  UNIQUE INDEX `UQ_nameCategory`(`nameCategory` ASC) USING BTREE,
  UNIQUE INDEX `UQ_abbrCategory`(`abbrCategory` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 'ELETRONICO', 'ELETRO', 1);
INSERT INTO `category` VALUES (2, 'BRINQUEDOS', 'BRINQ', 1);
INSERT INTO `category` VALUES (3, 'PAPELARIA', 'PAPEL', 1);
INSERT INTO `category` VALUES (4, 'AUTOMOTIVO', 'AUTO', 1);
INSERT INTO `category` VALUES (5, 'GAMES', 'GAMES', 1);

-- ----------------------------
-- Table structure for client
-- ----------------------------
DROP TABLE IF EXISTS `client`;
CREATE TABLE `client`  (
  `idClient` int NOT NULL AUTO_INCREMENT,
  `nameClient` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `CPF` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `addressClient` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`idClient`) USING BTREE,
  UNIQUE INDEX `UQ_CPF`(`CPF` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of client
-- ----------------------------
INSERT INTO `client` VALUES (1, 'TESTE 0', '00000000000', 'RUA ZERO, 0 - SAO PAULO - SP');
INSERT INTO `client` VALUES (2, 'TESTE 1', '11111111111', 'RUA UM, 1 - GUARULHOS - SP');
INSERT INTO `client` VALUES (3, 'TESTE 2', '22222222222', 'RUA DOIS, 2 - BERTIOGA - SP');
INSERT INTO `client` VALUES (4, 'TESTE 3', '33333333333', 'RUA TRES, 3 - SANTOS - SP');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `idOrder` int NOT NULL AUTO_INCREMENT,
  `idClient` int NOT NULL,
  `idOrderStatus` int NOT NULL,
  `descOrders` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `shippingCost` decimal(10, 2) NULL DEFAULT 10.00,
  PRIMARY KEY (`idOrder`) USING BTREE,
  INDEX `FK_idClient_Orders`(`idClient` ASC) USING BTREE,
  INDEX `FK_idOrderStatus_Orders`(`idOrderStatus` ASC) USING BTREE,
  CONSTRAINT `FK_idClient_Orders` FOREIGN KEY (`idClient`) REFERENCES `client` (`idClient`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_idOrderStatus_Orders` FOREIGN KEY (`idOrderStatus`) REFERENCES `orderstatus` (`idOrderStatus`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for orderstatus
-- ----------------------------
DROP TABLE IF EXISTS `orderstatus`;
CREATE TABLE `orderstatus`  (
  `idOrderStatus` int NOT NULL AUTO_INCREMENT,
  `descOrderStatus` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `atvOrderStatus` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`idOrderStatus`) USING BTREE,
  UNIQUE INDEX `UQ_descOrderStatus`(`descOrderStatus` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orderstatus
-- ----------------------------
INSERT INTO `orderstatus` VALUES (1, 'EM PROCESSAMENTO', 1);
INSERT INTO `orderstatus` VALUES (2, 'CONFIRMADO', 1);
INSERT INTO `orderstatus` VALUES (3, 'ENVIADO', 1);
INSERT INTO `orderstatus` VALUES (4, 'CANCELADO', 1);

-- ----------------------------
-- Table structure for paymenttype
-- ----------------------------
DROP TABLE IF EXISTS `paymenttype`;
CREATE TABLE `paymenttype`  (
  `idPaymentType` int NOT NULL AUTO_INCREMENT,
  `paymentMethodName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `atvPaymentType` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`idPaymentType`) USING BTREE,
  UNIQUE INDEX `UQ_paymentMethodName`(`paymentMethodName` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of paymenttype
-- ----------------------------
INSERT INTO `paymenttype` VALUES (1, 'CARTAO DE CREDITO', 1);
INSERT INTO `paymenttype` VALUES (2, 'PIX', 1);
INSERT INTO `paymenttype` VALUES (3, 'BOLETO', 1);

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `idProduct` int NOT NULL AUTO_INCREMENT,
  `nameProduct` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kidsProduct` tinyint(1) NULL DEFAULT 0,
  `idCategory` int NOT NULL,
  `reviewProduct` int NULL DEFAULT 5,
  PRIMARY KEY (`idProduct`) USING BTREE,
  INDEX `FK_idCategory_Product`(`idCategory` ASC) USING BTREE,
  CONSTRAINT `FK_idCategory_Product` FOREIGN KEY (`idCategory`) REFERENCES `category` (`idCategory`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `CH_reviewProduct` CHECK ((`reviewProduct` >= 0) and (`reviewProduct` <= 5))
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (1, 'CAMERA FOTOGRAFICA', 0, 1, 5);
INSERT INTO `product` VALUES (2, 'CARRO DE CONTROLE REMOTO', 0, 2, 5);
INSERT INTO `product` VALUES (3, 'CADERNO', 0, 3, 5);
INSERT INTO `product` VALUES (4, 'CHAVEIRO', 0, 4, 5);
INSERT INTO `product` VALUES (5, 'PLAYSTATION 5', 0, 5, 5);

-- ----------------------------
-- Table structure for productsize
-- ----------------------------
DROP TABLE IF EXISTS `productsize`;
CREATE TABLE `productsize`  (
  `idProduct` int NOT NULL,
  `idSize` int NOT NULL,
  `atvProductSize` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`idProduct`, `idSize`) USING BTREE,
  INDEX `FK_idSize_ProductSize`(`idSize` ASC) USING BTREE,
  CONSTRAINT `FK_idProduct_ProductSize` FOREIGN KEY (`idProduct`) REFERENCES `product` (`idProduct`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_idSize_ProductSize` FOREIGN KEY (`idSize`) REFERENCES `size` (`idSize`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of productsize
-- ----------------------------
INSERT INTO `productsize` VALUES (1, 1, 1);
INSERT INTO `productsize` VALUES (2, 1, 1);
INSERT INTO `productsize` VALUES (3, 2, 1);
INSERT INTO `productsize` VALUES (3, 3, 1);
INSERT INTO `productsize` VALUES (3, 4, 1);
INSERT INTO `productsize` VALUES (4, 1, 1);

-- ----------------------------
-- Table structure for productstock
-- ----------------------------
DROP TABLE IF EXISTS `productstock`;
CREATE TABLE `productstock`  (
  `idProduct` int NOT NULL,
  `IdStocK` int NOT NULL,
  `qtdProdut` int NOT NULL,
  INDEX `FK_idProduct_ProductStock`(`idProduct` ASC) USING BTREE,
  INDEX `FK_IdStocK_ProductStock`(`IdStocK` ASC) USING BTREE,
  CONSTRAINT `FK_idProduct_ProductStock` FOREIGN KEY (`idProduct`) REFERENCES `product` (`idProduct`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_IdStocK_ProductStock` FOREIGN KEY (`IdStocK`) REFERENCES `stock` (`idStock`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `CH_qtdProdut` CHECK (`qtdProdut` >= 0)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of productstock
-- ----------------------------

-- ----------------------------
-- Table structure for size
-- ----------------------------
DROP TABLE IF EXISTS `size`;
CREATE TABLE `size`  (
  `idSize` int NOT NULL AUTO_INCREMENT,
  `nameSize` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `abbrSize` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `atvSize` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`idSize`) USING BTREE,
  UNIQUE INDEX `UQ_nameSize`(`nameSize` ASC) USING BTREE,
  UNIQUE INDEX `UQ_abbrSize`(`abbrSize` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of size
-- ----------------------------
INSERT INTO `size` VALUES (1, 'UNICO', 'U', 1);
INSERT INTO `size` VALUES (2, 'PEQUENO', 'P', 1);
INSERT INTO `size` VALUES (3, 'MEDIO', 'M', 1);
INSERT INTO `size` VALUES (4, 'GRANDE', 'G', 1);

-- ----------------------------
-- Table structure for stock
-- ----------------------------
DROP TABLE IF EXISTS `stock`;
CREATE TABLE `stock`  (
  `idStock` int NOT NULL AUTO_INCREMENT,
  `locationStock` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `atvStock` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`idStock`) USING BTREE,
  UNIQUE INDEX `UQ_locationStock`(`locationStock` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock
-- ----------------------------
INSERT INTO `stock` VALUES (1, 'SAO PAULO', 1);
INSERT INTO `stock` VALUES (2, 'GUARULHOS', 1);
INSERT INTO `stock` VALUES (3, 'RIO DE JANEIRO', 1);

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier`  (
  `idSupplier` int NOT NULL AUTO_INCREMENT,
  `nameSupplier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `CNPJ` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `contactSupplier` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`idSupplier`) USING BTREE,
  UNIQUE INDEX `UQ_CNPJ`(`CNPJ` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of supplier
-- ----------------------------
INSERT INTO `supplier` VALUES (1, 'SUPPLIER 0', '000000000001111', '11999998888');
INSERT INTO `supplier` VALUES (2, 'SUPPLIER 1', '111111111112222', '11999997777');
INSERT INTO `supplier` VALUES (3, 'SUPPLIER 2', '222222222223333', '11999996666');
INSERT INTO `supplier` VALUES (4, 'SUPPLIER 3', '333333333334444', '11999995555');

SET FOREIGN_KEY_CHECKS = 1;
