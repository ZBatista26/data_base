 -- CRIANDO BANCO DE DADOS E OS REGISTROS QUE EXISTEM
 
 -- criando uma tabela
 
 -- tabela gêneros
 create table if not exists GENERO(
 ID SERIAL primary key,
 NOME VARCHAR(50)not null unique
 );
 
-- tabela filmes 
create table if not exists FILMES(
ID SERIAL primary key,
NOME VARCHAR(60) not null,
ID_GENERO INT not null,
constraint FK_GENERO foreign key (ID_GENERO) references GENERO(ID)
);
--questão 02
insert into GENERO (nome)
values ('Animação'), ('Terror'), ('Ação'), ('Drama'), ('Comedia');

--questão 03
insert into FILMES (NOME, ID_GENERO)
values ('Batman', 3), ('Harry potter', 3 ), ('it a coisa', 2), ('moana', 1);

--questão 04
insert into FILMES(NOME, ID_GENERO)
VALUES ('jgfjh', 3), ('jhgfjhgf', 1), ('pato donald', 1), ('hulk', 3), ('tropa de elite', 3);

--questão 05
insert into genero (id, nome)
values (6, 'Ducumentario'), (7, 'suspense');
 
select NOME from filmes where ID_GENERO = 2;

--questão 07
select NOME from filmes where ID_GENERO = 2 or ID_GENERO = 4;

select * from genero;
select * from filmes;  

SELECT * FROM FILMES WHERE NOME ILIKE 'T%';

UPDATE FILMES
       SET ID_GENERO = 4
	   WHERE ID_GENERO = 3;

UPDATE FILMES
       SET ID_GENERO = (SELECT ID FROM GENERO WHERE NOME = 'Ação')
	   WHERE ID_GENERO = (SELECT ID FROM GENERO WHERE NOME = 'Drama');

--questão 11

SELECT FILMES.NOME AS NOME_DO_FILMES, GENERO.NOME AS GÊNERO FROM FILMES, GENERO
WHERE ID_GENERO =  GENERO.ID ORDER BY FILMES.NOME;

SELECT FILMES.NOME AS NOME_DO_FILME, GENERO.NOME AS GENERO_NOME FROM FILMES JOIN GENERO ON FILMES.ID_GENERO = GENERO.ID;

-- criar um código SQL que delete os filmes de gênero ação.
DELETE FROM FILMES
WHERE ID_GENERO = (SELECT ID FROM GENERO WHERE NOME = 'Ação');



CREATE TABLE transacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    categoria_id INT NOT NULL,
    tipo ENUM('Receita', 'Despesa') NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    data DATETIME DEFAULT CURRENT_TIMESTAMP,
    descricao TEXT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);
