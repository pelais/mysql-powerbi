SELECT DISTINCT
   C.DATA
,  CONFIG.FANTASIADESCRIPTOGRAFADO AS NOME_EMPRESA
,  FABRICANTE.DESCRFABRICANTE AS NMARCA
,  C.NRNFCF
,  CATEGORIA.DESCRCATEGORIA AS NCATEGORIA
,  I.DESCRICAO
,  P.CODPROD
,  I.DESCRICAO AS DESCRICAO_PRODUTO
,  P.CURVAABC
,  C.CLIENTE
,  F.NOME AS NVENDEDOR
,  C.RAZSOCIAL AS RAZSOCIAL
,  I.CODBARRA
,  CASE
     WHEN   COALESCE(CLIFOR.CIDADEENT, ' ') <> ' ' THEN CLIFOR.CIDADEENT
     ELSE   CLIFOR.CIDADEFAT   END CIDADEFAT
,  CASE
     WHEN   COALESCE(CLIFOR.UFENT, ' ') <> ' ' THEN CLIFOR.UFENT
     ELSE   CLIFOR.UFFAT   END as UFFAT
,  CASE
     WHEN   (COALESCE(I.VRBONIFICACAO,0) > 0) AND (C.TIPONF = 'E') THEN         (COALESCE(I.VRBONIFICACAO,0)) * (-1)
     WHEN   (COALESCE(I.VRBONIFICACAO,0) > 0) AND (C.TIPONF = 'S') THEN         (COALESCE(I.VRBONIFICACAO,0))
 ELSE           0.00   END AS VRBONIFICACAO
,  CAST(
        CASE
            WHEN   (C.TIPONF = 'E') THEN         (COALESCE(I.VRTOTITEM,0) +         COALESCE(I.VRIPI,0)  +          COALESCE(I.VRSUBSTICMS,0) +         COALESCE(I.VRIPIACRESCIMO,0) -         COALESCE(I.DESCONTO,0) -         COALESCE(I.DESCITEM,0) +         COALESCE(I.ACRESCIMO,0) -         COALESCE(I.VRDESCZONAFRANCA,0) -         COALESCE(I.VRDESCPIS,0) -         COALESCE(I.VRDESCORGAOPUBLICO,0) -         COALESCE(I.VRDESCCOFINS,0)+         COALESCE(I.VRFRETE,0)+          COALESCE(I.VRSEGURO,0)+         COALESCE(I.VRDESPESAS,0)) * (-1)
            WHEN   (C.TIPONF = 'S') THEN         (COALESCE(I.VRTOTITEM,0) +         COALESCE(I.VRIPI,0)  +          COALESCE(I.VRSUBSTICMS,0) +         COALESCE(I.VRIPIACRESCIMO,0) -         COALESCE(I.DESCONTO,0) -         COALESCE(I.DESCITEM,0) +         COALESCE(I.ACRESCIMO,0) -         COALESCE(I.VRDESCZONAFRANCA,0) -         COALESCE(I.VRDESCPIS,0) -         COALESCE(I.VRDESCORGAOPUBLICO,0) -         COALESCE(I.VRDESCCOFINS,0)+         COALESCE(I.VRFRETE,0)+          COALESCE(I.VRSEGURO,0)+         COALESCE(I.VRDESPESAS,0))
            ELSE   0.00   END AS NUMERIC(15,2)) AS VRNOTAFISCAL
,  CAST(
        CASE
            WHEN   (N.FINANCEIRO = 'S') AND (C.TIPONF = 'E') THEN         (COALESCE(I.VRTOTITEM,0) +         COALESCE(I.VRIPI,0)  +          COALESCE(I.VRSUBSTICMS,0) +         COALESCE(I.VRIPIACRESCIMO,0) -         COALESCE(I.DESCONTO,0) -         COALESCE(I.DESCITEM,0) +         COALESCE(I.ACRESCIMO,0) -         COALESCE(I.VRDESCZONAFRANCA,0) -         COALESCE(I.VRDESCPIS,0) -         COALESCE(I.VRDESCORGAOPUBLICO,0) -         COALESCE(I.VRDESCCOFINS,0)+         COALESCE(I.VRFRETE,0)+          COALESCE(I.VRSEGURO,0)+         COALESCE(I.VRDESPESAS,0)) * (-1)
            WHEN   (N.FINANCEIRO = 'S') AND (C.TIPONF = 'S') THEN         (COALESCE(I.VRTOTITEM,0) +         COALESCE(I.VRIPI,0)  +          COALESCE(I.VRSUBSTICMS,0) +         COALESCE(I.VRIPIACRESCIMO,0) -         COALESCE(I.DESCONTO,0) -         COALESCE(I.DESCITEM,0) +         COALESCE(I.ACRESCIMO,0) -         COALESCE(I.VRDESCZONAFRANCA,0) -         COALESCE(I.VRDESCPIS,0) -         COALESCE(I.VRDESCORGAOPUBLICO,0) -         COALESCE(I.VRDESCCOFINS,0)+         COALESCE(I.VRFRETE,0)+          COALESCE(I.VRSEGURO,0)+         COALESCE(I.VRDESPESAS,0))
            ELSE   0.00   END AS NUMERIC(15,2)) AS VRFINANCEIRO
