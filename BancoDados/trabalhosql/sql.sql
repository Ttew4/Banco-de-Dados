CREATE TABLE Evento (
codigoEvento number PRIMARY KEY,
id_Cidade number,
nome text,
data date,
horarioAbertura number)

CREATE TABLE Participante (
CPF varchar PRIMARY KEY,
dataNasc date,
telefone number,
apelido text,
grupoSanguineo text,
nome text,
sexo text)

CREATE TABLE Inscricao (
numInscricao number PRIMARY KEY,
id_Modalidade number,
id_Evento number,
id_Participante varchar,
pagamento number,
contatoEmergencia number,
FOREIGN KEY(id_Evento) REFERENCES Evento (codigoEvento),
FOREIGN KEY(id_Participante) REFERENCES Participante (CPF))

CREATE TABLE Modalidade (
codigoModalidade number PRIMARY KEY,
id_Evento number,
horarioLargada number,
valor number,
descricao text,
distancia_km number,
FOREIGN KEY(id_Evento) REFERENCES Evento (codigoEvento))

CREATE TABLE Cidade (
codigoCidade number PRIMARY KEY,
nome text,
UF text)

ALTER TABLE Evento ADD FOREIGN KEY(id_Cidade) REFERENCES Cidade (codigoCidade)
ALTER TABLE Inscricao ADD FOREIGN KEY(id_Modalidade) REFERENCES Modalidade (codigoModalidade)