-- ----------------------------------------------------------------
--   Conecta ao banco postgres e recria o banco db_easy_talk
-- ----------------------------------------------------------------
\c postgres;

DROP DATABASE IF EXISTS db_easy_talk;
CREATE DATABASE db_easy_talk;

\c db_easy_talk;

-- ----------------------------------------------------------------
--   1) Criação dos tipos ENUM
-- ----------------------------------------------------------------

-- Estado da consulta, conforme UML
CREATE TYPE estado_consulta_enum AS ENUM ('SOLICITADA',
    'CONFIRMADA',
    'CANCELADA',
    'EM_ANDAMENTO',
    'FINALIZADA');


-- ----------------------------------------------------------------
--   2) Criação de Tabelas
-- ----------------------------------------------------------------

-- 2.1) Tabela de usuários (dados comuns de autenticação)
CREATE TABLE IF NOT EXISTS tb_users
(
    id       BIGSERIAL,             -- ID autoincrementável
    email    VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,

    UNIQUE (email),

    PRIMARY KEY (id)
);

-- 2.2) Tabela de clientes (subtipo de usuário)
CREATE TABLE IF NOT EXISTS tb_clientes
(
    nome    VARCHAR(255) NOT NULL,
    cpf     VARCHAR(14)  NOT NULL,
    foto    VARCHAR(255),
    user_id BIGINT       NOT NULL, -- Associação com tb_users

    UNIQUE (cpf),

    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES tb_users (id)
);

-- 2.3) Tabela de psicólogos (subtipo de usuário)
CREATE TABLE IF NOT EXISTS tb_psicologos
(
    nome_completo    VARCHAR(255) NOT NULL,
    crp              VARCHAR(50)  NOT NULL,
    numero_registro  VARCHAR(50),
    foto             VARCHAR(255),
    descricao        TEXT,
    duracao_consulta INT,                   -- Duração padrão da consulta (em minutos)
    valor_consulta   NUMERIC(10, 2),
    user_id          BIGINT       NOT NULL, -- Associação com tb_users

    UNIQUE (crp),

    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES tb_users (id)
);

-- 2.4) Tabela das especializações (existe independentemente)
CREATE TABLE IF NOT EXISTS tb_especializacoes
(
    id        BIGSERIAL,
    titulo    VARCHAR(100) NOT NULL, -- Título/nome da especialização
    descricao TEXT,                  -- Descrição da especialização

    UNIQUE (titulo),

    PRIMARY KEY (id)
);

-- 2.5) Tabela de relacionamento muitos-para-muitos
--      entre psicólogos e especializações
CREATE TABLE IF NOT EXISTS tb_psicologo_especializacoes
(
    psicologo_id      BIGINT NOT NULL,
    especializacao_id BIGINT NOT NULL,

    PRIMARY KEY (psicologo_id, especializacao_id),

    FOREIGN KEY (psicologo_id) REFERENCES tb_psicologos (id),
    FOREIGN KEY (especializacao_id) REFERENCES tb_especializacoes (id)
);

-- 2.6) Tabela para armazenar os horários disponíveis dos psicólogos
--      (podemos armazenar um timestamp único ou um período de início/fim)
CREATE TABLE IF NOT EXISTS tb_psicologo_horarios
(
    id           BIGSERIAL,          -- ID autoincrementável
    psicologo_id BIGINT    NOT NULL,
    horario      TIMESTAMP NOT NULL, -- Horário específico disponível

    PRIMARY KEY (id),

    FOREIGN KEY (psicologo_id) REFERENCES tb_psicologos (id)
);

-- 2.7) Tabela de consultas
CREATE TABLE IF NOT EXISTS tb_consultas
(
    id           BIGSERIAL,                     -- ID autoincrementável
    data_hora    TIMESTAMP            NOT NULL,
    duracao      INT,
    estado       estado_consulta_enum NOT NULL, -- SOLICITADA, CONFIRMADA, CANCELADA...
    cliente_id   BIGINT               NOT NULL,
    psicologo_id BIGINT               NOT NULL,

    PRIMARY KEY (id),

    FOREIGN KEY (cliente_id) REFERENCES tb_clientes (id),
    FOREIGN KEY (psicologo_id) REFERENCES tb_psicologos (id)
);

-- 2.8) Tabela para Checklist de Tarefas
--      (uma consulta pode ter, no máximo, um checklist)
CREATE TABLE IF NOT EXISTS tb_checklist_tarefa
(
    id          BIGSERIAL,
    consulta_id BIGINT,
    texto       TEXT, -- pode ser JSON, texto simples, etc.

    UNIQUE (consulta_id),

    PRIMARY KEY (id),
    FOREIGN KEY (consulta_id) REFERENCES tb_consultas (id)
);

-- 2.9) Tabela para Anotações de cada consulta
--      (uma consulta pode ter várias anotações)
CREATE TABLE IF NOT EXISTS tb_anotacao
(
    id          BIGSERIAL,
    consulta_id BIGINT NOT NULL,
    texto       TEXT   NOT NULL,

    UNIQUE (consulta_id),

    PRIMARY KEY (id),
    FOREIGN KEY (consulta_id) REFERENCES tb_consultas (id)
);

-- ----------------------------------------------------------------
--   3) Comandos de DROP (tabelas e tipos ENUM)
--      (Podem ser executados no início ou no final,
--       dependendo do fluxo de desenvolvimento)
-- ----------------------------------------------------------------

/*
DROP TABLE IF EXISTS tb_anotacao CASCADE;
DROP TABLE IF EXISTS tb_checklist_tarefa CASCADE;
DROP TABLE IF EXISTS tb_consultas CASCADE;
DROP TABLE IF EXISTS tb_psicologo_horarios CASCADE;
DROP TABLE IF EXISTS tb_psicologo_especializacoes CASCADE;
DROP TABLE IF EXISTS tb_especializacoes CASCADE;
DROP TABLE IF EXISTS tb_psicologos CASCADE;
DROP TABLE IF EXISTS tb_clientes CASCADE;
DROP TABLE IF EXISTS tb_users CASCADE;

DROP TYPE IF EXISTS funcao_enum CASCADE;
DROP TYPE IF EXISTS tipo_consulta_enum CASCADE;
DROP TYPE IF EXISTS estado_consulta_enum CASCADE;
*/