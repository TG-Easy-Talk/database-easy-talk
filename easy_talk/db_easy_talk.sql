-- ----------------------------------------------------------------
--   Conecta ao banco postgres e recria o banco db_easy_talk
-- ----------------------------------------------------------------
\c postgres;
\c db_easy_talk;

DROP DATABASE IF EXISTS db_easy_talk;
CREATE DATABASE db_easy_talk;



-- ----------------------------------------------------------------
--   1) Criação dos tipos ENUM
-- ----------------------------------------------------------------

-- Estado da consulta, conforme UML
CREATE TYPE estado_consulta_enum AS ENUM (
    'SOLICITADA',
    'CONFIRMADA',
    'CANCELADA',
    'EM_ANDAMENTO',
    'FINALIZADA'
    );

-- ----------------------------------------------------------------
--   2) Criação de Tabelas
-- ----------------------------------------------------------------

-- 2.1) Tabela de usuários (dados comuns de autenticação)
CREATE TABLE IF NOT EXISTS tb_users
(
    id    BIGSERIAL, -- ID autoincrementável
    email VARCHAR(255) NOT NULL,
    senha VARCHAR(255) NOT NULL,

    UNIQUE (email),

    PRIMARY KEY (id)
);

-- 2.2) Tabela de clientes (subtipo de usuário)
CREATE TABLE IF NOT EXISTS tb_clientes
(
    id      BIGSERIAL,             -- ID autoincrementável
    nome    VARCHAR(255) NOT NULL,
    cpf     VARCHAR(14)  NOT NULL,
    foto    VARCHAR(255),
    user_id BIGINT       NOT NULL, -- Associação com tb_users

    UNIQUE (cpf),

    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES tb_users (id)
);

-- 2.3) Tabela de psicólogos (subtipo de usuário)
CREATE TABLE IF NOT EXISTS tb_psicologos
(
    id               BIGSERIAL,
    nome_completo    VARCHAR(255) NOT NULL,
    crp              VARCHAR(50)  NOT NULL UNIQUE,
    numero_registro  VARCHAR(50),
    foto             VARCHAR(255),
    descricao        TEXT,
    duracao_consulta INT, -- Duração padrão da consulta (em minutos)
    valor_consulta   NUMERIC(10, 2),
    user_id          BIGINT       NOT NULL,
    disponibilidade  JSONB DEFAULT
                               '[
                                 {
                                   "dia_semana": 1,
                                   "intervalos": [
                                     {
                                       "horario_inicio": "09:00",
                                       "horario_fim": "12:00"
                                     },
                                     {
                                       "horario_inicio": "14:00",
                                       "horario_fim": "18:00"
                                     }
                                   ]
                                 },
                                 {
                                   "dia_semana": 3,
                                   "intervalos": [
                                     {
                                       "horario_inicio": "10:00",
                                       "horario_fim": "16:00"
                                     }
                                   ]
                                 }
                               ]'::jsonb,
    PRIMARY KEY (id),
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


-- 2.6) Tabela de consultas (com checklist e anotações integrados)
CREATE TABLE IF NOT EXISTS tb_consultas
(
    id               BIGSERIAL,                     -- ID autoincrementável
    data_hora        TIMESTAMP            NOT NULL,
    duracao          INT,
    estado           estado_consulta_enum NOT NULL, -- SOLICITADA, CONFIRMADA, CANCELADA...
    cliente_id       BIGINT               NOT NULL,
    psicologo_id     BIGINT               NOT NULL,
    checklist_tarefa TEXT,                          -- Checklist de tarefas (pode ser armazenado como JSON ou texto simples)
    anotacao         TEXT,                          -- Anotação da consulta (caso a consulta permita somente uma anotação; se for múltipla, considere usar JSONB ou um array)

    PRIMARY KEY (id),

    FOREIGN KEY (cliente_id) REFERENCES tb_clientes (id),
    FOREIGN KEY (psicologo_id) REFERENCES tb_psicologos (id)
);

-- ----------------------------------------------------------------
--   3) Comandos de DROP (tabelas e tipos ENUM)
--      (Podem ser executados no início ou no final,
--       dependendo do fluxo de desenvolvimento)
-- ----------------------------------------------------------------


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