,  CASE
         WHEN   (C.TIPONF = 'S')  THEN         COALESCE(I.VRTOTITEM,0)
         WHEN   (C.TIPONF = 'E')  THEN         COALESCE(I.VRTOTITEM,0)*(-1)
         ELSE   0   END AS VRTOTITEM
,  I.VRDESPESAS
,  CASE
     WHEN   (C.TIPONF = 'E')  THEN         COALESCE(I.ACRESCIMO, 0)*(-1)
     WHEN   (C.TIPONF = 'S')  THEN         COALESCE(I.ACRESCIMO,0)
     ELSE   0   END AS ACRESCIMO

,  CAST(CASE
     WHEN   (C.TIPONF = 'E')  THEN         (COALESCE(I.DESCONTO, 0) + COALESCE(I.VRDESCORGAOPUBLICO,0) + COALESCE(I.DESCITEM,0))*(-1)
     WHEN   (C.TIPONF = 'S')  THEN         COALESCE(I.DESCONTO, 0)+ COALESCE(I.VRDESCORGAOPUBLICO,0) + COALESCE(I.DESCITEM,0)
     ELSE   0   END AS NUMERIC(15,2)) AS DESCONTO
,  CASE
     WHEN   (C.TIPONF = 'E')  THEN         COALESCE(I.VRDESCZONAFRANCA,0)*(-1)
     WHEN   (C.TIPONF = 'S')  THEN         COALESCE(I.VRDESCZONAFRANCA,0)
     ELSE   0 END AS VRDESCZONAFRANCA
,  CASE
     WHEN   (C.TIPONF = 'E')  THEN         COALESCE(I.VRDESCPIS,0)*(-1)
     WHEN   (C.TIPONF = 'S')  THEN         COALESCE(I.VRDESCPIS,0)
     ELSE   0   END AS VRDESCPIS
,  CASE
     WHEN   (C.TIPONF = 'E')  THEN         COALESCE(I.VRDESCCOFINS,0)*(-1)
     WHEN   (C.TIPONF = 'S')  THEN         COALESCE(I.VRDESCCOFINS,0)
     ELSE   0   END AS VRDESCCOFINS
,  N.FINANCEIRO
,  CASE
     WHEN   (C.TIPONF = 'E') THEN         COALESCE(I.VRFRETE,0)*(-1)
     WHEN   (C.TIPONF = 'S') THEN         COALESCE(I.VRFRETE,0)
     ELSE           0.00   END AS VRFRETE

,  CASE
     WHEN   C.TIPONF = 'E' THEN         COALESCE(I.VRSUBSTICMS,0)*(-1)
     WHEN   C.TIPONF = 'S' THEN         COALESCE(I.VRSUBSTICMS,0)
     ELSE           0.00   END AS VRSUBSTICMS
,  CASE
     WHEN   N.IPI = 'C' THEN         (COALESCE(I.VRIPIACRESCIMO, 0)+COALESCE(I.VRIPI, 0)) *(-1)
     WHEN   N.IPI = 'D' THEN         COALESCE(I.VRIPIACRESCIMO, 0)+COALESCE(I.VRIPI, 0)
     ELSE   0   END AS VRIPI
,  I.VRSEGURO
,  CASE
     WHEN   C.TIPONF = 'E' THEN         COALESCE(I.QTDE,0)*(-1)
     WHEN   C.TIPONF = 'S' THEN         COALESCE(I.QTDE,0)
     ELSE       0.00   END AS QTDE
,  CLIFOR.PAISFAT
,  CASE COALESCE(C.VRFINANCEIRO,0)
     WHEN   0 THEN 'N'
     ELSE   'S' END TEMFINANCEIRO

