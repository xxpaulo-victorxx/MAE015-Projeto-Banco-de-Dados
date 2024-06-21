------------------------------------------------------------------------------------
-- Platform:          MySQL
-- Author:            Paulo Victor Innocencio
-- DRE:               116213599
-- Email:             pv.innocencio@poli.ufrj.br
-- GitHub:            https://github.com/xxpaulo-victorxx
------------------------------------------------------------------------------------
CREATE DATABASE instituto_futuro;
USE instituto_futuro;

-- Tabela para armazenar as pessoas
CREATE TABLE Pessoas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    rg VARCHAR(20) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    profissao VARCHAR(100),
    pis_pasep VARCHAR(20),
    empresa VARCHAR(255)
);

-- Tabela para armazenar os temas
CREATE TABLE Temas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    coordenador_id INT,
    FOREIGN KEY (coordenador_id) REFERENCES Pessoas(id)
);

-- Tabela para armazenar os comitês
CREATE TABLE Comites (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tema_id INT,
    FOREIGN KEY (tema_id) REFERENCES Temas(id)
);

-- Tabela para armazenar a relação entre comitês e pessoas
CREATE TABLE Comites_Pessoas (
    comite_id INT,
    pessoa_id INT,
    PRIMARY KEY (comite_id, pessoa_id),
    FOREIGN KEY (comite_id) REFERENCES Comites(id),
    FOREIGN KEY (pessoa_id) REFERENCES Pessoas(id)
);

-- Tabela para armazenar os projetos
CREATE TABLE Projetos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    coordenador_id INT,
    tema_id INT,
    orcamento DECIMAL(15, 2),
    situacao VARCHAR(50),
    data_inicio DATE,
    data_termino_previsto DATE,
    documento_proposta TEXT,
    documento_descritivo TEXT,
    FOREIGN KEY (coordenador_id) REFERENCES Pessoas(id),
    FOREIGN KEY (tema_id) REFERENCES Temas(id)
);

-- Tabela para armazenar a relação entre projetos e pessoas (corpo técnico-científico)
CREATE TABLE Projetos_Pessoas (
    projeto_id INT,
    pessoa_id INT,
    horas_dedicadas INT,
    PRIMARY KEY (projeto_id, pessoa_id),
    FOREIGN KEY (projeto_id) REFERENCES Projetos(id),
    FOREIGN KEY (pessoa_id) REFERENCES Pessoas(id)
);

-- Tabela para armazenar os espaços
CREATE TABLE Espacos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    endereco TEXT,
    capacidade INT,
    horario_funcionamento VARCHAR(100),
    informacoes_contato TEXT,
    site VARCHAR(255)
);

-- Tabela para armazenar a relação entre projetos e espaços
CREATE TABLE Projetos_Espacos (
    projeto_id INT,
    espaco_id INT,
    sede BOOLEAN,
    PRIMARY KEY (projeto_id, espaco_id),
    FOREIGN KEY (projeto_id) REFERENCES Projetos(id),
    FOREIGN KEY (espaco_id) REFERENCES Espacos(id)
);

-- Tabela para armazenar os documentos
CREATE TABLE Documentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    resumo TEXT,
    palavras_chave TEXT,
    data_publicacao DATE,
    data_revisao DATE,
    corpo TEXT,
    referencias TEXT,
    site_publicacao VARCHAR(255),
    local_publicacao VARCHAR(255),
    isbn VARCHAR(20),
    citacoes INT
);

-- Tabela para armazenar os resultados dos projetos
CREATE TABLE Resultados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    projeto_id INT,
    documento_id INT,
    tipo VARCHAR(50),
    FOREIGN KEY (projeto_id) REFERENCES Projetos(id),
    FOREIGN KEY (documento_id) REFERENCES Documentos(id)
);

-- Tabela para armazenar a relação entre resultados e pessoas (autores)
CREATE TABLE Resultados_Autores (
    resultado_id INT,
    autor_id INT,
    PRIMARY KEY (resultado_id, autor_id),
    FOREIGN KEY (resultado_id) REFERENCES Resultados(id),
    FOREIGN KEY (autor_id) REFERENCES Pessoas(id)
);

-- Tabela para armazenar os prêmios dos resultados
CREATE TABLE Premios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    resultado_id INT,
    descricao TEXT,
    FOREIGN KEY (resultado_id) REFERENCES Resultados(id)
);
