/*
Francisco André Martins
*/
/*criação da base de dados a utilizar*/
CREATE DATABASE BD_EST_DOAÇÕES;
USE BD_EST_DOAÇÕES;

/*-----------------------------------------------------------------------------------------*/
/*criação das tabelas*/

CREATE TABLE alimento(
	id_alimento INT,
	designação VARCHAR(50) UNIQUE NOT NULL,
	calorias INT NOT NULL,
	CHECK (calorias>0),
	CONSTRAINT tb_alimento_PK PRIMARY KEY(id_alimento)
)

CREATE TABLE medicamento(
	id_medicamento INT,
	designação VARCHAR(50) UNIQUE NOT NULL,
	principioAtivo VARCHAR(50) NOT NULL,
	CONSTRAINT tb_medicamento_PK PRIMARY KEY(id_medicamento)
)

CREATE TABLE vestuario(
	id_vestuario INT,
	designação VARCHAR(50) UNIQUE NOT NULL,
	tamanho INT NOT NULL,
	CONSTRAINT tb_vestuario_PK PRIMARY KEY(id_vestuario)
)

create table alimento_produto(
	id_alimento INT,
	id_produto INT,
	CONSTRAINT tb_alimento_produto_PK PRIMARY KEY (id_alimento, id_produto)
)

CREATE TABLE medicamento_produto(
	id_medicamento INT,
	id_produto INT,
	CONSTRAINT tb_medicamento_produto_PK PRIMARY KEY(id_medicamento, id_produto)
)

CREATE TABLE vestuario_produto(
	id_vestuario INT,
	id_produto INT,
	CONSTRAINT tb_vestuario_produto_PK PRIMARY KEY(id_vestuario, id_produto)
)

/*-----------------------------------------------------------------------------------------6*/
CREATE TABLE doador(
	id_doador INT,
	nome VARCHAR(50) NOT NULL,
	CONSTRAINT tb_doador_PK PRIMARY KEY(id_doador)
)

/*-----------------------------------------------------------------------------------------7*/
CREATE TABLE voluntario(
	id_voluntario INT,
	nome VARCHAR(50) NOT NULL,
	dataNascimento DATETIME NOT NULL,
	CONSTRAINT tb_voluntario_PK PRIMARY KEY(id_voluntario)
)

/*-----------------------------------------------------------------------------------------8*/
CREATE TABLE doacao(
	id_doacao INT,
	data_doacao DATETIME NOT NULL,
	CONSTRAINT tb_doacao_PK PRIMARY KEY(id_doacao)
)

/*-----------------------------------------------------------------------------------------9*/
CREATE TABLE produto(
	id_produto INT,
	quantidade INT NOT NULL,
	PRIMARY KEY(id_produto)
)

/*-----------------------------------------------------------------------------------------10*/
CREATE TABLE viatura(
	id_viatura INT,
	matricula VARCHAR(9) UNIQUE NOT NULL,
	CONSTRAINT tb_viatura_PK PRIMARY KEY(id_viatura)
)

/*-----------------------------------------------------------------------------------------11*/
CREATE TABLE entrega_localDestino(
	id_entrega INT,
	id_local INT NOT NULL,
	morada varchar(50) NOT NULL,
	data_entrega DATETIME NOT NULL,
	id_voluntario_comandante INT,
	CONSTRAINT tb_entrega_localDestino_PK PRIMARY KEY(id_entrega),
	CONSTRAINT tb_entrega_localDestino_vol_comandante_FK FOREIGN KEY(id_voluntario_comandante) REFERENCES voluntario
)

/*-----------------------------------------------------------------------------------------12*/
CREATE TABLE embalagem(
	id_embalagem INT,
	designação VARCHAR(50) NOT NULL,
	dataEntrada DATETIME NOT NULL,
	dataSaida DATETIME NOT NULL,
	id_entrega INT,
	CONSTRAINT tb_embalagem_PK PRIMARY KEY(id_embalagem),
	CONSTRAINT tb_embalagem_entrega_FK FOREIGN KEY (id_entrega) REFERENCES entrega_localDestino
)

CREATE TABLE doacao_voluntario_embalagem(
	id_doacao INT,
	id_voluntario INT,
	id_embalagem INT,
	CONSTRAINT tb_doacao_voluntario_embalagem PRIMARY KEY(id_doacao, id_voluntario, id_embalagem)
)