, CLIGRUPO.descrgrupo

 FROM   CNF C
 INNER   JOIN INF I ON C.NRNFCF = I.NRNFCF AND C.SERIE = I.SERIE
 INNER   JOIN NATOPERACAO N ON N.CODIGO = I.NATOPERACAO
 INNER   JOIN PRODUTO P ON P.CODBARRA = I.CODBARRA
 INNER   JOIN PRODUTO_IMPOSTO PI ON PI.PRODUTO = P.CODPROD AND PI.EMPRESA = C.EMPRESA
 INNER   JOIN PRODUTO_CUSTO PC ON PC.PRODUTO = P.CODPROD AND PC.EMPRESA = C.EMPRESA
 LEFT   OUTER JOIN CLIFOR ON CLIFOR.CODIGO = C.CLIENTE

left JOIN CLIGRUPO ON CLIGRUPO.grupo = CLIFOR.grupocliente

 LEFT   JOIN CTAB ON CTAB.CODIGO = C.TABPRECO
 LEFT   OUTER JOIN FUNCIONARIO F ON F.FUNCIONARIO = I.VENDEDOR
 LEFT   OUTER JOIN FUNCIONARIO IND ON IND.FUNCIONARIO = I.INDICACAO
 LEFT   OUTER JOIN CULTURA ON CULTURA.CODIGO = I.CULTURA
 LEFT   OUTER JOIN ALMOX ON ALMOX.CODIGO = C.ALMOXARIFADO
 LEFT   OUTER JOIN CLASSFISCAL ON CLASSFISCAL.LETRA = PI.LCLASSFISCAL
 LEFT   OUTER JOIN PRODUTO EMB ON P.EMBALAGEM = EMB.CODPROD
 LEFT   OUTER JOIN ROTA ON ROTA.ROTA = CLIFOR.ROTAFAT
 LEFT   OUTER JOIN ATENDIMENTO ATEND ON ATEND.ATENDIMENTO = C.ATENDIMENTO
 LEFT   JOIN FABRICANTE ON FABRICANTE.FABRICANTE = I.FABRICANTE
 LEFT   JOIN DEPARTAMENTO ON DEPARTAMENTO.DEPARTAMENTO = I.DEPARTAMENTO
 LEFT   JOIN SECAO ON SECAO.SECAO = P.SECAO
 LEFT   JOIN CATEGORIA ON CATEGORIA.CATEGORIA = P.CATEGORIA
 LEFT   JOIN GRUPO2 ON GRUPO2.CODIGO = P.GRUPO2
 LEFT   JOIN GRUPO3 ON GRUPO3.CODIGO = P.GRUPO3
 LEFT   JOIN CORES ON CORES.CODIGO = P.CODIGO_COR
 LEFT   JOIN CONFIG ON CONFIG.CODIGO = C.EMPRESA
 LEFT   JOIN CONFIG2 ON CONFIG2.FILIAL = C.EMPRESA
 WHERE   C.DATA >= '01-Jan-2021'
 --AND   C.DATA <= CURRENT_DATE
 AND   ((COALESCE(C.KITCUSTOMIZADO, 'T')  = 'T'
 AND   (NOT ((COALESCE(I.TIPOPRODUTOORIG,P.TIPOPRODUTO) = 2)
 AND  (I.ITEMVINCULADO = 0)
 AND   (I.ITEMPRINCIPAL <> 0)))) OR (COALESCE(C.KITCUSTOMIZADO,'T')  = 'F' ))
 AND   ( ( N.TIPOOPERACAO = 1) OR  ( N.TIPOOPERACAO = 3) OR  ( N.TIPOOPERACAO = 2
 AND   N.TIPONF = 'E'))
 GROUP   BY     C.SERIE
,  C.CLIENTE
,  ALMOX.DESCRICAO
,  CLIFOR.TELFAT
,  C.VENDEDOR
,  C.RAZSOCIAL
,  CASE
     WHEN   COALESCE(CLIFOR.CIDADEENT, ' ') <> ' ' THEN CLIFOR.CIDADEENT
     ELSE   CLIFOR.CIDADEFAT    END
,  CASE
     WHEN   COALESCE(CLIFOR.UFENT, ' ') <> ' ' THEN CLIFOR.UFENT
     ELSE   CLIFOR.UFFAT    END
,  CLIFOR.PAISFAT
,  CLIFOR.FANTASIA
,  C.VRBASEICMS
,  CASE
     WHEN   CLIFOR.PESSOAFJ = 'F' THEN            CLIFOR.CPF
     ELSE   CLIFOR.CNPJ    END
,  COALESCE(CTAB.DESCRICAO, 'TABELA PADRAO')
,  CASE
     WHEN   (CTAB.FORMACAOPRECO = 'T') THEN COALESCE(CTAB.FP_CONSIDERAFRETE, 'F')
     ELSE   COALESCE(CONFIG.FP_CONSIDERAFRETE, 'F')    END
