mis_indicator_full <- c( # According to Eurostat data download (but too many)
  "iso3c"="iso3c",
  "year"="time",
  "loans"="Gross non-performing loans, domestic and foreign entities - % of gross loans",
  "banking_leverage"="Consolidated banking leverage, domestic and foreign entities (asset-to-equity multiple)",
  "current_account_avg3y"="Current account balance - % of GDP, 3 years average",
  "direct_investment_stocks"="Direct investment in the reporting economy (stocks) - % of GDP",
  "current_account"="Current account balance - % of GDP",
  "export_oecd_5ychange"="Share of OECD export - 5 years % change",
  "lending_borrowing"="Net Lending / Borrowing - % of GDP",
  "direct_investment_flows"="Direct investment in the reporting economy (flows) - % of GDP",
  "trade_balance_energy"="Net trade balance of energy products - % of GDP",
  "REER_42tp_change1y"="Real effective exchange rate, 42 trading partners - 1 year % change",
  "REER_42tp_change3y"="Real effective exchange rate, 42 trading partners - 3 years % change",
  "REER_euro_change3y"="Real effective exchange rate, euro area trading partners - 3 years % change",
  "export_shares_change5y"="Export market shares - 5 years % change",
  "export_shares_change1y"="Export market shares - 1 year % change",
  "export_shares_vol_change1y"="Export market share, volumes - 1 year % change",
  "finance_liabs_ch1y"="Total financial sector liabilities, non-consolidated - 1 year % change",
  "finance_liabs_mio"="Total financial sector liabilities, non-consolidated - million of national currency",
  "debt_gov"="General government sector debt - % of GDP",
  "house_prices_real_ch1y"="House price index, deflated - 1 year % change",
  "house_prices_nom_ch3y"="Nominal house price index - 3 years % change",
  "int_inv_pos"="Net international investment position - % of GDP",
  "int_inv_pos_adj"="Net international investment position excluding non-defaultable instruments - % of GDP",
  "poverty_risk_perc"="People at risk of poverty or social exclusion - % of total population",
  "poverty_risk_ch3y"="People at risk of poverty or social exclusion - % of total population, % point change (t, t-3)",
  "povery_risk_post_transfer_perc"="People at risk of poverty after social transferes - % of total population",
  "povery_risk_post_transfer_perc_ch3y"="People at risk of poverty after social transferes - % of total population, % point change (t, t-3)",
  "deprived_perc"="Severely materially deprived people - % of total population",
  "deprived_perc_ch3y"="Severely materially deprived people - % of total population, % point change (t, t-3)",
  "low_work_perc"="People living in households with very low work Intensity - % of population aged 0-59",
  "low_work_perc_ch3y"="People living in households with very low work intensity - % of population aged 0-59, % point change (t, t-3)",
  "ulc_ch3y"="Nominal unit labour cost index - 3 years % change",
  "ulc_ch1y"="Nominal unit labour cost index - 1 year % change",
  "ulc_perf_eu_ch10y"="Unit labour cost performance relative to euro area - 10 years % change",
  "activity_rate_perc"="Activity rate (15-64 years) - % of the total population of the same age group",
  "activity_rate_perc_ch3y"="Activity rate (15-64 years) - % point change (t, t-3)",
  "unemp_long_perc"="Long-term unemployment rate - % of active population in the same age group",
  "unemp_long_perc_ch3y"="Long-term unemployment rate - % of active population in the same age group, % point change (t, t-3)",
  "unemp_youth_perc"="Youth unemployment rate - % of active population in the same age group",
  "unemp_youth_ch3y"="Youth unemployment rate - % of active population in the same age group, % point change (t, t-3)",
  "neet_youth_perc"="Young people neither in employment nor in education and training - % of total population",
  "neet_youth_perc_ch3y"="Young people neither in employment nor in education and training - % of total population, % point change (t, t-3)",
  "gdp_real_ch1y"="Real gross domestic product (GDP) - 1 year % change",
  "cap_formation"="Gross fixed capital formation - % of GDP",
  "tot_ch5y"="Terms of trade - 5 years % change",
  "construction"="Residential construction - % of GDP",
  "employment_ch1y"="Employment - 1 year % change",
  "productitivy_labor"="Labour productivity - 1 year % change",
  "credit_priv_flow"="Private sector credit flow, consolidated - % of GDP",
  "debt_priv"="Private sector debt, consolidated - % of GDP",
  "debt_households"="Household debt, consolidated including Non-profit institutions serving households - % of GDP",
  "rd_exp"="Gross domestic expenditure on R&D - % of GDP",
  "unemp_avg3y"="Unemployment rate - 3 years average",
  "unemp_rate" = "Unemployment rate - %",
  "finance_debt_to_equity"="Financial sector leverage (debt-to-equity) - %",
  "debt_external"="Net external debt - % of GDP",
  "ulc_ch10y"="Nominal unit labour cost index - 10 years % change",
  "debt_priv_perc"="Private sector debt, non-consolidated - % of GDP",
  "credit_flow_priv"="Private sector credit flow, non-consolidated - % of GDP"
)