/*-----------------------------------------------------------------------------------------14*/
CREATE TABLE armazem(
	id_armazem INT,
	morada VARCHAR(50) NOT NULL,
	capacidade INT NOT NULL,
	dataE DATETIME NOT NULL,
	dataS DATETIME NOT NULL,
	CONSTRAINT tb_armazem_PK PRIMARY KEY(id_armazem)
)

CREATE TABLE armazem_viatura_embalagem(
	id_armazem INT,
	id_viatura INT,
	id_embalagem INT,
	CONSTRAINT tb_armazem_viatura_embalagem PRIMARY KEY(id_armazem, id_viatura, id_embalagem)
)

/*-----------------------------------------------------------------------------------------16*/
CREATE TABLE recetor(
	id_recetor INT,
	nome VARCHAR(50) NOT NULL,
	dataNascimento DATETIME NOT NULL,
	id_localDestino INT,
	CONSTRAINT tb_recetor_PK PRIMARY KEY(id_recetor),
	CONSTRAINT tb_recetor_local_FK FOREIGN KEY (id_localDestino) REFERENCES entrega_localDestino
)

/*-----------------------------------------------------------------------------------------17*/
CREATE TABLE lingua(
	id_lingua INT,
	designação VARCHAR(50) UNIQUE NOT NULL,
	CONSTRAINT tb_lingua_PK PRIMARY KEY(id_lingua)
)

/*-----------------------------------------------------------------------------------------18*/
CREATE TABLE ong(
	id_ong INT,
	nome VARCHAR(50) UNIQUE NOT NULL,
	CONSTRAINT tb_ong_PK PRIMARY KEY(id_ong)
)

/*-----------------------------------------------------------------------------------------19*/
CREATE TABLE voluntario_ong(
	id_ong INT,
	id_voluntario INT,
	CONSTRAINT tb_ong_voluntario_PK PRIMARY KEY(id_ong),
	CONSTRAINT tb_ong_voluntario_ONG_FK FOREIGN KEY (id_ong) REFERENCES ong,
	CONSTRAINT tb_ong_voluntario_VOLUNTARIO_FK FOREIGN KEY (id_voluntario) REFERENCES voluntario
)

/*-----------------------------------------------------------------------------------------20*/
CREATE TABLE doacao_voluntario(
	id_voluntario INT,
	id_doacao INT,
	CONSTRAINT tb_voluntario_doacao PRIMARY KEY (id_doacao),
	CONSTRAINT tb_voluntario_doacao_doacao_FK FOREIGN KEY (id_doacao) REFERENCES doacao,
	CONSTRAINT tb_voluntario_doacao_voluntario_FK FOREIGN KEY (id_voluntario) REFERENCES voluntario
)

/*-----------------------------------------------------------------------------------------21*/
CREATE TABLE produto_doacao(
	id_doacao INT,
	id_produto INT,
	CONSTRAINT tb_doacao_produto PRIMARY KEY (id_produto),
	CONSTRAINT tb_doacao_produto_doacao_FK FOREIGN KEY (id_doacao) REFERENCES doacao,
	CONSTRAINT tb_doacao_produto_produto_FK FOREIGN KEY (id_produto) REFERENCES produto
)

/*-----------------------------------------------------------------------------------------22*/
CREATE TABLE doador_produto(
	id_doador INT,
	id_produto INT,
	CONSTRAINT tb_doador_produto PRIMARY KEY (id_produto),
	CONSTRAINT tb_doador_produto_doador_FK FOREIGN KEY (id_doador) REFERENCES doador,
	CONSTRAINT  tb_doador_produto_produto_FK FOREIGN KEY (id_produto) REFERENCES produto
)

/*-----------------------------------------------------------------------------------------23*/
CREATE TABLE viatura_entrega(
	id_viatura INT,
	id_entrega INT,
	CONSTRAINT tb_viatura_entrega PRIMARY KEY (id_viatura,id_entrega)
)

/*-----------------------------------------------------------------------------------------24*/
CREATE TABLE lingua_recetor(
	id_lingua INT,
	id_recetor INT,
	id_linguaSecundaria INT,
	CONSTRAINT tb_lingua_recetor_PK PRIMARY KEY(id_lingua),
	CONSTRAINT tb_lingua_recetor_lingua_FK FOREIGN KEY (id_lingua) REFERENCES lingua,
	CONSTRAINT tb_rlingua_recetor_recetor_FK FOREIGN KEY (id_recetor) REFERENCES recetor,
	CONSTRAINT tb_lingua_recetor_linguaSecundaria_FK FOREIGN KEY (id_linguaSecundaria) REFERENCES lingua
)

