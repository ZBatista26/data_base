
begin;
CREATE TABLE autor(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(60) NOT NULL,
	data_nascimento DATE,
	CONSTRAINT chk_data_nascimento CHECK (data_nascimento <= CURRENT_DATE)
);
CREATE TABLE livro(
	id SERIAL PRIMARY KEY,
	titulo VARCHAR(60) NOT NULL,
	id_autor INTEGER,
	ano_publicacao INT, 
	CONSTRAINT fk_autor_livro FOREIGN KEY (id_autor) REFERENCES autor(id),
	CONSTRAINT chk_ano_publicacao CHECK (ano_publicacao >= 1500 AND ano_publicacao <= EXTRACT(YEAR FROM CURRENT_DATE))
);
CREATE TABLE usuario(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(60) NOT NULL,
	email VARCHAR(60) UNIQUE,
	data_adesao DATE,
	CONSTRAINT chk_data_adesao CHECK (data_adesao <= CURRENT_DATE)
);
CREATE TABLE emprestimo(
	id SERIAL PRIMARY KEY,
	id_livro INTEGER,
	id_usuario INTEGER,
	data_emprestimo DATE NOT NULL,
	data_devolucao DATE NOT NULL,
	CONSTRAINT fk_livro FOREIGN KEY (id_livro) REFERENCES livro(id),
	CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id),
	CONSTRAINT chk_data_devolucao CHECK (data_emprestimo <= data_devolucao),
	CONSTRAINT uq_livro_emprestimo UNIQUE(id_livro, data_emprestimo)
);

<<<<<<< HEAD
-- criando as inserções
=======
--Tabela serviços
CREATE TABLE IF NOT EXISTS SERVICOS(
ID SERIAL PRIMARY KEY,
NOME VARCHAR(100) NOT NULL,
DESCRICAO TEXT NOT NULL,
PRECO NUMERIC (10,2) NOT NULL CHECK  (PRECO > 0),
TIPO_SERVICOS VARCHAR(50) NOT NULL CHECK (TIPO_SERVICOS IN ('Consultoria', 'Suporte', 'Manutenção'))
);
>>>>>>> 3b507d3bf37008354b235853b5fdd3a6c05ae9a8

insert into autor(nome, data_nascimento)
values('William Shakespeare', '1564-04-23'),
('Jane Austen', '1800-12-16'),
('Machado de assis', '1839-06-21'),
('Jorge Amado', '1970-10-08'),
('Isabel Allende', '1942-08-02');
select * from autor

<<<<<<< HEAD
insert into livro(titulo, id_autor, ano_publicacao)
values('Romeu e julieta', 1, 1597),
('Orgulho e preconceito', 2, 1813),
('Dom Casmurro', 3, 1899),
('Casa de palha', 4, 1931),
('A Casa dos espíritos', 5, 1982);
select * from livro

insert into usuario(nome, email, data_adesao)
values('francico01', 'francisco01@email.com', '2023-12-2'),
('francisco02', 'francisco02@email.com', '2023-12-3'),
('francisco03', 'francisco03@email.com', '2023-12-4'),
('francisco04', 'francisco04@email.com', '2023-12-5'),
('francisco05', 'francisco05@email.com', '2023-12-06');
select * from usuario

insert into emprestimo(id_livro, id_usuario, data_emprestimo, data_devolucao)
values(1, 1, '2024-12-19', '2025-01-26'),
(2, 2, '2024-12-19', '2025-01-27'),
(3, 3, '2024-12-19', '2025-01-28'),
(4, 4, '2024-12-19', '2025-01-29'),
(5, 5, '2024-12-19', '2025-01-30');
select * from emprestimo

-- consulta SQL

--01
SELECT LIVRO.TITULO, AUTOR.NOME AS AUTOR FROM LIVRO JOIN AUTOR ON LIVRO.ID_AUTOR = AUTOR.ID;

--02
SELECT NOME, EMAIL FROM USUARIO;

--03
SELECT USUARIO.NOME, LIVRO.TITULO, EMPRESTIMO.DATA_EMPRESTIMO, EMPRESTIMO.DATA_DEVOLUCAO FROM EMPRESTIMO 
JOIN LIVRO ON ID_LIVRO = LIVRO.ID
JOIN USUARIO ON ID_USUARIO = USUARIO.ID;

