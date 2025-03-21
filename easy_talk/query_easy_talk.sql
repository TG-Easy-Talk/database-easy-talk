-- ===================================================================
-- 1. Listar clientes com seus e-mails
-- Descrição:
--   Esta query lista os nomes dos clientes juntamente com seus e-mails.
--   A associação é realizada entre a tabela tb_clientes e tb_users,
--   relacionando a coluna user_id de tb_clientes com a coluna id de tb_users.
-- ===================================================================
SELECT c.nome, -- Nome do cliente
       u.email -- E-mail associado ao cliente (da tabela tb_users)
FROM tb_clientes c
         JOIN tb_users u
              ON c.user_id = u.id;


-- ===================================================================
-- 2. Contar o número de especializações associadas a cada psicólogo
-- Descrição:
--   Esta query conta quantas especializações estão associadas a cada
--   psicólogo. É feita a junção da tabela tb_psicologos com
--   tb_psicologo_especializacoes usando LEFT JOIN para incluir psicólogos
--   que podem não ter nenhuma especialização cadastrada.
-- ===================================================================
SELECT p.id                        AS psicologo_id,         -- ID do psicólogo
       p.nome_completo,                                     -- Nome completo do psicólogo
       COUNT(pe.especializacao_id) AS total_especializacoes -- Total de especializações associadas
FROM tb_psicologos p
         LEFT JOIN tb_psicologo_especializacoes pe
                   ON p.id = pe.psicologo_id
GROUP BY p.id,
         p.nome_completo;


-- ===================================================================
-- 3. Contar o número total de consultas por estado
-- Descrição:
--   Esta query agrupa as consultas pelo estado e conta o total de
--   registros para cada estado na tabela tb_consultas.
-- ===================================================================
SELECT estado,                     -- Estado da consulta
       COUNT(*) AS total_consultas -- Total de consultas por estado
FROM tb_consultas
GROUP BY estado;


-- ===================================================================
-- 4. Listar a disponibilidade dos psicólogos
-- Descrição:
--   Esta query extrai informações da coluna JSON "disponibilidade" na
--   tabela tb_psicologos. Ela utiliza CROSS JOIN LATERAL para iterar
--   sobre os elementos do array JSON, extraindo o dia da semana e os
--   intervalos de horário (início e fim).
-- ===================================================================
SELECT p.id                                AS psicologo_id,   -- ID do psicólogo
       p.nome_completo,                                       -- Nome completo do psicólogo
       disp_elem ->> 'dia_semana'          AS dia_semana,     -- Dia da semana extraído do JSON
       intervals_elem ->> 'horario_inicio' AS horario_inicio, -- Horário de início do intervalo
       intervals_elem ->> 'horario_fim'    AS horario_fim     -- Horário de fim do intervalo
FROM tb_psicologos p
         CROSS JOIN LATERAL jsonb_array_elements(p.disponibilidade) AS disp_elem
         CROSS JOIN LATERAL jsonb_array_elements(disp_elem -> 'intervalos') AS intervals_elem;


-- ===================================================================
-- 5. Listar detalhes das consultas, clientes e psicólogos
-- Descrição:
--   Esta query retorna os detalhes de cada consulta, incluindo:
--     - ID da consulta
--     - Nome do cliente
--     - Nome completo do psicólogo
--     - Data e hora da consulta
--     - Estado da consulta
--     - Duração da consulta
--   A associação é feita entre as tabelas tb_consultas, tb_clientes e tb_psicologos.
-- ===================================================================
SELECT c.id            AS consulta_id,    -- ID da consulta
       cl.nome         AS nome_cliente,   -- Nome do cliente
       p.nome_completo AS nome_psicologo, -- Nome completo do psicólogo
       c.data_hora,                       -- Data e hora da consulta
       c.estado,                          -- Estado da consulta
       c.duracao                          -- Duração da consulta
FROM tb_consultas c
         JOIN tb_clientes cl
              ON c.cliente_id = cl.id
         JOIN tb_psicologos p
              ON c.psicologo_id = p.id;


-- ===================================================================
-- 6. Calcular a duração média das consultas por psicólogo
-- Descrição:
--   Esta query calcula a média da duração das consultas para cada
--   psicólogo. Ela junta as tabelas tb_consultas e tb_psicologos e agrupa
--   os resultados por psicólogo.
-- ===================================================================
SELECT p.id           AS psicologo_id, -- ID do psicólogo
       p.nome_completo,                -- Nome completo do psicólogo
       AVG(c.duracao) AS duracao_media -- Duração média das consultas
FROM tb_consultas c
         JOIN tb_psicologos p
              ON c.psicologo_id = p.id
GROUP BY p.id,
         p.nome_completo;


-- ===================================================================
-- 7. Listar psicólogos com suas especializações
-- Descrição:
--   Esta query exibe os psicólogos e as especializações associadas a cada
--   um, utilizando STRING_AGG para concatenar os títulos das especializações.
--   São realizadas junções (LEFT JOIN) com tb_psicologo_especializacoes e tb_especializacoes.
-- ===================================================================
SELECT p.id                       AS psicologo_id,   -- ID do psicólogo
       p.nome_completo,                              -- Nome completo do psicólogo
       STRING_AGG(e.titulo, ', ') AS especializacoes -- Especializações concatenadas em uma única string
FROM tb_psicologos p
         LEFT JOIN tb_psicologo_especializacoes pe
                   ON p.id = pe.psicologo_id
         LEFT JOIN tb_especializacoes e
                   ON pe.especializacao_id = e.id
GROUP BY p.id,
         p.nome_completo;


-- ===================================================================
-- 8. Contar o total de consultas por psicólogo
-- Descrição:
--   Esta query conta o total de consultas realizadas por cada psicólogo,
--   juntando as tabelas tb_consultas e tb_psicologos e agrupando pelo
--   ID e nome do psicólogo.
-- ===================================================================
SELECT p.id        AS psicologo_id,   -- ID do psicólogo
       p.nome_completo,               -- Nome completo do psicólogo
       COUNT(c.id) AS total_consultas -- Total de consultas associadas ao psicólogo
FROM tb_consultas c
         JOIN tb_psicologos p
              ON c.psicologo_id = p.id
GROUP BY p.id,
         p.nome_completo;


-- ===================================================================
-- 9. Listar consultas com checklist e contagem de anotações
-- Descrição:
--   Esta query lista os detalhes das consultas que possuem um checklist de
--   tarefas (checklist_tarefa não nulo). Além dos detalhes básicos da
--   consulta, inclui:
--     - Nome do cliente
--     - Nome completo do psicólogo
--     - Checklist de tarefas
--     - Uma coluna calculada (qtd_anotacoes) que indica se há
--       alguma anotação associada à consulta (0 para nenhuma, 1 para alguma).
-- ===================================================================
SELECT c.id            AS consulta_id,    -- ID da consulta
       cl.nome         AS nome_cliente,   -- Nome do cliente
       p.nome_completo AS nome_psicologo, -- Nome completo do psicólogo
       c.checklist_tarefa,                -- Checklist de tarefas da consulta
       CASE
           WHEN c.anotacao IS NULL OR c.anotacao = '' THEN 0 -- Sem anotação
           ELSE 1 -- Com anotação
           END         AS qtd_anotacoes   -- Indicador de existência de anotação
FROM tb_consultas c
         JOIN tb_clientes cl
              ON c.cliente_id = cl.id
         JOIN tb_psicologos p
              ON c.psicologo_id = p.id
WHERE c.checklist_tarefa IS NOT NULL;
