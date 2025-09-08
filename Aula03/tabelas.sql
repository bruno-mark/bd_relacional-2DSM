CREATE TABLE autor (
    id_autor SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    nacionalidade VARCHAR(100)
);

CREATE TABLE livro (
    id_livro SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    ano_publicacao INT,
    isbn VARCHAR(20) UNIQUE
);

CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE,
    telefone VARCHAR(20)
);

CREATE TABLE emprestimo (
    id_emprestimo SERIAL PRIMARY KEY,
    data_emprestimo DATE NOT NULL,
    data_devolucao DATE,
    id_cliente INT NOT NULL REFERENCES cliente(id_cliente)
);

CREATE TABLE livro_autor (
    id_livro INT NOT NULL REFERENCES livro(id_livro),
    id_autor INT NOT NULL REFERENCES autor(id_autor),
    PRIMARY KEY (id_livro, id_autor)
);

CREATE TABLE emprestimo_livro (
    id_emprestimo INT NOT NULL REFERENCES emprestimo(id_emprestimo),
    id_livro INT NOT NULL REFERENCES livro(id_livro),
    PRIMARY KEY (id_emprestimo, id_livro)
);