--04
SELECT LIVRO.TITULO, EMPRESTIMO.DATA_EMPRESTIMO
FROM EMPRESTIMO
JOIN LIVRO ON ID_LIVRO = LIVRO.ID
WHERE DATA_DEVOLUCAO = NULL;

--18
SELECT USUARIO.NOME as nome_usuario, LIVRO.TITULO 
FROM EMPRESTIMO
JOIN LIVRO ON ID_LIVRO = LIVRO.ID
JOIN USUARIO ON ID_USUARIO = USUARIO.ID
JOIN AUTOR ON ID_AUTOR = AUTOR.ID
WHERE AUTOR.NOME = 'William Shakespeare';



rollback;

=======
--Tabela chamados
CREATE TABLE IF NOT EXISTS CHAMADOS(
ID SERIAL PRIMARY KEY,
CLIENTE_ID INT,
TECNICO_ID INT,
SERVICOS_ID INT,
DATA_CHAMADO DATE NOT NULL,
STATUS VARCHAR(20) NOT NULL CHECK (STATUS IN ('Pendente', 'Em andamento', 'Finalizado')) NOT NULL,
DESCRICAO TEXT NOT NULL,

CONSTRAINT FK_CLIENTE FOREIGN KEY (CLIENTE_ID) REFERENCES CLIENTE(ID) ON DELETE CASCADE,
CONSTRAINT FK_TECNICO FOREIGN KEY (TECNICO_ID) REFERENCES TECNICO(ID) ON DELETE CASCADE,
CONSTRAINT FK_SERVICOS FOREIGN KEY (SERVICOS_ID) REFERENCES SERVICOS(ID) ON DELETE CASCADE
);

--TABELA PAGAMENTOS
CREATE TABLE IF NOT EXISTS PAGAMENTOS(
ID SERIAL PRIMARY KEY,
CLIENTE_ID INT,
CHAMADOS_ID INT,
VALOR_PAGO NUMERIC (10,2) NOT NULL CHECK (VALOR_PAGO > 0),
DATA_PAGAMENTO DATE NOT NULL,
FORMA_DE_PAGAMENTO VARCHAR(50) NOT NULL,

CONSTRAINT FK_CLIENTE_PAGAMENTO FOREIGN KEY (CLIENTE_ID) REFERENCES CLIENTE(ID) ON DELETE CASCADE,
CONSTRAINT FK_CHAMADOS FOREIGN KEY (CHAMADOS_ID) REFERENCES CHAMADOS(ID) ON DELETE CASCADE
);

--Tabela inserts
INSERT INTO CLIENTE(ID, NOME, EMAIL, TELEFONE, DATA_CADASTRO)
VALUES(1, 'João Silva', 'joao@email.com', '(11) 98765-4321', '2023-01-15'),
(2, 'Maria Oliveira', 'maria@email.com', '(31) 99654- 3210', '2023-02-20'),
(3, 'Pedro Souza', 'pedro@email.com', '(31) 99765- 1234', '2023-03-10'),
(4, 'Ana Costa', 'ana@email.com', '(41) 98888-9999', '2023-04-25'),
(5, 'Lucas almeida', 'lucas@email.com', '(61) 99123-4567', '2023-05-30');

INSERT INTO SERVICOS(ID, NOME, DESCRICAO, PRECO, TIPO_SERVICOS)
VALUES(1, 'Consultoria em TI', 'Consultoria especializada em infraestrutura de TI', '500.00', 'Consultoria'),
(2, 'Manutenção de Equipamentos', 'Manutenção preventiva e corretiva de equipamentos', '300.00', 'Manutenção'),
(3, 'Suporte Técnico', 'Suporte remoto e presencial para empresas', '200.00', 'Suporte');

INSERT INTO TECNICO(ID, NOME, ESPECIALIDADE, DATA_CONTRARACAO)
VALUES(1, 'Carlos Oliveira', 'Consultoria TI', '2022-10-10'),
(2, 'Fernanda Souza', 'Manutenção', '2021-06-15' ),
(3, 'Roberto Costa', 'Suporte Técnico', '2020-08-20');