,  ROTA.DESCRICAO
,  I.TIPOVENDA
,  C.TIPONF
,  C.NRNFCF
,  C.NRCUPOM
,  C.PEDIDO
,  C.NROS
,  C.DATA
,  EXTRACT( YEAR  FROM   C.DATA )||'/'||lpad( EXTRACT( MONTH  FROM   C.DATA ),2,'0')
,  C.DTMOVTO
,  C.NATOPERACAO
,  C.VRFRETENEGOCIADO
,  C.PESOLIQ
,  N.NATUREZA
,  C.NRCONHECIMENTOFRETE
,  FABRICANTE.DESCRFABRICANTE
,  DEPARTAMENTO.DESCRDEPTO
,  SECAO.DESCRSECAO
,  CATEGORIA.DESCRCATEGORIA
,  GRUPO2.DESCRICAO
,  GRUPO3.descricao
,  CORES.NOME
,  I.NRITEM
,  I.DESCRICAO
,  I.CODBARRA
,  I.CODFABRICANTE
,  I.CODAUXILIAR
,  I.VARIACAO
,  I.DEPARTAMENTO
,  I.ALIQICMS
,  I.COMPLEMENTO
,  I.UNIDADE
,  I.TRIBUTACAO
,  CLASSFISCAL.CLASSFISCAL
,  I.MARGEMLIQ
,  I.MARGEMBRUTA
,  C.FPVENDAMARGEM
,  C.FPVENDAIMPFED
,  I.CUSTO_COMPRA
,  I.CUSTO_DIFICMS
,  I.CUSTO_ICMS
,  I.CUSTO_IPI
,  I.CUSTO_SUBST
,  I.CUSTO_FRETE
,  I.CUSTO_OUTROS
,  I.CUSTO_PISCOFINS
,  I.BASECALCULO
,  P.TIPOPISCOFINS
,  PC.DESPVARIAVEIS
,  I.LOTE
,  I.DATALOTE
,  C.FRETECONTA
,  P.TAMANHO
,  (P.largura * P.comprimento) * (COALESCE(I.QTDE,0))
,  P.CODPROD
,  EMB.EMBAL_VENDA
,  I.TIPOVENDA
,  C.TIPONF
,  CULTURA.DESCRICAO
,  P.CSTPISNFE
,  P.CSTCOFINSNFE
,  P.CSTPISNFE_CREDITO
,  P.CSTPISNFE_ISENTO
,  P.CSTCOFINSNFE_CREDITO
,  P.CSTCOFINSNFE_ISENTO
,  F.NOME
,  IND.NOME
,  P.OBSPRODUTO
,  P.ESTATUAL
,  N.FINANCEIRO
,  CASE
     WHEN   (C.TIPONF = 'S')  THEN           COALESCE(I.VRTOTITEM,0)
     WHEN   (C.TIPONF = 'E')  THEN           COALESCE(I.VRTOTITEM,0)*(-1)
     ELSE   0    END
,  CASE
     WHEN   (N.FINANCEIRO = 'S') AND   (C.TIPONF = 'E') THEN          (COALESCE(I.VRTOTITEM,0) +           COALESCE(I.VRIPI,0)  +            COALESCE(I.VRSUBSTICMS,0) +           COALESCE(I.VRIPIACRESCIMO,0) -           COALESCE(I.DESCONTO,0) -           COALESCE(I.DESCITEM,0) +           COALESCE(I.ACRESCIMO,0) -           COALESCE(I.VRDESCZONAFRANCA,0) -           COALESCE(I.VRDESCPIS,0) -           COALESCE(I.VRDESCORGAOPUBLICO,0) -           COALESCE(I.VRDESCCOFINS,0)+           COALESCE(I.VRFRETE,0)+            COALESCE(I.VRSEGURO,0)+           COALESCE(I.VRDESPESAS,0)) * (-1)
     WHEN   (N.FINANCEIRO = 'S') AND   (C.TIPONF = 'S') THEN          (COALESCE(I.VRTOTITEM,0) +           COALESCE(I.VRIPI,0)  +            COALESCE(I.VRSUBSTICMS,0) +           COALESCE(I.VRIPIACRESCIMO,0) -           COALESCE(I.DESCONTO,0) -           COALESCE(I.DESCITEM,0) +           COALESCE(I.ACRESCIMO,0) -           COALESCE(I.VRDESCZONAFRANCA,0) -           COALESCE(I.VRDESCPIS,0) -           COALESCE(I.VRDESCORGAOPUBLICO,0) -           COALESCE(I.VRDESCCOFINS,0)+           COALESCE(I.VRFRETE,0)+            COALESCE(I.VRSEGURO,0)+           COALESCE(I.VRDESPESAS,0))
     ELSE   0.00    END
