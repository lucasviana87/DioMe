-- CRIAÇÃO DATABASE
CREATE DATABASE ECOMMERCE;
USE ECOMMERCE;
-- =======================================================================================
-- CRIAÇÃO DA TABELA CATEGORIA
CREATE TABLE Category(
	idCategory INT AUTO_INCREMENT,
	nameCategory VARCHAR(50) NOT NULL,
	abbrCategory VARCHAR(10) NOT NULL, 
	atvCategory BOOLEAN DEFAULT TRUE,
	CONSTRAINT PK_idCategory PRIMARY KEY (idCategory),
	CONSTRAINT UQ_nameCategory UNIQUE (nameCategory), 
	CONSTRAINT UQ_abbrCategory UNIQUE (abbrCategory)
);
INSERT INTO Category (nameCategory, abbrCategory) 
VALUES 
(UPPER('Eletronico'), UPPER('Eletro')),
(UPPER('Brinquedos'), UPPER('Brinq')),
(UPPER('Papelaria'), UPPER('Papel')),
(UPPER('Automotivo'), UPPER('Auto')),
(UPPER('Games'), UPPER('Games'));

-- CRIAÇÃO DA TABELA TAMANHO
CREATE TABLE Size(
	idSize INT AUTO_INCREMENT,
	nameSize VARCHAR(50) NOT NULL,
	abbrSize VARCHAR(10) NOT NULL, 
	atvSize BOOLEAN DEFAULT TRUE,
	CONSTRAINT PK_idSize PRIMARY KEY (idSize),
	CONSTRAINT UQ_nameSize UNIQUE (nameSize), 
	CONSTRAINT UQ_abbrSize UNIQUE (abbrSize)
);
INSERT INTO Size (nameSize, abbrSize)
VALUES
(UPPER('Unico'),UPPER('U')),
(UPPER('Pequeno'), UPPER('P')),
(UPPER('Medio'), UPPER('M')),
(UPPER('Grande'), UPPER('G'));

-- CRIAÇÃO DA TABELA STATUS DO PEDIDO
CREATE TABLE OrderStatus(
	idOrderStatus INT auto_increment,
	descOrderStatus VARCHAR(50) NOT NULL,
	atvOrderStatus BOOLEAN DEFAULT TRUE,
	CONSTRAINT PK_idOrderStatus PRIMARY KEY (idOrderStatus),
  CONSTRAINT UQ_descOrderStatus UNIQUE (descOrderStatus)
);
INSERT INTO OrderStatus (descOrderStatus)
VALUES
(UPPER('Em Processamento')),
(UPPER('Confirmado')),
(UPPER('Enviado')),
(UPPER('Cancelado'));

-- CRIAÇÃO DA TABELA TIPO DE PAGAMENTO
CREATE TABLE PaymentType (
    idPaymentType INT AUTO_INCREMENT,
    paymentMethodName VARCHAR(100) NOT NULL,
    atvPaymentType BOOLEAN DEFAULT TRUE,
    CONSTRAINT PK_idPaymentType PRIMARY KEY (idPaymentType),
    CONSTRAINT UQ_paymentMethodName UNIQUE (paymentMethodName)
);
INSERT INTO PaymentType (paymentMethodName)
VALUES
(UPPER('Cartao de Credito')),
(UPPER('PIX')),
(UPPER('Boleto'));



-- =======================================================================================

-- CRIAÇÃO DA TABELA CLIENTE
CREATE TABLE Client(
	idClient INT AUTO_INCREMENT,
	nameClient VARCHAR(50) NOT NULL,
	CPF VARCHAR(11) NOT NULL,
	addressClient VARCHAR(255) NOT NULL,
	CONSTRAINT PK_idClient PRIMARY KEY (idClient),
	CONSTRAINT UQ_CPF UNIQUE(CPF)
);
INSERT INTO Client (nameClient, CPF, addressClient)
VALUES
(UPPER('TESTE 0'), UPPER('00000000000'), UPPER('Rua Zero, 0 - Sao Paulo - SP')),
(UPPER('TESTE 1'), UPPER('11111111111'), UPPER('Rua Um, 1 - Guarulhos - SP')),
(UPPER('TESTE 2'), UPPER('22222222222'), UPPER('Rua Dois, 2 - Bertioga - SP')),
(UPPER('TESTE 3'), UPPER('33333333333'), UPPER('Rua Tres, 3 - Santos - SP'));


-- CRIAÇÃO DA TABELA FORNECEDOR
CREATE TABLE Supplier(
	idSupplier INT AUTO_INCREMENT,
	nameSupplier VARCHAR(50) NOT NULL,
	CNPJ VARCHAR(15) NOT NULL,
	contactSupplier VARCHAR(11) NOT NULL,
	CONSTRAINT PK_idSupplier PRIMARY KEY (idSupplier),
	CONSTRAINT UQ_CNPJ UNIQUE(CNPJ)
);
INSERT INTO Supplier (nameSupplier, CNPJ, contactSupplier)
VALUES
(UPPER('SUPPLIER 0'), UPPER('000000000001111'), UPPER('11999998888')),
(UPPER('SUPPLIER 1'), UPPER('111111111112222'), UPPER('11999997777')),
(UPPER('SUPPLIER 2'), UPPER('222222222223333'), UPPER('11999996666')),
(UPPER('SUPPLIER 3'), UPPER('333333333334444'), UPPER('11999995555'));

