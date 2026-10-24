
use biblioteca;

create table livros(
	id_livro int primary key auto_increment,
    titulo VARCHAR(100) not null,
    autor VARCHAR(100) not null
    
);

create table leitores(
	id_leitor int primary key auto_increment,
    nome VARCHAR(100) not null,
    email VARCHAR(100) unique not null
    
);

create table emprestimos(
	id_emprestimo int primary key auto_increment,
    id_livro int,
    id_leitor int,
    data_emprestimo DATE not null,
    data_prevista DATE not null,
    data_devolucao DATE,
    foreign key(id_livro) references livros (id_livro),
    foreign key(id_leitor) references leitores (id_leitor)
    
);

insert into livros(titulo,autor) values("Pequeno principe","Guilherme"),
								("As aventuras de PI","Gabriel"),
								("Guia de lambda no C#","Arthur");

insert into leitores(nome,email) values("Eric","eric@maluan");
insert into leitores(nome,email) values("Samuel","samuel@neto");
insert into leitores(nome,email) values("Gustavo","gustavo@lima");

insert into emprestimos(id_livro,id_leitor,data_emprestimo,data_prevista,data_devolucao) 
values ("1","1","20261001","20261007","20261005");
insert into emprestimos(id_livro,id_leitor,data_emprestimo,data_prevista,data_devolucao) 
values ("2","2","20260930","20261005","20261006");
insert into emprestimos(id_livro,id_leitor,data_emprestimo,data_prevista) 
values ("2","2","20261004","20261005");


SELECT 
    l.nome,
    b.titulo,
    e.data_emprestimo
FROM emprestimos e
INNER JOIN leitores l ON e.id_leitor = l.id_leitor
INNER JOIN livros b ON e.id_livro = b.id_livro;

SELECT 
    l.nome,
    b.titulo
FROM leitores l
LEFT JOIN emprestimos e ON l.id_leitor = e.id_leitor
LEFT JOIN livros b ON e.id_livro = b.id_livro;

SELECT 
    l.nome,
    b.titulo,
    e.data_prevista
FROM emprestimos e
INNER JOIN leitores l ON e.id_leitor = l.id_leitor
INNER JOIN livros b ON e.id_livro = b.id_livro
WHERE e.data_devolucao IS NULL;


DROP FUNCTION IF EXISTS fn_CalcularAtraso;

DELIMITER $$

CREATE FUNCTION fn_CalcularAtraso(p_id_emprestimo INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_prevista DATE;
    DECLARE v_devolucao DATE;
    DECLARE v_atraso INT;

    SELECT data_prevista, data_devolucao
      INTO v_prevista, v_devolucao
      FROM emprestimos
     WHERE id_emprestimo = p_id_emprestimo;

    SET v_atraso = DATEDIFF(IFNULL(v_devolucao, CURRENT_DATE()), v_prevista);

    IF v_atraso < 0 THEN
        SET v_atraso = 0;
    END IF;

    RETURN v_atraso;
END$$

DELIMITER ;

SELECT fn_CalcularAtraso(1);

DROP PROCEDURE IF EXISTS sp_RegistrarDevolucao;

DELIMITER $$

CREATE PROCEDURE sp_RegistrarDevolucao(IN p_id_emprestimo INT)
BEGIN
    UPDATE emprestimos
       SET data_devolucao = CURRENT_DATE()
     WHERE id_emprestimo = p_id_emprestimo
       AND data_devolucao IS NULL;

    SELECT p_id_emprestimo AS id_emprestimo,
           fn_CalcularAtraso(p_id_emprestimo) AS dias_de_atraso;
END$$

DELIMITER ;

CALL sp_RegistrarDevolucao(3);