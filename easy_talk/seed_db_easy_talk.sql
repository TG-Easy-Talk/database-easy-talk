\c postgres;
\c db_easy_talk;

--------------------------------------------------
-- Seed de dados para tb_users
--------------------------------------------------
-- Insere 10 usuários: os 5 primeiros serão para clientes e os 5 seguintes para psicólogos.
INSERT INTO tb_users (email, senha)
VALUES ('client1@example.com', 'pass1'),
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
VALUES ('Client One', '111.111.111-11', 'client1.jpg', 1),
       ('Client Two', '222.222.222-22', 'client2.jpg', 2),
       ('Client Three', '333.333.333-33', 'client3.jpg', 3),
       ('Client Four', '444.444.444-44', 'client4.jpg', 4),
       ('Client Five', '555.555.555-55', 'client5.jpg', 5);

--------------------------------------------------
-- Seed de dados para tb_psicologos
--------------------------------------------------
-- Os psicólogos referenciam os usuários com IDs 6 a 10
INSERT INTO tb_psicologos
(nome_completo, crp, numero_registro, foto, descricao, duracao_consulta, valor_consulta, user_id, disponibilidade)
VALUES ('Psych One',
        'CRP001',
        'REG001',
        'psych1.jpg',
        'Descrição do Psicólogo 1',
        60,
        150.00,
        6,
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
        ]'::jsonb),
       ('Psych Two',
        'CRP002',
        'REG002',
        'psych2.jpg',
        'Descrição do Psicólogo 2',
        50,
        180.00,
        7,
        '[
          {
            "dia_semana": 2,
            "intervalos": [
              {
                "horario_inicio": "08:00",
                "horario_fim": "11:00"
              },
              {
                "horario_inicio": "13:00",
                "horario_fim": "17:00"
              }
            ]
          },
          {
            "dia_semana": 4,
            "intervalos": [
              {
                "horario_inicio": "09:00",
                "horario_fim": "15:00"
              }
            ]
          }
        ]'::jsonb),
       ('Psych Three',
        'CRP003',
        'REG003',
        'psych3.jpg',
        'Descrição do Psicólogo 3',
        45,
        200.00,
        8,
        '[
          {
            "dia_semana": 1,
            "intervalos": [
              {
                "horario_inicio": "10:00",
                "horario_fim": "13:00"
              }
            ]
          },
          {
            "dia_semana": 5,
            "intervalos": [
              {
                "horario_inicio": "14:00",
                "horario_fim": "18:00"
              }
            ]
          }
        ]'::jsonb),
       ('Psych Four',
        'CRP004',
        'REG004',
        'psych4.jpg',
        'Descrição do Psicólogo 4',
        60,
        220.00,
        9,
        '[
          {
            "dia_semana": 3,
            "intervalos": [
              {
                "horario_inicio": "09:00",
                "horario_fim": "12:00"
              }
            ]
          },
          {
            "dia_semana": 5,
            "intervalos": [
              {
                "horario_inicio": "10:00",
                "horario_fim": "15:00"
              }
            ]
          }
        ]'::jsonb),
       ('Psych Five',
        'CRP005',
        'REG005',
        'psych5.jpg',
        'Descrição do Psicólogo 5',
        90,
        250.00,
        10,
        '[
          {
            "dia_semana": 1,
            "intervalos": [
              {
                "horario_inicio": "08:00",
                "horario_fim": "11:00"
              }
            ]
          },
          {
            "dia_semana": 3,
            "intervalos": [
              {
                "horario_inicio": "13:00",
                "horario_fim": "17:00"
              }
            ]
          }
        ]'::jsonb);

--------------------------------------------------
-- Seed de dados para tb_especializacoes
--------------------------------------------------
INSERT INTO tb_especializacoes (titulo, descricao)
VALUES ('Relacionamento', 'Especialização em relacionamento interpessoal'),
       ('Social', 'Especialização em questões sociais'),
       ('Infantil', 'Especialização em psicologia infantil'),
       ('Hospitalar', 'Especialização em ambiente hospitalar'),
       ('Trabalho', 'Especialização em psicologia organizacional');

--------------------------------------------------
-- Seed de dados para tb_psicologo_especializacoes
--------------------------------------------------
-- Relaciona cada psicólogo a uma especialização distinta
-- ATENÇÃO: Supondo que os IDs dos psicólogos inseridos sejam 1, 2, 3, 4 e 5.
INSERT INTO tb_psicologo_especializacoes (psicologo_id, especializacao_id)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5);

INSERT INTO tb_consultas
(data_hora, duracao, estado, cliente_id, psicologo_id, checklist_tarefa, anotacao)
VALUES ('2025-04-10 09:00:00',
        60,
        'SOLICITADA',
        1,
        1,
        '[
          {
            "titulo": "Checar documentos",
            "concluido": false
          },
          {
            "titulo": "Confirmar consulta",
            "concluido": false
          }
        ]',
        'Consulta agendada para avaliação inicial.'),
       ('2025-04-11 10:00:00',
        45,
        'CONFIRMADA',
        2,
        2,
        '[
          {
            "titulo": "Preparar sala",
            "concluido": false
          },
          {
            "titulo": "Revisar histórico",
            "concluido": false
          }
        ]',
        'Cliente relatou melhora no humor.'),
       ('2025-04-12 11:00:00',
        30,
        'CANCELADA',
        3,
        3,
        '[
          {
            "titulo": "Reagendar consulta",
            "concluido": false
          },
          {
            "titulo": "Avisar secretaria",
            "concluido": false
          }
        ]',
        'Consulta cancelada pelo cliente.'),
       ('2025-04-13 14:00:00',
        50,
        'EM_ANDAMENTO',
        4,
        4,
        '[
          {
            "titulo": "Verificar resultados",
            "concluido": false
          },
          {
            "titulo": "Acompanhar evolução",
            "concluido": false
          }
        ]',
        'Sessão em andamento, focada em ansiedade.'),
       ('2025-04-14 15:00:00',
        55,
        'FINALIZADA',
        5,
        5,
        '[
          {
            "titulo": "Finalizar relatório",
            "concluido": false
          },
          {
            "titulo": "Encaminhar para revisão",
            "concluido": false
          }
        ]',
        'Consulta finalizada com sucesso, encaminhado para relatório.');

SELECT * FROM tb_users;
SELECT * FROM tb_clientes;
SELECT * FROM tb_psicologos;
SELECT * FROM tb_especializacoes;
SELECT * FROM tb_psicologo_especializacoes;
SELECT * FROM tb_consultas;


-- TRUNCATE TABLE
--     tb_consultas,
--     tb_psicologo_especializacoes,
--     tb_especializacoes,
--     tb_psicologos,
--     tb_clientes,
--     tb_users
--     RESTART IDENTITY CASCADE;
