-- Modelo Fisico Tabelas
CREATE TABLE Empresa (
 cnpj VARCHAR(20) PRIMARY KEY,
 razaoSocial VARCHAR(50) NOT NULL,
 endereco VARCHAR(50)
);

CREATE TABLE Produto (
 codigo INTEGER PRIMARY KEY,
 descricao VARCHAR(50) NOT NULL,
 valorUnitario NUMERIC(8,2) CHECK (valorUnitario > 0),
 qtdEstoque INTEGER DEFAULT 0,
 codEmpresa VARCHAR(50),
 FOREIGN KEY(codEmpresa) REFERENCES Empresa (cnpj)
);

CREATE TABLE Cliente (
 codigo INTEGER PRIMARY KEY,
 nome VARCHAR(50) NOT NULL,
 endereco VARCHAR(150),
 telefone1 VARCHAR(12) ,
 telefone2 VARCHAR(12)
);

CREATE TABLE Funcionario (
 codigo INTEGER PRIMARY KEY,
 nome VARCHAR(50) NOT NULL,
 salario NUMERIC(8,2) CHECK (salario > 0),
 telefone VARCHAR(12) NOT NULL,
 codEmpresa VARCHAR(20) NOT NULL
);

ALTER TABLE Funcionario ADD FOREIGN KEY(codEmpresa) REFERENCES Empresa (cnpj);


CREATE TABLE Pedido (
 codigo         serial PRIMARY KEY,
 dataEntrega    DATE,
 valorTotal     NUMERIC(8,2) NOT NULL, 
 codCliente     INTEGER NOT NULL,
 codFuncionario INTEGER NOT NULL,
 FOREIGN KEY(codCliente) REFERENCES Cliente (codigo),
 FOREIGN KEY(codFuncionario) REFERENCES Funcionario (codigo)
);

CREATE TABLE itens (
 codPedido 	INTEGER,
 codProduto INTEGER,
 qtd 		INTEGER,
 FOREIGN KEY(codPedido) REFERENCES Pedido (codigo),
 FOREIGN KEY(codProduto) REFERENCES Produto (codigo),
 PRIMARY KEY(codPedido,codProduto)
);

CREATE TABLE NotaFiscal (
 numero INTEGER PRIMARY KEY,
 serie VARCHAR(50) NOT NULL,
 dataEmissao DATE NOT NULL,
 valorTotal NUMERIC(10,2) NOT NULL,
 tipo VARCHAR(30) NOT NULL,
 status VARCHAR(25) NOT NULL,
 codPedido INTEGER,
 FOREIGN KEY(codPedido) REFERENCES Pedido (codigo)
);

-- CARGA DE DADOS MOODLE

----------------------------------------------------

INSERT INTO Empresa (cnpj, razaoSocial, endereco) 
VALUES ('11.222.333/0001-44', 'Tech Distribuidora Ltda', 'Rua 15 de Novembro, 1000');
INSERT INTO Empresa (cnpj, razaoSocial, endereco) 
VALUES ('22.111.444/0001-33', 'InfoMaster', 'Av. Brasil, 855');

INSERT INTO Produto (codigo, descricao, valorUnitario, qtdEstoque, codEmpresa) VALUES 
(1, 'Mouse Óptico Logitech', 85.50, 50, '11.222.333/0001-44'),
(2, 'Teclado Mecânico',120.00, 40, '11.222.333/0001-44'),
(3, 'Cabo USB-C Nylon',35.90, 100, '22.111.444/0001-33'),
(4, 'Pendrive 64GB',55.00, 60, '22.111.444/0001-33'),
(5, 'Fone de Ouvido Bluetooth',250.00, 80, '22.111.444/0001-33'),
(6, 'Mousepad Gamer', 70.00, 120, '11.222.333/0001-44'),
(7, 'Cabo HDMI 2m', 45.50, 45, '11.222.333/0001-44'),
(8, 'Carregador Fast Charge',110.00, 30, '11.222.333/0001-44'),
(9, 'Adaptador P2/P3',25.00, 90, '11.222.333/0001-44'),
(10,'Suporte Articulado',65.90, 70, '11.222.333/0001-44'),
(11, 'Hub USB 4 Portas 3.0', 89.90, 25, '11.222.333/0001-44'),
(12, 'Capa para Notebook 15.6', 95.00, 20, '11.222.333/0001-44'),
(13, 'Webcam Full HD',320.00, 15, '11.222.333/0001-44'),
(14, 'Filtro de Linha 5 Tomadas',58.00, 35, '11.222.333/0001-44'),
(15, 'Kit Limpa Telas',29.90, 150, '11.222.333/0001-44');


