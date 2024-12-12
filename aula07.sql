--CRIANDO BANCO DE DADOS PARA CADASTRO DE PESSOAS E LIVROS (DATABASE)

-- criando uma tabela

-- Tabela de Usuários
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    data_cadastro DATE NOT NULL DEFAULT CURRENT_DATE
);

-- Tabela de Editoras
CREATE TABLE editoras (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);

-- Tabela de Gêneros
CREATE TABLE generos (
    id SERIAL PRIMARY KEY,
    DESCRICAO VARCHAR(100) NOT NULL UNIQUE
);

-- Tabela de Livros
CREATE TABLE IF NOT EXISTS livros (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    quantidade_disponivel INT NOT NULL CHECK (quantidade_disponivel >= 0),
    editora_id INT NOT NULL REFERENCES editoras(id),
    genero_id INT NOT NULL REFERENCES generos(id),
    UNIQUE (titulo, editora_id)
);

-- Tabela de Empréstimos
CREATE TABLE emprestimos (
    id SERIAL PRIMARY KEY,
    usuario_id INT NOT NULL REFERENCES usuarios(id),
    livro_id INT NOT NULL REFERENCES livros(id),
    data_emprestimo TIMESTAMP NOT NULL DEFAULT CURRENT_DATE,
    data_devolucao TIMESTAMP NOT NULL DEFAULT CURRENT_DATE
);

--adicionar um campo para adcionar telefone dos usuarios
ALTER table usuarios add column telefone char(11) DEFAULT 'NENHUM';

--alterar tamanho do campo de titulo na tabela livros para compactar até (200) caracteres
ALTER TABLE LIVROS ALTER COLUMN TITULO TYPE VARCHAR(200);

-- para remover 
ALTER TABLE usuarios DROP data_cadastro;

--Garanta que o mesmo titulo do livro possa ser registrado na mesma editora
ALTER TABLE LIVROS ADD CONSTRAINT uq_livros_editora UNIQUE(titulo, editora_id);

--Garantir que a data de emprestimos e devolução sejam distintas e validads 
ALTER TABLE EMPRESTIMOS ADD CONSTRAINT chk_data_devolucao CHECK (data_devolucao >= data_emprestimo);

INSERT INTO USUARIOS(id, nome, email, telefone)
VALUES(1, 'Valtemir', 'valtemir@senac.br', '9999-9999'), (2, 'francisco', 'franciscobatista744@gmail.com', '9999-9999');

INSERT INTO EDITORAS (id, nome)
VALUES (1, 'Senac'), (2, 'mundo');

INSERT INTO GENEROS (id, descricao)
VALUES (1, 'terror'), (2, 'Drama'), (3, 'Ficção');

INSERT INTO LIVROS(titulo, quantidade_disponivel, editora_id, genero_id)
VALUES 
('Harry potter', 10, 2, 3),
('As cronicas de narnia', 20, 2, 3),
('Coraline', 30, 1, 1),
('O hobbit', 40, 2, 3),
('Quem é você alasca', 40, 1, 2);

INSERT INTO EMPRESTIMOS(usuario_id, livro_id, data_devolucao)
VALUES
(2, 1, '2024-12-26'),
(1, 2, '2024-12-08');



select *FROM USUARIOS ;
select *FROM EDITORAS;
select *FROM GENEROS;
select *FROM LIVROS;
select *FROM EMPRESTIMOS;
