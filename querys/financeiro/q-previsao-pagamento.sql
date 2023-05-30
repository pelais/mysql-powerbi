select distinct

    EXTRACT( YEAR FROM icp.DTVENCTO ) ||'/'|| lpad( EXTRACT( MONTH FROM icp.DTVENCTO ),2,'0') AS MES_ANO,
    case
        when coalesce( icp.TIPOVALOR, 1 ) = 0 then
            'REAL'
        else
            'PREVISTO'
    end as TIPO,

    EXTRACT( month from icp.DTVENCTO ) as MES,
    EXTRACT( year from ICP.DTVENCTO) as ANO,
    icp.CODIGOCCUSTO AS DESPESA,
    ccusto.DESPESA AS GRUPODESPESA,
    sum( icp.VALOR ) as VALOR

from icp
left outer join ccusto on ccusto.CCUSTO = icp.CODIGOCCUSTO

where 1=1
AND icp.SITUACAO = 1
and ( (coalesce( icp.CODIGOCCUSTO, 0 ) = 0 ) or (ccusto.ECONOMICO <> 'T' ))

group by 1,2,3,4,5,6
order by 1,2