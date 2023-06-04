SELECT DISTINCT

    config.razsocialdescriptografado,
    config.FANTASIADESCRIPTOGRAFADO ,
    CNFE.EMPRESA,
    EXTRACT( YEAR FROM CNFE.DTENTRADA )||'/'||lpad( EXTRACT( MONTH FROM CNFE.DTENTRADA ),2,'0') AS MES_ANO,
    CNFE.FORNECEDOR,
    CNFE.RAZSOCIAL,
    SUM( CNFE.VRTOTAL) AS TOTAL_COMPRA

FROM CNFE

inner join config on config.codigo = CNFE.EMPRESA

WHERE 1=1
    AND CNFE.DTENTRADA >= '2021-01-01'
    --cast('01.01.' || (extract(year from current_date)-2) as date)
    AND CNFE.DTENTRADA <= current_date

GROUP BY 1,2,3,4,5,6