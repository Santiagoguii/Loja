SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
----------------------------------------------------------
-- Schema
----------------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `loja`;
USE `loja` ;
SET SQL_SAFE_UPDATES=0;

----------------------------------------------------------
-- CREATE table´s
----------------------------------------------------------

CREATE TABLE IF NOT EXISTS`Fornecedor` (
  `CPF/CNPJ` VARCHAR(20) NOT NULL,
  `Nome` VARCHAR(25) NULL,
  `Email` VARCHAR(25) NULL,
  PRIMARY KEY (`CPF/CNPJ`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `loja`.`Produto` (
  `Cd_Produto` INT NOT NULL,
  `Nome` VARCHAR(40) NULL,
  `Descricao` VARCHAR(50) NULL,
  `Preco` DECIMAL(5,2) NULL,
  `Tamanho` CHAR(2) NULL,
  `Cor` VARCHAR(25) NULL,
  `Marca` VARCHAR(25) NULL,
  `Peso` DECIMAL (5,2) NULL,
  `Fornecedor_CPF/CNPJ` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Cd_Produto`, `Fornecedor_CPF/CNPJ`))
ENGINE = InnoDB;

CREATE INDEX `fk_Produto_Fornecedor1_idx` ON `loja`.`Produto` (`Fornecedor_CPF/CNPJ` ASC) VISIBLE;


CREATE TABLE IF NOT EXISTS `loja`.`Desconto/Promocao` (
  `Valor do desconto` DECIMAL(5,2) NOT NULL,
  `Porcentagem` INT NOT NULL,
  `Tempo` DATETIME NOT NULL,
  `Produto_Cd_Produto` INT NOT NULL,
  PRIMARY KEY (`Produto_Cd_Produto`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `loja`.`Categoria_Produto` (
  `Nome` VARCHAR(25) NOT NULL,
  `Sexo` VARCHAR(1) NULL,
  `Marca` VARCHAR(25) NULL,
  `Produto_Cd_Produto` INT NOT NULL,
  PRIMARY KEY (`Nome`, `Produto_Cd_Produto`))
ENGINE = InnoDB;

CREATE INDEX `fk_Categoria_Produto_Produto_idx` ON `loja`.`Categoria_Produto` (`Produto_Cd_Produto` ASC) VISIBLE;


CREATE TABLE IF NOT EXISTS `loja`.`Cliente` (
  `CPF` VARCHAR(11) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NULL,
  `Telefone_Comercial` VARCHAR(11) NULL,
  `Data_Nascimento` DATE NOT NULL,
  PRIMARY KEY (`CPF`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `loja`.`Funcionarios` (
  `CPF` VARCHAR(11) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `sexo` VARCHAR(1) NULL,
  `Datadenasc` DATE NULL,
  `Salario` DECIMAL(5,2) NULL,
  `Dt_adm` DATE NULL,
  `Dt_saida` DATE NULL,
  `Cargo` VARCHAR(25) NULL,
  `Email` VARCHAR(45) NULL,
  PRIMARY KEY (`CPF`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `loja`.`Endereco` (
  `CEP` VARCHAR(8) NOT NULL,
  `Estado` VARCHAR(2) NULL,
  `Cidade` VARCHAR(25) NULL,
  `Bairro` VARCHAR(25) NULL,
  `Rua` VARCHAR(45) NULL,
  `N_residencia` VARCHAR(5) NULL,
  `Complemento` VARCHAR(50) NULL,
  `Logradouro` VARCHAR(100) NULL,
  `Cliente_CPF` VARCHAR(11)  NULL,
  `Funcionarios_CPF` VARCHAR(11) NULL,
  PRIMARY KEY (`CEP`))
ENGINE = InnoDB;


CREATE INDEX `fk_Endereco_Cliente1_idx` ON `loja`.`Endereco` (`Cliente_CPF` ASC) VISIBLE;

CREATE INDEX `fk_Endereco_Funcionarios1_idx` ON `loja`.`Endereco` (`Funcionarios_CPF` ASC) VISIBLE;


CREATE TABLE IF NOT EXISTS `loja`.`Telefone` (
  `Cd_Telefone` VARCHAR(11) NOT NULL,
  `Funcionarios_CPF` VARCHAR(11) NULL,
  `Cliente_CPF` VARCHAR(11) NULL,
  `Fornecedor_CPF/CNPJ` VARCHAR(20) NULL,
  PRIMARY KEY (`Cd_Telefone`))
ENGINE = InnoDB;


CREATE INDEX `fk_Telefone_Funcionarios1_idx` ON `loja`.`Telefone` (`Funcionarios_CPF` ASC) VISIBLE;

CREATE INDEX `fk_Telefone_Cliente1_idx` ON `loja`.`Telefone` (`Cliente_CPF` ASC) VISIBLE;

CREATE INDEX `fk_Telefone_Fornecedor1_idx` ON `loja`.`Telefone` (`Fornecedor_CPF/CNPJ` ASC) VISIBLE;


CREATE TABLE IF NOT EXISTS `loja`.`Estoque` (
  `Quantidade` INT NOT NULL,
  `Local` VARCHAR(25) NOT NULL,
  `Dt_entrada` DATETIME NULL,
  `Dt_saida` DATETIME NULL,
  `Produto_Cd_Produto` INT NOT NULL,
  PRIMARY KEY (`Produto_Cd_Produto`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `loja`.`Venda` (
  `Cd_Venda` INT NOT NULL auto_increment,
  `Status_entrega` VARCHAR(15) NULL,
    `valor` DECIMAL(5,2) NULL,
  `Funcionarios_CPF` VARCHAR(11) NOT NULL,
  `Cliente_CPF` VARCHAR(11) NOT NULL,
  `Produto_Cd_Produto` INT NOT NULL,
  PRIMARY KEY (`Cd_Venda`, `Funcionarios_CPF`, `Cliente_CPF`, `Produto_Cd_Produto`))
ENGINE = InnoDB;

CREATE INDEX `fk_Venda_Funcionarios1_idx` ON `loja`.`Venda` (`Funcionarios_CPF` ASC) VISIBLE;

CREATE INDEX `fk_Venda_Cliente1_idx` ON `loja`.`Venda` (`Cliente_CPF` ASC) VISIBLE;

CREATE INDEX `fk_Venda_Produto1_idx` ON `loja`.`Venda` (`Produto_Cd_Produto` ASC) VISIBLE;


CREATE TABLE IF NOT EXISTS `loja`.`Forma_pagamento` (
  `Cd_FormadePg` INT NOT NULL,
  `Tipo` VARCHAR(15) NULL,
  `Parcelas` INT NULL,
  `Venda_Cd_Venda` INT NOT NULL,
  PRIMARY KEY (`Cd_FormadePg`))
ENGINE = InnoDB;

CREATE INDEX `fk_Forma_pagamento_Venda1_idx` ON `loja`.`Forma_pagamento` (`Venda_Cd_Venda` ASC) VISIBLE;


CREATE TABLE IF NOT EXISTS `loja`.`Dependente` (
  `CPF` VARCHAR(11) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Dt_nasc` DATE NULL,
  `Parentesco` VARCHAR(15) NULL,
  `Funcionarios_CPF` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`CPF`, `Funcionarios_CPF`))
ENGINE = InnoDB;

CREATE INDEX `fk_Dependente_Funcionarios1_idx` ON `loja`.`Dependente` (`Funcionarios_CPF` ASC) VISIBLE;


CREATE TABLE IF NOT EXISTS `loja`.`Ferias` (
  `Cod_Férias` INT NOT NULL,
  `ano` YEAR NULL,
  `Dt_ini` DATETIME NULL,
  `Dt_fim` DATETIME NULL,
  `QtdDias` INT NULL,
  `Funcionarios_CPF` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`Cod_Férias`, `Funcionarios_CPF`))
