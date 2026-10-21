-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 21/10/2026 às 03:32
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `estudio_tatuagem`
--
CREATE DATABASE IF NOT EXISTS `estudio_tatuagem` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `estudio_tatuagem`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `agendamento`
--

CREATE TABLE `agendamento` (
  `idagendamento` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `idtatuador` int(11) NOT NULL,
  `dataagendamento` date NOT NULL,
  `horaagendamento` time NOT NULL,
  `descricaotatuagem` text DEFAULT NULL,
  `desenhoaprovado` varchar(255) DEFAULT NULL,
  `valortatuagem` decimal(10,2) DEFAULT NULL,
  `status` enum('pendente','confirmado','concluido','cancelado') NOT NULL DEFAULT 'pendente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `agendamento`
--

INSERT INTO `agendamento` (`idagendamento`, `idcliente`, `idtatuador`, `dataagendamento`, `horaagendamento`, `descricaotatuagem`, `desenhoaprovado`, `valortatuagem`, `status`) VALUES
(1, 1, 1, '2025-04-30', '17:00:00', 'Mandala no braço', NULL, 420.00, 'pendente'),
(2, 2, 2, '2025-06-04', '10:00:00', 'Rosa aquarela no ombro', NULL, 240.00, 'pendente'),
(3, 9, 4, '2024-11-14', '11:00:00', 'Leão realista na coxa', NULL, 1080.00, 'cancelado'),
(4, 17, 2, '2025-02-14', '14:00:00', 'Olho realista no antebraço', 'desenho_004.png', 600.00, 'concluido'),
(5, 23, 7, '2025-04-06', '09:00:00', 'Relógio com rosas realista', 'desenho_005.png', 520.00, 'concluido'),
(6, 17, 2, '2025-04-29', '09:00:00', 'Paisagem aquarela no ombro', NULL, 400.00, 'cancelado'),
(7, 4, 3, '2025-04-12', '11:00:00', 'Geométrico no antebraço', 'desenho_007.png', 220.00, 'concluido'),
(8, 23, 8, '2025-05-06', '16:00:00', 'Paisagem aquarela no ombro', 'desenho_008.png', 460.00, 'concluido'),
(9, 4, 8, '2025-06-04', '16:00:00', 'Paisagem aquarela no ombro', 'desenho_009.png', 520.00, 'concluido'),
(10, 22, 8, '2025-07-19', '14:00:00', 'Paisagem aquarela no ombro', 'desenho_010.png', 460.00, 'concluido'),
(11, 7, 7, '2025-08-17', '13:00:00', 'Relógio com rosas realista', 'desenho_011.png', 780.00, 'concluido'),
(12, 18, 5, '2025-08-30', '15:00:00', 'Tribal moderno no ombro', 'desenho_012.png', 510.00, 'concluido'),
(13, 17, 7, '2025-09-02', '13:00:00', 'Fechamento de braço blackwork', 'desenho_013.png', 1080.00, 'concluido'),
(14, 25, 6, '2025-08-26', '13:00:00', 'Floral em linhas finas na costela', 'desenho_014.png', 310.00, 'concluido'),
(15, 7, 2, '2025-09-14', '13:00:00', 'Retrato realista de cachorro no braço', NULL, 840.00, 'cancelado'),
(16, 11, 7, '2025-09-27', '15:00:00', 'Floral em linhas finas na costela', 'desenho_016.png', 260.00, 'concluido'),
(17, 13, 8, '2025-08-28', '11:00:00', 'Beija-flor aquarela na costela', 'desenho_017.png', 550.00, 'concluido'),
(18, 12, 5, '2025-10-18', '14:00:00', 'Fechamento de braço blackwork', 'desenho_018.png', 1400.00, 'concluido'),
(19, 10, 1, '2025-09-26', '17:00:00', 'Floral em linhas finas na costela', 'desenho_019.png', 340.00, 'concluido'),
(20, 16, 8, '2025-11-11', '17:00:00', 'Relógio com rosas realista', 'desenho_020.png', 670.00, 'concluido'),
(21, 16, 5, '2025-10-25', '13:00:00', 'Andorinhas old school no peito', 'desenho_021.png', 510.00, 'concluido'),
(22, 16, 2, '2025-12-03', '17:00:00', 'Peônia aquarela no antebraço', 'desenho_022.png', 360.00, 'concluido'),
(23, 12, 8, '2025-12-21', '16:00:00', 'Paisagem aquarela no ombro', 'desenho_023.png', 640.00, 'concluido'),
(24, 11, 2, '2025-12-16', '16:00:00', 'Peônia aquarela no antebraço', 'desenho_024.png', 480.00, 'concluido'),
(25, 23, 4, '2026-01-07', '10:00:00', 'Olho realista no antebraço', NULL, 550.00, 'cancelado'),
(26, 15, 7, '2026-02-23', '15:00:00', 'Leão realista na coxa', 'desenho_026.png', 990.00, 'concluido'),
(27, 15, 6, '2026-02-28', '11:00:00', 'Floral em linhas finas na costela', 'desenho_027.png', 210.00, 'concluido'),
(28, 5, 3, '2026-02-18', '14:00:00', 'Tribal moderno no ombro', 'desenho_028.png', 220.00, 'concluido'),
(29, 4, 7, '2026-03-01', '16:00:00', 'Dotwork lua e montanhas na panturrilha', 'desenho_029.png', 340.00, 'concluido'),
(30, 20, 7, '2026-03-10', '09:00:00', 'Olho realista no antebraço', NULL, 550.00, 'cancelado'),
(31, 19, 5, '2026-03-12', '16:00:00', 'Andorinhas old school no peito', 'desenho_031.png', 510.00, 'concluido'),
(32, 25, 6, '2026-04-14', '16:00:00', 'Tribal moderno no ombro', 'desenho_032.png', 310.00, 'concluido'),
(33, 7, 4, '2026-04-09', '13:00:00', 'Borboleta aquarela na panturrilha', 'desenho_033.png', 340.00, 'concluido'),
(34, 12, 5, '2026-03-20', '15:00:00', 'Dotwork lua e montanhas na panturrilha', 'desenho_034.png', 440.00, 'concluido'),
(35, 26, 2, '2026-04-28', '10:00:00', 'Borboleta aquarela na panturrilha', 'desenho_035.png', 220.00, 'concluido'),
(36, 3, 8, '2026-04-15', '16:00:00', 'Olho realista no antebraço', 'desenho_036.png', 520.00, 'concluido'),
(37, 13, 6, '2026-05-21', '16:00:00', 'Geométrico no antebraço', 'desenho_037.png', 290.00, 'concluido'),
(38, 27, 7, '2026-07-03', '17:00:00', 'Relógio com rosas realista', NULL, 580.00, 'cancelado'),
(39, 11, 2, '2026-07-15', '16:00:00', 'Borboleta aquarela na panturrilha', 'desenho_039.png', 310.00, 'concluido'),
(40, 25, 7, '2026-06-27', '10:00:00', 'Geométrico no antebraço', 'desenho_040.png', 270.00, 'concluido'),
(41, 16, 1, '2026-08-19', '11:00:00', 'Olho realista no antebraço', 'desenho_041.png', 520.00, 'concluido'),
(42, 28, 4, '2026-07-30', '17:00:00', 'Paisagem aquarela no ombro', 'desenho_042.png', 400.00, 'concluido'),
(43, 29, 7, '2026-08-27', '09:00:00', 'Retrato realista de cachorro no braço', 'desenho_043.png', 560.00, 'concluido'),
(44, 14, 7, '2026-08-06', '15:00:00', 'Olho realista no antebraço', 'desenho_044.png', 550.00, 'concluido'),
(45, 21, 2, '2026-09-14', '14:00:00', 'Leão realista na coxa', 'desenho_045.png', 1080.00, 'concluido'),
(46, 32, 1, '2026-09-27', '16:00:00', 'Retrato realista de cachorro no braço', 'desenho_046.png', 1090.00, 'concluido'),
(47, 5, 3, '2026-08-26', '10:00:00', 'Floral em linhas finas na costela', 'desenho_047.png', 210.00, 'concluido'),
(48, 32, 8, '2026-10-12', '15:00:00', 'Retrato realista de cachorro no braço', 'desenho_048.png', 1000.00, 'confirmado'),
(49, 14, 8, '2026-10-18', '15:00:00', 'Peônia aquarela no antebraço', NULL, 420.00, 'pendente'),
(50, 23, 2, '2026-10-28', '17:00:00', 'Beija-flor aquarela na costela', 'desenho_050.png', 320.00, 'confirmado'),
(51, 17, 7, '2026-10-17', '10:00:00', 'Geométrico no antebraço', 'desenho_051.png', 270.00, 'confirmado'),
(52, 32, 6, '2026-10-24', '17:00:00', 'Tribal moderno no ombro', 'desenho_052.png', 340.00, 'confirmado');

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliente`
--

CREATE TABLE `cliente` (
  `idcliente` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cpf` char(11) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `datacadastro` date DEFAULT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  `uf` char(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `cliente`
--

INSERT INTO `cliente` (`idcliente`, `nome`, `cpf`, `telefone`, `datacadastro`, `cidade`, `uf`) VALUES
(1, 'Helena Duarte', '25098548101', '41914711939', '2024-01-05', 'Sorocaba', 'SP'),
(2, 'Gabriel Monteiro', '16630258436', '14914839545', '2024-04-21', 'Joinville', 'SC'),
(3, 'Sofia Coutinho', '20844185183', '48943300873', '2025-01-11', 'Natal', 'RN'),
(4, 'Thales Nogueira', '22878528409', '89937985702', '2024-05-04', 'João Pessoa', 'PB'),
(5, 'Laura Bittencourt', '34425714725', '71923503548', '2024-06-04', 'Londrina', 'PR'),
(6, 'Otávio Fonseca', '08231408142', '54991169985', '2024-11-24', 'Londrina', 'PR'),
(7, 'Manuela Rezende', '65845510406', '16986374930', '2025-05-06', 'Uberlândia', 'MG'),
(8, 'Arthur Vasconcelos', '96111210246', '43919467204', '2025-10-27', 'Sorocaba', 'SP'),
(9, 'Clara Figueiredo', '30276327799', '53999512865', '2024-02-11', 'Vitória', 'ES'),
(10, 'Bernardo Quintela', '73656912475', '88958391412', '2024-02-17', 'Juiz de Fora', 'MG'),
(11, 'Lívia Sampaio', '06844891393', '51988980162', '2025-01-19', 'Ribeirão Preto', 'SP'),
(12, 'Enzo Matos', '06519749508', '31936344187', '2025-06-09', 'Recife', 'PE'),
(13, 'Alice Cavalcante', '57948624910', '87911412590', '2025-05-24', 'Maceió', 'AL'),
(14, 'Davi Brandão', '52567065431', '97992403299', '2025-08-30', 'Vitória', 'ES'),
(15, 'Valentina Lacerda', '82181059721', '67965711255', '2025-02-07', 'Belém', 'PA'),
(16, 'Heitor Ribas', '26977235446', '85929964879', '2025-11-14', 'Fortaleza', 'CE'),
(17, 'Isis Peixoto', '32851711113', '89920626171', '2024-07-08', 'Recife', 'PE'),
(18, 'Miguel Tavares', '21144063000', '18972744009', '2025-02-27', 'Campo Grande', 'MS'),
(19, 'Antonella Freire', '28724378518', '93988784479', '2025-04-25', 'Cuiabá', 'MT'),
(20, 'Pedro Henrique Leal', '81053215800', '54980229098', '2025-10-14', 'Fortaleza', 'CE'),
(21, 'Yasmin Bezerra', '67648841886', '43946237712', '2025-05-13', 'Porto Velho', 'RO'),
(22, 'Samuel Aragão', '84903389570', '15996467211', '2024-10-11', 'Campo Grande', 'MS'),
(23, 'Melissa Esteves', '17117509058', '15945477463', '2024-05-18', 'Aracaju', 'SE'),
(24, 'Caetano Viana', '27508962826', '71928057715', '2024-10-01', 'Porto Velho', 'RO'),
(25, 'Emanuelle Galvão', '99042873507', '91976111572', '2025-05-15', 'Florianópolis', 'SC'),
(26, 'Joaquim Reis', '21876384999', '34923608360', '2025-08-29', 'Florianópolis', 'SC'),
(27, 'Rebeca Amaral', '62490967878', '93900992437', '2026-01-24', 'Natal', 'RN'),
(28, 'Kauê Sales', '01936949300', '24994611308', '2026-03-24', 'Joinville', 'SC'),
(29, 'Cecília Prates', '97494987207', '99924186551', '2026-07-22', 'Ribeirão Preto', 'SP'),
(30, 'Ruan Miranda', '15349214276', '75960860846', '2024-09-09', 'João Pessoa', 'PB'),
(31, 'Sabrina Ximenes', '61294069160', '27940234643', '2024-12-28', 'Cuiabá', 'MT'),
(32, 'Nicolas Barroso', '10032044224', '61908706313', '2026-08-22', 'Maceió', 'AL');

-- --------------------------------------------------------

--
-- Estrutura para tabela `estilo`
--

CREATE TABLE `estilo` (
  `idestilo` int(11) NOT NULL,
  `descricao` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `estilo`
--

INSERT INTO `estilo` (`idestilo`, `descricao`) VALUES
(1, 'Blackwork'),
(2, 'Aquarela'),
(3, 'Realismo'),
(4, 'Old School');

-- --------------------------------------------------------

--
-- Estrutura para tabela `senioridade`
--

CREATE TABLE `senioridade` (
  `idsenioridade` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `senioridade`
--

INSERT INTO `senioridade` (`idsenioridade`, `nome`) VALUES
(1, 'Júnior'),
(2, 'Pleno'),
(3, 'Sênior');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tatuador`
--

CREATE TABLE `tatuador` (
  `idtatuador` int(11) NOT NULL,
  `nometatuador` varchar(100) NOT NULL,
  `cpf` char(11) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `datacontratacao` date DEFAULT NULL,
  `idsenioridade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tatuador`
--

INSERT INTO `tatuador` (`idtatuador`, `nometatuador`, `cpf`, `email`, `telefone`, `datacontratacao`, `idsenioridade`) VALUES
(1, 'Théo Lacerda', '21788020367', 'theo.lacerda@exemplo.com', '92949456957', '2020-06-19', 3),
(2, 'Bianca Ferrão', '47985589821', 'bianca.ferrao@exemplo.com', '48962192992', '2022-05-08', 2),
(3, 'Lorenzo Pimentel', '20554889021', 'lorenzo.pimentel@exemplo.com', '62901353992', '2023-12-04', 1),
(4, 'Cauã Oliveira', '34300244049', 'caua.oliveira@exemplo.com', '45934096164', '2021-09-07', 2),
(5, 'Débora Nascimento', '98192123839', 'debora.nascimento@exemplo.com', '48941567941', '2019-04-26', 3),
(6, 'Wellington Sá', '39782496502', 'wellington.sa@exemplo.com', '62954884103', '2025-05-04', 1),
(7, 'Priscila Moura', '26058727260', 'priscila.moura@exemplo.com', '82927397086', '2022-12-19', 2),
(8, 'Tiago Aguiar', '36912202152', 'tiago.aguiar@exemplo.com', '53904515477', '2018-06-25', 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tatuador_estilo`
--

CREATE TABLE `tatuador_estilo` (
  `idtatuador` int(11) NOT NULL,
  `idestilo` int(11) NOT NULL,
  `dataestilo` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tatuador_estilo`
--

INSERT INTO `tatuador_estilo` (`idtatuador`, `idestilo`, `dataestilo`) VALUES
(1, 1, '2020-03-01'),
(1, 3, '2021-05-10'),
(2, 2, '2022-06-15'),
(2, 3, '2023-02-20'),
(3, 1, '2025-02-15'),
(3, 4, '2024-01-10'),
(4, 2, '2021-09-20'),
(4, 3, '2022-11-05'),
(5, 1, '2020-07-18'),
(5, 4, '2019-02-11'),
(6, 1, '2025-03-03'),
(7, 1, '2024-06-10'),
(7, 3, '2023-04-17'),
(8, 2, '2018-08-06'),
(8, 3, '2019-10-14');

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `tipo` enum('admin','funcionario','cliente') NOT NULL DEFAULT 'funcionario',
  `idcliente` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nome`, `email`, `senha`, `tipo`, `idcliente`) VALUES
(1, 'Administrador Teste', 'admin@exemplo.com', '$2b$12$RY9VqBgwLd7ee0Csw1AfFulLOgk3eQ4WDqz57pb9ziIoraSNTQofa', 'admin', NULL);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `agendamento`
--
ALTER TABLE `agendamento`
  ADD PRIMARY KEY (`idagendamento`),
  ADD KEY `idcliente` (`idcliente`),
  ADD KEY `idtatuador` (`idtatuador`);

--
-- Índices de tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`idcliente`),
  ADD UNIQUE KEY `cpf` (`cpf`);

--
-- Índices de tabela `estilo`
--
ALTER TABLE `estilo`
  ADD PRIMARY KEY (`idestilo`);

--
-- Índices de tabela `senioridade`
--
ALTER TABLE `senioridade`
  ADD PRIMARY KEY (`idsenioridade`);

--
-- Índices de tabela `tatuador`
--
ALTER TABLE `tatuador`
  ADD PRIMARY KEY (`idtatuador`),
  ADD UNIQUE KEY `cpf` (`cpf`),
  ADD KEY `idsenioridade` (`idsenioridade`);

--
-- Índices de tabela `tatuador_estilo`
--
ALTER TABLE `tatuador_estilo`
  ADD PRIMARY KEY (`idtatuador`,`idestilo`),
  ADD KEY `idestilo` (`idestilo`);

--
-- Índices de tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idcliente` (`idcliente`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `agendamento`
--
ALTER TABLE `agendamento`
  MODIFY `idagendamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT de tabela `cliente`
--
ALTER TABLE `cliente`
  MODIFY `idcliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de tabela `estilo`
--
ALTER TABLE `estilo`
  MODIFY `idestilo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `senioridade`
--
ALTER TABLE `senioridade`
  MODIFY `idsenioridade` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `tatuador`
--
ALTER TABLE `tatuador`
  MODIFY `idtatuador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `agendamento`
--
ALTER TABLE `agendamento`
  ADD CONSTRAINT `agendamento_ibfk_1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`),
  ADD CONSTRAINT `agendamento_ibfk_2` FOREIGN KEY (`idtatuador`) REFERENCES `tatuador` (`idtatuador`);

--
-- Restrições para tabelas `tatuador`
--
ALTER TABLE `tatuador`
  ADD CONSTRAINT `tatuador_ibfk_1` FOREIGN KEY (`idsenioridade`) REFERENCES `senioridade` (`idsenioridade`);

--
-- Restrições para tabelas `tatuador_estilo`
--
ALTER TABLE `tatuador_estilo`
  ADD CONSTRAINT `tatuador_estilo_ibfk_1` FOREIGN KEY (`idtatuador`) REFERENCES `tatuador` (`idtatuador`),
  ADD CONSTRAINT `tatuador_estilo_ibfk_2` FOREIGN KEY (`idestilo`) REFERENCES `estilo` (`idestilo`);

--
-- Restrições para tabelas `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
