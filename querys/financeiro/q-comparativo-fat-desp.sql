SELECT
    '1. FATURAMENTO' as tipo,
    EXTRACT( YEAR FROM CNF.data )||'/'||lpad( EXTRACT( MONTH FROM CNF.data ),2,'0') AS MES_ANO,
    cnf.empresa,
    config.FANTASIADESCRIPTOGRAFADO,
    coalesce( receita.descricao, 'GERAL') as receita,
    sum(CASE
            WHEN (CNF.TIPONF = 'E') THEN
                cnf.vrfinanceiro * (-1)
            WHEN (CNF.TIPONF = 'S') THEN
                cnf.vrfinanceiro
            else
                0
        end)
    as VALOR

FROM CNF
inner join config on config.codigo = cnf.empresa
left outer join receita on receita.receita = CNF.receita
WHERE 1=1
AND CNF.DATA >= cast('01.01.2021' as timestamp)
AND CNF.DATA <= current_timestamp
GROUP BY 1,2,3,4,5

union

SELECT
    '2. DESPESAS' as tipo,
    EXTRACT( YEAR FROM CCORRENTE.DTPREVISTA )||'/'||lpad( EXTRACT( MONTH FROM CCORRENTE.DTPREVISTA ),2,'0') AS MES_ANO,
    serie.empresa,        
    config.FANTASIADESCRIPTOGRAFADO,
    'DESPESAS' as receita,
    SUM(VRLANCTO) AS VRTOTAL

FROM CCORRENTE

INNER JOIN CCUSTO ON CCUSTO.CCUSTO = CCORRENTE.DESPESA
INNER JOIN SERIE ON SERIE.SERIE = CCORRENTE.SERIE
INNER JOIN CONFIG ON CONFIG.CODIGO = SERIE.EMPRESA
LEFT OUTER JOIN GRUPODESP ON CCUSTO.DESPESA = GRUPODESP.GRUPODESP
WHERE CCORRENTE.DESPESA > 0
    AND CCORRENTE.DTPREVISTA >= cast('01.01.2021' as date)
    AND CCORRENTE.DTPREVISTA <= current_date
    AND CCUSTO.ECONOMICO <> 'T'
GROUP BY 1,2,3,4,5   order by 2,1