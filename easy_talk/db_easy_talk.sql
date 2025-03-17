\c postgres

-- Criação do banco de dados "db_easy_talk"
DROP DATABASE IF EXISTS db_easy_talk;
CREATE DATABASE db_easy_talk;

\c db_easy_talk

-- Criação dos tipos ENUM
CREATE TYPE funcao_enum AS ENUM ('ADMIN', 'PACIENTE', 'PSICÓLOGO');
CREATE TYPE tipo_consulta_enum AS ENUM ('MENSAGEM', 'LIGACAO', 'VIDEOCHAMADA');
CREATE TYPE status_consulta_enum AS ENUM ('AGENDADA', 'EM_ANDAMENTO', 'FINALIZADA');


-- Tabela de usuários (dados comuns de autenticação)
CREATE TABLE IF NOT EXISTS tb_users
(
    id       BIGSERIAL,             -- ID longo autoincrementável
    email    VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role     funcao_enum  NOT NULL, -- Usando o ENUM diretamente

    PRIMARY KEY (id)
);


-- Tabela de clientes, composta por um User
CREATE TABLE IF NOT EXISTS tb_clientes
(
    id      BIGSERIAL PRIMARY KEY, -- ID longo autoincrementável
    nome    VARCHAR(255) NOT NULL,
    email   VARCHAR(255) NOT NULL,
    cpf     VARCHAR(14)  NOT NULL UNIQUE,
    foto    VARCHAR(255),
    user_id UUID         NOT NULL,
    CONSTRAINT uq_cliente_email UNIQUE (email),
    CONSTRAINT uq_cliente_cpf UNIQUE (cpf),
    CONSTRAINT fk_cliente_user FOREIGN KEY (user_id) REFERENCES tb_users (id)
);

-- Tabela de psicólogos, composta por um User
CREATE TABLE IF NOT EXISTS tb_psicologos
(
    id              BIGSERIAL PRIMARY KEY, -- ID longo autoincrementável
    nome_completo   VARCHAR(255) NOT NULL,
    email           VARCHAR(255) NOT NULL,
    crp             VARCHAR(50)  NOT NULL,
    numero_registro VARCHAR(50),
    foto            VARCHAR(255),
    descricao       TEXT,
    valor_consulta  NUMERIC(10, 2),
    user_id         UUID         NOT NULL,
    CONSTRAINT uq_psicologo_email UNIQUE (email),
    CONSTRAINT uq_psicologo_crp UNIQUE (crp),
    CONSTRAINT fk_psicologo_user FOREIGN KEY (user_id) REFERENCES tb_users (id)
);

-- Tabela para as especializações (ex.: relacionamento, social, infantil, hospitalar, etc.)
CREATE TABLE IF NOT EXISTS tb_especializacoes
(
    id   SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);

-- Tabela de relacionamento muitos-para-muitos entre Psicólogos e Especializações
CREATE TABLE IF NOT EXISTS tb_psicologo_especializacoes
(
    psicologo_id      UUID NOT NULL,
    especializacao_id INT  NOT NULL,
    PRIMARY KEY (psicologo_id, especializacao_id),
    CONSTRAINT fk_pe_psicologo FOREIGN KEY (psicologo_id) REFERENCES tb_psicologos (id),
    CONSTRAINT fk_pe_especializacao FOREIGN KEY (especializacao_id) REFERENCES tb_especializacoes (id)
);

-- Tabela para armazenar os horários disponíveis dos psicólogos
CREATE TABLE IF NOT EXISTS tb_psicologo_horarios
(
    id           BIGSERIAL PRIMARY KEY, -- ID longo autoincrementável
    psicologo_id UUID      NOT NULL,
    horario      TIMESTAMP NOT NULL,
    CONSTRAINT fk_horario_psicologo FOREIGN KEY (psicologo_id) REFERENCES tb_psicologos (id)
);

-- Tabela de consultas
CREATE TABLE IF NOT EXISTS tb_consultas
(
    id           BIGSERIAL PRIMARY KEY, -- ID longo autoincrementável
    data_hora    TIMESTAMP            NOT NULL,
    duracao      INT,
    tipo         tipo_consulta_enum   NOT NULL,
    status       status_consulta_enum NOT NULL,
    cliente_id   UUID                 NOT NULL,
    psicologo_id UUID                 NOT NULL,
    CONSTRAINT fk_consulta_cliente FOREIGN KEY (cliente_id) REFERENCES tb_clientes (id),
    CONSTRAINT fk_consulta_psicologo FOREIGN KEY (psicologo_id) REFERENCES tb_psicologos (id)
);

-- Tabela para o Checklist de Tarefas (cada consulta pode ter, no máximo, um checklist)
CREATE TABLE IF NOT EXISTS tb_checklist_tarefa
(
    id          BIGSERIAL PRIMARY KEY, -- ID longo autoincrementável
    consulta_id UUID UNIQUE,
    tarefas     TEXT,                  -- Pode ser armazenado em formato JSON ou texto delimitado
    CONSTRAINT fk_checklist_consulta FOREIGN KEY (consulta_id) REFERENCES tb_consultas (id)
);

-- Tabela para as Anotações das Consultas (uma consulta pode ter várias anotações)
CREATE TABLE IF NOT EXISTS tb_anotacao_consulta
(
    id          BIGSERIAL PRIMARY KEY, -- ID longo autoincrementável
    consulta_id UUID NOT NULL,
    anotacao    TEXT NOT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_anotacao_consulta FOREIGN KEY (consulta_id) REFERENCES tb_consultas (id)
);
