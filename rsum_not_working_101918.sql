SELECT
   0 s_0,
   "Funds Expenditure"."Fund Ledger"."Fund Ledger Name" s_1,
   "Funds Expenditure"."Fund Ledger"."Parent Fund Ledger Name" s_2,
   CAST(CAST("Funds Expenditure"."Transaction Date"."Transaction Date" AS VARCHAR(10)) AS DATE) s_3,
   RSUM("Funds Expenditure"."Fund Transactions"."Transaction Expenditure Amount" BY "Funds Expenditure"."Fund Ledger"."Fund Ledger Name") s_4,
   SUM("Funds Expenditure"."Fund Transactions"."Transaction Allocation Amount" BY "Funds Expenditure"."Fund Ledger"."Fund Ledger Name") s_5
FROM "Funds Expenditure"
WHERE
(("Fiscal Period"."Fiscal Period Description" = 'FY-2019') AND ("Fund Transactions"."Transaction Expenditure Amount" <> 0) AND ("Fund Ledger"."Fund Type" = 'Summary fund') AND ("Fund Ledger"."Fund Ledger Status" = 'ACTIVE') AND ("Fund Ledger"."Fund Ledger Name" = 'Main Collections'))
ORDER BY 1, 3, 2, 4
FETCH FIRST 250001 ROWS ONLY
