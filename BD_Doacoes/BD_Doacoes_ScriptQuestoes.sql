/*
Francisco André Martins
*/
/*i.
Faça a listagem geral de todas as tabelas;
*/

SELECT * FROM alimento;
SELECT * FROM alimento_produto;
SELECT * FROM armazem;
SELECT * FROM armazem_viatura_embalagem;
SELECT * FROM comanda;
SELECT * FROM doacao;
SELECT * FROM produto_doacao;
SELECT * FROM doacao_voluntario_embalagem;
SELECT * FROM doador;
SELECT * FROM doador_produto;
SELECT * FROM embalagem;
SELECT * FROM entrega_localDestino;
SELECT * FROM lingua;
SELECT * FROM lingua_recetor
SELECT * FROM medicamento;
SELECT * FROM medicamento_produto;
SELECT * FROM ong;
SELECT * FROM voluntario_ong;
SELECT * FROM produto;
SELECT * FROM recetor;
SELECT * FROM responsavel;
SELECT * FROM vestuario;
SELECT * FROM vestuario_produto;
SELECT * FROM viatura;
SELECT * FROM viatura_entrega;
SELECT * FROM voluntario;
SELECT * FROM doacao_voluntario;

-----------------------------------------------------------------------------------------

/*ii.
Liste toda a informação sobre os doadores, que tenham ‘Rita’ no nome, e que 
tenham feito doações no primeiro trimestre de 2022. Apresente o resultado 
ordenado por nome de Z para A;
*/

select d.*
from doador d INNER JOIN doador_produto dp
	ON d.id_doador = dp.id_doador INNER JOIN produto p
	ON dp.id_produto=p.id_produto INNER JOIN produto_doacao pd
	ON p.id_produto=pd.id_produto INNER JOIN doacao doa
	ON pd.id_doacao=doa.id_doacao
WHERE MONTH(doa.data_doacao) IN (1,2,3) and d.nome LIKE (SELECT d2.nome
							FROM doador d2
							where d2.nome LIKE 'Rita')
ORDER BY d.nome DESC;

-----------------------------------------------------------------------------------------

/*iii.
Liste para cada nome de doador, o nome dos produtos doados e a respetiva 
quantidade. Inclua no resultado apenas doações realizadas entre as 10:00 e as 
12:00 dos primeiros 15 dias do mês de fevereiro de 2022. Ordene o resultado pela 
quantidade crescente de produto doado. A. SUGESTÃO: Para o atributo 'hora' use 
um valor inteiro (ex: 10h00m -> 1000);
*/

SELECT doador.nome, a.designação, p.quantidade, d.id_doacao
FROM doacao d INNER JOIN produto_doacao pd
	ON d.id_doacao=pd.id_doacao INNER JOIN produto p
	ON pd.id_produto=p.id_produto INNER JOIN doador_produto dp
	ON p.id_produto=dp.id_produto INNER JOIN doador doador
	ON dp.id_doador=doador.id_doador INNER JOIN doador_produto dp2
	ON doador.id_doador=dp.id_doador INNER JOIN alimento_produto ap
	ON dp.id_produto=ap.id_produto INNER JOIN alimento a
	ON ap.id_alimento=a.id_alimento
WHERE MONTH(d.data_doacao) IN (2) AND DAY(d.data_doacao) IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15) AND DATEPART(HOUR, d.data_doacao) BETWEEN 10 AND 12
UNION
SELECT doador.nome, m.designação, p.quantidade, d.id_doacao
FROM doacao d INNER JOIN produto_doacao pd
	ON d.id_doacao=pd.id_doacao INNER JOIN produto p
	ON pd.id_produto=p.id_produto INNER JOIN doador_produto dp
	ON p.id_produto=dp.id_produto INNER JOIN doador doador
	ON dp.id_doador=doador.id_doador INNER JOIN doador_produto dp2
	ON doador.id_doador=dp.id_doador INNER JOIN medicamento_produto mp
	ON dp.id_produto=mp.id_produto INNER JOIN medicamento m
	ON mp.id_medicamento=m.id_medicamento