,  CASE
     WHEN   (C.TIPONF = 'E') THEN          (COALESCE(I.VRTOTITEM,0) +           COALESCE(I.VRIPI,0)  +            COALESCE(I.VRSUBSTICMS,0) +           COALESCE(I.VRIPIACRESCIMO,0) -           COALESCE(I.DESCONTO,0) -           COALESCE(I.DESCITEM,0) +           COALESCE(I.ACRESCIMO,0) -           COALESCE(I.VRDESCZONAFRANCA,0) -           COALESCE(I.VRDESCPIS,0) -           COALESCE(I.VRDESCORGAOPUBLICO,0) -           COALESCE(I.VRDESCCOFINS,0)+           COALESCE(I.VRFRETE,0)+            COALESCE(I.VRSEGURO,0)+           COALESCE(I.VRDESPESAS,0)) * (-1)
     WHEN   (C.TIPONF = 'S') THEN          (COALESCE(I.VRTOTITEM,0) +           COALESCE(I.VRIPI,0)  +            COALESCE(I.VRSUBSTICMS,0) +           COALESCE(I.VRIPIACRESCIMO,0) -           COALESCE(I.DESCONTO,0) -           COALESCE(I.DESCITEM,0) +           COALESCE(I.ACRESCIMO,0) -           COALESCE(I.VRDESCZONAFRANCA,0) -           COALESCE(I.VRDESCPIS,0) -           COALESCE(I.VRDESCORGAOPUBLICO,0) -           COALESCE(I.VRDESCCOFINS,0)+           COALESCE(I.VRFRETE,0)+            COALESCE(I.VRSEGURO,0)+           COALESCE(I.VRDESPESAS,0))
     ELSE   0.00    END
,  CASE
     WHEN   (COALESCE(I.VRBONIFICACAO,0) > 0)
     AND   (C.TIPONF = 'E') THEN           (COALESCE(I.QTDE,0)) * (-1)
     WHEN   (COALESCE(I.VRBONIFICACAO,0) > 0)
     AND   (C.TIPONF = 'S') THEN           (COALESCE(I.QTDE,0))
     ELSE             0.00    END
,  CASE
     WHEN   (COALESCE(I.VRBONIFICACAO,0) > 0)
     AND   (C.TIPONF = 'E') THEN            (COALESCE(I.VRBONIFICACAO,0)) * (-1)
     WHEN   (COALESCE(I.VRBONIFICACAO,0) > 0)
     AND   (C.TIPONF = 'S') THEN            (COALESCE(I.VRBONIFICACAO,0))
     ELSE              0.00     END
,   CASE
     WHEN   (C.TIPONF = 'E') THEN           (COALESCE(I.VRTOTITEM,0) -            COALESCE(I.DESCONTO,0) -            COALESCE(I.DESCITEM,0) +            COALESCE(I.ACRESCIMO,0) -            COALESCE(I.VRDESCZONAFRANCA,0) -            COALESCE(I.VRDESCPIS,0) -            COALESCE(I.VRDESCORGAOPUBLICO,0) -            COALESCE(I.VRDESCCOFINS,0)) * (-1)
     WHEN   (C.TIPONF = 'S') THEN           (COALESCE(I.VRTOTITEM,0) -            COALESCE(I.DESCONTO,0) -            COALESCE(I.DESCITEM,0) +            COALESCE(I.ACRESCIMO,0) -            COALESCE(I.VRDESCZONAFRANCA,0) -            COALESCE(I.VRDESCPIS,0) -            COALESCE(I.VRDESCORGAOPUBLICO,0) -            COALESCE(I.VRDESCCOFINS,0))
     ELSE            0.00     END
,   CASE
     WHEN   (C.TIPONF = 'E') THEN             (COALESCE(I.CUSTO,0)*(COALESCE(I.QTDE,0)))*(-1)
     WHEN   (C.TIPONF = 'S') THEN            (COALESCE(I.CUSTO,0)*(COALESCE(I.QTDE,0)))
     ELSE             0.00     END
,   CASE
     WHEN   (C.TIPONF = 'E') THEN            COALESCE(I.VENDADOLAR,0)*(-1)
     WHEN   (C.TIPONF = 'S') THEN            COALESCE(I.VENDADOLAR,0)
     ELSE            0.00     END
