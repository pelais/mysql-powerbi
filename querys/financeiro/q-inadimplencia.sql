WITH INADIMPLENCIA AS (
    SELECT
    EXTRACT( YEAR FROM ICR.DTVENCTO )||'/'||LPAD(EXTRACT( MONTH FROM ICR.DTVENCTO ),2,'0') AS MES_ANO,
    EXTRACT( YEAR FROM ICR.DTVENCTO ) AS ANO,
    LPAD(EXTRACT( MONTH FROM ICR.DTVENCTO ),2,'0') AS MES,
    CAST(SUM(VALOR) AS NUMERIC(15,2)) AS VALOR_TOTAL,
    SUM(CASE WHEN ICR.situacao = 2 THEN valor ELSE 0.00 END ) AS VALOR_RECEBIDO,
    (CASE WHEN (SELECT MON$DATABASE_NAME FROM MON$DATABASE) LIKE '%BACKUP%' THEN
    'BACKUP' ELSE 'PRODUCAO' END) AS DB
    FROM ICR
    WHERE 1=1
    AND ICR.DTVENCTO BETWEEN DATEADD(-2 YEAR TO CURRENT_DATE)
    AND CURRENT_DATE
    GROUP BY 1,2,3)
    SELECT * FROM INADIMPLENCIA