WHERE MONTH(d.data_doacao) IN (2) AND DAY(d.data_doacao) IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15) AND DATEPART(HOUR, d.data_doacao) BETWEEN 10 AND 12
UNION
SELECT doador.nome, v.designação, p.quantidade, d.id_doacao
FROM doacao d INNER JOIN produto_doacao pd
	ON d.id_doacao=pd.id_doacao INNER JOIN produto p
	ON pd.id_produto=p.id_produto INNER JOIN doador_produto dp
	ON p.id_produto=dp.id_produto INNER JOIN doador doador
	ON dp.id_doador=doador.id_doador INNER JOIN doador_produto dp2
	ON doador.id_doador=dp.id_doador INNER JOIN alimento_produto vp
	ON dp.id_produto=vp.id_produto INNER JOIN alimento v
	ON vp.id_alimento=v.id_alimento
WHERE MONTH(d.data_doacao) IN (2) AND DAY(d.data_doacao) IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15) AND DATEPART(HOUR, d.data_doacao) BETWEEN 10 AND 12
ORDER BY p.quantidade ASC;

-----------------------------------------------------------------------------------------

/*iv.
Liste para cada designação de produto doado, a quantidade total e o número de 
vezes que foi doado. Tenha em consideração que podem existir produtos que 
nunca foram doados, mas também estes devem constar do resultado. Considere na 
solução apenas produtos doados no mínimo em 10 doações. Ordene o resultado 
pela quantidade começando pela maior quantidade e até à menor
*/

/*aumentar as doações de arroz (+2) e feijão (+5?)*/

select a.designação, SUM(p.quantidade) 'quantidade total que foi doada', COUNT(ap.id_alimento) 'número de vezes que foi doado'
from doacao d INNER JOIN produto_doacao pd
	ON d.id_doacao=pd.id_doacao INNER JOIN produto p
	ON pd.id_produto=p.id_produto INNER JOIN doador_produto dp
	ON p.id_produto=dp.id_produto INNER JOIN doador doador
	ON dp.id_doador=doador.id_doador INNER JOIN doador_produto dp2
	ON doador.id_doador=dp2.id_doador INNER JOIN alimento_produto ap
	ON dp2.id_produto=ap.id_produto INNER JOIN alimento a
	ON ap.id_alimento=a.id_alimento
GROUP BY a.designação
HAVING COUNT(ap.id_alimento) NOT BETWEEN 1 AND 10
UNION
select m.designação, SUM(p.quantidade) 'quantidade total que foi doada', COUNT(mp.id_medicamento) 'número de vezes que foi doado'
from doacao d INNER JOIN produto_doacao pd
	ON d.id_doacao=pd.id_doacao INNER JOIN produto p
	ON pd.id_produto=p.id_produto INNER JOIN doador_produto dp
	ON p.id_produto=dp.id_produto INNER JOIN doador doador
	ON dp.id_doador=doador.id_doador INNER JOIN doador_produto dp2
	ON doador.id_doador=dp2.id_doador INNER JOIN medicamento_produto mp
	ON dp2.id_produto=mp.id_produto INNER JOIN medicamento m
	ON mp.id_medicamento=m.id_medicamento
GROUP BY m.designação
HAVING COUNT(mp.id_medicamento) NOT BETWEEN 1 AND 10
UNION
select v.designação, SUM(p.quantidade) 'quantidade total que foi doada', COUNT(vp.id_vestuario) 'número de vezes que foi doado'
from doacao d INNER JOIN produto_doacao pd
	ON d.id_doacao=pd.id_doacao INNER JOIN produto p
	ON pd.id_produto=p.id_produto INNER JOIN doador_produto dp
	ON p.id_produto=dp.id_produto INNER JOIN doador doador
	ON dp.id_doador=doador.id_doador INNER JOIN doador_produto dp2
	ON doador.id_doador=dp2.id_doador INNER JOIN vestuario_produto vp
	ON dp2.id_produto=vp.id_produto INNER JOIN vestuario v
	ON vp.id_vestuario=v.id_vestuario