/*-----------------------------------------------------------------------------------------25*/
CREATE TABLE responsavel(
	id_responsavel INT,
	id_ajudante INT,
	CONSTRAINT tb_responsavel_PK PRIMARY KEY(id_ajudante),
	CONSTRAINT tb_responsavel_responsavel_recetor_FK FOREIGN KEY (id_responsavel) REFERENCES recetor,
	CONSTRAINT tb_responsavel_ajudante_recetor_FK FOREIGN KEY (id_ajudante) REFERENCES recetor
)

/*-----------------------------------------------------------------------------------------26*/

CREATE TABLE comanda(
	id_ajudante INT,
	id_responsavel INT,
	CONSTRAINT tb_comanda_PK PRIMARY KEY(id_ajudante),
	CONSTRAINT tb_comanda_ajudante FOREIGN KEY (id_ajudante) REFERENCES voluntario,
	CONSTRAINT tb_comanda_responsavel FOREIGN KEY (id_responsavel) REFERENCES voluntario
)

/*-----------------------------------------------------------------------------------------27*/

/*-----------------------------------------------------------------------------------------*/
/*Introduação de dados nas tabelas*/

insert into alimento(id_alimento, designação, calorias)
values (1, 'arroz', 340) 
insert into alimento(id_alimento, designação, calorias)
values (2, 'feijao', 118) 
insert into alimento(id_alimento, designação, calorias)
values (3, 'esparguete', 158) 
insert into alimento(id_alimento, designação, calorias)
values (4, 'atum em oleo', 240 ) 
insert into alimento(id_alimento, designação, calorias)
values (5, 'atum em agua', 150) 
insert into alimento(id_alimento, designação, calorias)
values (6, 'sardinha em oleo', 105)

insert into medicamento(id_medicamento, designação, principioAtivo)
values (1, 'ben-u-ron', 'paracetamol')
insert into medicamento(id_medicamento, designação, principioAtivo)
values (2, 'amoxicilina', 'amoxicilina')
insert into medicamento(id_medicamento, designação, principioAtivo)
values (3, 'cloroquina', 'difosfato de cloroquina')

insert into vestuario
values (1,'chapeu',56)
insert into vestuario
values (2,'calças',38)
insert into vestuario
values (3,'t-shirt',42)
insert into vestuario
values (4,'calçoes', 36)
insert into vestuario
values (5,'sandalias',38)
insert into vestuario
values (6,'cinto',38)
insert into vestuario
values (7,'sapatos',40)

/*-----------------------------------------------------------------------------------------*/

insert into doador (id_doador, nome )
values (1, 'Rita')
insert into doador (id_doador, nome)
values (2, 'Joao')
insert into doador (id_doador, nome )
values (3, 'Carlos')
insert into doador (id_doador, nome )
values (4, 'Maria')
insert into doador (id_doador, nome)
values (5, 'Joana')
insert into doador (id_doador, nome)
values (6, 'Jose')
insert into doador (id_doador, nome)
values (7, 'Manel')

/*-----------------------------------------------------------------------------------------*/

insert into voluntario( id_voluntario, nome, dataNascimento)
values (1, 'Joaquim', '1975.oct.14')
insert into voluntario( id_voluntario, nome, dataNascimento)
values (2, 'Raquel', '1979.nov.3')
insert into voluntario( id_voluntario, nome, dataNascimento)
values (3, 'Catarina', '1974.jan.10')
insert into voluntario( id_voluntario, nome, dataNascimento)
values (4, 'Margarida', '1987.december.4')
insert into voluntario( id_voluntario, nome, dataNascimento)
values (5, 'Fernando', '1988.june.2')
insert into voluntario( id_voluntario, nome, dataNascimento)
values (6, 'Fernanda', '1975.july.1')
insert into voluntario( id_voluntario, nome, dataNascimento)
values (7, 'Carlos', '1992.march.10')

/*-----------------------------------------------------------------------------------------*/