INSERT INTO Cliente (codigo, nome, telefone1, telefone2) VALUES 
 (1, 'Fernando Souza', '11911112222', NULL),
 (2, 'Gabriela Lima', '11922223333', '1133334444'),
 (3, 'Hugo Alves', '11933334444', NULL),
 (4, 'Igor Nunes', '11944445555', NULL),
 (5, 'Juliana Mendes', '11955556666', '1144445555'),
 (6, 'Karla Martins', '11966667777', NULL),
 (7, 'Leonardo Pires', '11977778888', NULL),
 (8, 'Marina Silva', '11988889999', '1155556666'),
 (9, 'Nicolas Costa', '11999990000', NULL),
 (10, 'Olivia Santos', '11900001111', NULL);

INSERT INTO Cliente (codigo, nome, endereco,telefone1) VALUES 
 (11, 'Jacó', 'Rua das Flores 123, Passo Fundo/RS', '11911112222'),
 (12, 'Juca', 'Av. brasil 858, Passo Fundo/rs', '11922223333'),
 (13, 'Teobaldo', 'Rua Santa Bárbara, s/n', '11922223333'),
 (14, 'Olivia Maia', 'Rua Paissandu, 1076/302 Passo Fundo/RS', '11922223333'),
 (15, 'Tedodoro', 'Rua Santa Bárbara, s/n', '11922223333');


INSERT INTO Funcionario (codigo, nome, salario, telefone, codEmpresa) VALUES 
(1, 'Ana', 3500.00, '11988887777', '11.222.333/0001-44'),
(2, 'Bruno', 4200.00, '11977776666', '11.222.333/0001-44'),
(3, 'Carlos', 3800.00, '11966665555', '22.111.444/0001-33'),
(4, 'Daniela', 4500.00, '11955554444', '22.111.444/0001-33'),
(5, 'Eduardo', 3200.00, '11944443333', '11.222.333/0001-44');


INSERT INTO Pedido (valorTotal, dataEntrega, codCliente, codFuncionario) VALUES 
(820.00, '2025-11-01', 1, 1),  -- 1x Webcam(320) + 2x Fone(250)
(360.00, '2025-11-02', 2, 2),  -- 3x Teclado(120)
(179.50, '2025-12-02', 3, 3),  -- 5x Cabo USB-C(35.90)
(550.00, '2026-01-03', 4, 4),  -- 10x Pendrive(55)
(265.30, '2026-02-04', 5, 5),  -- 2x Hub(89.90) + 1x Mouse(85.50)
(95.00, '2026-02-04', 6, 1),   -- 1x Capa(95)
(182.00, '2026-02-05', 7, 2),  -- 4x HDMI(45.50)
(330.00, '2026-03-06', 8, 3),  -- 3x Carregador(110)
(150.00, '2026-04-07', 9, 4),  -- 6x Adaptador(25)
(131.80, '2026-04-07', 10, 5), -- 2x Suporte(65.90)
(29.90, '2026-04-08', 1, 1),   -- 1x Limpa Telas(29.90)
(290.00, '2026-04-08', 2, 2),  -- 5x Filtro de Linha(58)
(370.00, '2026-05-09', 3, 3),  -- 1x Fone(250) + 1x Teclado(120)
(311.00, '2026-05-10', 4, 4),  -- 2x Mouse(85.50) + 2x Mousepad(70)
(1280.00, '2026-07-10', 5, 5), -- 4x Webcam(320)
(145.90, '2026-07-11', 6, 1),  -- 1x Carregador(110) + 1x Cabo USB-C(35.90)
(190.00, '2026-07-12', 7, 2),  -- 2x Capa(95)
(269.70, '2026-07-13', 8, 3),  -- 3x Hub USB(89.90)
(455.00, '2026-08-14', 9, 4),  -- 10x HDMI(45.50)
(400.00, '2026-08-15', 10, 5); -- 5x Pendrive(55) + 5x Adaptador(25)

INSERT INTO itens (codProduto, codPedido,qtd) VALUES 
(13,1,1), (5,1,2),         -- Pedido 1
(2,2,3),                     -- Pedido 2
(3,3,5),                     -- Pedido 3
(4,4,10),                    -- Pedido 4
(11,5,2), (1,5,1),         -- Pedido 5
(12,6,1),                    -- Pedido 6
(7,7,4),                     -- Pedido 7
(8,8,3),                     -- Pedido 8
(9,9,6),                     -- Pedido 9
(10,10,2),                   -- Pedido 10
(15,11,1),                   -- Pedido 11
(14,12,5),                   -- Pedido 12
(5,13,1), (2,13,1),        -- Pedido 13
(1,14,2), (6,14,2),        -- Pedido 14
(13,15,4),                   -- Pedido 15
(8,16,1), (3,16,1),        -- Pedido 16
(12,17,2),                   -- Pedido 17
(11,18,3),                   -- Pedido 18
(7,19,10),                   -- Pedido 19
(4,20,5), (9,20,5);        -- Pedido 20