GROUP BY v.designação
HAVING COUNT(vp.id_vestuario) NOT BETWEEN 1 AND 10
ORDER BY SUM(p.quantidade) DESC;

-----------------------------------------------------------------------------------------

/*v.
Para cada viatura indique a quantidade de entregas em que participou. Apresente 
o resultado ordenado pela quantidade (da maior para a menor) e diferenciado por 
semestre;
*/

SELECT v.matricula, COUNT(ve.id_entrega) 'quantidade de entregas em que participou', eld.data_entrega 'data'
FROM viatura v INNER JOIN viatura_entrega ve
	ON v.id_viatura=ve.id_viatura CROSS JOIN entrega_localDestino eld
WHERE eld.data_entrega IN (SELECT eld2.data_entrega
			FROM entrega_localDestino eld2
			WHERE MONTH(eld2.data_entrega) IN (1,2,3))
GROUP BY eld.data_entrega, v.matricula
UNION
SELECT DISTINCT v.matricula, COUNT(ve.id_entrega)'quantidade de entregas em que participou' , eld.data_entrega 'data'
FROM viatura v INNER JOIN viatura_entrega ve
	ON v.id_viatura=ve.id_viatura CROSS JOIN entrega_localDestino eld
WHERE eld.data_entrega IN (SELECT eld2.data_entrega
			FROM entrega_localDestino eld2
			WHERE MONTH(eld2.data_entrega) IN (4,5,6))
GROUP BY eld.data_entrega, v.matricula
UNION
SELECT DISTINCT v.matricula, COUNT(ve.id_entrega) 'quantidade de entregas em que participou' , eld.data_entrega 'data'
FROM viatura v INNER JOIN viatura_entrega ve
	ON v.id_viatura=ve.id_viatura CROSS JOIN entrega_localDestino eld
WHERE eld.data_entrega IN (SELECT eld2.data_entrega
			FROM entrega_localDestino eld2
			WHERE MONTH(eld2.data_entrega) IN (7,8,9))
GROUP BY eld.data_entrega, v.matricula
UNION
SELECT DISTINCT v.matricula, COUNT(ve.id_entrega)'quantidade de entregas em que participou' , eld.data_entrega 'data'
FROM viatura v INNER JOIN viatura_entrega ve
	ON v.id_viatura=ve.id_viatura CROSS JOIN entrega_localDestino eld
WHERE eld.data_entrega IN (SELECT eld2.data_entrega
			FROM entrega_localDestino eld2
			WHERE MONTH(eld2.data_entrega) IN (10,11,12))
GROUP BY eld.data_entrega, v.matricula
ORDER BY eld.data_entrega ASC;

-----------------------------------------------------------------------------------------

/*vi.
Liste toda a informação sobre voluntários nascidos antes de 2000 que tendo 
realizado entregas, nunca tenham sido responsáveis por nenhuma. Apresente o 
resultado ordenado por nome de enfermeiro de Z para A;
*/

select v.nome, COUNT(eld.id_voluntario_comandante) 'quantidade de entregas de que foi responsável', eld.data_entrega 'data'
from voluntario v INNER JOIN entrega_localDestino eld
	ON v.id_voluntario=eld.id_voluntario_comandante INNER JOIN embalagem e
	ON eld.id_entrega=e.id_entrega INNER JOIN doacao_voluntario_embalagem dve
	ON e.id_embalagem=dve.id_embalagem INNER JOIN doacao d
	ON dve.id_doacao=d.id_doacao
WHERE MONTH(d.data_doacao) NOT IN (2,4,6,8,10,12) 
GROUP BY v.nome, eld.data_entrega
HAVING COUNT(eld.id_voluntario_comandante) NOT BETWEEN 0 AND 3;

-----------------------------------------------------------------------------------------

/*vii.
Liste para cada nome de voluntário a quantidade de entregas de que foi 
responsável. Não devem constar do resultado as doações realizadas nos meses 
pares, nem os voluntários que tenham sido responsáveis por menos do que quatro 
entregas. Apresente o resultado ordenado por data de entrega, começando pela 
mais recente;
*/