ENGINE = InnoDB;

CREATE INDEX `fk_Férias_Funcionarios1_idx` ON `loja`.`Ferias` (`Funcionarios_CPF` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

----------------------------------------------------------
-- ALTER table´s
----------------------------------------------------------

ALTER TABLE `loja`.`Produto`
MODIFY COLUMN `Peso` DECIMAL(4,2) NULL;

ALTER TABLE `loja`.`Produto`
MODIFY COLUMN `Preco` DECIMAL(5,2) NULL;

ALTER TABLE `loja`.`Produto`
DROP COLUMN `Descricao`;

ALTER TABLE `loja`.`Funcionarios`
MODIFY COLUMN `Salario` DECIMAL(6,2) NOT NULL;

ALTER TABLE `loja`.`Endereco`
MODIFY COLUMN `Complemento` VARCHAR(100) NULL;

ALTER TABLE `loja`.`Forma_pagamento`
MODIFY COLUMN `Parcelas` INT NOT NULL;

ALTER TABLE `loja`.`Ferias`
MODIFY COLUMN `Dt_fim` DATETIME NOT NULL;

ALTER TABLE `loja`.`Endereco`
MODIFY COLUMN `Logradouro` VARCHAR(40) NULL;

ALTER TABLE `loja`.`ferias`
MODIFY COLUMN `Dt_ini` DATETIME NOT NULL;

ALTER TABLE `loja`.`Estoque`
MODIFY COLUMN `Quantidade` INT NOT NULL;

ALTER TABLE `loja`.`Estoque`
ADD COLUMN Cd_Estoque INT ;

ALTER TABLE `loja`.`Desconto/Promocao`
ADD COLUMN `Dt_ini` DATETIME NOT NULL ;

ALTER TABLE `loja`.`Desconto/Promocao`
ADD COLUMN `Dt_fim` DATETIME NOT NULL ;

ALTER TABLE `loja`.`Produto`
MODIFY COLUMN `tamanho` VARCHAR(4) NULL;

ALTER TABLE `loja`.`Desconto/Promocao`
DROP COLUMN `Tempo`;

ALTER TABLE `loja`.`venda`
ADD COLUMN `Dt_compra` DATETIME;

ALTER TABLE `loja`.`venda`
ADD COLUMN `Quantidade` INT NOT NULL;

ALTER TABLE `loja`.`forma_pagamento`
MODIFY COLUMN `Cd_Formadepg` INT NOT NULL AUTO_INCREMENT;

ALTER TABLE `loja`.`forma_pagamento`
MODIFY COLUMN `Tipo` VARCHAR(30);

ALTER TABLE `loja`.`venda`
MODIFY COLUMN `Valor` DECIMAL(7,2);

----------------------------------------------------------
-- INSERT´S 
----------------------------------------------------------

-- Inserções na tabela Fornecedor
INSERT INTO `Fornecedor` (`CPF/CNPJ`, `Nome`, `Email`) VALUES
('23456789011', 'Zara', 'zara@email.com'),
('23456789022', 'H&M', 'hm@email.com'),
('23456789033', 'Nike', 'nike@email.com'),
('23456789044', 'Adidas', 'adidas@email.com'),
('23456789055', 'GAP', 'gap@email.com'),
('23456789066', 'Louis Vuitton', 'louisvuitton@email.com'),
('23456789077', 'Versace', 'versace@email.com'),
('23456789088', 'Gucci', 'gucci@email.com'),
('23456789099', 'Prada', 'prada@email.com'),
('23456789000', 'Calvin Klein', 'calvinklein@email.com');

INSERT INTO `loja`.`Produto` (`Cd_Produto`, `Nome`, `Preco`, `Tamanho`, `Cor`, `Marca`, `Peso`, `Fornecedor_CPF/CNPJ`) VALUES
(1, 'Zara Jeans', 299.99, 40, 'Azul', 'Zara', 1.2, '12345678901'),
(2, 'Zara Camiseta', 179.99, 'M', 'Branco', 'Zara', 0.8, '12345678901'),
(3, 'H&M Calça', 329.99, 36, 'Preto', 'H&M', 1.5, '23456789012'),
(4, 'H&M Camisa', 199.99, 'P', 'Vermelho', 'H&M', 1.0, '23456789012'),
(5, 'Nike Tênis', 399.99, 42, 'Verde', 'Nike', 0.9, '34567890123'),
(6, 'Nike Moletom', 159.99, 'G', 'Cinza', 'Nike', 1.2, '34567890123'),
(7, 'Adidas Shorts', 119.99, 'M', 'Rosa', 'Adidas', 0.7, '45678901234'),
(8, 'Adidas Camiseta', 84.99, 'M', 'Amarelo', 'Adidas', 0.8, '45678901234'),
(9, 'GAP Vestido', 199.99, 'P', 'Azul Marinho', 'GAP', 1.0, '56789012345'),
(10, 'GAP Jaqueta', 259.99, 'G', 'Verde Militar', 'GAP', 1.5, '56789012345'),
(11, 'Louis Vuitton Bolsa', 499.99, NULL, 'Marrom', 'Louis Vuitton', 0.5, '67890123456'),
(12, 'Louis Vuitton Cinto', 149.99, NULL, 'Preto', 'Louis Vuitton', 0.3, '67890123456'),
(13, 'Versace Óculos de Sol', 359.99, NULL, 'Dourado', 'Versace', 0.2, '78901234567'),
(14, 'Versace Perfume', 299.99, NULL, 'Roxo', 'Versace', 0.3, '78901234567'),
(15, 'Gucci Sapato', 349.99, 41, 'Marrom', 'Gucci', 1.2, '89012345678'),
(16, 'Gucci Bolsa', 299.99, NULL, 'Bege', 'Gucci', 0.8, '89012345678'),
(17, 'Prada Vestido de Festa', 499.99, 'M', 'Preto', 'Prada', 1.0, '90123456789'),
(18, 'Prada Óculos de Grau', 179.99, NULL, 'Azul', 'Prada', 0.3, '90123456789'),
(19, 'Calvin Klein Jeans', 219.99, 32, 'Azul Claro', 'Calvin Klein', 1.0, '01234567890'),
(20, 'Calvin Klein Camiseta Polo', 239.99, 38, 'Verde Oliva', 'Calvin Klein', 0.7, '01234567890');

INSERT INTO `loja`.`Desconto/Promocao` (`Valor do desconto`, `Porcentagem`,`Dt_ini`, `Dt_fim`, `Produto_Cd_Produto`) VALUES
(29.99, 10, '2023-01-01', '2023-01-31', 1),
(49.49, 15, '2023-02-01', '2023-02-28', 3),
(79.99, 20, '2023-03-01', '2023-03-31', 5),
(15.99, 10, '2023-04-01', '2023-04-30', 6),
(11.99, 10,'2023-05-01', '2023-05-31', 7),
(25.99, 10, '2023-06-01', '2023-06-30', 10),
(71.99, 20, '2023-07-01', '2023-07-31', 13),
(34.99, 15, '2023-08-01', '2023-08-31', 15),
(24.99, 05, '2023-09-01', '2023-09-30', 17),
(23.99, 10, '2023-10-01', '2023-10-31', 20);

INSERT INTO `loja`.`Categoria_Produto` (`Nome`, `Sexo`, `Marca`, `Produto_Cd_Produto`) VALUES
('Jeans', 'M', 'Zara', 1),
('Camiseta', 'F', 'Zara', 2),
('Tênis ', 'U', 'Nike', 5),
('Moletom', 'U', 'Nike', 6),
('Vestido', 'F', 'GAP', 9),
('Bolsa', 'U', 'Louis Vuitton', 11),
('Cinto', 'u', 'Louis Vuitton', 12),
('Polo', 'F', 'Calvin Klein', 20),
('Óculos', 'U', 'Prada', 18),
('Perfume', 'U', 'Versace', 14);

INSERT INTO `loja`.`Cliente` (`CPF`, `Nome`, `Email`, `Telefone_Comercial`, `Data_Nascimento`) VALUES
('11111111111', 'Ana Silva', 'ana.silva@email.com', '21987654321', '1990-01-01'),
('22222222222', 'João Santos', 'joao.santos@email.com', '31987654322', '1995-05-15'),
('33333333333', 'Carla Oliveira', 'carla.oliveira@email.com', '31987654323', '1988-07-20'),
('44444444444', 'Pedro Pereira', 'pedro.pereira@email.com', '81987654324', '1992-09-30'),
('55555555555', 'Mariana Costa', 'mariana.costa@email.com', '21987654325', '1985-03-12'),
('66666666666', 'Rafaela Martins', 'rafaela.martins@email.com', '31987654326', '1998-11-25'),
('77777777777', 'Lucas Silva', 'lucas.silva@email.com', '21987654327', '1982-06-05'),
('88888888888', 'Fernando Santos', 'fernando.santos@email.com', '31987654328', '1994-02-18'),
('99999999999', 'Vanessa Oliveira', 'vanessa.oliveira@email.com', '31987654329', '1989-08-10'),
('00000000000', 'Rodrigo Pereira', 'rodrigo.pereira@email.com', '23987654330', '1997-04-03');

INSERT INTO `loja`.`Funcionarios` (`CPF`, `Nome`, `sexo`, `Datadenasc`, `Salario`, `Dt_adm`, `Dt_saida`, `Cargo`, `Email`) VALUES
('12345678901', 'Ana Silva', 'F', '1985-03-10', 3000.00, '2022-01-01', NULL, 'Vendedora', 'ana.silva@email.com'),
('23456789012', 'João Santos', 'M', '1992-08-22', 3500.00, '2022-01-15', NULL, 'Caixa', 'joao.santos@email.com'),
('34567890123', 'Carla Oliveira', 'F', '1980-12-05', 4000.00, '2022-02-01', '2022-05-01', 'Gerente', 'carla.oliveira@email.com'),
('45678901234', 'Pedro Pereira', 'M', '1995-06-15', 3200.00, '2022-03-01', NULL, 'Atendente', 'pedro.pereira@email.com'),
('56789012345', 'Mariana Costa', 'F', '1988-04-20', 3800.00, '2022-04-15', NULL, 'Supervisora', 'mariana.costa@email.com'),
('67890123456', 'Rafaela Martins', 'F', '1983-09-01', 4200.00, '2022-05-01', NULL, 'Caixa', 'rafaela.martins@email.com'),
('78901234567', 'Lucas Silva', 'M', '1979-11-18', 4500.00, '2022-06-01', NULL, 'Gerente', 'lucas.silva@email.com'),
('89012345678', 'Fernando Santos', 'M', '1990-07-10', 5000.00, '2022-07-15', NULL, 'Vendedor', 'fernando.santos@email.com'),
('90123456789', 'Vanessa Oliveira', 'F', '1986-02-03', 3800.00, '2022-08-01', NULL, 'Supervisora', 'vanessa.oliveira@email.com'),
('01234567890', 'Rodrigo Pereira', 'M', '1993-04-12', 4200.00, '2022-09-01', NULL, 'Atendente', 'rodrigo.pereira@email.com');

INSERT INTO `loja`.`Endereco` (`CEP`, `Estado`, `Cidade`, `Bairro`, `Rua`, `N_residencia`, `Complemento`, `Logradouro`, `Funcionarios_CPF`) VALUES
('12345678', 'SP', 'São Paulo', 'Centro', 'Rua A', '123', 'Apto 101', 'Próximo ao Parque', '12345678901'),
('45678901', 'SP', 'São Paulo', 'Moema', 'Rua D', '1011', 'Apto 202', 'Próximo a Parque', '23456789012'),
('56789012', 'RJ', 'Rio de Janeiro', 'Ipanema', 'Rua E', '1213', 'Cobertura', 'Próximo à Praia', '34567890123'),
('78901234', 'SP', 'São Paulo', 'Itaim Bibi', 'Rua G', '1617', 'Casa', 'Próximo a Parque',  '45678901234'),
('01234567', 'SP', 'São Paulo', 'Vila Madalena', 'Rua J', '2223', 'Apto 505', 'Próximo a Parque','56789012345');

INSERT INTO `loja`.`Endereco` (`CEP`, `Estado`, `Cidade`, `Bairro`, `Rua`, `N_residencia`, `Complemento`, `Logradouro`, `Cliente_CPF` ) VALUES
('34567890', 'MG', 'Belo Horizonte', 'Savassi', 'Rua C', '789', 'Loja', 'Próximo a Shopping', '33333333333'),
('67890123', 'MG', 'Belo Horizonte', 'Centro', 'Rua F', '1415', 'Apto 303', 'Próximo a Shopping', '66666666666'),
('90123456', 'MG', 'Belo Horizonte', 'Barro Preto', 'Rua I', '2021', 'Loja', 'Próximo a Shopping', '99999999999'),
('89012345', 'RJ', 'Rio de Janeiro', 'Leblon', 'Rua H', '1819', 'Apto 404', 'Próximo à Praia', '88888888888'),
('23456789', 'RJ', 'Rio de Janeiro', 'Copacabana', 'Rua B', '456', 'Casa', 'Próximo à Praia', '22222222222');

INSERT INTO `loja`.`Telefone` (`Cd_Telefone`, `Cliente_CPF`) VALUES
( '21987654321', '11111111111'),
( '31987654322', '22222222222'),
( '31987654323', '33333333333'),
( '81987654324', '44444444444'),
( '21987654325', '55555555555'),
( '31987654326', '66666666666'),
( '21987654327', '77777777777'),
( '31987654328', '88888888888'),
( '31987654329', '99999999999'),
( '23987654330', '00000000000');

INSERT INTO `loja`.`Estoque` (`Quantidade`, `Local`, `Dt_entrada`, `Dt_saida`, `Produto_Cd_Produto`) VALUES
(50, 'Armazém 1', '2023-01-01', NULL, 1),
(30, 'Armazém 1', '2023-01-02', NULL, 2),
(40, 'Armazém 1', '2023-01-03', NULL, 3),
(25, 'Armazém 1', '2023-01-04', NULL, 4),
(35, 'Armazém 2', '2023-01-05', NULL, 5),
(20, 'Armazém 2', '2023-01-06', NULL, 6),
(45, 'Armazém 2', '2023-01-07', NULL, 7),
(60, 'Armazém 2', '2023-01-08', NULL, 8),
(28, 'Armazém 3', '2023-01-09', NULL, 9),
(38, 'Armazém 3', '2023-01-10', NULL, 10),
(55, 'Armazém 3', '2023-01-11', NULL, 11),
(22, 'Armazém 3', '2023-01-12', NULL, 12),
(42, 'Armazém 4', '2023-01-13', NULL, 13),
(33, 'Armazém 4', '2023-01-14', NULL, 14),
(50, 'Armazém 4', '2023-01-15', NULL, 15),
(29, 'Armazém 4', '2023-01-16', NULL, 16),
(48, 'Armazém 5', '2023-01-17', NULL, 17),
(18, 'Armazém 5', '2023-01-18', NULL, 18),
(37, 'Armazém 5', '2023-01-19', NULL, 19),
(40, 'Armazém 5', '2023-01-20', NULL, 20);

INSERT INTO `Ferias` (`Cod_Férias`, `ano`, `Dt_ini`, `Dt_fim`, `QtdDias`, `Funcionarios_CPF`) VALUES
(1, 2023, '2023-02-15', '2023-02-28', 14, '12345678901'),
(2, 2023, '2023-03-10', '2023-03-20', 11, '23456789012'),
(3, 2023, '2023-04-01', '2023-04-15', 15, '34567890123'),
(4, 2023, '2023-05-05', '2023-05-15', 11, '45678901234'),
(5, 2023, '2023-06-01', '2023-06-10', 10, '56789012345'),
(6, 2023, '2023-07-01', '2023-07-15', 15, '67890123456'),
(7, 2023, '2023-08-01', '2023-08-10', 10, '78901234567'),
(8, 2023, '2023-09-15', '2023-09-30', 16, '89012345678'),
(9, 2023, '2023-10-01', '2023-10-15', 15, '90123456789'),
(10, 2023, '2023-11-01', '2023-11-10', 10, '01234567890');

INSERT INTO `Dependente` (`CPF`, `Nome`, `Dt_nasc`, `Parentesco`, `Funcionarios_CPF`) VALUES
('13131313131', 'Ana Silva Jr.', '2000-01-15', 'Filho', '12345678901'),
('21212121212', 'Joana Silva', '2005-03-20', 'Filha', '12345678901'),
('46464646464', 'Pedro Santos', '2002-08-10', 'Filho', '23456789012'),
('50505050505', 'Mariana Santos', '2010-05-02', 'Filha', '23456789012'),
('84848484848', 'Carlos Oliveira', '1998-11-08', 'Cônjuge', '34567890123'),
('39304930424', 'Beatriz Pereira', '2004-09-25', 'Filho', '45678901234'),
('93287183781', 'Lucas Pereira', '2012-07-12', 'Filho', '45678901234'),
('39102839811', 'Isabela Costa', '2000-04-18', 'Cônjuge', '56789012345'),
('48593847587', 'Gabriel Costa', '2007-02-28', 'Filho', '56789012345'),
('19238901281', 'Fernanda Martins', '1995-06-05', 'Cônjuge', '67890123456'),
('02938493204', 'Guilherme Silva', '2001-09-15', 'Filho', '78901234567'),
('48728636232', 'Eduardo Silva', '2009-10-08', 'Filho', '78901234567'),
('04890218491', 'Patrícia Santos', '1997-03-01', 'Cônjuge', '89012345678'),
('75832432643', 'Rodrigo Santos', '2004-12-20', 'Filho', '89012345678'),
('31212312329', 'Amanda Oliveira', '2003-07-05', 'Filho', '90123456789'),
('04832647324', 'Laura Oliveira', '2011-01-30', 'Filha', '90123456789'),
('00000003123', 'Camila Pereira', '1999-08-18', 'Cônjuge', '01234567890'),
('00031231233', 'Daniel Pereira', '2006-04-03', 'Filha', '01234567890'),
('19847387999', 'Vitor Silva', '2008-12-12', 'Filho', '12345678901'),
('12938791283', 'Sophia Silva', '2015-06-20', 'Filha', '23456789012');

INSERT INTO `loja`.`Venda` (`Status_entrega`, `Funcionarios_CPF`, `valor`, `Cliente_CPF`, `Produto_Cd_Produto`,`Quantidade`, `Dt_compra`) VALUES
('Entregue', '12345678901', 299.99, '11111111111', 1, 1, '2023-11-21 08:30:00'),
('Pendente', '12345678901', 539.97, '22222222222', 2, 3, '2023-11-21 12:45:00'),
('Entregue', '12345678901', 659.98, '33333333333', 3, 2, '2023-11-22 10:15:00'),
('Entregue', '12345678901', 1199.97, '11111111111', 5, 3, '2023-11-22 15:00:00'),
('Pendente', '12345678901', 254.97, '22222222222', 8, 3, '2023-11-23 09:20:00'),
('Entregue', '89012345678', 399.98, '33333333333', 9, 2, '2023-11-23 14:30:00'),
('Entregue', '89012345678', 899.97, '11111111111', 1, 3, '2023-11-24 11:45:00'),
('Pendente', '89012345678', 259.99, '22222222222', 10, 1, '2023-11-24 16:00:00'),
('Entregue', '89012345678', 1499.97,'33333333333', 17, 3, '2023-11-25 13:10:00'),
('Entregue', '89012345678', 239.99, '11111111111', 20, 1, '2023-11-25 17:45:00');

INSERT INTO `Forma_pagamento` (`Tipo`, `Parcelas`, `Venda_Cd_Venda`) VALUES
('Cartão de Crédito', 3, 1),
('Cartão de Débito', 1, 2),
('Cartão de Crédito', 8, 3),
('Cartão de Débito', 1, 4),
('Cartão de Débito', 1, 5),
('Cartão de Crédito', 3, 6),
('PIX', 1, 7),
('PIX', 1, 8),
('PIX', 1, 9),
('Cartão de Crédito', 2, 10);

----------------------------------------------------------
-- Delete/update
----------------------------------------------------------

-- Deletar um fornecedor pelo CPF/CNPJ:
DELETE FROM Fornecedor WHERE `CPF/CNPJ` = '12345678901';

-- Atualizar o email do fornecedor Zara:
UPDATE Fornecedor SET Email = 'emailzara@email.com' WHERE Nome = 'Zara';

-- Deletar um produto pelo código:
DELETE FROM Produto WHERE Cd_Produto = 1;

-- Atualizar o preço da camisa H&M:
UPDATE Produto SET Preco = 219.99 WHERE Nome = 'H&M Camisa';

-- Deletar uma promoção pelo valor do desconto:
DELETE FROM `Desconto/Promocao` WHERE `Valor do desconto` = 29.99;

-- Atualizar o percentual de desconto de uma promoção:
UPDATE `Desconto/Promocao` SET Porcentagem = 25 WHERE `Valor do desconto` = 49.49;

-- Deletar uma categoria de produto pelo nome:
DELETE FROM Categoria_Produto WHERE Nome = 'Jeans';

-- Atualizar o sexo da categoria de produto Vestido:
UPDATE Categoria_Produto SET Sexo = 'F' WHERE Nome = 'Vestido';

-- Deletar um cliente pelo CPF:
DELETE FROM Cliente WHERE CPF = '11111111111';

-- Atualizar o telefone de João Santos:
UPDATE Telefone SET Cd_Telefone = '31987654321' WHERE Cliente_CPF = '22222222222';

-- Deletar um funcionário pelo CPF:
DELETE FROM Funcionarios WHERE CPF = '45678901234';

-- Atualizar o salário de Pedro Pereira:
UPDATE Funcionarios SET Salario = 4000.00 WHERE Nome = 'Mariana Costa';

-- Deletar um endereço pelo CEP:
DELETE FROM Endereco WHERE CEP = '12345678';

-- Atualizar o complemento do endereço de Carla Oliveira:
UPDATE Endereco SET Complemento = 'Apto 303' WHERE Funcionarios_CPF = '34567890123';

-- Deletar um telefone pelo número:
DELETE FROM Telefone WHERE Cd_Telefone = '21987654321';

-- Atualizar a quantidade de um produto no estoque:
UPDATE Estoque SET Quantidade = 60 WHERE Produto_Cd_Produto = 1;

-- Deletar uma venda pelo código:
DELETE FROM Venda WHERE Cd_Venda = 1;

-- Atualizar o status de entrega da segunda venda:
UPDATE Venda SET Status_entrega = 'Entregue' WHERE Cd_Venda = 2;

-- Deletar uma forma de pagamento pelo tipo:
DELETE FROM Forma_pagamento WHERE Tipo = 'PIX';

-- Atualizar o número de parcelas de uma forma de pagamento:
UPDATE Forma_pagamento SET Parcelas = 4 WHERE Tipo = 'Cartão de Crédito';

-- Deletar um dependente pelo CPF:
DELETE FROM Dependente WHERE CPF = '13131313131';

-- Atualizar o nome de um dependente:
UPDATE Dependente SET Nome = 'Ana Silva Jr. Atualizado' WHERE CPF = '13131313131';

-- Deletar um período de férias pelo código:
DELETE FROM Ferias WHERE Cod_Férias = 1;

-- Atualizar a quantidade de dias de férias:
UPDATE Ferias SET QtdDias = 20 WHERE Cod_Férias = 2;

-- Deletar um produto do estoque:
DELETE FROM Estoque WHERE Produto_Cd_Produto = 2;

----------------------------------------------------------
-- consultas/perguntas/relatórios 
----------------------------------------------------------

-- Listar todos os produtos com seus preços:
SELECT Cd_Produto, Nome, Preco
FROM Produto;

SELECT P.Nome, DP.`Valor do desconto`, DP.Porcentagem, DP.Dt_ini, DP.Dt_fim
FROM Produto P
JOIN `Desconto/Promocao` DP ON P.Cd_Produto = DP.Produto_Cd_Produto
WHERE NOW() BETWEEN DP.Dt_ini AND DP.Dt_fim;

SELECT P.Cd_Produto, P.Nome, E.Quantidade
FROM Produto P
JOIN Estoque E ON P.Cd_Produto = E.Produto_Cd_Produto;

SELECT P.Nome, CP.Nome as Categoria
FROM Produto P
JOIN Categoria_Produto CP ON P.Cd_Produto = CP.Produto_Cd_Produto
WHERE CP.Nome = 'Bolsa';

SELECT V.Cd_Venda, V.Cliente_CPF, V.Funcionarios_CPF
FROM Venda V
WHERE V.Funcionarios_CPF = '12345678901';

SELECT P.Nome, E.Quantidade
FROM Produto P
JOIN Estoque E ON P.Cd_Produto = E.Produto_Cd_Produto
WHERE E.Quantidade < 30;

SELECT DISTINCT F.Nome, D.Nome as Dependente
FROM Funcionarios F
JOIN Dependente D ON F.CPF = D.Funcionarios_CPF;

SELECT CP.Nome as Categoria, SUM(V.Quantidade) as Quantidade_Total
FROM Categoria_Produto CP
JOIN Produto P ON CP.Produto_Cd_Produto = P.Cd_Produto
JOIN Venda V ON P.Cd_Produto = V.Produto_Cd_Produto
GROUP BY CP.Nome;

SELECT V.Produto_Cd_Produto, P.Nome
FROM Venda V
JOIN Produto P ON V.Produto_Cd_Produto = P.Cd_Produto
WHERE V.Cliente_CPF = '11111111111';

SELECT P.Nome, DP.Porcentagem
FROM Produto P
JOIN `Desconto/Promocao` DP ON P.Cd_Produto = DP.Produto_Cd_Produto
WHERE DP.Porcentagem > 15;

SELECT C.Nome
FROM Cliente C
LEFT JOIN Venda V ON C.CPF = V.Cliente_CPF
WHERE V.Cd_Venda IS NULL;

SELECT P.Nome, SUM(V.Quantidade) as Quantidade_Vendida
FROM Produto P
JOIN Venda V ON P.Cd_Produto = V.Produto_Cd_Produto
GROUP BY P.Nome
ORDER BY Quantidade_Vendida DESC
LIMIT 10;

SELECT V.Cd_Venda, V.Cliente_CPF, V.Produto_Cd_Produto, P.Nome as Produto, DP.Porcentagem
FROM Venda V
JOIN Produto P ON V.Produto_Cd_Produto = P.Cd_Produto
JOIN `Desconto/Promocao` DP ON P.Cd_Produto = DP.Produto_Cd_Produto;

SELECT C.Nome AS Nome_Cliente, SUM(V.valor) AS Total_Gasto
FROM Cliente C
JOIN Venda V ON C.CPF = V.Cliente_CPF
GROUP BY C.CPF
ORDER BY Total_Gasto DESC;

SELECT SUM(V.valor) AS Receita_Total
FROM Venda V
WHERE V.Dt_compra BETWEEN '2023-01-01' AND '2023-12-31';

SELECT F.Nome AS Nome_Funcionario, Ferias.Dt_ini, Ferias.Dt_fim
FROM Funcionarios F
JOIN Ferias ON F.CPF = Ferias.Funcionarios_CPF
WHERE Ferias.Dt_ini <= CURDATE() AND Ferias.Dt_fim >= CURDATE();

SELECT P.Cd_Produto, P.Nome AS Nome_Produto, CP.Nome AS Categoria, CP.Sexo, CP.Marca
FROM Produto P
JOIN Categoria_Produto CP ON P.Cd_Produto = CP.Produto_Cd_Produto;
  
SELECT C.Nome AS ClienteNome, COUNT(V.Cd_Venda) AS TotalCompras
FROM Cliente C
LEFT JOIN Venda V ON C.CPF = V.Cliente_CPF
WHERE V.Dt_compra >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY C.CPF;

SELECT FP.Tipo, COUNT(V.Cd_Venda) AS TotalVendas
FROM Forma_pagamento FP
JOIN Venda V ON FP.Venda_Cd_Venda = V.Cd_Venda
GROUP BY FP.Tipo;

SELECT AVG(YEAR(CURDATE()) - YEAR(Data_Nascimento)) AS Media_idade
FROM Cliente;


SELECT F.Nome AS FuncionarioNome, COUNT(V.Cd_Venda) AS TotalVendas
FROM Funcionarios F
LEFT JOIN Venda V ON F.CPF = V.Funcionarios_CPF
GROUP BY F.CPF;

----------------------------------------------------------
-- View's
----------------------------------------------------------

-- Relatório de Vendas por Funcionário:
CREATE VIEW VendasPorFuncionario AS
SELECT
    f.CPF AS Funcionario_CPF,
    f.Nome AS Funcionario_Nome,
    COUNT(v.Cd_Venda) AS Quantidade_Vendas,
    SUM(v.valor) AS Total_Vendas
FROM
    Funcionarios f
    JOIN Venda v ON f.CPF = v.Funcionarios_CPF
GROUP BY
    f.CPF, f.Nome;
    
-- Relatório de Vendas por Cliente:
CREATE VIEW VendasPorCliente AS
SELECT
    c.CPF AS Cliente_CPF,
    c.Nome AS Cliente_Nome,
    COUNT(v.Cd_Venda) AS Quantidade_Compras,
    SUM(v.valor) AS Total_Gasto
FROM
    Cliente c
    JOIN Venda v ON c.CPF = v.Cliente_CPF
GROUP BY
    c.CPF, c.Nome;
    
-- Relatório de Produtos em Estoque:
CREATE VIEW ProdutosEmEstoque AS
SELECT
    p.Cd_Produto,
    p.Nome AS Nome_Produto,
    e.Quantidade AS Quantidade_Estoque,
    e.Local AS Local_Armazenamento
FROM
    Produto p
    JOIN Estoque e ON p.Cd_Produto = e.Produto_Cd_Produto;
    
-- Relatório de Vendas por Categoria de Produto:
CREATE VIEW VendasPorCategoria AS
SELECT
    cp.Nome AS Categoria,
    COUNT(v.Cd_Venda) AS Quantidade_Vendas,
    SUM(v.valor) AS Total_Vendas
FROM
    Categoria_Produto cp
    JOIN Produto p ON cp.Produto_Cd_Produto = p.Cd_Produto
    JOIN Venda v ON p.Cd_Produto = v.Produto_Cd_Produto
GROUP BY
    cp.Nome;
    
-- Relatório de Descontos e Promoções:
CREATE VIEW DescontosPromocoes AS
SELECT
    p.Nome AS Nome_Produto,
    dp.`Valor do desconto` AS Valor_Desconto,
    dp.Porcentagem AS Porcentagem_Desconto,
    dp.Dt_ini AS Data_Inicio,
    dp.Dt_fim AS Data_Fim
FROM
    `Desconto/Promocao` dp
    JOIN Produto p ON dp.Produto_Cd_Produto = p.Cd_Produto;
    
    
-- Relatório de Funcionários com Dependentes:
CREATE VIEW FuncionariosComDependentes AS
SELECT
    f.CPF AS Funcionario_CPF,
    f.Nome AS Funcionario_Nome,
    d.CPF AS Dependente_CPF,
    d.Nome AS Dependente_Nome,
    d.Parentesco
FROM
    Funcionarios f
    JOIN Dependente d ON f.CPF = d.Funcionarios_CPF;
    
-- Relatório de Férias Agendadas:

CREATE VIEW FeriasAgendadas AS
SELECT
    f.Cod_Férias,
    f.ano,
    f.Dt_ini AS Data_Inicio,
    f.Dt_fim AS Data_Fim,
    f.QtdDias,
    fu.CPF AS Funcionario_CPF,
    fu.Nome AS Funcionario_Nome
FROM
    Ferias f
    JOIN Funcionarios fu ON f.Funcionarios_CPF = fu.CPF;
    
-- Relatório de Vendas por Período:
CREATE VIEW VendasPorPeriodo AS
SELECT
    DATE(v.Dt_compra) AS Data_Compra,
    COUNT(v.Cd_Venda) AS Quantidade_Vendas,
    SUM(v.valor) AS Total_Vendas
FROM
    Venda v
GROUP BY
    DATE(v.Dt_compra);
    
-- Relatório de Vendas por Forma de Pagamento:

CREATE VIEW VendasPorFormaPagamento AS
SELECT
    fp.Tipo AS Forma_Pagamento,
    COUNT(v.Cd_Venda) AS Quantidade_Vendas,
    SUM(v.valor) AS Total_Vendas
FROM
    Forma_pagamento fp
    JOIN Venda v ON fp.Venda_Cd_Venda = v.Cd_Venda
GROUP BY
    fp.Tipo;
    
-- Relatório de Clientes por Cidade:

CREATE VIEW ClientesPorCidade AS
SELECT
    e.Cidade,
    COUNT(c.CPF) AS Quantidade_Clientes
FROM
    Endereco e
    JOIN Cliente c ON e.Cliente_CPF = c.CPF
GROUP BY
    e.Cidade;
    
    
----------------------------------------------------------
-- Procedures
----------------------------------------------------------
-- ATUALIZAR PRODUTO 
DELIMITER //
CREATE PROCEDURE Atlproduto(IN produtoID INT, 
IN novoNome VARCHAR(50))
BEGIN
    UPDATE Produto
    SET Nome = novoNome
    WHERE Cd_Produto = produtoID;
    SELECT Nome, Preco
    FROM Produto
    WHERE Cd_Produto = produtoID;
    UPDATE Estoque
    SET Quantidade = Quantidade - 1
    WHERE Produto_Cd_Produto = produtoID;
    SELECT Cd_Produto, Nome, Preco
    FROM Produto
    WHERE Cd_Produto = produtoID;
END //
------------------------------------------------------


-- ATUALIZAR CATEGORIA DE PRODUTO 
DELIMITER //
CREATE PROCEDURE AtlctgProduto(IN produtoID INT, IN novaCategoria VARCHAR(25))
BEGIN
    UPDATE Categoria_Produto
    SET Nome = novaCategoria
    WHERE Produto_Cd_Produto = produtoID;
    SELECT Produto.Nome AS NomeProduto, Categoria_Produto.Nome AS NovaCategoria
    FROM Produto
    INNER JOIN Categoria_Produto ON Produto.Cd_Produto = Categoria_Produto.Produto_Cd_Produto
    WHERE Produto.Cd_Produto = produtoID;
    SELECT Produto.Nome AS NomeProduto, Categoria_Produto.Nome AS Categoria, Categoria_Produto.Sexo, Categoria_Produto.Marca
    FROM Produto
    INNER JOIN Categoria_Produto ON Produto.Cd_Produto = Categoria_Produto.Produto_Cd_Produto
    WHERE Produto.Cd_Produto = produtoID;
    SELECT Produto.Cd_Produto, Produto.Nome AS NomeProduto, Categoria_Produto.Nome AS NovaCategoria
    FROM Produto
    INNER JOIN Categoria_Produto ON Produto.Cd_Produto = Categoria_Produto.Produto_Cd_Produto
    WHERE Produto.Cd_Produto = produtoID;
END //
------------------------------------------------------------

-- ATUALIZAR DESCRIÇÃO DO PRODUTO 
DELIMITER //
CREATE PROCEDURE AtlDescProduto(IN produtoID INT, IN novaDescricao TEXT)
BEGIN
    UPDATE Produto
    SET Descricao = novaDescricao
    WHERE Cd_Produto = produtoID;
    SELECT Descricao
    FROM Produto
    WHERE Cd_Produto = produtoID;
    UPDATE Estoque
    SET Quantidade = Quantidade - 1
    WHERE Produto_Cd_Produto = produtoID;
    SELECT Cd_Produto, Nome, Preco, Descricao
    FROM Produto
    WHERE Cd_Produto = produtoID;
END //
---------------------------------------------------------------

-- ATUALIZAR QAUNTAIDADE DE PRODUTOS DA LOJA 
DELIMITER //
CREATE PROCEDURE AtlQtdProduto(IN produtoID INT, IN novaQuantidade INT)
BEGIN
    UPDATE Estoque
    SET Quantidade = novaQuantidade
    WHERE Produto_Cd_Produto = produtoID;
    SELECT Produto.Nome AS NomeProduto, Estoque.Quantidade AS NovaQuantidade
    FROM Produto
    INNER JOIN Estoque ON Produto.Cd_Produto = Estoque.Produto_Cd_Produto
    WHERE Produto.Cd_Produto = produtoID;
    SELECT Produto.Nome AS NomeProduto, Estoque.Quantidade, Estoque.Local, Estoque.Dt_entrada
    FROM Produto
    INNER JOIN Estoque ON Produto.Cd_Produto = Estoque.Produto_Cd_Produto
    WHERE Produto.Cd_Produto = produtoID;
    SELECT Produto.Cd_Produto, Produto.Nome AS NomeProduto, Estoque.Quantidade AS NovaQuantidade
    FROM Produto
    INNER JOIN Estoque ON Produto.Cd_Produto = Estoque.Produto_Cd_Produto
    WHERE Produto.Cd_Produto = produtoID;
END //
------------------------------------------------------------

-- ATUALIZAR O PESO DE CADA PRODUTO 
DELIMITER //
CREATE PROCEDURE AtlPsProduto(IN produtoID INT, IN novoPeso DECIMAL(10, 2))
BEGIN
    UPDATE Produto
    SET Peso = novoPeso
    WHERE Cd_Produto = produtoID;
    SELECT Nome, Preco
    FROM Produto
    WHERE Cd_Produto = produtoID;
    UPDATE Estoque
    SET Quantidade = Quantidade - 1
    WHERE Produto_Cd_Produto = produtoID;
    SELECT Cd_Produto, Nome, Peso
    FROM Produto
    WHERE Cd_Produto = produtoID;
END //
--------------------------------------------------------------------------

-- ATUALIZAR PREÇO DO PRODUTO 
DELIMITER //
CREATE PROCEDURE AtlPrecoProduto(IN produtoID INT, IN novoPreco DECIMAL(10, 2))
BEGIN
    UPDATE Produto
    SET Preco = novoPreco
    WHERE Cd_Produto = produtoID;
    SELECT Nome, Preco
    FROM Produto
    WHERE Cd_Produto = produtoID;
    UPDATE Estoque
    SET Quantidade = Quantidade - 1
    WHERE Produto_Cd_Produto = produtoID;
    SELECT Cd_Produto, Nome, Preco
    FROM Produto
    WHERE Cd_Produto = produtoID;
END //
-- 
CALL Atlproduto(1, ' NOVO');
CALL AtlctgProduto(6, 'KIDS');
CALL AtlDescProduto(3, 'aaaaaaaaaaaaa');
CALL AtlQtdProduto(5, 50);
CALL AtlPsProduto(5, 2.5);
CALL AtlPrecoProduto(3, 229.99);


SHOW PROCEDURE STATUS;

----------------------------------------------------------
-- Functions
----------------------------------------------------------
-- idade cliente
DELIMITER //

CREATE FUNCTION CalcularIdadeCliente(clienteCPF VARCHAR(11)) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE idade INT;

    SELECT YEAR(CURDATE()) - YEAR(Data_Nascimento) - (RIGHT(CURDATE(), 5) < RIGHT(Data_Nascimento, 5))
    INTO idade
    FROM Cliente
    WHERE CPF = clienteCPF;

    RETURN idade;
END //

DELIMITER ;

SET @cpfCliente = '00000000000'; 

SELECT CalcularIdadeCliente(@cpfCliente) AS IdadeCliente;
 
 
 ---------------------------------------------------------------
 -- idade funcionario
DELIMITER //

CREATE FUNCTION CalcularIdadeFuncionarios(FuncionariosCPF VARCHAR(11)) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE idade INT;

    SELECT YEAR(CURDATE()) - YEAR(Datadenasc) - (RIGHT(CURDATE(), 5) < RIGHT(Datadenasc, 5))
    INTO idade
    FROM funcionarios
    WHERE CPF = funcionariosCPF;

    RETURN idade;
END //
DELIMITER ;


SET @cpfFuncionarios = '34567890123'; 

SELECT CalcularIdadeFuncionarios(@cpffuncionarios) AS IdadeFuncionarios;

--------------------------------------
-- idade dependente
DELIMITER //
CREATE FUNCTION CalcularIdadedependente(dependenteCPF VARCHAR(11)) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE idade INT;

    SELECT YEAR(CURDATE()) - YEAR(Dt_nasc) - (RIGHT(CURDATE(), 5) < RIGHT(Dt_nasc, 5))
    INTO idade
    FROM dependente
    WHERE CPF = dependenteCPF;

    RETURN idade;
END //
DELIMITER ;

SET @cpfdependente = '21212121212'; 

SELECT CalcularIdadedependente(@cpfdependente) AS Idadedependente;

--------------------------------------
-- TEMPO DE EMPRESA EM DIAS

DELIMITER //

CREATE FUNCTION TempoDeEmpresa(CPF_funcionario VARCHAR(11))RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE data_admissao DATE;
    DECLARE data_saida DATE;
    DECLARE tempo_empresa INT;

    SELECT Dt_adm, Dt_saida INTO data_admissao, data_saida
    FROM loja.Funcionarios
    WHERE CPF = CPF_funcionario;

    IF data_saida IS NOT NULL THEN
        SET tempo_empresa = DATEDIFF(data_saida, data_admissao);
    ELSE
        SET tempo_empresa = DATEDIFF(CURDATE(), data_admissao);
    END IF;

    RETURN tempo_empresa;
END //

DELIMITER ;

SELECT TempoDeEmpresa('12345678901') AS TempoDeServico;

----------------------------------------------------
-- TEMPO DA VENDA 

-- Criação da função para calcular o tempo de uma venda em dias
DELIMITER //
CREATE FUNCTION TempodaVenda(venda_id INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE tempo_em_dias INT;

    SELECT DATEDIFF(NOW(), `Dt_compra`)
    INTO tempo_em_dias
    FROM `loja`.`Venda`
    WHERE `Cd_Venda` = venda_id;

    RETURN tempo_em_dias;
END //
DELIMITER ;

-- Exemplo de uso da função (substitua '1' pelo ID da venda desejada)
SELECT TempodaVenda(2) AS TempoEmDias;

--------------------------------------------------------------------------
-- calculo do transporte

delimiter $$
create function calcINSS(sb decimal(7,2)) 
	returns decimal(7,2) DETERMINISTIC
    begin
		declare inss decimal(7,2);
		if sb <= 1302 then set inss = sb * 0.075;
		elseif sb >= 1302.01 and sb <= 2571.29 then set inss = sb * 0.09;
        elseif sb >= 2571.30 and sb <= 3856.94 then set inss = sb * 0.12;
        elseif sb >= 3856.95 and sb <= 7507.49 then set inss = sb * 0.14;
        else set inss = 7507.50 * 0.14;
        end if;
		return inss;
    end $$
delimiter ;

SELECT calcINSS(1500) AS result1;

----------------------------------------------------------
-- TRIGGERS
------------------------------------------------------------

-- UPDATE FÉRIAS
DELIMITER //
CREATE TRIGGER UpdateFerias
BEFORE UPDATE ON Ferias
FOR EACH ROW
BEGIN
    IF DAYOFWEEK(NEW.Dt_ini) = 3 OR DAYOFWEEK(NEW.Dt_fim) = 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é permitido atualizar as férias em uma terça-feira.';
    END IF;
END //
DELIMITER ;

UPDATE Ferias SET Dt_ini = '2023-01-04', Dt_fim = '2023-01-10' WHERE Cod_Férias = 1;

-- DELETAR PRODUTO POR QUANTIDADE 
DELIMITER //
CREATE TRIGGER dropProduto
BEFORE DELETE ON Estoque
FOR EACH ROW
BEGIN
    DECLARE quantidade_atual INT;

    SELECT Quantidade INTO quantidade_atual
    FROM Estoque
    WHERE Produto_Cd_Produto = OLD.Produto_Cd_Produto;

    IF quantidade_atual < 30 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é permitido excluir produtos com quantidade inferior a 30 em estoque.';
    END IF;
END //
DELIMITER ;

DELETE FROM Estoque WHERE Produto_Cd_Produto = 3;

-- validação de de nome e cpf

DELIMITER //
CREATE TRIGGER validacao_nomecpf
BEFORE INSERT ON cliente

FOR EACH ROW
BEGIN
    IF LENGTH(NEW.Nome) < 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Nome deve ter pelo menos 10 caracteres';
    END IF;

    IF NOT NEW.CPF REGEXP '^[0-9]{11}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: CPF inválido';
    END IF;
END //
DELIMITER ;

INSERT INTO cliente (Nome, CPF) VALUES ('Maria', '12345678901');
INSERT INTO cliente (Nome, CPF) VALUES ('Maria Giovanna ', '1234A567890');

-- Forma de Pagamento 
DELIMITER //
CREATE TRIGGER LForma_pagamento
BEFORE INSERT ON loja.Forma_pagamento
FOR EACH ROW
BEGIN
  IF NEW.Parcelas > 5 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Não é permitido parcelar essa compra mais que 5 vezes.';
  END IF;
END //
DELIMITER ;

INSERT INTO loja.Forma_pagamento (Tipo, Parcelas, Venda_Cd_Venda) VALUES ('Cartão de Crédito', 9, 11);

-- inserção do produto
DELIMITER //
CREATE TRIGGER InsertProduto
BEFORE INSERT ON loja.Produto FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM loja.Produto WHERE Cd_Produto = NEW.Cd_Produto) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Código de produto duplicado.';
    END IF;
END //
DELIMITER ;

INSERT INTO `loja`.`Produto` (`Cd_Produto`, `Nome`, `Preco`, `Tamanho`, `Cor`, `Marca`, `Peso`, `Fornecedor_CPF/CNPJ`) VALUES
(1, 'Zara Jeans', 299.99, 40, 'Azul', 'Zara', 1.2, '12345678901');

-- INSERIR CLIENTES MAIORES DE 18 ANOS
DELIMITER //

CREATE TRIGGER addCliente
BEFORE INSERT ON loja.Cliente
FOR EACH ROW
BEGIN
    DECLARE cliente_idade INT;
    SET cliente_idade = TIMESTAMPDIFF(YEAR, NEW.Data_Nascimento, CURDATE());

    IF cliente_idade < 18 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é permitido cadastrar clientes menores de 18  anos.';
    END IF;
END //
DELIMITER ;

INSERT INTO loja.Cliente (CPF, Nome, Email, Telefone_Comercial, Data_Nascimento)
VALUES ('12345678901', 'Enzo Santos', 'Enzoantos@email.com', '72927389042', '2008-01-01');

----------------------------------------------------------
-- Drop´s
----------------------------------------------------------

DROP TABLE IF EXISTS `loja`.`Férias` ;
DROP TABLE IF EXISTS `loja`.`Dependente` ;
DROP TABLE IF EXISTS `loja`.`Forma_pagamento` ;
DROP TABLE IF EXISTS `loja`.`Venda` ;
DROP TABLE IF EXISTS `loja`.`Estoque` ;
DROP TABLE IF EXISTS `loja`.`Telefone` ;
DROP TABLE IF EXISTS `loja`.`Endereo` ;
DROP TABLE IF EXISTS `loja`.`Funcionarios` ;
DROP TABLE IF EXISTS `loja`.`Cliente` ;
DROP TABLE IF EXISTS `loja`.`Categoria_Produto` ;
DROP TABLE IF EXISTS `loja`.`Desconto/Promocao` ;
DROP TABLE IF EXISTS `loja`.`Produto` ;
DROP TABLE IF EXISTS `loja`.`Fornecedor` ;
DROP SCHEMA IF EXISTS `loja` ;

-- views 
DROP VIEW IF EXISTS VendasPorFuncionario;
DROP VIEW IF EXISTS VendasPorCliente;
DROP VIEW IF EXISTS ProdutosEmEstoque;
DROP VIEW IF EXISTS VendasPorCategoria;
DROP VIEW IF EXISTS DescontosPromocoes;
DROP VIEW IF EXISTS FuncionariosComDependentes;
DROP VIEW IF EXISTS FeriasAgendadas;
DROP VIEW IF EXISTS VendasPorPeriodo;
DROP VIEW IF EXISTS VendasPorFormaPagamento;
DROP VIEW IF EXISTS ClientesPorCidade;