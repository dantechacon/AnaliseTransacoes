/* Inicialmente, vamos modificar a formatação das datas de transações, trazendo os valores para o primeiro dia do mês e definindo-o 
como ref_month. Isso possibilita o agrupamento dos valores por mês. */

WITH date_ref_monthly AS (SELECT DISTINCT DATE_FORMAT(transaction_date, '%Y-%m-01') AS ref_month
    FROM transactions), monthly_churned_customers AS (

/* Nesse momento, os clientes distintos em situação de churn são contabilizados e agrupados por mês. Repare que é utilizado um left join com 
transactions t e drm.ref_month, dando à consulta a possibilidade de trazer um mês de referência, mesmo que não existam registros de 
transações. Junto a esse join, foi definido um filtro que puxa valores nulos de transações no intervalo de referência, ou seja, clientes 
em churn aqueles que não tiveram transações no intervalo de 28 dias. */
    
  SELECT drm.ref_month, COUNT(DISTINCT t.customer_id) AS churned_customers
    FROM date_ref_monthly drm
    LEFT JOIN transactions t ON DATE_FORMAT(t.transaction_date, '%Y-%m-01') <= drm.ref_month AND t.transaction_date > DATE_SUB(drm.ref_month, INTERVAL 28 DAY) 
    AND t.transaction_date <= drm.ref_month WHERE t.customer_id IS NULL
    GROUP BY drm.ref_month)
SELECT ref_month, churned_customers
FROM monthly_churned_customers
ORDER BY ref_month DESC;

/* Por fim, os dados de mês referencial a clientes em churn (sem transacionar por +28 dias) são ordenados por mês e trazidos em DESC, 
ou seja, do mais recente para o mais antigo. Como dito anteriormente, em outro notebook, isso nos possibilita uma gestão mais eficiente 
dos dados em relatórios de visualização, pois ao definir limite de rows, é difícil haver limitação de dados de um mesmo mês de referência. */
