\c postgres
\c db_easy_talk


-----------------------------
-- Seed de dados para tb_users
-----------------------------
INSERT INTO tb_users (email, password, role) VALUES
  ('admin@example.com', 'admin123', 'ADMIN'),
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
-- (Supondo que os usuários com role PACIENTE foram gerados com IDs 2 a 6)
-----------------------------
INSERT INTO tb_clientes (nome, email, cpf, foto, user_id) VALUES
  ('Client One', 'client1@example.com', '111.111.111-11', 'client1.jpg', 2),
  ('Client Two', 'client2@example.com', '222.222.222-22', 'client2.jpg', 3),
  ('Client Three', 'client3@example.com', '333.333.333-33', 'client3.jpg', 4),
  ('Client Four', 'client4@example.com', '444.444.444-44', 'client4.jpg', 5),
  ('Client Five', 'client5@example.com', '555.555.555-55', 'client5.jpg', 6);

-----------------------------
-- Seed de dados para tb_psicologos
-- (Supondo que os usuários com role PSICÓLOGO foram gerados com IDs 7 a 11)
-----------------------------
INSERT INTO tb_psicologos (nome_completo, email, crp, numero_registro, foto, descricao, valor_consulta, user_id) VALUES
  ('Psych One', 'psych1@example.com', 'CRP001', 'REG001', 'psych1.jpg', 'Descrição do psicólogo 1', 150.00, 7),
  ('Psych Two', 'psych2@example.com', 'CRP002', 'REG002', 'psych2.jpg', 'Descrição do psicólogo 2', 180.00, 8),
  ('Psych Three', 'psych3@example.com', 'CRP003', 'REG003', 'psych3.jpg', 'Descrição do psicólogo 3', 200.00, 9),
  ('Psych Four', 'psych4@example.com', 'CRP004', 'REG004', 'psych4.jpg', 'Descrição do psicólogo 4', 220.00, 10),
  ('Psych Five', 'psych5@example.com', 'CRP005', 'REG005', 'psych5.jpg', 'Descrição do psicólogo 5', 250.00, 11);

-----------------------------
-- Seed de dados para tb_especializacoes
-----------------------------
INSERT INTO tb_especializacoes (nome) VALUES
  ('Relacionamento'),
  ('Social'),
  ('Infantil'),
  ('Hospitalar'),
  ('Trabalho');

-----------------------------
-- Seed de dados para tb_psicologo_especializacoes
-- (Assumindo que os psicólogos, inseridos em tb_psicologos, recebem IDs 1 a 5 nesta tabela)
-----------------------------
INSERT INTO tb_psicologo_especializacoes (psicologo_id, especializacao_id) VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5);

-----------------------------
-- Seed de dados para tb_psicologo_horarios
-----------------------------
INSERT INTO tb_psicologo_horarios (psicologo_id, horario) VALUES
  (1, '2025-04-01 09:00:00'),
  (2, '2025-04-01 10:00:00'),
  (3, '2025-04-01 11:00:00'),
  (4, '2025-04-01 14:00:00'),
  (5, '2025-04-01 15:00:00');

-----------------------------
-- Seed de dados para tb_consultas
-- (Utilizando os clientes e psicólogos previamente inseridos.
--  Os IDs dos clientes em tb_clientes serão 1 a 5 e dos psicólogos em tb_psicologos serão 1 a 5)
-----------------------------
INSERT INTO tb_consultas (data_hora, duracao, tipo, status, cliente_id, psicologo_id) VALUES
  ('2025-04-10 09:00:00', 60, 'MENSAGEM', 'AGENDADA', 1, 1),
  ('2025-04-11 10:00:00', 45, 'LIGACAO', 'EM_ANDAMENTO', 2, 2),
  ('2025-04-12 11:00:00', 30, 'VIDEOCHAMADA', 'FINALIZADA', 3, 3),
  ('2025-04-13 14:00:00', 50, 'MENSAGEM', 'AGENDADA', 4, 4),
  ('2025-04-14 15:00:00', 55, 'LIGACAO', 'EM_ANDAMENTO', 5, 5);

-----------------------------
-- Seed de dados para tb_checklist_tarefa
-- (Cada consulta tem no máximo um checklist)
-----------------------------
INSERT INTO tb_checklist_tarefa (consulta_id, tarefas) VALUES
  (1, '["Tarefa 1", "Tarefa 2"]'),
  (2, '["Tarefa 3", "Tarefa 4"]'),
  (3, '["Tarefa 5", "Tarefa 6"]'),
  (4, '["Tarefa 7", "Tarefa 8"]'),
  (5, '["Tarefa 9", "Tarefa 10"]');

-----------------------------
-- Seed de dados para tb_anotacao_consulta
-- (Uma consulta pode ter várias anotações; neste seed, cada consulta recebe uma anotação)
-----------------------------
INSERT INTO tb_anotacao_consulta (consulta_id, anotacao) VALUES
  (1, 'Anotação para consulta 1'),
  (2, 'Anotação para consulta 2'),
  (3, 'Anotação para consulta 3'),
  (4, 'Anotação para consulta 4'),
  (5, 'Anotação para consulta 5');
