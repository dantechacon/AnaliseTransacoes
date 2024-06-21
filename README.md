# Objetivos:
Analisar uma base fictícia com transações realizadas ao longo de 2023, com um total de aproximadamente 20 milhões de linhas. O código desse projeto foi construído com linguagem SQL e fornece visões relacionadas à retenção mensal de TPV (total payment value, em português - volume total de pagamento), TPV rolling (utilizada para calcular a soma do TPV nos últimos dias para cada dia presente na base de dados), e Churn (utilizada para medir a quantidade de clientes que deixaram de fazer transações por um período determinado).

# Tipos dos dados:

- `transaction_id` (INT): Identificador único da transação
- `customer_id` (INT): Identificador único do cliente
- `transaction_date` (DATE): Data da transação
- `transaction_amount` (DECIMAL): Valor da transação
- `activate_month`: Mês da primeira transação do cliente
- `safra`: Número de meses desde a primeira transação
- `retained_tpv`: Percentual do TPV retido em cada mês subsequente à primeira
- `ref_date`: Data de referência
- `rolling_tpv_7`: Soma do TPV nos últimos 7 dias
- `active_costumers_7`: número de clientes ativos nos últimos 7 dias transação
- `reference_month`: Mês de referência
- `churned_customers`: Número de clientes que não realizaram transações nos
últimos 28 dias dentro do mês de referência

# Visões criadas:

- Visão safrada
- TPV Rolling
- Visão de churn

  
// Disclaimer: Esse projeto faz parte do case técnico proposto pelo time de Analytics da Stone em processo seletivo. 