INSERT INTO NotaFiscal (numero, serie, dataEmissao, valorTotal, tipo, status, codPedido) VALUES 
(1001, 'S1', '2023-11-01', 820.00, 'VENDA', 'EMITIDA', 1),
(1002, 'S1', '2023-11-02', 360.00, 'VENDA', 'EMITIDA', 2),
(1003, 'S1', '2023-11-02', 179.50, 'VENDA', 'EMITIDA', 3),
(1004, 'S1', '2023-11-03', 550.00, 'VENDA', 'EMITIDA', 4),
(1005, 'S1', '2023-11-04', 265.30, 'VENDA', 'EMITIDA', 5),
(1006, 'S1', '2023-11-04', 95.00, 'VENDA', 'EMITIDA', 6),
(1007, 'S1', '2023-11-05', 182.00, 'VENDA', 'EMITIDA', 7),
(1008, 'S1', '2023-11-06', 330.00, 'VENDA', 'EMITIDA', 8),
(1009, 'S1', '2023-11-07', 150.00, 'VENDA', 'EMITIDA', 9),
(1010, 'S1', '2023-11-07', 131.80, 'VENDA', 'EMITIDA', 10),
(1011, 'S1', '2023-11-08', 29.90, 'VENDA', 'EMITIDA', 11),
(1012, 'S1', '2023-11-08', 290.00, 'VENDA', 'EMITIDA', 12),
(1013, 'S1', '2023-11-09', 370.00, 'VENDA', 'EMITIDA', 13),
(1014, 'S1', '2023-11-10', 311.00, 'VENDA', 'EMITIDA', 14),
(1015, 'S1', '2023-11-10', 1280.00, 'VENDA', 'EMITIDA', 15),
(1016, 'S1', '2023-11-11', 145.90, 'VENDA', 'EMITIDA', 16),
(1017, 'S1', '2023-11-12', 190.00, 'VENDA', 'EMITIDA', 17),
(1018, 'S1', '2023-11-13', 269.70, 'VENDA', 'EMITIDA', 18),
(1019, 'S1', '2023-11-14', 455.00, 'VENDA', 'EMITIDA', 19),
(1020, 'S1', '2023-11-15', 400.00, 'VENDA', 'EMITIDA', 20);

-- Inserindo 3 Notas Fiscais com status CANCELADA
INSERT INTO NotaFiscal (numero, serie, dataEmissao, valorTotal, tipo, status, codPedido) VALUES 
(1021, 'S1', '2023-11-16', 150.00, 'VENDA', 'CANCELADA', 1),
(1022, 'S1', '2023-11-17', 320.00, 'VENDA', 'CANCELADA', 5),
(1023, 'S1', '2023-11-18', 85.50, 'VENDA', 'CANCELADA', 13);


Select * from produto

1-
Select codigo,nome,telefone1,telefone2 From cliente order by nome asc;

2-
Select codigo,descricao,qtdestoque,valorunitario From produto Where qtdestoque < 40;

3-
Select valortotal,dataentrega From pedido Where valortotal between 50 and 200 AND extract(month from dataentrega)in (02,04);

4-
Select * From notafiscal Where dataemissao >= '10/12/2022';

5-
Select nome,endereco,telefone2 from cliente where UPPER(endereco) like '%RS%' AND telefone2 is null;


--------------------- JOINS ____________________
-- chave primaria e chave estrangeira
-- juntar tabelas para obter valores distintos, unindo cnpj para buscar razao social empresa e comparar a func.
6-
Select funcionario.nome, empresa.razaoSocial
From funcionario inner join empresa ON
	empresa.cnpj = funcionario.codEmpresa;

7-
Select cliente.nome as "Cliente",pedido.codigo,pedido.dataentrega,pedido.valortotal
From cliente inner join pedido ON
	cliente.codigo = pedido.codcliente
Order by cliente.nome;
8-
Select pedido.codigo,pedido.valortotal,funcionario.nome as "Funcionário"
From pedido inner join funcionario ON
	pedido.codfuncionario = funcionario.codigo;	

9-
Select  itens.qtd, produto.codigo as "Codigo Produto", produto.descricao, pedido.codigo as "Codigo Pedido",
		produto.valorunitario
from produto inner join itens on produto.codigo = itens.codproduto
	inner join pedido on
	itens.codpedido = pedido.codigo

10- 
Select nf.numero, nf.dataemissao, p.dataentrega,p.codigo
from pedido p inner join notafiscal nf ON
	p.codigo = nf.codpedido
order by p.dataentrega; 

