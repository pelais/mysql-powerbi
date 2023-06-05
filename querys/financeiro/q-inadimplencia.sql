WITH INADIMPLENCIA AS (
    SELECT  
    EXTRACT( YEAR FROM ICR.DTVENCTO )||'/'||LPAD(EXTRACT( MONTH FROM ICR.DTVENCTO ),2,'0') AS MES_ANO,  
    EXTRACT( YEAR FROM ICR.DTVENCTO ) AS ANO,        
    LPAD(EXTRACT( MONTH FROM ICR.DTVENCTO ),2,'0') AS MES,
    CAST(SUM(VALOR) AS NUMERIC(15,2)) AS VALOR_TOTAL,
    SUM(CASE WHEN ICR.situacao = 2 THEN valor ELSE 0.00 END ) AS VALOR_RECEBIDO,
    (SELECT MON$DATABASE_NAME FROM MON$DATABASE)AS DB_ATUAL
    FROM ICR 
    WHERE 1=1
    AND ICR.DTVENCTO BETWEEN DATEADD(-2 YEAR TO CURRENT_DATE) 
    AND CURRENT_DATE 
    --AND ICR.DTVENCTO <= '31.12.2016' 
    GROUP BY 1,2,3) 
    SELECT * FROM INADIMPLENCIA