select v.nome, COUNT(eld.id_voluntario_comandante) 'quantidade de entregas de que foi responsável por viagem', eld.data_entrega
from voluntario v INNER JOIN entrega_localDestino eld
	ON v.id_voluntario=eld.id_voluntario_comandante INNER JOIN embalagem e
	ON eld.id_entrega=e.id_entrega INNER JOIN doacao_voluntario_embalagem dve
	ON e.id_embalagem=dve.id_embalagem INNER JOIN doacao d
	ON dve.id_doacao=d.id_doacao
WHERE MONTH(d.data_doacao) NOT IN (2,4,6,8,10,12)
GROUP BY v.nome, eld.data_entrega
ORDER BY eld.data_entrega DESC;

-----------------------------------------------------------------------------------------

/*viii.
Liste o nome dos 3 produtos mais doados em termos de quantidade, de forma 
diferenciada por ‘Alimentos’; ‘Medicamentos’ e ‘Vestuário’. Apresente o resultado 
ordenado por quantidade começando pela maior;
*/

select top(3) a.designação, SUM(p.quantidade) 'quantidade'
from produto p inner join  alimento_produto ap
	on p.id_produto=ap.id_produto INNER JOIN alimento a
	on ap.id_alimento=a.id_alimento
GROUP BY a.designação
UNION
select top(3) m.designação, SUM(p.quantidade) 'quantidade'
from produto p inner join  medicamento_produto mp
	on p.id_produto=mp.id_produto INNER JOIN medicamento m
	on mp.id_medicamento=m.id_medicamento
GROUP BY m.designação
UNION
select top(3) v.designação, SUM(p.quantidade) 'quantidade'
from produto p inner join  vestuario_produto vp
	on p.id_produto=vp.id_produto INNER JOIN vestuario v
	on vp.id_vestuario=v.id_vestuario
GROUP BY v.designação
order by 'quantidade' DESC;

-----------------------------------------------------------------------------------------

/*ix.
Liste o nome dos voluntários que tenham sido responsáveis por pelo menos duas 
entregas no mesmo dia. No resultado deverá constar o nome do voluntário, e a 
data. O resultado apresentado deve ser ordenado por data, iniciando-se a listagem 
pela mais recente;
*/

select v.nome, eld.data_entrega
from voluntario v INNER JOIN entrega_localDestino eld
	ON v.id_voluntario=eld.id_voluntario_comandante INNER JOIN embalagem e
	ON eld.id_entrega=e.id_entrega INNER JOIN doacao_voluntario_embalagem dve
	ON e.id_embalagem=dve.id_embalagem INNER JOIN doacao d
	ON dve.id_doacao=d.id_doacao
GROUP BY v.nome, eld.data_entrega
HAVING COUNT(eld.id_voluntario_comandante) NOT BETWEEN 0 AND 1
ORDER BY eld.data_entrega DESC;

-----------------------------------------------------------------------------------------

/*x.
Recorra ao mecanismo de criação de vista de modo a criar uma vista que para cada 
língua falada pelos recetores, que contabilize o número de vezes que esta é
principal ou secundária
*/
CREATE VIEW lingua_falada_pelos_recetores (recetor, lingua, lingua_recetor, contaPrincipal, contaSecundaria)
AS
SELECT r.nome, l.designação 'lingua principal', COUNT(l.id_lingua) 'nPrincipal' ,l.designação 'lingua secundaria', COUNT(lr2.id_lingua) 'nSecundaria'
FROM recetor r INNER JOIN lingua_recetor lr
	ON r.id_recetor=lr.id_recetor INNER JOIN lingua l
	ON lr.id_lingua=l.id_lingua INNER JOIN lingua_recetor lr2
	ON l.id_lingua=lr2.id_linguaSecundaria
GROUP BY r.nome, l.designação;

/*
2ª vista
*/

CREATE VIEW nEmbalagem_por_tipo (embalagem, nEmbalagem)
AS
SELECT DISTINCT e.designação ,COUNT(e.designação) 'nEmbalagem por tipo'
from embalagem e
GROUP BY e.designação;