11-
Select pedido.codigo as "Nº do pedido", cliente.nome as "Cliente", funcionario.nome as "Funcionario"
from pedido 
inner join cliente on pedido.codcliente = cliente.codigo
inner join funcionario on pedido.codfuncionario = funcionario.codigo
	
12-
SELECT funcionario.nome, sum(valortotal) as "Soma total por funcionário"
from pedido inner join funcionario on
	pedido.codfuncionario = funcionario.codigo
group by funcionario.nome

13-
SELECT cliente.nome, sum(pedido.valortotal) as "Valor Total Acumulado"
from cliente inner join pedido on
	cliente.codigo = codcliente
group by cliente.nome
order by sum(valortotal) desc

14-

Select produto.descricao, itens.qtd, cliente.nome
from pedido
inner join itens on itens.codpedido = pedido.codigo
inner join cliente on pedido.codcliente = cliente.codigo
inner join produto on itens.codproduto = produto.codigo
where cliente.nome = 'Fernando Souza'

15-

SELECT pedido.codigo, produto.descricao, itens.qtd, produto.valorunitario, (produto.valorunitario * itens.qtd) as SUBTOTAL
from pedido
inner join itens on itens.codpedido = pedido.codigo
inner join produto on itens.codproduto = produto.codigo

16
SELECT p.descricao, SUM(i.qtd) AS quantidade_total
FROM produto p
INNER JOIN itens i ON p.codigo = i.codProduto
GROUP BY p.codigo, p.descricao
ORDER BY quantidade_total DESC


17-

SELECT DISTINCT c.nome AS Cliente
from Cliente c 
	inner join pedido p on c.codigo = p.codcliente
	inner join itens i on p.codigo = i.codpedido
	inner join produto pr on i.codproduto = pr.codigo
WHERE pr.valorunitario > 100;

18-

SELECT empresa.razaoSocial, count(funcionario.codigo)
FROM empresa inner join funcionario ON
	empresa.cnpj = funcionario.codempresa
group by empresa.razaoSocial

19-
SELECT empresa.razaoSocial, count(produto.codigo), SUM(produto.valorunitario)
FROM empresa inner join produto ON
	empresa.cnpj = produto.codempresa
group by empresa.razaoSocial

20-
SELECT codPedido, SUM(qtd) AS quantidade_itens
FROM itens
GROUP BY codPedido;

21-
SELECT c.nome, COUNT(p.codigo) AS num_pedidos, ROUND(AVG(p.valorTotal), 2) AS valor_medio
FROM cliente c
INNER JOIN pedido p ON c.codigo = p.codCliente
GROUP BY c.codigo, c.nome
ORDER BY valor_medio DESC;

22-
SELECT e.razaoSocial, MAX(p.valorUnitario) AS valor_maximo, MIN(p.valorUnitario) AS valor_minimo
FROM empresa e
INNER JOIN produto p ON e.cnpj = p.codEmpresa
GROUP BY e.cnpj, e.razaoSocial;

23-
SELECT f.nome, COUNT(p.codigo) AS num_pedidos
FROM funcionario f
LEFT JOIN pedido p ON f.codigo = p.codFuncionario
GROUP BY f.codigo, f.nome;

24-
SELECT p.codigo, p.valorTotal, COUNT(i.codProduto) AS num_produtos
FROM pedido p
INNER JOIN itens i ON p.codigo = i.codPedido
GROUP BY p.codigo, p.valorTotal
HAVING COUNT(i.codProduto) > 1;

25-
SELECT cliente.nome, SUM(pedido.valortotal) as Somatoria, count(pedido.codigo) as Qtd
FROM pedido inner join cliente on
	pedido.codcliente = cliente.codigo
group by cliente.nome,pedido.codcliente
HAVING count(pedido.codigo) > 1
order by Somatoria desc

26-
--criar visão
CREATE VIEW v_produto_empresas AS
SELECT e.razaosocial, p.codigo, p.descricao, p.valorunitario
FROM empresa e inner join produto p ON e.cnpj = p.codempresa
--consultar visão
SELECT razaosocial,descricao FROM v_produto_empresas
WHERE razaosocial = 'InfoMaster'

27-

CREATE VIEW v_desempenho_vendedores AS
SELECT f.nome, f.salario, SUM(p.valorTotal) AS total_vendas
FROM funcionario f
INNER JOIN pedido p ON f.codigo = p.codFuncionario
GROUP BY f.codigo, f.nome, f.salario;

28-
CREATE VIEW v_relatorio_fiscal AS
SELECT nf.numero, nf.status, nf.dataEmissao, nf.valorTotal, c.nome AS nome_cliente
FROM NotaFiscal nf
INNER JOIN pedido p ON nf.codPedido = p.codigo
INNER JOIN cliente c ON p.codCliente = c.codigo;
