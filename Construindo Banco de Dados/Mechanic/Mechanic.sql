-- Verifica se o banco de dados já existe e o exclui
DROP DATABASE IF EXISTS Mechanic;

-- Cria o banco de dados
CREATE DATABASE Mechanic;

-- Seleciona o banco de dados para uso
USE Mechanic;

-- CRIAÇÃO DA TABELA CLIENTE
CREATE TABLE Client(
	idClient INT AUTO_INCREMENT,
	nameClient VARCHAR(50) NOT NULL,
	CPF VARCHAR(11) NOT NULL,
	addressClient VARCHAR(255) NOT NULL,
	CONSTRAINT PK_idClient PRIMARY KEY (idClient),
	CONSTRAINT UQ_Client_CPF UNIQUE(CPF)
);
INSERT INTO Client (nameClient, CPF, addressClient)
VALUES
(UPPER('TESTE 0'), UPPER('00000000000'), UPPER('Rua Zero, 0 - Sao Paulo - SP')),
(UPPER('TESTE 1'), UPPER('11111111111'), UPPER('Rua Um, 1 - Guarulhos - SP')),
(UPPER('TESTE 2'), UPPER('22222222222'), UPPER('Rua Dois, 2 - Bertioga - SP')),
(UPPER('TESTE 3'), UPPER('33333333333'), UPPER('Rua Tres, 3 - Santos - SP'));

-- CRIAÇÃO DA TABELA VEICULOS
CREATE TABLE Vehicle(
	idVehicle INT AUTO_INCREMENT,
    LicensePlate VARCHAR(7) NOT NULL,
    Make VARCHAR(20) NOT NULL,
    Model VARCHAR(20) NOT NULL,
    idClient INT NOT NULL,
    CONSTRAINT PK_idVehicle PRIMARY KEY (idVehicle),
    CONSTRAINT FK_Vehicle_idClient FOREIGN KEY (idClient) REFERENCES Client (idClient),
    CONSTRAINT UQ_LicensePlate UNIQUE (LicensePlate)
);
INSERT INTO Vehicle (LicensePlate, Make, Model, idClient)
SELECT UPPER('AAA1A11'), UPPER('FIAT'), UPPER('UNO'), idClient FROM Client WHERE CPF ='00000000000'
UNION ALL
SELECT UPPER('BBB2B22'), UPPER('GM'), UPPER('COBALT'), idClient FROM Client WHERE CPF ='11111111111'
UNION ALL
SELECT UPPER('CCC3C33'), UPPER('VW'), UPPER('GOL'), idClient FROM Client WHERE CPF ='22222222222'
UNION ALL
SELECT UPPER('DDD4D44'), UPPER('HONDA'), UPPER('CIVIC'), idClient FROM Client WHERE CPF ='33333333333';

-- CRIAÇÃO DA TABELA MECANICOS
CREATE TABLE Mechanic(
	idMechanic INT AUTO_INCREMENT,
	nameMechanic VARCHAR(50) NOT NULL,
	CPF VARCHAR(11) NOT NULL,
	addressMechanic VARCHAR(255) NOT NULL,
	specialty VARCHAR(20) NOT NULL,
	CONSTRAINT PK_idMechanic PRIMARY KEY (idMechanic),
	CONSTRAINT UQ_Mechanic_CPF UNIQUE(CPF)
);
INSERT INTO Mechanic (nameMechanic, CPF, addressMechanic, specialty)
VALUES
(UPPER('MECHANIC 1'), UPPER('44444444444'), UPPER('Rua Teste, 4 - Sao Paulo - SP'), UPPER('ELETRICA')),
(UPPER('MECHANIC 2'), UPPER('55555555555'), UPPER('Rua Cinco, 5 - Guarulhos - SP'), UPPER('BORRACHARIA')),
(UPPER('MECHANIC 3'), UPPER('66666666666'), UPPER('Rua Test, 6 - Bertioga - SP'), UPPER('MOTOR'));

