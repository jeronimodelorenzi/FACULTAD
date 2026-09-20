CREATE TABLE MATERIA
(
  codigo INT NOT NULL,
  titulo INT NOT NULL,
  PRIMARY KEY (codigo)
);

CREATE TABLE DOCENTE
(
  dni_docente INT NOT NULL,
  PRIMARY KEY (dni_docente)
);

CREATE TABLE MESA
(
  turno INT NOT NULL,
  año INT NOT NULL,
  codigo_mesa INT NOT NULL,
  codigo INT NOT NULL,
  dni_docente INT NOT NULL,
  PRIMARY KEY (codigo_mesa),
  FOREIGN KEY (codigo) REFERENCES MATERIA(codigo),
  FOREIGN KEY (dni_docente) REFERENCES DOCENTE(dni_docente)
);

CREATE TABLE ESTUDIANTE
(
  dni_estudiante INT NOT NULL,
  PRIMARY KEY (dni_estudiante)
);

CREATE TABLE SE_INSCRIBE
(
  fecha INT NOT NULL,
  nota INT NOT NULL,
  codigo_mesa INT NOT NULL,
  dni_estudiante INT NOT NULL,
  PRIMARY KEY (codigo_mesa, dni_estudiante),
  FOREIGN KEY (codigo_mesa) REFERENCES MESA(codigo_mesa),
  FOREIGN KEY (dni_estudiante) REFERENCES ESTUDIANTE(dni_estudiante)
);