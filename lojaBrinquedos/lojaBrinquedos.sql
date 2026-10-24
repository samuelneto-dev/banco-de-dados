
USE lojaBrinquedos;

create table if not exists brinquedos(
	id int primary key auto_increment,
    nome VARCHAR (100)NOT NULL,
    categoria VARCHAR (50)NOT NULL,
    preco DECIMAL(10,2),CHECK (preco >0),
    quantidade_estoque INT DEFAULT 0
);


INSERT INTO brinquedos (nome,categoria,preco,quantidade_estoque) VALUES("Carrinho de controle remoto", "Veiculos", 150, 10);
INSERT INTO brinquedos (nome,categoria,preco,quantidade_estoque) VALUES("Boneca Articulada", "Bonecos", 80, 15);
INSERT INTO brinquedos (nome,categoria,preco,quantidade_estoque) VALUES("Quebra cabeça 1000 peças", "Jogos", 45, 20);
INSERT INTO brinquedos (nome,categoria,preco,quantidade_estoque) VALUES("Jogos de Tabuleiro Estratégia", "Jogos", 120, 8);
INSERT INTO brinquedos (nome,categoria,preco,quantidade_estoque) VALUES("Urso de pelúcia gigante", "Pelucias", 200, 5);


SELECT COUNT(categoria) AS Total_Modelos FROM brinquedos;
SELECT SUM(preco) AS Total_Valor FROM brinquedos;
select AVG (preco) AS Media_preco FROM brinquedos;
select MAX(preco) AS Mais_Caro FROM brinquedos;
select MIN(preco) AS Mais_Barato FROM brinquedos;

SELECT COUNT(*) AS Total_Jogos FROM brinquedos WHERE categoria = 'jogos';
