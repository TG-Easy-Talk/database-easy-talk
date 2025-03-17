\c postgres

-- Criação do banco de dados "db_easy_talk"
DROP DATABASE IF EXISTS db_easy_talk;
CREATE DATABASE db_easy_talk;

-- Define o search_path para facilitar o uso dos objetos dentro do schema
\c db_easy_talk

-- Criação dos tipos ENUM
CREATE TYPE funcao_enum AS ENUM ('ADMIN', 'PACIENTE', 'PSICÓLOGO');
CREATE TYPE tipo_consulta_enum AS ENUM ('MENSAGEM', 'LIGACAO', 'VIDEOCHAMADA');
CREATE TYPE status_consulta_enum AS ENUM ('AGENDADA', 'EM_ANDAMENTO', 'FINALIZADA');

-- Tabela de usuários (dados comuns de autenticação)
CREATE TABLE IF NOT EXISTS tb_users
(
    id       BIGSERIAL,             -- ID longo autoincrementável
    email    VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role     funcao_enum  NOT NULL, -- Usando o ENUM diretamente

    UNIQUE (email),

    PRIMARY KEY (id)
);

-- Tabela de clientes, composta por um User
CREATE TABLE IF NOT EXISTS tb_clientes
(
    id      BIGSERIAL, -- ID longo autoincrementável
    nome    VARCHAR(255) NOT NULL,
    email   VARCHAR(255) NOT NULL,
    cpf     VARCHAR(14)  NOT NULL,
    foto    VARCHAR(255),
    user_id BIGSERIAL    NOT NULL,

    PRIMARY KEY (id),

    UNIQUE (email),
    UNIQUE (cpf),

    FOREIGN KEY (user_id) REFERENCES tb_users (id)
);

-- Tabela de psicólogos, composta por um User
CREATE TABLE IF NOT EXISTS tb_psicologos
(
    id              BIGSERIAL, -- ID longo autoincrementável
    nome_completo   VARCHAR(255) NOT NULL,
    email           VARCHAR(255) NOT NULL,
    crp             VARCHAR(50)  NOT NULL,
    numero_registro VARCHAR(50),
    foto            VARCHAR(255),
    descricao       TEXT,
    valor_consulta  NUMERIC(10, 2),
    user_id         BIGSERIAL    NOT NULL,

    UNIQUE (email),
    UNIQUE (crp),

    PRIMARY KEY (id),

    FOREIGN KEY (user_id) REFERENCES tb_users (id)
);

-- Tabela para as especializações (ex.: relacionamento, social, infantil, hospitalar, etc.)
CREATE TABLE IF NOT EXISTS tb_especializacoes
(
    id   SERIAL,
    nome VARCHAR(100) NOT NULL,

    UNIQUE (nome),

    PRIMARY KEY (id)
);

-- Tabela de relacionamento muitos-para-muitos entre Psicólogos e Especializações
CREATE TABLE IF NOT EXISTS tb_psicologo_especializacoes
(
    psicologo_id      BIGSERIAL NOT NULL,
    especializacao_id INT       NOT NULL,

    PRIMARY KEY (psicologo_id, especializacao_id),

    FOREIGN KEY (psicologo_id) REFERENCES tb_psicologos (id),
    FOREIGN KEY (especializacao_id) REFERENCES tb_especializacoes (id)
);

-- Tabela para armazenar os horários disponíveis dos psicólogos
CREATE TABLE IF NOT EXISTS tb_psicologo_horarios
(
    id           BIGSERIAL, -- ID longo autoincrementável
    psicologo_id BIGSERIAL      NOT NULL,
    horario      TIMESTAMP NOT NULL,

    PRIMARY KEY (id),

    FOREIGN KEY (psicologo_id) REFERENCES tb_psicologos (id)
);

-- Tabela de consultas
CREATE TABLE IF NOT EXISTS tb_consultas
(
    id           BIGSERIAL, -- ID longo autoincrementável
    data_hora    TIMESTAMP            NOT NULL,
    duracao      INT,
    tipo         tipo_consulta_enum   NOT NULL,
    status       status_consulta_enum NOT NULL,
    cliente_id   BIGSERIAL            NOT NULL,
    psicologo_id BIGSERIAL            NOT NULL,

    PRIMARY KEY (id),

    FOREIGN KEY (cliente_id) REFERENCES tb_clientes (id),
    FOREIGN KEY (psicologo_id) REFERENCES tb_psicologos (id)
);

-- Tabela para o Checklist de Tarefas (cada consulta pode ter, no máximo, um checklist)
CREATE TABLE IF NOT EXISTS tb_checklist_tarefa
(
    id          BIGSERIAL, -- ID longo autoincrementável
    consulta_id BIGSERIAL,
    tarefas     TEXT,      -- Pode ser armazenado em formato JSON ou texto delimitado

    UNIQUE (consulta_id),

    PRIMARY KEY (id),
    FOREIGN KEY (consulta_id) REFERENCES tb_consultas (id)
);

-- Tabela para as Anotações das Consultas (uma consulta pode ter várias anotações)
CREATE TABLE IF NOT EXISTS tb_anotacao_consulta
(
    id          BIGSERIAL, -- ID longo autoincrementável
    consulta_id BIGSERIAL NOT NULL,
    anotacao    TEXT      NOT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),

    FOREIGN KEY (consulta_id) REFERENCES tb_consultas (id)
);


-- Comandos para apagar todas as tabelas criadas, em ordem que respeita as dependências
DROP TABLE IF EXISTS tb_anotacao_consulta CASCADE;
DROP TABLE IF EXISTS tb_checklist_tarefa CASCADE;
DROP TABLE IF EXISTS tb_consultas CASCADE;
DROP TABLE IF EXISTS tb_psicologo_horarios CASCADE;
DROP TABLE IF EXISTS tb_psicologo_especializacoes CASCADE;
DROP TABLE IF EXISTS tb_especializacoes CASCADE;
DROP TABLE IF EXISTS tb_psicologos CASCADE;
DROP TABLE IF EXISTS tb_clientes CASCADE;
DROP TABLE IF EXISTS tb_users CASCADE;

-- Em seguida, apague os tipos ENUM criados
DROP TYPE IF EXISTS funcao_enum CASCADE;
DROP TYPE IF EXISTS tipo_consulta_enum CASCADE;
DROP TYPE IF EXISTS status_consulta_enum CASCADE;