,   CASE
     WHEN   (C.TIPONF = 'E') THEN            COALESCE(I.BASEICMSFRETE,0)*(-1)
     WHEN   (C.TIPONF = 'S') THEN            COALESCE(I.BASEICMSFRETE,0)
     ELSE              0.00     END
,  CASE
     WHEN   (C.TIPONF = 'E') THEN           COALESCE(I.VRFRETE,0)*(-1)
     WHEN   (C.TIPONF = 'S') THEN           COALESCE(I.VRFRETE,0)
     ELSE             0.00    END
,   CASE
     WHEN   (C.TIPONF = 'E')  THEN            (COALESCE(I.DESCONTO, 0)+ COALESCE(I.VRDESCORGAOPUBLICO,0) +  COALESCE(I.DESCITEM,0))*(-1)
     WHEN   (C.TIPONF = 'S')  THEN            COALESCE(I.DESCONTO, 0)+ COALESCE(I.VRDESCORGAOPUBLICO,0) + COALESCE(I.DESCITEM,0)
     ELSE   0     END
,   CASE
     WHEN   (C.TIPONF = 'E')  THEN            COALESCE(I.ACRESCIMO, 0)*(-1)
     WHEN   (C.TIPONF = 'S')  THEN            COALESCE(I.ACRESCIMO,0)
     ELSE   0     END
,    CASE
     WHEN   (C.TIPONF = 'E')  THEN            COALESCE(I.VRDESCZONAFRANCA,0)*(-1)
     WHEN   (C.TIPONF = 'S')  THEN            COALESCE(I.VRDESCZONAFRANCA,0)
     ELSE   0     END
,   CASE
     WHEN   (C.TIPONF = 'E')  THEN            COALESCE(I.VRDESCPIS,0)*(-1)
     WHEN   (C.TIPONF = 'S')  THEN            COALESCE(I.VRDESCPIS,0)
     ELSE   0     END
,   CASE
     WHEN   (C.TIPONF = 'E')  THEN            COALESCE(I.VRDESCCOFINS,0)*(-1)
     WHEN   (C.TIPONF = 'S')  THEN            COALESCE(I.VRDESCCOFINS,0)
     ELSE   0     END
,   CASE
     WHEN   N.IPI = 'C' THEN            (COALESCE(I.VRIPIACRESCIMO, 0)+COALESCE(I.VRIPI, 0)) *(-1)
     WHEN   N.IPI = 'D' THEN            COALESCE(I.VRIPIACRESCIMO, 0)+COALESCE(I.VRIPI, 0)
     ELSE   0     END
,   CASE
     WHEN   C.TIPONF = 'E' THEN            COALESCE(I.VRICMS,0)*(-1)
     WHEN   C.TIPONF = 'S' THEN            COALESCE(I.VRICMS,0)
     ELSE              0.0000     END
,   CASE
     WHEN   C.TIPONF = 'E' THEN            (COALESCE(I.PIS_VRIMPOSTO,0)+COALESCE(I.COFINS_VRIMPOSTO,0))*(-1)
     WHEN   C.TIPONF = 'S' THEN            (COALESCE(I.PIS_VRIMPOSTO,0)+COALESCE(I.COFINS_VRIMPOSTO,0))
     ELSE              0.0000     END
,   CASE
     WHEN   C.TIPONF = 'E' THEN            COALESCE(I.VRSUBSTICMS,0)*(-1)
     WHEN   C.TIPONF = 'S' THEN            COALESCE(I.VRSUBSTICMS,0)
     ELSE             0.00     END
,   CASE
     WHEN   C.TIPONF = 'E' THEN            COALESCE(I.QTDE,0)*(-1)
     WHEN   C.TIPONF = 'S' THEN            COALESCE(I.QTDE,0)
     ELSE            0.00     END
,   CASE
     WHEN   I.ESTOQUE = 'E' THEN            COALESCE(I.QTDE,0)*(-1)
     WHEN   I.ESTOQUE = 'S' THEN            COALESCE(I.QTDE,0)
     ELSE   0     END
,   CASE
     WHEN   (C.TIPONF = 'E') THEN            COALESCE(I.PESOBRUTO,0)*(I.QTDE)*(-1)
     WHEN   (C.TIPONF = 'S') THEN            COALESCE(I.PESOBRUTO,0)*(I.QTDE)
     ELSE            0.00     END
,   CASE
     WHEN   (C.TIPONF = 'E') THEN            COALESCE(I.PESOLIQ,0)*(I.QTDE)*(-1)
     WHEN   (C.TIPONF = 'S') THEN            COALESCE(I.PESOLIQ,0)*(I.QTDE)
     ELSE             0.00     END
