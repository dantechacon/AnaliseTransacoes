/* No primeiro momento, definimos a data de referência para ser trazida no resultado da consulta, a qual é atribuída pela data da transação, 
de acordo com o intervalos que definirmos na subquery. Após isso, calculamos o tpv para as transações dos últimos 7 dias. 
Para fins de documentação mais clara, o date_add surge como uma opção para tornar a janela móvel de dias mais explícita na consulta: 'INTERVAL 6 DAY' 
que seria um intervalo de 6 dias entre uma info e outra. */

SELECT t1.transaction_date AS ref_date, (SELECT SUM(t2.transaction_amount)
FROM transactions t2 WHERE t2.transaction_date BETWEEN t1.transaction_date AND DATE_ADD(t1.transaction_date, INTERVAL 6 DAY)) AS rolling_tpv_7,

/* Em seguida, calculamos a quantidade de clientes distintos ativos nos últimos 7 dias, ou seja, com registros de transações. */  
  
(SELECT COUNT(DISTINCT t2.customer_id)
FROM transactions t2 WHERE t2.transaction_date BETWEEN t1.transaction_date AND DATE_ADD(t1.transaction_date, INTERVAL 6 DAY)) AS active_customers_7
FROM transactions t1 ORDER BY ref_date DESC;

/* É interessante notar também, que ao ordenarmos por ref_date DESC, trazemos as informações mais recentes no topo, e as mais antigas depois. No uso dessa query em ferramentas como
looker datastudio e/ou google sheets, por exemplo, em que integraríamos a consulta via BigQuery, conseguimos trazer um limite de rows menor, deixar a visualização mais leve, e trazer
dados mais recentes - com maior relevância numa análise do dia a dia - para o topo do dashboard.
