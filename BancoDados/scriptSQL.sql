-- Estudo de caso "Escola"
-- Modelo/Projeto Fisico
-- Linguagem "SQL"

create table cidade(
	Codigo	int			primary key,
	Nome	varchar(30)	not null,
	UF		char(2)		default 'RS',
	numHabitantes	int
);

select * from cidade --(ver por comando)
-- "*" Todos da tabela cidade

create table aluno(
	Matricula int 	 not null,
	Nome varchar(40) not null,
	dataNasc date  	 check(dataNasc <= current_date),
	codCidade int,
	FOREIGN KEY(codCidade) REFERENCES cidade(Codigo)
);

-- drop table aluno; (deletar tabelas)
select * from aluno

alter table aluno add constraint pk_aluno PRIMARY KEY(matricula);

--****************--
-- CARGA DE DADOS --
--****************--
SELECT * FROM cidade

INSERT INTO cidade(codigo,nome,uf,numHabitantes) VALUES(1,'Passo Fundo','RS',2150081);
INSERT INTO cidade(codigo,nome,uf,numHabitantes) VALUES(2,'Lagoa Vermelha','RS',27001);
INSERT INTO cidade(codigo,nome,uf,numHabitantes) VALUES(3,'Chapeco','SC',240199);
INSERT INTO cidade(codigo,nome,numHabitantes) VALUES(4,'Não me Toque',21000);
INSERT INTO cidade(codigo,nome) VALUES(5,'Itapuca');
INSERT INTO cidade(codigo,nome) VALUES(6,'Nova Prata');
INSERT INTO cidade VALUES(7,'Tunas','PR',3050); -- campos não obrigatórios, porém cuidar sequência.
INSERT INTO cidade VALUES(8,'Constantina','RS',10004);
INSERT INTO cidade VALUES(9,'Saudades','SC',10059);
INSERT INTO cidade VALUES(10,'Alegrete','RS',72486);

UPDATE cidade
SET UF = 'RS'
WHERE codigo = 7; -- ou nome = 'Tunas'
-- atualizar dados, cuidar 'where' pra não mudar a tabela toda.

SELECT * FROM aluno

INSERT INTO aluno(matricula,nome,datanasc,codcidade) VALUES(121,'José','06/07/2005',1);
INSERT INTO aluno(matricula,nome,datanasc,codcidade) VALUES(144,'Maria','12/01/2003',5);
INSERT INTO aluno(matricula,nome,datanasc,codcidade) VALUES(122,'Ana','10/08/2000',8);
INSERT INTO aluno(matricula,nome,codcidade) VALUES(123,'Juca',1);
INSERT INTO aluno(matricula,nome,datanasc,codcidade) VALUES(127,'Luana','11/09/2001',2);
INSERT INTO aluno(matricula,nome,datanasc,codcidade) VALUES(143,'Josue','12/05/2001',10);
INSERT INTO aluno VALUES(125,'Napoleão','11/11/2025',9); -- deletado
INSERT INTO aluno VALUES(067,'João','11/11/2025',6);
INSERT INTO aluno VALUES(003,'Jonas','22/01/1999',9);
INSERT INTO aluno VALUES(099,'Jones','26/02/1998',4);

DELETE FROM aluno WHERE matricula = '125';


CREATE TABLE hobby(
	codigo int,
	descricao varchar(30) not null,
	obs varchar(120),
	PRIMARY KEY(codigo)
);

CREATE TABLE AlunoHobby(
	Frequencia int,
	Matricula int,
	Codigo_Hobby int,
	FOREIGN KEY(Matricula) REFERENCES aluno(Matricula),
	FOREIGN KEY(Codigo_Hobby) REFERENCES hobby(codigo),
	PRIMARY KEY(Matricula,Codigo_Hobby)
);

INSERT INTO Hobby(codigo,descricao,obs) VALUES (200,'Vôlei','Atividade no piso');
INSERT INTO Hobby(codigo,descricao,obs) VALUES (333,'Bocha','Cancha de cal');
INSERT INTO Hobby(codigo,descricao) VALUES (110,'Ler');
INSERT INTO Hobby(codigo,descricao) VALUES (203,'Estudar');
INSERT INTO Hobby(codigo,descricao) VALUES (207,'Pedalar');
INSERT INTO Hobby(codigo,descricao) VALUES (201,'Futebol');
INSERT INTO Hobby VALUES (206,'Correr');
INSERT INTO Hobby VALUES (210,'Lutar','Boxe');

SELECT * FROM Hobby

INSERT INTO AlunoHobby (Matricula,Codigo_Hobby,Frequencia)VALUES(121,200,1);
INSERT INTO AlunoHobby (Matricula,Codigo_Hobby,Frequencia)VALUES(144,333,5);
INSERT INTO AlunoHobby (Matricula,Codigo_Hobby,Frequencia)VALUES(122,110,6);
INSERT INTO AlunoHobby (Matricula,Codigo_Hobby,Frequencia)VALUES(123,207,4);
INSERT INTO AlunoHobby (Matricula,Codigo_Hobby,Frequencia)VALUES(127,201,7);
INSERT INTO AlunoHobby (Matricula,Codigo_Hobby,Frequencia)VALUES(143,206,2);
INSERT INTO AlunoHobby (Matricula,Codigo_Hobby,Frequencia)VALUES(67,210,3);

SELECT * FROM AlunoHobby



-- EXERCICIOS (DQL)

1- listar nome cidades em ordem alfabetica

SELECT Nome FROM cidade ORDER BY Nome;

2- listar o nome e nº habitantes das cidades com mais de 100mil hab

SELECT Nome,numHabitantes FROM cidade WHERE numHabitantes > 100000;

3- listar o nome dos alunos que nasceram antes do ano 2000

SELECT Nome FROM aluno WHERE extract(year from dataNasc) < 2000;

4 - Listar o nome dos hobbys com letras C e l

SELECT descricao FROM Hobby Where descricao LIKE 'C%' OR descricao LIKE 'L%';

5- nome alunos nasceram dia 26

SELECT Nome FROM aluno WHERE extract(day from dataNasc) = 26;

6- listar nome e uf das cidades sem nº de habitantes

SELECT Nome,uf, numHabitantes FROM cidade WHERE numHabitantes IS NULL; 

7- listar nome, nº hab e 20% do nº de habitantes das cidades RS, listar dados maior
para menor em nº hab.
-- RENOMEAR COLUNA e PORCENTAGEM.
SELECT Nome,numHabitantes, numHabitantes * 20/100 as "20%", uf FROM cidade WHERE UPPER(uf) = 'RS' AND numHabitantes is not null;

8- listar matricula alunos praticam hobby frequencia >1 semana;

SELECT Matricula,Frequencia FROM AlunoHobby WHERE Frequencia >1;

9-  listar todos os hobbys que possuem observacao, hobby ordem alfabetica descrecente.

SELECT descricao,obs FROM Hobby WHERE obs is not null ORDER BY descricao desc;

10 - Listar o nome das cidades ( em caixa alta) dos estados do RS,rs, SC e Sc.
-- UPPER transforma em CAPS a string(coluna)
SELECT Nome, UPPER(nome) as "Caixa-Alta", uf FROM cidade WHERE upper(uf) = 'RS' OR upper(uf) = 'SC';

11 - Comando para aumentar 10% a populacao da cidade passo fundo
SELECT * FROM cidade
UPDATE cidade
SET numHabitantes = numHabitantes + (numHabitantes * 10/100) 
Where nome = 'Passo Fundo';

SELECT round(numHabitantes,0) as "Habitantes de Passo Fundo (10% aumento)"
FROM cidade
WHERE codigo = '1'