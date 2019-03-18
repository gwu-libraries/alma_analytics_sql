SELECT transactions.spend_2018 saw_0, transactions.spend_2019 saw_1, transactions.encumbrance_2019 saw_2, transactions.pol_ref saw_3, transactions.title saw_4, current_funds.current_fund_code saw_5, current_funds.current_fund_name saw_6, transactions.status saw_7, transactions.continuity saw_8 FROM (SELECT "Fund Ledger"."Fund Ledger Code" current_fund_code, "Fund Ledger"."Fund Ledger Name" current_fund_name, "PO Line"."PO Line Reference" saw_2 FROM "Funds Expenditure" WHERE ("Fund Ledger"."Fund Type" = 'Allocated fund') AND ("Fund Ledger"."Fund Ledger Status" = 'ACTIVE') AND ("Fiscal Period"."Fiscal Period Filter" = 'Current Fiscal Year')) current_funds RIGHT JOIN (SELECT FILTER("Fund Transactions"."Transaction Expenditure Amount" USING "Fiscal Period"."Fiscal Period Filter" = 'Previous Fiscal Year') spend_2018, FILTER("Fund Transactions"."Transaction Expenditure Amount" USING "Fiscal Period"."Fiscal Period Filter" = 'Current Fiscal Year') spend_2019, FILTER("Fund Transactions"."Transaction Encumbrance Amount" USING "Fiscal Period"."Fiscal Period Filter" = 'Current Fiscal Year') encumbrance_2019, "PO Line"."PO Line Reference" pol_ref, "Bibliographic Details"."Title" title, "PO Line"."Status" status, "PO Line Type"."Continuity" continuity FROM "Funds Expenditure" WHERE (((FILTER("Fund Transactions"."Transaction Expenditure Amount" USING "Fiscal Period"."Fiscal Period Filter" = 'Current Fiscal Year') IS NOT NULL) AND (FILTER("Fund Transactions"."Transaction Expenditure Amount" USING "Fiscal Period"."Fiscal Period Filter" = 'Current Fiscal Year') <> 0)) OR ((FILTER("Fund Transactions"."Transaction Expenditure Amount" USING "Fiscal Period"."Fiscal Period Filter" = 'Previous Fiscal Year') IS NOT NULL) AND (FILTER("Fund Transactions"."Transaction Expenditure Amount" USING "Fiscal Period"."Fiscal Period Filter" = 'Previous Fiscal Year') <> 0))) AND ("PO Line"."PO Line Reference" <> '-1')) transactions ON transactions.pol_ref = current_funds.saw_2