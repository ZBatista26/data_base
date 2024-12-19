
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

-- criando as inserções

insert into autor(nome, data_nascimento)
values('William Shakespeare', '1564-04-23'),
('Jane Austen', '1800-12-16'),
('Machado de assis', '1839-06-21'),
('Jorge Amado', '1970-10-08'),
('Isabel Allende', '1942-08-02');
select * from autor

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