insert into medicamento_produto
values(1,1)
insert into vestuario_produto
values(1,2)
insert into alimento_produto
values(1,3)
insert into alimento_produto
values(1,4)
insert into vestuario_produto
values(2,5)
insert into medicamento_produto
values(2,5)
/*FALTA 6(id_produto)*/
insert into medicamento_produto
values(3,7)
insert alimento_produto
values(1, 8)
insert alimento_produto
values(2, 9)
insert alimento_produto
values(4, 10)
insert alimento_produto
values(2, 11)
insert alimento_produto
values(3, 12)
insert alimento_produto
values(5, 13)
insert alimento_produto
values(6, 14)
insert alimento_produto
values(1, 15)
insert alimento_produto
values(1, 16)
insert alimento_produto
values(1, 17)

/*-----------------------------------------------------------------------------------------*/

INSERT INTO doacao
VALUES (1, '2022.jan.05 11:00:00');
INSERT INTO doacao
VALUES (2, '2022.jan.05 11:01:00');
INSERT INTO doacao
VALUES (3, '2022.feb.02 11:05:00')
INSERT INTO doacao
VALUES (4, '2022.feb.02 15:00:00')
INSERT INTO doacao
VALUES (5, '2022.feb.15 11:00:00')
insert into doacao
values(6, '2022.feb.25 15:00:00')
insert into doacao
values(7, '2022.03.01 11:35:00')
insert into doacao
values(8, '2022.03.10 11:00:00')
insert into doacao
values(9, '2022.03.10 11:25:00')
insert into doacao
values(10, '2022.03.15 15:35:00')
insert into doacao
values(11, '2022.03.31 16:05:00')
insert into doacao
values(12, '2022.04.05 11:00:00')
insert into doacao
values(13, '2022.04.06 11:05:00')
insert into doacao
values(14, '2022.04.09 15:05:00')
insert into doacao
values(15, '2022.04.22 15:15:00')
insert into doacao
values(16, '2022.04.25 10:15:00')
insert into doacao
values(17, '2022.04.30 11:00:00')

/*-----------------------------------------------------------------------------------------*/


/*-----------------------------------------------------------------------------------------*/

insert into produto
values (1,11)
insert into produto
values (2,9)
insert into produto
values(3,5)
insert into produto
values(4,7)
insert into produto
values(5,20)
insert into produto
values(6,3)
insert into produto
values(7,4)
insert into produto
values(8,15)
insert into produto
values(9,20)
insert into produto
values(10,100)
insert into produto
values(11,91)
insert into produto
values(12,41)
insert into produto
values(13,23)
insert into produto
values(14,23)
insert into produto
values(15,25)
insert into produto
values(16,10)
insert into produto
values(17,15)

insert into produto_doacao
values (1,1)
insert into produto_doacao
values (2,2)
insert into produto_doacao
values(3,3)
insert into produto_doacao
values(4,4)
insert into produto_doacao
values(5,5)
insert into produto_doacao
values(6,6)
insert into produto_doacao
values(7,7)
insert into produto_doacao
values(8,8)
insert into produto_doacao
values(9,9)
insert into produto_doacao
values(10,10)
insert into produto_doacao
values(11,11)
insert into produto_doacao
values(12,12)
insert into produto_doacao
values(13,13)
insert into produto_doacao
values(14,14)
insert into produto_doacao
values(15,15)
insert into produto_doacao
values(16,16)
insert into produto_doacao
values(17,17)

insert into doador_produto
values (1,1)
insert into doador_produto
values (2,2)
insert into doador_produto
values(3,3)
insert into doador_produto
values(4,4)
insert into doador_produto
values(5,5)
insert into doador_produto
values(6,6)
insert into doador_produto
values(7,7)
insert into doador_produto
values(5,8)
insert into doador_produto
values(4,9)
insert into doador_produto
values(2,10)
insert into doador_produto
values(5,11)
insert into doador_produto
values(6,12)
insert into doador_produto
values(1,13)
insert into doador_produto
values(2,14)
insert into doador_produto
values(7,15)
insert into doador_produto
values(1,16)
insert into doador_produto
values(1,17)