-- CRIAÇÃO DA LOCAL DE ESTOQUE
CREATE TABLE Stock(
	idStock INT AUTO_INCREMENT, 
	locationStock VARCHAR(255),
	atvStock BOOLEAN DEFAULT TRUE,
	CONSTRAINT PK_idStock_Stock PRIMARY KEY(idStock),
	CONSTRAINT UQ_locationStock UNIQUE (locationStock)
);
INSERT INTO Stock (locationStock)
VALUES
(UPPER('Sao Paulo')),
(UPPER('Guarulhos')),
(UPPER('Rio de Janeiro'));



-- CRIAÇÃO DA TABELA PRODUTO
CREATE TABLE Product(
	idProduct INT AUTO_INCREMENT,
	nameProduct VARCHAR(100) NOT NULL,
	kidsProduct BOOLEAN DEFAULT FALSE,
	idCategory INT NOT NULL,
	reviewProduct INT DEFAULT 5,
	CONSTRAINT PK_idProduct PRIMARY KEY (idProduct),
	CONSTRAINT CH_reviewProduct CHECK (reviewProduct >= 0 AND reviewProduct <= 5),
	CONSTRAINT FK_idCategory_Product FOREIGN KEY (idCategory) REFERENCES Category (idCategory)
);
INSERT INTO Product (nameProduct, idCategory)
SELECT UPPER('Camera Fotografica'), idCategory FROM Category WHERE abbrCategory = 'ELETRO'
UNION ALL
SELECT UPPER('Carro de Controle remoto'), idCategory FROM Category WHERE abbrCategory = 'BRINQ'
UNION ALL
SELECT UPPER('Caderno'), idCategory FROM Category WHERE abbrCategory = 'PAPEL'
UNION ALL
SELECT UPPER('Chaveiro'), idCategory FROM Category WHERE abbrCategory = 'AUTO'
UNION ALL
SELECT UPPER('PlayStation 5'), idCategory FROM Category WHERE abbrCategory = 'GAMES';


-- CRIAÇÃO DA TABELA QUE VINCULA PRODUTO e TAMANHO
CREATE TABLE ProductSize(
	idProduct INT NOT NULL,
	idSize INT NOT NULL,
	atvProductSize BOOLEAN DEFAULT TRUE,
	CONSTRAINT PK_idProduct_idSize PRIMARY KEY (idProduct,idSize),
	CONSTRAINT FK_idProduct_ProductSize FOREIGN KEY (idProduct) REFERENCES Product (idProduct),
	CONSTRAINT FK_idSize_ProductSize FOREIGN KEY (idSize) REFERENCES Size (idSize)
);
INSERT INTO ProductSize (idProduct, idSize)
SELECT P.idProduct, S.idSize
FROM Product P
JOIN Size S ON (
    (P.nameProduct = UPPER('Camera Fotografica') AND S.abbrSize = 'U') OR
    (P.nameProduct = UPPER('Carro de Controle remoto') AND S.abbrSize = 'U') OR
    (P.nameProduct = UPPER('Caderno') AND S.abbrSize IN ('P', 'M', 'G')) OR
    (P.nameProduct = UPPER('Chaveiro') AND S.abbrSize = 'U') OR
    (P.nameProduct = UPPER('PlayStation') AND S.abbrSize = 'U')
);

-- CRIAÇÃO DA TABELA ESTOQUE DE PRODUTO TAMANHO QUANTIDADE
CREATE TABLE ProductStock(
	idProduct INT NOT NULL,
	IdStocK INT NOT NULL,
	qtdProdut INT NOT NULL ,
	CONSTRAINT FK_idProduct_ProductStock FOREIGN KEY (idProduct) REFERENCES Product (idProduct),
	CONSTRAINT FK_IdStocK_ProductStock FOREIGN KEY (IdStocK) REFERENCES StocK (IdStocK),
	CONSTRAINT CH_qtdProdut CHECK (qtdProdut >=0)
);



-- CRIAÇÃO DA TABELA PEDIDO
CREATE TABLE Orders(
	idOrder INT AUTO_INCREMENT,
	idClient INT NOT NULL,
	idOrderStatus INT NOT NULL,
	descOrders VARCHAR(255),
	shippingCost DECIMAL(10,2) DEFAULT 10,
	CONSTRAINT PK_idOrder PRIMARY KEY (idOrder),
	CONSTRAINT FK_idClient_Orders FOREIGN KEY (idClient) REFERENCES Client (idClient),
	CONSTRAINT FK_idOrderStatus_Orders FOREIGN KEY (idOrderStatus) REFERENCES OrderStatus (idOrderStatus)
);






