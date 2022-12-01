CREATE DATABASE prueba_doris_gutierrez950;

\c prueba_doris_gutierrez_567

1. CREANDO LAS TABLAS

CREATE TABLE peliculas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR (255),
    anno INT
);


CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    tag VARCHAR(32)
);


CREATE TABLE peliculas_tags (
    peliculas_id BIGINT,
    tag_id BIGINT,
    FOREIGN KEY (peliculas_id) REFERENCES peliculas (id),
    FOREIGN KEY (tag_id) REFERENCES tags (id)
);


2. INSERT DE TABLAS

--TABLA PELICULAS
INSERT INTO peliculas (nombre, anno) VALUES ('africa mia', 1998);
INSERT INTO peliculas (nombre, anno) VALUES ('titANIC', 1999);
INSERT INTO peliculas (nombre, anno) VALUES ('CASABLANCA', 1966);
INSERT INTO peliculas (nombre, anno) VALUES ('ROBERT RABIT', 1986);
INSERT INTO peliculas (nombre, anno) VALUES ('GOSTHS', 1995);


--TABLA TAGS
INSERT INTO tags (tag) VALUES ('drama');
INSERT INTO tags (tag) VALUES ('drama');
INSERT INTO tags (tag) VALUES ('comedia');
INSERT INTO tags (tag) VALUES ('fantasia');
INSERT INTO tags (tag) VALUES ('suspenso');



--TABLA INTERMEDIA PELICULAS Y TAGS
INSERT INTO peliculas_tags (peliculas_id, tag_id) VALUES (1,1);
INSERT INTO peliculas_tags (peliculas_id, tag_id) VALUES (1,4);
INSERT INTO peliculas_tags (peliculas_id, tag_id) VALUES (2,1);
INSERT INTO peliculas_tags (peliculas_id, tag_id) VALUES (1,2);
INSERT INTO peliculas_tags (peliculas_id, tag_id) VALUES (2,2);


3 . - CANTIDAD DE ETIQUETAS
SELECT peliculas.nombre, COUNT(peliculas_tags.tag_id)
FROM peliculas LEFT JOIN peliculas_tags on peliculas_id = peliculas_tags.peliculas_id
GROUP BY peliculas.nombre;


4 . -ETAPA 2  creamos el 2º modelo preguntas, respuestas y usuarios

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    edad INT
);
 
CREATE TABLE preguntas (
    id SERIAL PRIMARY KEY,
    question VARCHAR(255),
    correct_respuesta VARCHAR
);

CREATE TABLE respuestas (
    id SERIAL PRIMARY KEY,
    respuesta VARCHAR(255),
    usuario_id BIGINT,
    question_id BIGINT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios (id),
    FOREIGN KEY (question_id) REFERENCES preguntas (id)
);

5 . - INSERT DE DATOS

INSERT INTO usuarios (nombre, edad) VALUES ('PEDRO', 23);
INSERT INTO usuarios (nombre, edad) VALUES ('DIEGO', 28);
INSERT INTO usuarios (nombre, edad) VALUES ('MARIA', 41);
INSERT INTO usuarios (nombre, edad) VALUES ('MARTA', 43);
INSERT INTO usuarios (nombre, edad) VALUES ('DOMINGO', 22);

INSERT INTO preguntas (question, correct_respuesta) VALUES ('¿Quién escribió La Odisea?','homero');
INSERT INTO preguntas (question, correct_respuesta) VALUES ('¿Dónde originaron los juegos olímpicos?','Grecia');
INSERT INTO preguntas (question, correct_respuesta) VALUES ('¿Qué tipo de animal es la ballena?','mamifero');
INSERT INTO preguntas (question, correct_respuesta) VALUES ('¿Quién pintó “la ultima cena”?','Leonardo Davinci');
INSERT INTO preguntas (question, correct_respuesta) VALUES ('¿Cuál es el océano más grande?','Pacifico');

INSERT INTO respuestas (respuesta, usuario_id, question_id) VALUES ('homero', 5, 5);
INSERT INTO respuestas (respuesta, usuario_id, question_id) VALUES ('Grecia', 4, 1);
INSERT INTO respuestas (respuesta, usuario_id, question_id) VALUES ('mamifero', 3, 1);
INSERT INTO respuestas (respuesta, usuario_id, question_id) VALUES ('Leonardo Davinci', 2, 3);
INSERT INTO respuestas (respuesta, usuario_id, question_id) VALUES ('Pacifico', 1, 4);


6 _ - RESPUESTAS CORRECTAS TOTALES POR USUARIO

SELECT usuarios.nombre, COUNT (preguntas.correct_respuesta) as correct_respuesta
FROM preguntas RIGHT JOIN respuestas on respuestas.respuesta = preguntas.correct_respuesta 
JOIN usuarios ON usuarios.id = respuestas.usuario_id 
GROUP BY  usuarios.nombre ,usuario_id ;


7 . - USUARIO CON REPUESTA CORRECTA

SELECT preguntas.question,COUNT(respuestas.usuario_id) as Respuesta_correctas 
FROM respuestas
RIGHT JOIN preguntas on respuestas.question_id = preguntas.id
group BY
  preguntas.question;

8 _ - BORRADO EN CASCADA Y SE  VERIFICARA CON UN USUARIO ID=1

DELETE FROM usuarios WHERE id =1 ;

ALTER TABLE respuestas DROP CONSTRAINT respuestas_usuario_id_fkey, ADD FOREIGN KEY (usuario_id) 
REFERENCES usuarios(id) ON DELETE CASCADE;


9 _ - RESTRICION DE MAYOR DE 18 AÑOS

ALTER TABLE usuario ADD CHECK (edad > 18);


10 _ - AGREGANDO EL CAMPO EMAIL

ALTER TABLE usuarios ADD email VARCHAR(100) UNIQUE;


https://vimeo.com/manage/videos/776820713/privacy
