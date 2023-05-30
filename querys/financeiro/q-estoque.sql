select 
config.codigo, 
config.RAZSOCIALDESCRIPTOGRAFADO, 
config.FANTASIADESCRIPTOGRAFADO,
COALESCE(fabricante.DESCRFABRICANTE, 'OUTROS') AS COLUNA, 
sum( produto_custo.VRCOMPRAVAR * ESTOQUE.ESTATUAL ) as CUSTO_SEMIMP 

from estoque 
inner join produto on produto.CODPROD = estoque.CODPROD 
left outer join fabricante on fabricante.FABRICANTE = produto.FABRICANTE 
inner join almox on almox.CODIGO = estoque.ALMOX 
inner join config on config.codigo = almox.EMPRESA 
inner join produto_custo on produto_custo.produto = produto.codprod 
WHERE estoque.ESTATUAL > 0 
group by 1,2,3,4