-- CRIAÇÃO DA TABELA EQUIPE
CREATE TABLE Team(
	idTeam INT AUTO_INCREMENT,
	descTeam VARCHAR(50) NOT NULL,
	idMechanic INT NOT NULL,
	CONSTRAINT PK_idTeam PRIMARY KEY (idTeam),
	CONSTRAINT FK_Team_idMechanic FOREIGN KEY (idMechanic) REFERENCES Mechanic (idMechanic)
);
INSERT INTO Team (descTeam, IdMechanic)
SELECT UPPER('ELETRICA'), idMechanic FROM Mechanic WHERE CPF = '44444444444'
UNION ALL
SELECT UPPER('RODAS E SUSPENCAO'), idMechanic FROM Mechanic WHERE CPF = '55555555555'
UNION ALL
SELECT UPPER('MECANICA GERAL'), idMechanic FROM Mechanic WHERE CPF = '66666666666';

-- CRIAÇÃO DA TABELA SITUAÇÃO DA ORDEM DE SERVIÇO
CREATE TABLE StatusOS(
	idStatusOS INT AUTO_INCREMENT,
	descStatusOS VARCHAR(20) NOT NULL,
	CONSTRAINT PK_idStatusOS PRIMARY KEY (idStatusOS)
);
INSERT INTO StatusOS (descStatusOS)
VALUES
(UPPER('Em Andamento')),
(UPPER('Concluido')),
(UPPER('Cancelado'));


-- CRIAÇÃO DA TABELA TIPO DE SERVIÇO
CREATE TABLE TypeService(
	idTypeService INT AUTO_INCREMENT,
	descTypeService VARCHAR(50) NOT NULL,
	valueTypeService DECIMAL (10,2) NOT NULL,
	CONSTRAINT PK_idTypeService PRIMARY KEY (idTypeService)
);
INSERT INTO TypeService (descTypeService, valueTypeService)
VALUES
(UPPER('Alinhamento'),(100.00)),
(UPPER('Troca de pneu'),(20.00)),
(UPPER('Troca de oleo'),(30.00)),
(UPPER('Troca de filtro de oleo'),(30.00)),
(UPPER('Troca de lampada'),(5.00)),
(UPPER('Troca de bateria'),(15.00));


-- CRIAÇÃO DA TABELA PEÇAS
CREATE TABLE Parts(
	idParts INT AUTO_INCREMENT,
	descParts VARCHAR(50) NOT NULL,
	valueParts DECIMAL (10,2) NOT NULL,
	CONSTRAINT PK_idParts PRIMARY KEY (idParts)
);
INSERT INTO Parts (descParts, valueParts)
VALUES
(UPPER('Oleo 15W40'),(30.00)),
(UPPER('Oleo 5W30'),(35.00)),
(UPPER('BATERIA 60A'),(400.00)),
(UPPER('LAMPADA H4'),(50.00)),
(UPPER('FILTRO DE OLEO'),(50.00)),
(UPPER('PNEU 14 175/65'),(370.00));

-- CRIAÇÃO DA TABELA OS
CREATE TABLE OS(
	idOS INT AUTO_INCREMENT,
	dtEmissao DATE NOT NULL,
	dtEntrega DATE NOT NULL,
	idVehicle INT NOT NULL,
	idTeam INT NOT NULL,
	CONSTRAINT PK_idOS PRIMARY KEY (idOS),
	CONSTRAINT FK_OS_idVehicle FOREIGN KEY (idVehicle) REFERENCES Vehicle (idVehicle),
	CONSTRAINT FK_OS_idTeam FOREIGN KEY (idTeam) REFERENCES Team (idTeam)
);
INSERT INTO OS (dtEmissao, dtEntrega, idVehicle, idTeam)
SELECT CURRENT_DATE(), DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY), V.idVehicle, T.idTeam FROM Vehicle V JOIN Team T ON T.descTeam = 'MECANICA GERAL' WHERE V.LicensePlate = 'AAA1A11' 
UNION ALL 
SELECT CURRENT_DATE(), DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY), V.idVehicle, T.idTeam FROM Vehicle V JOIN Team T ON T.descTeam = 'RODAS E SUSPENCAO' WHERE V.LicensePlate = 'BBB2B22';