,   CASE
     WHEN   (I.ESTOQUE = 'E') THEN           COALESCE(I.QTDE,0) * COALESCE(I.PESOBRUTO,0)*(-1)
     WHEN   (I.ESTOQUE = 'S') THEN           COALESCE(I.QTDE,0) * COALESCE(I.PESOBRUTO,0)
     ELSE   0    END
,  CASE
     WHEN   (COALESCE(C.INDICACAO,0) >0 )  AND   (COALESCE(C.INDICACAO,0) = COALESCE(F.FUNCIONARIO,0)) AND   (COALESCE(C.INDICACAO,0) <> COALESCE(C.VENDEDOR,0)) THEN
            CASE C.TIPOVENDA
                 WHEN   'P' THEN CAST( (COALESCE(I.PERCOMISSAOIND,0)) AS NUMERIC(15,4))
                 WHEN   'V' THEN CAST( (COALESCE(I.PERCOMISSAOIND,0)) AS NUMERIC(15,4))         END
     WHEN   (COALESCE(C.INDICACAO,0) >0 )  AND   (COALESCE(C.INDICACAO,0) = COALESCE(F.FUNCIONARIO,0))            AND   (COALESCE(C.INDICACAO,0) = COALESCE(C.VENDEDOR,0 ) ) THEN
        CASE C.TIPOVENDA
         WHEN   'P' THEN CAST( (COALESCE(I.COMISSAOP,0)+COALESCE(I.PERCOMISSAOIND,0) ) AS NUMERIC(15,4))
         WHEN   'V' THEN CAST( (COALESCE(I.COMISSAOV,0)+COALESCE(I.PERCOMISSAOIND,0) ) AS NUMERIC(15,4))         END
     ELSE
        CASE C.TIPOVENDA
         WHEN   'P' THEN CAST( (COALESCE(I.COMISSAOP,0)  ) AS NUMERIC(15,4))
         WHEN   'V' THEN CAST( (COALESCE(I.COMISSAOV,0)  ) AS NUMERIC(15,4))
        END
    END
,  C.NRMESA
,  ATEND.DESCRICAO
,  P.CURVAABC
,  N.CODIGO
,  I.BASEICMSFRETE
,  I.VRSEGURO
,  I.VRDESPESAS
,  I.VRFRETENEGOCIADO
,  CONFIG.FANTASIADESCRIPTOGRAFADO
,  CONFIG.CODIGO
,  I.ESTOQUE
,  C.PROTCHNFE
,  C.PROTCSTAT
,  C.NRRECIBO
,  C.PROTXMOTIVO
,  C.NOTAVALIDA
,  C.DTEXPEDICAO
,  CASE
     WHEN   COALESCE(I.QTDE,0) > 0           THEN CAST((COALESCE(C.VRFRETE,0) / I.QTDE) AS NUMERIC(15,4))
     ELSE   0       END
,  CASE
     WHEN   COALESCE(I.QTDE,0) > 0          THEN CAST((COALESCE(C.VRTOTALPRODUTOS,0) / I.QTDE) AS NUMERIC(15,4))
     ELSE   0      END
,  CAST(
        CASE
         WHEN   ((CTAB.FORMACAOPRECO = 'T')
         AND   (C.FRETECONTA = 1)
         AND   (CTAB.FP_CONSIDERAFRETE = 'T')
         AND   (C.VRFRETE > 0)
         AND   (C.VRTOTALPRODUTOS > 0)
         AND   (I.QTDE > 0)) OR               ((CONFIG.FP_CONSIDERAFRETE = 'T')
         AND   (C.FRETECONTA = 1)
         AND   (CTAB.FORMACAOPRECO <> 'T')
         AND   (C.VRFRETE > 0)
         AND   (C.VRTOTALPRODUTOS > 0)
         AND   (I.QTDE > 0))  THEN              ((COALESCE(C.VRFRETE,0) /              (COALESCE(C.VrTotalProdutos,0)  -               COALESCE(C.VRDescontoItem,0) -               COALESCE(C.VrDesconto,0) +              COALESCE(C.VrAcrescimo,0))) / I.QTDE)
         ELSE   0.00       END
        AS NUMERIC(15,4))
,  COALESCE(I.Desconto,0)
,  COALESCE(I.DescItem,0)
,  COALESCE(I.VRIPI,0)
,  CASE
     WHEN   COALESCE(I.QTDE, 0) > 0             THEN CAST((COALESCE(C.FPVENDAFRETE,0) / I.QTDE) AS NUMERIC(15,4))
     ELSE   0    END
