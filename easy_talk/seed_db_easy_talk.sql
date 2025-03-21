\c postgres;
\c db_easy_talk;

--------------------------------------------------
-- Seed de dados para tb_users
--------------------------------------------------
-- Insere 20 usuários: os 10 primeiros serão para clientes e os 10 seguintes para psicólogos.
INSERT INTO tb_users (email, senha)
VALUES
    -- Clientes (IDs 1 a 10)
    ('carlos.silva@example.com', 'pass1'),
    ('mariana.costa@example.com', 'pass2'),
    ('ana.souza@example.com', 'pass3'),
    ('pedro.oliveira@example.com', 'pass4'),
    ('luiza.martins@example.com', 'pass5'),
    ('rafael.gomes@example.com', 'pass11'),
    ('gabriela.ferreira@example.com', 'pass12'),
    ('bruno.santos@example.com', 'pass13'),
    ('fernanda.lima@example.com', 'pass14'),
    ('ricardo.carvalho@example.com', 'pass15'),

    -- Psicólogos (IDs 11 a 20)
    ('roberto.pereira@example.com', 'pass6'),
    ('camila.oliveira@example.com', 'pass7'),
    ('marcos.silva@example.com', 'pass8'),
    ('adriana.souza@example.com', 'pass9'),
    ('fabio.costa@example.com', 'pass10'),
    ('renata.rocha@example.com', 'pass16'),
    ('lucas.almeida@example.com', 'pass17'),
    ('bianca.martins@example.com', 'pass18'),
    ('andre.lima@example.com', 'pass19'),
    ('juliana.carvalho@example.com', 'pass20');


--------------------------------------------------
-- Seed de dados para tb_clientes
--------------------------------------------------
-- Os clientes referenciam os 10 primeiros usuários (IDs 1 a 10)
INSERT INTO tb_clientes (nome, cpf, foto, user_id)
VALUES ('Carlos da Silva', '111.111.111-11', 'carlos.jpg', 1),
       ('Mariana Costa', '222.222.222-22', 'mariana.jpg', 2),
       ('Ana Paula Souza', '333.333.333-33', 'ana.jpg', 3),
       ('Pedro Oliveira', '444.444.444-44', 'pedro.jpg', 4),
       ('Luiza Martins', '555.555.555-55', 'luiza.jpg', 5),
       ('Rafael Gomes', '666.666.666-66', 'rafael.jpg', 6),
       ('Gabriela Ferreira', '777.777.777-77', 'gabriela.jpg', 7),
       ('Bruno Santos', '888.888.888-88', 'bruno.jpg', 8),
       ('Fernanda Lima', '999.999.999-99', 'fernanda.jpg', 9),
       ('Ricardo Carvalho', '000.000.000-00', 'ricardo.jpg', 10);


