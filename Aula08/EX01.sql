CREATE TABLE cursos (id_curso SERIAL PRIMARY KEY, nome VARCHAR(100) NOT NULL);
CREATE TABLE alunos (id_aluno SERIAL PRIMARY KEY, nome VARCHAR(100) NOT NULL, idade INT, id_curso INT REFERENCES cursos(id_curso));

INSERT INTO cursos (nome) VALUES ('Engenharia');
INSERT INTO cursos (nome) VALUES ('Computação');
INSERT INTO alunos (nome, idade, id_curso) VALUES ('Carlos Almeida', 22, 1);
INSERT INTO alunos (nome, idade, id_curso) VALUES ('Fernanda Costa', 16, 2);
INSERT INTO alunos (nome, idade, id_curso) VALUES ('Roberto', 20, null);

SELECT alunos.nome, cursos.nome as curso
FROM cursos
INNER JOIN alunos ON cursos.id_curso = alunos.id_curso;

SELECT alunos.nome, cursos.nome as curso
FROM alunos
LEFT JOIN cursos ON cursos.id_curso = alunos.id_curso;