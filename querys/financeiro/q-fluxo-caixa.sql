with pagamentos as(
	SELECT DISTINCT 
	'PAGAMENTO' AS TIPO,
	serie.empresa,
	config.RAZSOCIALDESCRIPTOGRAFADO,
	config.FANTASIADESCRIPTOGRAFADO,
	coalesce( cobrancaicp.descrcobranca, 'BOLETO') AS DESCRCOBRANCA,
	ICP.nrdocumento,
	EXTRACT( YEAR FROM CASE WHEN icp.dtvencto < current_date THEN current_date ELSE ICP.DTVENCTO END )||'/'||
	lpad( EXTRACT( MONTH FROM CASE WHEN icp.dtvencto < current_date THEN current_date ELSE ICP.DTVENCTO END ),2,'0') AS MES_ANO_VENCT,

	EXTRACT( YEAR FROM CASE WHEN icp.DTCOMPETENCIA  < current_date THEN current_date ELSE ICP.DTCOMPETENCIA  END )||'/'||
	lpad( EXTRACT( MONTH FROM CASE WHEN icp.DTCOMPETENCIA  < current_date THEN current_date ELSE ICP.DTCOMPETENCIA  END ),2,'0') AS MES_ANO_COMPT,

	CAST(icp.DTCOMPETENCIA AS date) AS DTCOMPETENCIA,
	CASE
		WHEN ICP.dtvencto < current_date THEN
			cast( CURRENT_DATE-1 as varchar(10))
		ELSE
			cast( ICP.dtvencto as varchar(10))
	END AS DTPREVISAO,

	CAST(ICP.dtvencto AS date) AS dtvencto,
	ICP.razsocial,
	ICP.serie,
	COALESCE( CCUSTO.descrccusto, 'COMPRAS' ) AS DESPESA_RECEITA,
	CASE
		WHEN ICP.dtvencto < current_date THEN
			ICP.valor
		ELSE
			0.00
	END AS VALOR_VENCIDO,

	CASE
		WHEN ICP.dtvencto > current_date THEN
			ICP.valor
		ELSE
			0.00
	END AS VALOR_AVENCER,

	CASE
		WHEN ICP.dtvencto = current_date THEN
			ICP.valor
		ELSE
			0.00
	END AS VALOR_HOJE,

	ICP.valor * (-1) as VALOR,

	ICP.valor AS VALOR_NOMINAL FROM ICP

	inner join serie on serie.serie = ICP.serie
	inner join config on config.codigo = serie.empresa
	LEFT OUTER join cobrancaicp on cobrancaicp.cobranca = icp.tipocobranca and cobrancaicp.fluxo = 'T'
	LEFT OUTER JOIN ccusto ON CCUSTO.ccusto = ICP.codigoccusto

	WHERE ICP.situacao = 1
		and ccusto.ECONOMICO <> 'T'
		--and icp.dtvencto <= current_date + 30
),

	recebimentos as(
		SELECT DISTINCT
			'RECEBIMENTO' AS TIPO,
			serie.empresa,
			config.RAZSOCIALDESCRIPTOGRAFADO,
			config.FANTASIADESCRIPTOGRAFADO,
			COALESCE( cobranca.descrcobranca,  'CARTEIRA' ) AS DESCRCOBRANCA,
			ICR.nrdocumento,
			EXTRACT( YEAR FROM CASE WHEN ICR.dtvencto < current_date THEN current_date ELSE ICR.DTVENCTO END ) ||'/'||
			lpad(EXTRACT( MONTH FROM CASE WHEN ICR.dtvencto < current_date THEN current_date ELSE ICR.DTVENCTO END ),2,'0') AS MES_ANO_VENCT,

			EXTRACT( YEAR FROM CASE WHEN icr.DTEMISSAO  < current_date THEN current_date ELSE icr.DTEMISSAO  END )||'/'||
			lpad( EXTRACT( MONTH FROM CASE WHEN icr.DTEMISSAO  < current_date THEN current_date ELSE icr.DTEMISSAO   END ),2,'0') AS MES_ANO_COMPT,

			CAST(icr.DTEMISSAO AS date) AS DTCOMPETENCIA,
			CASE
				WHEN ICR.dtvencto < current_date THEN
					CURRENT_DATE -1
				ELSE
					 ICR.dtvencto
			END AS DTPREVISAO,
			CAST(ICR.dtvencto AS date) AS dtvencto,
			ICR.razsocial,
			ICR.serie,
			COALESCE( receita.descricao, 'GERAL' ) AS DESPESA_RECEITA,
			CASE
				WHEN ICR.dtvencto < current_date THEN
					ICR.valor
				ELSE              0.00
			END AS VALOR_VENCIDO,

			CASE
				WHEN ICR.dtvencto > current_date THEN
					ICR.valor
				ELSE
					0.00
			END AS VALOR_AVENCER,

			CASE
				WHEN ICR.dtvencto = current_date THEN
					ICR.valor
				ELSE
					0.00
			END AS VALOR_HOJE,
			ICR.valor,
			ICR.valor AS VALOR_NOMINAL

	FROM ICR

	inner join serie on serie.serie = icr.serie
	inner join config on config.codigo = serie.empresa
	LEFT OUTER join cobranca on cobranca.cobranca = icr.tipocobranca and cobranca.fluxo = 'T'
	LEFT OUTER JOIN receita ON receita.receita = ICR.receita WHERE icr.situacao = 1
	and cobranca.FLUXO <> 'F'
	--and icr.dtvencto <= current_date + 30
	and icr.dtvencto >= current_date - 7
    AND icr.TIPOCOBRANCA NOT IN (SELECT cobranca FROM cobranca WHERE fluxo = 'F'))

	SELECT
		TIPO,
		EMPRESA,
		RAZSOCIALDESCRIPTOGRAFADO,
		FANTASIADESCRIPTOGRAFADO,
		DESCRCOBRANCA,
		MES_ANO_VENCT,
		MES_ANO_COMPT,
		DTCOMPETENCIA,
		NRDOCUMENTO,
		DTPREVISAO,
		DTVENCTO,
		RAZSOCIAL,
		SERIE,
		DESPESA_RECEITA,
		VALOR_VENCIDO,
		VALOR_AVENCER,
		VALOR_HOJE,
		VALOR, VALOR_NOMINAL
	FROM PAGAMENTOS

	union

	SELECT
		TIPO,
		EMPRESA,
		RAZSOCIALDESCRIPTOGRAFADO,
		FANTASIADESCRIPTOGRAFADO,
		DESCRCOBRANCA,
		MES_ANO_VENCT,
		MES_ANO_COMPT,
		dtvencto,
		DTCOMPETENCIA,
		NRDOCUMENTO,
		DTPREVISAO,
		RAZSOCIAL,
		SERIE,
		DESPESA_RECEITA,
		VALOR_VENCIDO,
		VALOR_AVENCER,
		VALOR_HOJE,
		VALOR,
		VALOR_NOMINAL
FROM RECEBIMENTOS
ORDER BY 6