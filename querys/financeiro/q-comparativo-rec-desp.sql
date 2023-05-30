SELECT

    '1. RECEITAS' as tipo,
    EXTRACT( YEAR FROM icr.dtpagto ) ||'/'||lpad( EXTRACT( MONTH FROM icr.dtpagto ),2,'0')        AS MES_ANO,
    icr.empresa,
    config.FANTASIADESCRIPTOGRAFADO,
    coalesce( receita.descricao, 'GERAL') as receita,
    SUM(ICR.vrpago) AS VALOR

FROM icr
inner join serie on serie.serie = icr.serie
inner join config on config.codigo = icr.empresa
left outer join receita on receita.receita = icr.receita
left outer join funcionario on funcionario.funcionario = icr.vendedor
WHERE icr.situacao = 2
    AND ICR.dtpagto >= cast('01.01.2021' as timestamp)
    AND ICR.dtpagto <= current_timestamp
--AND icr.NRDOCUMENTO = '000028562'

GROUP BY 1,2,3,4,5

union

SELECT '2. DESPESAS' as tipo,

EXTRACT( YEAR FROM CCORRENTE.DTPREVISTA )||'/'||lpad( EXTRACT( MONTH FROM CCORRENTE.DTPREVISTA ),2,'0') AS MES_ANO,
serie.empresa,
config.FANTASIADESCRIPTOGRAFADO,
'DESPESAS' as receita,
CAST(SUM(CCORRENTE.VRLANCTO)AS NUMERIC(15,2)) AS VRTOTAL
FROM CCORRENTE
INNER JOIN CCUSTO ON CCUSTO.CCUSTO = CCORRENTE.DESPESA
INNER JOIN SERIE ON SERIE.SERIE = CCORRENTE.SERIE
INNER JOIN CONFIG ON CONFIG.CODIGO = SERIE.EMPRESA
LEFT OUTER JOIN GRUPODESP ON CCUSTO.DESPESA = GRUPODESP.GRUPODESP
WHERE CCORRENTE.DESPESA > 0
    AND CCORRENTE.DTPREVISTA >= cast('01.01.2021' as date)
    AND CCORRENTE.DTPREVISTA <= current_date    AND CCUSTO.ECONOMICO <> 'T'
GROUP BY 1,2,3,4,5

UNION

SELECT

    '1. RECEITAS' as tipo,
    EXTRACT( YEAR FROM cc.dtefetiva ) ||'/'||lpad( EXTRACT( MONTH FROM cc.dtefetiva ),2,'0')        AS MES_ANO,
    serie.empresa,
    config.FANTASIADESCRIPTOGRAFADO,
    'ADIANTAMENTO' as receita,
    SUM(cc.vrlancto) AS VALOR

FROM ccorrente cc
inner join serie on serie.serie = cc.SERIE
inner join config on config.codigo = serie.empresa
left outer join receita on receita.receita = cc.receita
left outer join funcionario on funcionario.funcionario = cc.VENDEDOR
WHERE 1=1
    AND cc.ORIGEM IN ('ADT')
    AND cc.dtefetiva >= cast('01.01.2021' as timestamp)
    AND cc.dtefetiva <= CURRENT_TIMESTAMP

GROUP BY 1,2,3,4,5
order by 2,1