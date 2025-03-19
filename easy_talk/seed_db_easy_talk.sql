\c postgres
\c db_easy_talk

-----------------------------
-- Seed de dados para tb_users
-----------------------------
INSERT INTO tb_users (email, password, role)
VALUES ('admin@example.com', 'admin123', 'ADMIN'),
       ('client1@example.com', 'client123', 'PACIENTE'),
       ('client2@example.com', 'client123', 'PACIENTE'),
       ('client3@example.com', 'client123', 'PACIENTE'),
       ('client4@example.com', 'client123', 'PACIENTE'),
       ('client5@example.com', 'client123', 'PACIENTE'),
       ('psych1@example.com', 'psych123', 'PSICÓLOGO'),
       ('psych2@example.com', 'psych123', 'PSICÓLOGO'),
       ('psych3@example.com', 'psych123', 'PSICÓLOGO'),
       ('psych4@example.com', 'psych123', 'PSICÓLOGO'),
       ('psych5@example.com', 'psych123', 'PSICÓLOGO');

-----------------------------
-- Seed de dados para tb_clientes
-----------------------------
INSERT INTO tb_clientes (nome, cpf, foto, user_id)
VALUES ('Client One', '111.111.111-11', 'client1.jpg', 2),
       ('Client Two', '222.222.222-22', 'client2.jpg', 3),
       ('Client Three', '333.333.333-33', 'client3.jpg', 4),
       ('Client Four', '444.444.444-44', 'client4.jpg', 5),
       ('Client Five', '555.555.555-55', 'client5.jpg', 6);

-----------------------------
-- Seed de dados para tb_psicologos
-- (Supondo que os usuários com role PSICÓLOGO foram gerados com IDs 7 a 11)
-- Lembrando que a tabela tb_psicologos agora inclui duracao_consulta (INT).
-----------------------------
INSERT INTO tb_psicologos (nome_completo, crp, numero_registro, foto, descricao, duracao_consulta, valor_consulta,
                           user_id)
VALUES ('Psych One', 'CRP001', 'REG001', 'psych1.jpg', 'Descrição do psicólogo 1', 60, 150.00, 7),
       ('Psych Two', 'CRP002', 'REG002', 'psych2.jpg', 'Descrição do psicólogo 2', 50, 180.00, 8),
       ('Psych Three', 'CRP003', 'REG003', 'psych3.jpg', 'Descrição do psicólogo 3', 45, 200.00, 9),
       ('Psych Four', 'CRP004', 'REG004', 'psych4.jpg', 'Descrição do psicólogo 4', 60, 220.00, 10),
       ('Psych Five', 'CRP005', 'REG005', 'psych5.jpg', 'Descrição do psicólogo 5', 90, 250.00, 11);

-----------------------------
-- Seed de dados para tb_especializacoes
-- (Tabelas passaram a ter campos: titulo, descricao)
-----------------------------
INSERT INTO tb_especializacoes (titulo, descricao)
VALUES ('Relacionamento', 'Foco em relacionamentos interpessoais e de casal'),
       ('Social', 'Aspectos sociais e sociabilidade'),
       ('Infantil', 'Psicologia voltada ao público infantil'),
       ('Hospitalar', 'Atuação em ambiente hospitalar'),
       ('Trabalho', 'Foco no contexto de trabalho e carreira');

-----------------------------
-- Seed de dados para tb_psicologo_especializacoes
-----------------------------
-- Psicólogo One: 1 especialização
INSERT INTO tb_psicologo_especializacoes (psicologo_id, especializacao_id)
VALUES (1, 1);

-- Psicólogo Two: 2 especializações
INSERT INTO tb_psicologo_especializacoes (psicologo_id, especializacao_id)
VALUES (2, 2),
       (2, 3);

-- Psicólogo Three: 3 especializações
INSERT INTO tb_psicologo_especializacoes (psicologo_id, especializacao_id)
VALUES (3, 1),
       (3, 3),
       (3, 5);

-- Psicólogo Four: 4 especializações
INSERT INTO tb_psicologo_especializacoes (psicologo_id, especializacao_id)
VALUES (4, 1),
       (4, 2),
       (4, 3),
       (4, 4);

-- Psicólogo Five: 5 especializações
INSERT INTO tb_psicologo_especializacoes (psicologo_id, especializacao_id)
VALUES (5, 1),
       (5, 2),
       (5, 3),
       (5, 4),
       (5, 5);

-----------------------------
-- Seed de dados para tb_psicologo_horarios
-----------------------------
INSERT INTO tb_psicologo_horarios (psicologo_id, horario)
VALUES (1, '2025-04-01 09:00:00'),
       (2, '2025-04-01 10:00:00'),
       (3, '2025-04-01 11:00:00'),
       (4, '2025-04-01 14:00:00'),
       (5, '2025-04-01 15:00:00');

-----------------------------
-- Seed de dados para tb_consultas
-- (Utilizando 'estado_consulta_enum' no campo estado)
-- (Mapeando 'AGENDADA' → 'SOLICITADA' para ficar coerente com a UML)
-----------------------------
INSERT INTO tb_consultas (data_hora, duracao, tipo, estado, cliente_id, psicologo_id)
VALUES ('2025-04-10 09:00:00', 60, 'MENSAGEM', 'SOLICITADA', 1, 1),
       ('2025-04-11 10:00:00', 45, 'LIGACAO', 'EM_ANDAMENTO', 2, 2),
       ('2025-04-12 11:00:00', 30, 'VIDEOCHAMADA', 'FINALIZADA', 3, 3),
       ('2025-04-13 14:00:00', 50, 'MENSAGEM', 'SOLICITADA', 4, 4),
       ('2025-04-14 15:00:00', 55, 'LIGACAO', 'EM_ANDAMENTO', 5, 5);

-----------------------------
-- Seed de dados para tb_checklist_tarefa
-- (Uma consulta pode ter, no máximo, um checklist)
-----------------------------
INSERT INTO tb_checklist_tarefa (consulta_id, tarefas)
VALUES (1, '["Tarefa 1", "Tarefa 2"]'),
       (2, '["Tarefa 3", "Tarefa 4"]'),
       (3, '["Tarefa 5", "Tarefa 6"]'),
       (4, '["Tarefa 7", "Tarefa 8"]'),
       (5, '["Tarefa 9", "Tarefa 10"]');

-----------------------------
-- Seed de dados para tb_anotacao_consulta
-- (Uma consulta pode ter várias anotações; aqui cada consulta recebe uma)
-----------------------------
INSERT INTO tb_anotacao_consulta (consulta_id, anotacao)
VALUES (1, 'Anotação para consulta 1'),
       (2, 'Anotação para consulta 2'),
       (3, 'Anotação para consulta 3'),
       (4, 'Anotação para consulta 4'),
       (5, 'Anotação para consulta 5');


-- Comando para excluir todas as inserções das tabelas, sem excluir as tabelas:
-- TRUNCATE TABLE tb_anotacao_consulta,
--     tb_checklist_tarefa,
--     tb_consultas,
--     tb_psicologo_horarios,
--     tb_psicologo_especializacoes,
--     tb_especializacoes,
--     tb_psicologos,
--     tb_clientes,
--     tb_users
--     RESTART IDENTITY CASCADE;