--------------------------------------------------
-- Seed de dados para tb_psicologos
--------------------------------------------------
-- Os psicólogos referenciam os usuários com IDs 11 a 20
INSERT INTO tb_psicologos
(nome_completo, crp, numero_registro, foto, descricao, duracao_consulta, valor_consulta, user_id, disponibilidade)
VALUES ('Dr. Roberto Pereira',
        'CRP001',
        'REG001',
        'roberto.jpg',
        'Especialista em terapia cognitivo-comportamental',
        60,
        150.00,
        11,
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
       ('Dra. Camila Oliveira',
        'CRP002',
        'REG002',
        'camila.jpg',
        'Focada em terapia familiar e de casal',
        50,
        180.00,
        12,
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
       ('Dr. Marcos da Silva',
        'CRP003',
        'REG003',
        'marcos.jpg',
        'Especialista em psicologia infantil e adolescente',
        45,
        200.00,
        13,
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
       ('Dra. Adriana Souza',
        'CRP004',
        'REG004',
        'adriana.jpg',
        'Especialista em distúrbios de ansiedade e depressão',
        60,
        220.00,
        14,
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
       ('Dr. Fábio Costa',
        'CRP005',
        'REG005',
        'fabio.jpg',
        'Especialista em neuropsicologia e avaliação cognitiva',
        90,
        250.00,
        15,
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
        ]'::jsonb),
       ('Dra. Renata Rocha',
        'CRP006',
        'REG006',
        'renata.jpg',
        'Experiência em terapia de grupo e abordagens integrativas',
        55,
        190.00,
        16,
        '[
          {
            "dia_semana": 2,
            "intervalos": [
              {
                "horario_inicio": "07:30",
                "horario_fim": "11:30"
              }
            ]
          },
          {
            "dia_semana": 4,
            "intervalos": [
              {
                "horario_inicio": "12:00",
                "horario_fim": "16:00"
              }
            ]
          }
        ]'::jsonb),
       ('Dr. Lucas Almeida',
        'CRP007',
        'REG007',
        'lucas.jpg',
        'Focado em psicologia esportiva e de alta performance',
        50,
        210.00,
        17,
        '[
          {
            "dia_semana": 3,
            "intervalos": [
              {
                "horario_inicio": "10:00",
                "horario_fim": "12:00"
              }
            ]
          },
          {
            "dia_semana": 6,
            "intervalos": [
              {
                "horario_inicio": "09:00",
                "horario_fim": "11:00"
              }
            ]
          }
        ]'::jsonb),
       ('Dra. Bianca Martins',
        'CRP008',
        'REG008',
        'bianca.jpg',
        'Especialista em terapia cognitivo-comportamental e mindfulness',
        65,
        230.00,
        18,
        '[
          {
            "dia_semana": 1,
            "intervalos": [
              {
                "horario_inicio": "11:00",
                "horario_fim": "14:00"
              }
            ]
          },
          {
            "dia_semana": 4,
            "intervalos": [
              {
                "horario_inicio": "15:00",
                "horario_fim": "19:00"
              }
            ]
          }
        ]'::jsonb),
       ('Dr. André Lima',
        'CRP009',
        'REG009',
        'andre.jpg',
        'Com foco em terapia de casal e abordagem sistêmica',
        40,
        170.00,
        19,
        '[
          {
            "dia_semana": 2,
            "intervalos": [
              {
                "horario_inicio": "08:30",
                "horario_fim": "10:30"
              }
            ]
          },
          {
            "dia_semana": 5,
            "intervalos": [
              {
                "horario_inicio": "13:00",
                "horario_fim": "16:00"
              }
            ]
          }
        ]'::jsonb),
       ('Dra. Juliana Carvalho',
        'CRP010',
        'REG010',
        'juliana.jpg',
        'Especialista em intervenções terapêuticas inovadoras',
        70,
        260.00,
        20,
        '[
          {
            "dia_semana": 4,
            "intervalos": [
              {
                "horario_inicio": "09:30",
                "horario_fim": "12:30"
              }
            ]
          },
          {
            "dia_semana": 6,
            "intervalos": [
              {
                "horario_inicio": "14:00",
                "horario_fim": "17:00"
              }
            ]
          }
        ]'::jsonb);


--------------------------------------------------
-- Seed de dados para tb_especializacoes
--------------------------------------------------
-- Insere 8 especializações, ampliando as categorias existentes
INSERT INTO tb_especializacoes (titulo, descricao)
VALUES ('Relacionamento', 'Especialização em relacionamento interpessoal'),
       ('Social', 'Especialização em questões sociais'),
       ('Infantil', 'Especialização em psicologia infantil'),
       ('Hospitalar', 'Especialização em ambiente hospitalar'),
       ('Trabalho', 'Especialização em psicologia organizacional'),
       ('Pediatria', 'Especialização em psicologia pediátrica'),
       ('Esporte', 'Especialização em psicologia esportiva'),
       ('Neuropsicologia', 'Especialização em avaliação neuropsicológica');


--------------------------------------------------
-- Seed de dados para tb_psicologo_especializacoes
--------------------------------------------------
-- Associa cada psicólogo (IDs 1 a 10 na tabela tb_psicologos) a um número variável de especializações.
INSERT INTO tb_psicologo_especializacoes (psicologo_id, especializacao_id)
VALUES
    -- Psicólogos 1 a 5
    -- Psicólogo 1: 1 registro
    (1, 1),

    -- Psicólogo 2: 2 registros
    (2, 1),
    (2, 3),

    -- Psicólogo 3: 3 registros
    (3, 1),
    (3, 3),
    (3, 5),

    -- Psicólogo 4: 4 registros
    (4, 1),
    (4, 2),
    (4, 3),
    (4, 4),

    -- Psicólogo 5: 5 registros
    (5, 1),
    (5, 2),
    (5, 3),
    (5, 4),
    (5, 5),

    -- Psicólogos 6 a 10
    -- Psicólogo 6: 1 registro
    (6, 2),

    -- Psicólogo 7: 2 registros
    (7, 2),
    (7, 4),

    -- Psicólogo 8: 3 registros
    (8, 3),
    (8, 5),
    (8, 6),

    -- Psicólogo 9: 4 registros
    (9, 2),
    (9, 4),
    (9, 7),
    (9, 8),

    -- Psicólogo 10: 5 registros
    (10, 1),
    (10, 3),
    (10, 5),
    (10, 7),
    (10, 8);


--------------------------------------------------
-- Seed de dados para tb_consultas
--------------------------------------------------
-- Insere 10 consultas variadas, relacionando clientes (IDs 1 a 10) e psicólogos (IDs 1 a 10)
INSERT INTO tb_consultas
(data_hora, duracao, estado, cliente_id, psicologo_id, checklist_tarefa, anotacao)
VALUES ('2025-04-10 09:00:00', 60, 'SOLICITADA', 1, 1,
        'Exercício de respiração; Registro de sentimentos',
        'Consulta agendada para avaliação inicial.'),
       ('2025-04-11 10:00:00', 45, 'CONFIRMADA', 2, 2,
        'Anotar pensamentos automáticos; Prática de mindfulness',
        'Cliente relatou melhora no humor.'),
       ('2025-04-12 11:00:00', 30, 'CANCELADA', 3, 3,
        'Reflexão pessoal; Técnicas de relaxamento',
        'Consulta cancelada pelo cliente.'),
       ('2025-04-13 14:00:00', 50, 'EM_ANDAMENTO', 4, 4,
        'Registro do humor; Auto-observação diária',
        'Sessão em andamento, focada em ansiedade.'),
       ('2025-04-14 15:00:00', 55, 'FINALIZADA', 5, 5,
        'Revisão dos exercícios terapêuticos; Planejamento de estratégias de coping',
        'Consulta finalizada com sucesso, encaminhado para relatório.'),
       ('2025-04-15 09:30:00', 40, 'CONFIRMADA', 6, 6,
        'Sessão de avaliação de ansiedade',
        'Cliente apresentou sinais de melhora.'),
       ('2025-04-16 10:30:00', 35, 'SOLICITADA', 7, 7,
        'Discussão sobre manejo de estresse',
        'Aguardando confirmação.'),
       ('2025-04-17 11:30:00', 50, 'FINALIZADA', 8, 8,
        'Sessão de follow-up para terapia cognitivo-comportamental',
        'Evolução positiva observada.'),
       ('2025-04-18 14:30:00', 60, 'EM_ANDAMENTO', 9, 9,
        'Terapia focada em reestruturação cognitiva',
        'Sessão em andamento com novos insights.'),
       ('2025-04-19 15:30:00', 45, 'CANCELADA', 10, 10,
        'Sessão agendada, mas cancelada pelo cliente',
        'Motivo informado: imprevistos pessoais.');



SELECT * FROM tb_users;
SELECT * FROM tb_clientes;
SELECT * FROM tb_psicologos;
SELECT * FROM tb_especializacoes;
SELECT * FROM tb_psicologo_especializacoes;
SELECT * FROM tb_consultas;


TRUNCATE TABLE
    tb_consultas,
    tb_psicologo_especializacoes,
    tb_especializacoes,
    tb_psicologos,
    tb_clientes,
    tb_users
    RESTART IDENTITY CASCADE;
