\c postgres;
\c db_easy_talk;

--------------------------------------------------
-- Seed de dados para tb_users
--------------------------------------------------
-- Insere 10 usuários: os 5 primeiros serão para clientes e os 5 seguintes para psicólogos.
INSERT INTO tb_users (email, password)
VALUES
    ('client1@example.com', 'pass1'),
    ('client2@example.com', 'pass2'),
    ('client3@example.com', 'pass3'),
    ('client4@example.com', 'pass4'),
    ('client5@example.com', 'pass5'),
    ('psych1@example.com', 'pass6'),
    ('psych2@example.com', 'pass7'),
    ('psych3@example.com', 'pass8'),
    ('psych4@example.com', 'pass9'),
    ('psych5@example.com', 'pass10');

--------------------------------------------------
-- Seed de dados para tb_clientes
--------------------------------------------------
-- Os clientes referenciam os 5 primeiros usuários (IDs 1 a 5)
INSERT INTO tb_clientes (nome, cpf, foto, user_id)
VALUES
    ('Client One', '111.111.111-11', 'client1.jpg', 1),
    ('Client Two', '222.222.222-22', 'client2.jpg', 2),
    ('Client Three', '333.333.333-33', 'client3.jpg', 3),
    ('Client Four', '444.444.444-44', 'client4.jpg', 4),
    ('Client Five', '555.555.555-55', 'client5.jpg', 5);

--------------------------------------------------
-- Seed de dados para tb_psicologos
--------------------------------------------------
-- Os psicólogos referenciam os usuários com IDs 6 a 10
INSERT INTO tb_psicologos (nome_completo, crp, numero_registro, foto, descricao, duracao_consulta, valor_consulta, user_id)
VALUES
    ('Psych One', 'CRP001', 'REG001', 'psych1.jpg', 'Descrição do Psicólogo 1', 60, 150.00, 6),
    ('Psych Two', 'CRP002', 'REG002', 'psych2.jpg', 'Descrição do Psicólogo 2', 50, 180.00, 7),
    ('Psych Three', 'CRP003', 'REG003', 'psych3.jpg', 'Descrição do Psicólogo 3', 45, 200.00, 8),
    ('Psych Four', 'CRP004', 'REG004', 'psych4.jpg', 'Descrição do Psicólogo 4', 60, 220.00, 9),
    ('Psych Five', 'CRP005', 'REG005', 'psych5.jpg', 'Descrição do Psicólogo 5', 90, 250.00, 10);

--------------------------------------------------
-- Seed de dados para tb_especializacoes
--------------------------------------------------
INSERT INTO tb_especializacoes (titulo, descricao)
VALUES
    ('Relacionamento', 'Especialização em relacionamento interpessoal'),
    ('Social', 'Especialização em questões sociais'),
    ('Infantil', 'Especialização em psicologia infantil'),
    ('Hospitalar', 'Especialização em ambiente hospitalar'),
    ('Trabalho', 'Especialização em psicologia organizacional');

--------------------------------------------------
-- Seed de dados para tb_psicologo_especializacoes
--------------------------------------------------
-- Relaciona cada psicólogo a uma especialização distinta
INSERT INTO tb_psicologo_especializacoes (psicologo_id, especializacao_id)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

--------------------------------------------------
-- Seed de dados para tb_psicologo_horarios
--------------------------------------------------
INSERT INTO tb_psicologo_horarios (psicologo_id, horario)
VALUES
    (1, '2025-04-01 09:00:00'),
    (2, '2025-04-01 10:00:00'),
    (3, '2025-04-01 11:00:00'),
    (4, '2025-04-01 14:00:00'),
    (5, '2025-04-01 15:00:00');

--------------------------------------------------
-- Seed de dados para tb_consultas
--------------------------------------------------
-- Cada consulta associa um cliente (IDs 1 a 5) a um psicólogo (IDs 1 a 5)
INSERT INTO tb_consultas (data_hora, duracao, estado, cliente_id, psicologo_id)
VALUES
    ('2025-04-10 09:00:00', 60, 'SOLICITADA', 1, 1),
    ('2025-04-11 10:00:00', 45, 'CONFIRMADA', 2, 2),
    ('2025-04-12 11:00:00', 30, 'CANCELADA', 3, 3),
    ('2025-04-13 14:00:00', 50, 'EM_ANDAMENTO', 4, 4),
    ('2025-04-14 15:00:00', 55, 'FINALIZADA', 5, 5);

--------------------------------------------------
-- Seed de dados para tb_checklist_tarefa
--------------------------------------------------
-- Cada consulta terá um checklist único
INSERT INTO tb_checklist_tarefa (consulta_id, texto)
VALUES
    (1, '["Tarefa A", "Tarefa B"]'),
    (2, '["Tarefa C", "Tarefa D"]'),
    (3, '["Tarefa E", "Tarefa F"]'),
    (4, '["Tarefa G", "Tarefa H"]'),
    (5, '["Tarefa I", "Tarefa J"]');

--------------------------------------------------
-- Seed de dados para tb_anotacao
--------------------------------------------------
-- Cada consulta terá uma anotação associada
INSERT INTO tb_anotacao (consulta_id, texto)
VALUES
    (1, 'Anotação da consulta 1'),
    (2, 'Anotação da consulta 2'),
    (3, 'Anotação da consulta 3'),
    (4, 'Anotação da consulta 4'),
    (5, 'Anotação da consulta 5');
