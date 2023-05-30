SELECT DISTINCT

    coalesce( funcionario.nome, 'EMPRESA') as vendedor,       
    coalesce( receita.descricao, 'GERAL') as receita,        
    EXTRACT( YEAR FROM icr.dtpagto ) ||'/'||lpad( EXTRACT( MONTH FROM icr.dtpagto ),2,'0') AS MES_ANO,        
    icr.nrdocumento,
    icr.serie,
    config.FANTASIADESCRIPTOGRAFADO AS fantasia_empresa,
    icr.DTEMISSAO data_emissao,
    icr.DTPAGTO AS data_pagto,
    icr.DTVENCTO data_vencimento,
    clifor.RAZSOCIAL AS razsocial_cliente,
    icr.PARCELA,
    SUM(ICR.vrpago) AS VALOR

FROM icr 

LEFT OUTER JOIN config ON config.codigo = icr.EMPRESA 
left outer join receita on receita.receita = icr.receita    
left outer join funcionario on funcionario.funcionario = icr.vendedor
LEFT JOIN clifor ON clifor.CODIGO = icr.cliente

WHERE icr.situacao = 2      
AND ICR.dtpagto >= cast('01.01.2021 00:00:01' as timestamp)      
AND ICR.dtpagto <= current_timestamp  
AND icr.TIPOCOBRANCA NOT IN (SELECT cobranca FROM cobranca WHERE fluxo = 'F')

GROUP BY 1,2,3,4,5,6,7,8,9,10,11

order by 1,2