mis_indicator_red <- c(# https://ec.europa.eu/eurostat/web/macroeconomic-imbalances-procedure/indicators
  "gdp_real_ch1y"="Real gross domestic product (GDP) - 1 year % change",
  "export_shares_vol_change1y"="Export market share, volumes - 1 year % change",
  "productitivy_labor"="Labour productivity - 1 year % change",
  "employment_ch1y"="Employment - 1 year % change",
  "REER_euro_change3y"="Real effective exchange rate, euro area trading partners - 3 years % change",
  "house_prices_nom_ch3y"="Nominal house price index - 3 years % change",
  "tot_ch5y"="Terms of trade - 5 years % change",
  "export_oecd_5ychange"="Share of OECD export - 5 years % change",  # HP: Export performance against advanced economies – 5 year % change
  "ulc_perf_eu_ch10y"="Unit labour cost performance relative to euro area - 10 years % change",
  
  
  "cap_formation"="Gross fixed capital formation - % of GDP",
  "rd_exp"="Gross domestic expenditure on R&D - % of GDP",
  "lending_borrowing"="Net Lending / Borrowing - % of GDP",
  "int_inv_pos"="Net international investment position - % of GDP",
  "direct_investment_stocks"="Direct investment in the reporting economy (stocks) - % of GDP",
  "direct_investment_flows"="Direct investment in the reporting economy (flows) - % of GDP",
  "trade_balance_energy"="Net trade balance of energy products - % of GDP",
  "construction"="Residential construction - % of GDP",
  "debt_households"="Household debt, consolidated including Non-profit institutions serving households - % of GDP",
  
  "activity_rate_perc"="Activity rate (15-64 years) - % of the total population of the same age group",
  "unemp_long_perc"="Long-term unemployment rate - % of active population in the same age group", # Long-term unemployment rate - % of active population aged 15-74
  "unemp_youth_perc"="Youth unemployment rate - % of active population in the same age group",
  "neet_youth_perc"="Young people neither in employment nor in education and training - % of total population",
  "poverty_risk_perc"="People at risk of poverty or social exclusion - % of total population",
  "povery_risk_post_transfer_perc"="People at risk of poverty after social transferes - % of total population",
  "deprived_perc"="Severely materially deprived people - % of total population",
  "low_work_perc"="People living in households with very low work Intensity - % of population aged 0-59",
  
  "loans"="Gross non-performing loans, domestic and foreign entities - % of gross loans",
  "banking_leverage"="Consolidated banking leverage, domestic and foreign entities (asset-to-equity multiple)"
)

mis_perc_change <- c(
  "gdp_real_ch1y"="Real gross domestic product (GDP) - 1 year % change",
  "export_shares_vol_change1y"="Export market share, volumes - 1 year % change",
  "productitivy_labor"="Labour productivity - 1 year % change",
  "employment_ch1y"="Employment - 1 year % change",
  "REER_euro_change3y"="Real effective exchange rate, euro area trading partners - 3 years % change",
  "house_prices_nom_ch3y"="Nominal house price index - 3 years % change",
  "tot_ch5y"="Terms of trade - 5 years % change",
  "export_oecd_5ychange"="Share of OECD export - 5 years % change",  # HP: Export performance against advanced economies – 5 year % change
  "ulc_perf_eu_ch10y"="Unit labour cost performance relative to euro area - 10 years % change"
)

mis_perc_gdp <- c(
  "cap_formation"="Gross fixed capital formation - % of GDP",
  "rd_exp"="Gross domestic expenditure on R&D - % of GDP",
  "lending_borrowing"="Net Lending / Borrowing - % of GDP",
  "int_inv_pos"="Net international investment position - % of GDP",
  "direct_investment_stocks"="Direct investment in the reporting economy (stocks) - % of GDP",
  "direct_investment_flows"="Direct investment in the reporting economy (flows) - % of GDP",
  "trade_balance_energy"="Net trade balance of energy products - % of GDP",
  "construction"="Residential construction - % of GDP",
  "debt_households"="Household debt, consolidated including Non-profit institutions serving households - % of GDP"
)

mis_perc_pop <- c(
  "activity_rate_perc"="Activity rate (15-64 years) - % of the total population of the same age group",
  "unemp_long_perc"="Long-term unemployment rate - % of active population in the same age group", # Long-term unemployment rate - % of active population aged 15-74
  "unemp_youth_perc"="Youth unemployment rate - % of active population in the same age group",
  "neet_youth_perc"="Young people neither in employment nor in education and training - % of total population",
  "poverty_risk_perc"="People at risk of poverty or social exclusion - % of total population",
  "povery_risk_post_transfer_perc"="People at risk of poverty after social transferes - % of total population",
  "deprived_perc"="Severely materially deprived people - % of total population",
  "low_work_perc"="People living in households with very low work Intensity - % of population aged 0-59"
)



