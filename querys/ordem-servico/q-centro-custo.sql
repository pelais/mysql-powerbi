SELECT DISTINCT

	COS.NROS,
	COALESCE(DEPTOCENTROCUSTO.DESCRICAO, 'SEM DEPARTAMENTO') DEPTO_CUSTO,
	COALESCE(CENTROCUSTO.CENTROCUSTO, 'SEM CENTRO DE CUSTO') CENTRO_CUSTO,
	COALESCE(CENTROCUSTO_CNF.VALOR, 0) VALOR,
	COALESCE(CENTROCUSTO_CNF.PERCENTUAL, 0) PERCENTUAL
	
FROM COS 

INNER JOIN CNF ON CNF.NROS = COS.NROS
LEFT JOIN CENTROCUSTO_CNF ON CENTROCUSTO_CNF.NRNFCF = CNF.NRNFCF AND CENTROCUSTO_CNF.SERIE = CNF.SERIE
LEFT JOIN CENTROCUSTO ON CENTROCUSTO.CODIGO =  CENTROCUSTO_CNF.IDCENTROCUSTO
LEFT JOIN DEPTOCENTROCUSTO ON DEPTOCENTROCUSTO.ID_DEPTOCENTROCUSTO = CENTROCUSTO.ID_DEPTOCENTROCUSTO 

ORDER BY COS.NROS