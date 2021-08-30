/*
An invoice should show up on the report when 
- it is over the encumbrance amount
- over the allocated fund balance
- being paid against a closed POL
- when the invoice inflation rate exceeds 3% of the prior year amount
NOTES
1. The expenditure seems to be created when the invoice is created (not approved). Therefore, to check for invoice price mismatch, it's necessary to compare the invoice-line total price with the pol-line total price.
2. Likewise, the expenditure will already be reflected in the fund available balance (since overexpenditures are not prohibited), so we can merely check for a negative available balance.

*/
SELECT current_invoices.invoice_number, current_invoices.invoice_creator, current_invoices.invoice_date, current_invoices.invoice_status, current_invoices.pol_ref, current_invoices.vendor_name, current_invoices.fund_name, current_invoices.fund_code, current_invoices.pol_fund_expenditure, current_invoices.pol_price, current_invoices.pol_status, current_funds.bal_avail, total_exp_by_pol.pol_total_expenditure, previous_payments.previous_exp, ((total_exp_by_pol.pol_total_expenditure - previous_payments.previous_exp) / previous_payments.previous_exp) percent_increase
FROM
(SELECT
   "Funds Expenditure"."Fund Ledger"."Fund Ledger Code" fund_code,
   "Funds Expenditure"."Fund Ledger"."Fund Ledger Name" fund_name,
   "Funds Expenditure"."Invoice Line"."Invoice-Creator" invoice_creator,
   "Funds Expenditure"."Invoice Line"."Invoice-Date" invoice_date,
   "Funds Expenditure"."Invoice Line"."Invoice-Number" invoice_number,
   "Funds Expenditure"."Invoice Line"."Invoice-Status" invoice_status,
   "Funds Expenditure"."PO Line"."PO Line Reference" pol_ref,
   "Funds Expenditure"."Vendor"."Vendor Name" vendor_name,
   ROUND("Funds Expenditure"."Fund Transactions"."Transaction Expenditure Amount", 0) pol_fund_expenditure,
   ROUND("Funds Expenditure"."Fund Transactions"."PO Line Total Price", 0) pol_price,
    "Funds Expenditure"."PO Line"."Status" pol_status
FROM "Funds Expenditure"
WHERE
(("Invoice Line"."Invoice-Status" IN ('In Approval', 'In Review')) AND ("Fund Ledger"."Fund Type" = 'Allocated fund'))
) current_invoices
INNER JOIN 
(SELECT
   "Funds Expenditure"."Fund Ledger"."Fund Ledger Code" fl_code,
   "Funds Expenditure"."Fund Ledger"."Fund Ledger Name" fl_name,
   "Funds Expenditure"."Fund Transactions"."Transaction Available Balance" bal_avail
FROM "Funds Expenditure"
WHERE
(("Fiscal Period"."Fiscal Period Filter" = 'Current Fiscal Year') AND ("Fund Ledger"."Fund Type" = 'Allocated fund'))
) current_funds
ON (current_invoices.fund_name = current_funds.fl_name) AND (current_invoices.fund_code = current_funds.fl_code)
LEFT JOIN
(SELECT
   "Funds Expenditure"."PO Line"."PO Line Reference" pol_ref,
   "Funds Expenditure"."Fund Transactions"."Transaction Expenditure Amount" previous_exp,
   RANK("Funds Expenditure"."Fiscal Period"."Fiscal Period Start Date" BY "Funds Expenditure"."PO Line"."PO Line Reference") r
FROM "Funds Expenditure"
WHERE
(("Fiscal Period"."Fiscal Period Start Date" < CAST((EXTRACT(YEAR FROM timestampadd(SQL_TSI_YEAR, -1, CURRENT_DATE))*1000 + 0701) AS CHAR))  AND ("Fund Transactions"."Transaction Expenditure Amount" > 0))
) previous_payments
ON (current_invoices.pol_ref = previous_payments.pol_ref) AND (previous_payments.r = 1)
INNER JOIN 
(SELECT "Funds Expenditure"."PO Line"."PO Line Reference" pol_ref,
       "Funds Expenditure"."Fund Transactions"."Transaction Expenditure Amount" pol_total_expenditure
FROM "Funds Expenditure" 
WHERE "Fiscal Period"."Fiscal Period Filter" = 'Current Fiscal Year') total_exp_by_pol
ON current_invoices.pol_ref = total_exp_by_pol.pol_ref
WHERE (current_funds.bal_avail < 0) OR (current_invoices.pol_fund_expenditure > current_invoices.pol_price) OR (current_invoices.pol_status != 'ACTIVE') OR ((total_exp_by_pol.pol_total_expenditure - previous_payments.previous_exp) / previous_payments.previous_exp > .03) OR (current_invoices.pol_ref='-1')