insert into doacao_voluntario
values (1,1)
insert into doacao_voluntario
values (2,2)
insert into doacao_voluntario
values (1,3)
insert into doacao_voluntario
values (1,4)
insert into doacao_voluntario
values (1,5)
insert into doacao_voluntario
values (3,6)
insert into doacao_voluntario
values (1,7)
insert into doacao_voluntario
values (2,8)
insert into doacao_voluntario
values (2,9)
insert into doacao_voluntario
values (3,10)
insert into doacao_voluntario
values (1,11)
insert into doacao_voluntario
values (4,12)
insert into doacao_voluntario
values (5,13)
insert into doacao_voluntario
values (6,14)
insert into doacao_voluntario
values (7,15)
insert into doacao_voluntario
values (2,16)
insert into doacao_voluntario
values (2,17)

/*-----------------------------------------------------------------------------------------*/

select * from entrega_localDestino

INSERT INTO entrega_localDestino
VALUES(1,1,'Galle de Ambrosio Vallejo (Madrid)', '2022.jan.06 10:00:00',1)

INSERT INTO entrega_localDestino
VALUES(2,1,'Galle de Ambrosio Vallejo (Madrid)', '2022.feb.03 10:00:00',1)

INSERT INTO entrega_localDestino
VALUES(3,1,'Galle de Ambrosio Vallejo (Madrid)', '2022.feb.05 10:00:00',1)

insert into entrega_localDestino
values(4,1,'Galle de Ambrosio Vallejo (Madrid)', '2022.feb.26 10:00:00',1)

insert into entrega_localDestino
values(5,1,'Galle de Ambrosio Vallejo (Madrid)', '2022.mar.02 10:00:00',1)

insert into entrega_localDestino
values(6,1,'Galle de Ambrosio Vallejo (Madrid)', '2022.mar.11 10:00:00',1)

insert into entrega_localDestino
values(7,1,'Galle de Ambrosio Vallejo (Madrid)', '2022.mar.16 10:00:00',1)

insert into entrega_localDestino
values(8,1,'Galle de Ambrosio Vallejo (Madrid)', '2022.apr.1 10:00:00',1)

insert into entrega_localDestino
values(9,1,'Galle de Ambrosio Vallejo (Madrid)', '2022.apr.6 10:00:00',1)

insert into entrega_localDestino
values(10,1,'Galle de Ambrosio Vallejo (Madrid)', '2022.apr.07 10:00:00',1)

insert into entrega_localDestino
values(11,1,'Galle de Ambrosio Vallejo (Madrid)', '2022.apr.10 10:00:00',1)

insert into entrega_localDestino
values(12,1,'Galle de Ambrosio Vallejo (Madrid)', '2022.apr.23 10:00:00',1)

insert into entrega_localDestino
values(13,1,'Galle de Ambrosio Vallejo (Madrid)',1, '2022.apr.26 10:00:00')

insert into entrega_localDestino
values(14,1,'Galle de Ambrosio Vallejo (Madrid)',1, '2022.may.1 10:00:00')



/*-----------------------------------------------------------------------------------------*/

insert into embalagem
values (1,'embalagem medicamento', '2022.jan.05 11:00:00', '2022.jan.05 17:00:00', 1)
insert into embalagem
values (2,'embalagem vestuario', '2022.jan.05 11:01:00', '2022.jan.05 17:00:00', 1)
insert into embalagem
values(3, 'embalagem alimento', '2022.feb.02 11:05:00', '2022.feb.02 17:00:00', 2)
insert into embalagem
values(4, 'embalagem alimento', '2022.feb.02 15:00:00', '2022.feb.02 17:00:00', 2)
insert into embalagem
values(5, 'embalagem medicamento', '2022.feb.15 11:00:00', '2022.feb.15 17:00:00', 3)
insert into embalagem
values(6, 'embalagem medicamento', '2022.feb.25 15:00:00', '2022.feb.25 17:00:00', 4)
insert into embalagem
values(7, 'embalagem medicamento', '2022.mar.01 11:35:00', '2022.mar.01 17:00:00',5)
insert into embalagem
values(8, 'embalagem alimento', '2022.mar.10 11:00:00', '2022.mar.10 17:00:00',6)
insert into embalagem
values(9, 'embalagem alimento', '2022.mar.10 11:25:00', '2022.mar.10 17:00:00',6)
insert into embalagem
values(10, 'embalagem alimento', '2022.mar.15 15:35:00', '2022.mar.10 17:00:00',7)
insert into embalagem
values(11, 'embalagem alimento', '2022.mar.31 16:05:00', '2022.mar.31 17:00:00',8)
insert into embalagem
values(12, 'embalagem alimento', '2022.apr.05 11:00:00', '2022.apr.05 17:00:00', 9)
insert into embalagem
values(13, 'embalagem alimento', '2022.apr.07 11:05:00', '2022.apr.07 17:00:00',10)
insert into embalagem
values(14, 'embalagem alimento', '2022.apr.09 15:05:00', '2022.apr.09 17:00:00',11)
insert into embalagem
values(15, 'embalagem alimento', '2022.apr.22 15:15:00', '2022.apr.22 17:00:00',12)
insert into embalagem
values(16, 'embalagem alimento', '2022.apr.25 10:15:00', '2022.apr.25 17:00:00',13)
insert into embalagem
values(17, 'embalagem alimento', '2022.apr.30 11:00:00', '2022.apr.30 17:00:00',14)