INSERT INTO CHAMADOS(CLIENTE_ID, TECNICO_ID, SERVICOS_ID, DATA_CHAMADO, STATUS, DESCRICAO)
VALUES(1, 1, 1, '2023-06-01', 'Pendente', 'Fiação da casa queimada'),
(2, 2, 2, '2023-07-10', 'Em andamento', 'Vazamento na tubulação'),
(3, 3, 3, '2023-08-05', 'Finalizado', 'Reparação no ar-condicionado'),
(4, 1, 2, '2023-09-20', 'Pendente', 'Manutenção no servidor'),
(5, 2, 1, '2023-10-15', 'Finalizado', 'Suporte para software');

INSERT INTO PAGAMENTOS(CLIENTE_ID, CHAMADOS_ID, VALOR_PAGO, DATA_PAGAMENTO, FORMA_DE_PAGAMENTO)
VALUES(1, 1, '350.00', '2023-06-15' , 'Cartão de Crédito'),
(2, 2, '450.00', '2023-07-15','Cartão de Crédito'),
(3, 3, '600.00', '2023-08-10', 'Cartão de Crédito'),
(4, 4, '300.00', '2023-09-25', 'Cartão de Crédito');

SELECT * FROM CLIENTE
SELECT * FROM SERVICOS
SELECT * FROM TECNICO
SELECT * FROM CHAMADOS
SELECT * FROM PAGAMENTOS

--4. Liste o nome e e-mail de todos os clientes cadastrados.
SELECT NOME, EMAIL 
FROM CLIENTE;

--5. Recupere os nomes dos serviços disponíveis e seus respectivos preços.
SELECT NOME, PRECO
FROM SERVICOS;

--6. Exiba os nomes e especialidades de todos os técnicos.
SELECT NOME, ESPECIALIDADE
FROM TECNICO;

--7. Mostre a descrição e o status de todos os chamados registrados.
SELECT DESCRICAO, STATUS
FROM CHAMADOS;

--8. Liste os valores pagos e as datas de pagamento de todos os registros na tabela de pagamentos.
SELECT VALOR_PAGO, DATA_PAGAMENTO
FROM PAGAMENTOS;

--9. Liste os nomes dos clientes e as descrições de seus chamados que estão com o status "Em Andamento".
SELECT  CLIENTE.NOME AS Nome_Cliente, CHAMADOS.DESCRICAO AS Descricao_Chamado
FROM CHAMADOS JOIN CLIENTE ON CHAMADOS.CLIENTE_ID = CLIENTE.ID WHERE CHAMADOS.STATUS = 'Em andamento';

--10
SELECT DISTINCT TECNICO.NOME AS Nome_Tecnico
FROM CHAMADOS JOIN SERVICOS ON CHAMADOS.SERVICOS_ID = SERVICOS.ID JOIN TECNICO ON CHAMADOS.TECNICO_ID = TECNICO.ID WHERE SERVICOS.TIPO_SERVICOS = 'Manutenção';

--11
ELECT CLIENTE.NOME AS Nome_Cliente, SUM(PAGAMENTOS.VALOR_PAGO) AS Valor_Total_Pago
FROM PAGAMENTOS JOIN CLIENTE ON PAGAMENTOS.CLIENTE_ID = CLIENTE.ID GROUP BY CLIENTE.NOME;

--12
SELECT CLIENTE.NOME AS Nome_Cliente, SERVICOS.NOME AS Nome_Servico, SERVICOS.DESCRICAO AS Descricao_Servico
FROM CHAMADOS JOIN CLIENTE ON CHAMADOS.CLIENTE_ID = CLIENTE.ID JOIN SERVICOS ON CHAMADOS.SERVICOS_ID = SERVICOS.ID;

--13
SELECT DISTINCT TECNICO.NOME AS Nome_Tecnico, SERVICOS.NOME AS Nome_Servico
FROM CHAMADOS JOIN SERVICOS ON CHAMADOS.SERVICOS_ID = SERVICOS.ID JOIN TECNICO ON CHAMADOS.TECNICO_ID = TECNICO.ID WHERE SERVICOS.PRECO > 400;

--14
UPDATE SERVICOS SET PRECO = 350 WHERE TIPO_SERVICOS = 'Manutenção' AND PRECO < 350;

--15
DELETE FROM TECNICO WHERE ID NOT IN (
        SELECT DISTINCT TECNICO_ID 
        FROM CHAMADOS
    );
>>>>>>> 3b507d3bf37008354b235853b5fdd3a6c05ae9a8