,  (COALESCE(I.COMISSAO,0) + COALESCE(I.COMISSAOIND,0))
,   CAST( COALESCE(
            CASE
                 WHEN   (CONFIG.SimplesPta = 'T')THEN
                    CASE
                         WHEN   ((I.TRIBUTACAO = 1) OR (I.TRIBUTACAO = 3) OR (I.TRIBUTACAO = 6) OR (I.TRIBUTACAO = 7)) THEN              (COALESCE(CONFIG2.AliqICMSSTSimples,0))
                         ELSE   (COALESCE(CONFIG.ALIQSIMPLES,0) )
                    END
                 WHEN   (CONFIG.TIPOAPURACAO > 0) then
                    CASE
                         WHEN   (CTAB.FORMACAOPRECO = 'T') THEN         (COALESCE(CTAB.FP_ALIQIMPFED,0))
                         ELSE           (COALESCE(CONFIG2.FP_ALIQIMPFED,0))
                    END
             ELSE   0.00
            END
            ,  0)
        AS NUMERIC(15,4))
,   CASE
         WHEN   COALESCE(I.QTDE,0) > 0              THEN CAST((COALESCE(C.FPVENDAOUTRAS,0) / I.QTDE) AS NUMERIC(15,4))
         ELSE   0     END
,   (COALESCE(I.PIS_VRIMPOSTO,0) + COALESCE(I.COFINS_VRIMPOSTO,0))
,   CASE
     WHEN   COALESCE(I.QTDE,0) > 0             THEN CAST((COALESCE(C.FPVENDACONFIG,0) / I.QTDE) AS NUMERIC(15,4))
     ELSE   0     END
,   CASE
     WHEN   COALESCE(I.QTDE, 0) > 0             THEN CAST((((COALESCE(I.Custo_COMPRA,0) * I.QTDE) +             (COALESCE(I.Custo_ICMS,0) * I.QTDE) +             (COALESCE(I.Custo_SUBST,0) * I.QTDE) +             (COALESCE(I.Custo_DIFICMS,0) * I.QTDE) +              (COALESCE(I.Custo_IPI,0) * I.QTDE) +             (COALESCE(I.Custo_FRETE,0) + (COALESCE(I.VRFRETENegociado,0) / I.QTDE)) +             (COALESCE(I.Custo_OUTROS,0) * I.QTDE)) -             (COALESCE(I.Custo_PISCOFINS,0) * I.QTDE)) AS NUMERIC(15,4))
     ELSE   0      END
,   CAST(COALESCE(
                CASE
                 WHEN  (CONFIG.SIMPLESPTA <> 'T') THEN
                    CASE
                     WHEN  (CTAB.FORMACAOPRECO = 'T') THEN           (((100-COALESCE(CTAB.FP_ALIQIMPFED,0))/100))
                     ELSE             (((100-COALESCE(CONFIG2.FP_ALIQIMPFED,0))/100))
                    END
                 ELSE   0.00
                 END
        ,  0)
    AS NUMERIC(15,4))
,  CASE
     WHEN   COALESCE(I.QTDE,0) > 0        THEN CAST(((((COALESCE(I.Custo_COMPRA,0) * I.QTDE) +            (COALESCE(I.Custo_ICMS,0) * I.QTDE) +            (COALESCE(I.Custo_SUBST,0) * I.QTDE) +            (COALESCE(I.Custo_DIFICMS,0) * I.QTDE) +             (COALESCE(I.Custo_IPI,0) * I.QTDE) +            (COALESCE(I.Custo_FRETE,0) * I.QTDE)) +            (COALESCE(I.Custo_OUTROS,0) * I.QTDE)) + (COALESCE(I.VRFRETENEGOCIADO / I.QTDE,0)))  AS NUMERIC(15,4))
     ELSE   0     END
,  CASE
     WHEN   COALESCE(C.VRTOTALPRODUTOS,0) > 0             THEN CAST((ROUND((I.VRTOTITEM/ (C.VRTOTALPRODUTOS)),2) * COALESCE(C.PESOLIQ,0))AS NUMERIC(15,2))
     ELSE   0     END
,  CASE
     WHEN   COALESCE(C.VRTOTALPRODUTOS,0) > 0             THEN CAST((ROUND((I.VRTOTITEM/ (C.VRTOTALPRODUTOS)),2) * COALESCE(C.PESOBRUTO,0))AS NUMERIC(15,2))
     ELSE   0     END
,  I.CUSTOFORMACAO
,  CASE COALESCE(C.VRFINANCEIRO,0)
     WHEN   0 THEN 'N'
     ELSE   'S' END

, CLIGRUPO.descrgrupo