insert into doacao_voluntario_embalagem
values(1,1,1)
insert into doacao_voluntario_embalagem
values(2,2,2)
insert into doacao_voluntario_embalagem
values (3,3,3)
insert into doacao_voluntario_embalagem
values (4,2,3)
insert into doacao_voluntario_embalagem
values (5,3,4)
insert into doacao_voluntario_embalagem
values (6,3,6)
insert into doacao_voluntario_embalagem
values (7,1,7)
insert into doacao_voluntario_embalagem
values (8,2,8)
insert into doacao_voluntario_embalagem
values (9,2,9)
insert into doacao_voluntario_embalagem
values (10,3,10)
insert into doacao_voluntario_embalagem
values (11,1,11)
insert into doacao_voluntario_embalagem
values (12,4,12)
insert into doacao_voluntario_embalagem
values (13,5,13)
insert into doacao_voluntario_embalagem
values (14,6,14)
insert into doacao_voluntario_embalagem
values (15,7,15)
insert into doacao_voluntario_embalagem
values (16,2,16)
insert into doacao_voluntario_embalagem
values (17,2,17)

/*-----------------------------------------------------------------------------------------*/
insert into viatura
values (1, 'XQ-33-XQ')

/*-----------------------------------------------------------------------------------------*/

insert into viatura_entrega
values (1,1)
insert into viatura_entrega
values (1,2)
insert into viatura_entrega
values (1,3)
insert into viatura_entrega
values (1,4)
insert into viatura_entrega
values (1,5)
insert into viatura_entrega
values (1,6)
insert into viatura_entrega
values (1,7)
insert into viatura_entrega
values (1,8)
insert into viatura_entrega
values (1,9)
insert into viatura_entrega
values (1,10)
insert into viatura_entrega
values (1,11)
insert into viatura_entrega
values (1,12)
insert into viatura_entrega
values (1,13)
insert into viatura_entrega
values (1,14)

/*-----------------------------------------------------------------------------------------*/
insert into comanda
values (2,1)
insert into comanda
values (3,1)
insert into comanda
values (4,1)
insert into comanda
values (5,6)
insert into comanda
values (7,6)

/*-----------------------------------------------------------------------------------------*/

insert into recetor
values (1, 'Joao', '1988-3-13', 1)
insert into recetor
values (2, 'Pablo', '1975-4-16', 1)
insert into recetor
values (3, 'Juan', '1974-9-19', 1)

insert into responsavel
values (1,2)
insert into responsavel
values (1,3)

/*-----------------------------------------------------------------------------------------*/

insert into lingua(id_lingua, designação)
values(1,'português')
insert into lingua(id_lingua, designação)
values(2,'espanhol')
insert into lingua(id_lingua, designação)
values(3,'inglês')
insert into lingua(id_lingua, designação)
values(4,'francês')
insert into lingua(id_lingua, designação)
values(5,'alemão')
insert into lingua(id_lingua, designação)
values(6,'italiano')
insert into lingua(id_lingua, designação)
values(7,'sueco')

insert into lingua_recetor
values (1,1,2)
insert into lingua_recetor
values (2,2,1)
insert into lingua_recetor
values (6,3,2)

/*-----------------------------------------------------------------------------------------*/

insert into ong
values(1,'Caritas')
insert into ong
values(2,'Apoio ao Emigrante')

insert into voluntario_ong
values (1,5)
insert into voluntario_ong
values (2,7)

/*-----------------------------------------------------------------------------------------*/





