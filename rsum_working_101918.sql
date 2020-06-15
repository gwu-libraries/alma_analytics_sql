SELECT UNSUPPRESSED 
   0 s_0,
   "Funds Expenditure"."Fund Ledger"."Fund Ledger Name" s_1,
   "Funds Expenditure"."Fund Ledger"."Parent Fund Ledger Name" s_2,
   "Funds Expenditure"."Transaction Date"."Transaction Date" s_3,
   RSUM(FILTER("Funds Expenditure"."Fund Transactions"."Transaction Amount" USING "Funds Expenditure"."Fund Transaction Details"."Transaction Item Type" ='ALLOCATION') BY "Funds Expenditure"."Fund Ledger"."Fund Ledger Name")-(IFNULL(RSUM(FILTER("Funds Expenditure"."Fund Transactions"."Transaction Amount" USING "Funds Expenditure"."Fund Transaction Details"."Transaction Item Type" ='EXPENDITURE') BY "Funds Expenditure"."Fund Ledger"."Fund Ledger Name"),0)+IFNULL(RSUM(FILTER("Funds Expenditure"."Fund Transactions"."Transaction Amount" USING "Funds Expenditure"."Fund Transaction Details"."Transaction Item Type" ='ENCUMBRANCE') BY "Funds Expenditure"."Fund Ledger"."Fund Ledger Name"),0)) s_4,
   RSUM(FILTER("Funds Expenditure"."Fund Transactions"."Transaction Amount" USING "Funds Expenditure"."Fund Transaction Details"."Transaction Item Type" ='ALLOCATION') BY "Funds Expenditure"."Fund Ledger"."Fund Ledger Name")-IFNULL(RSUM(FILTER("Funds Expenditure"."Fund Transactions"."Transaction Amount" USING "Funds Expenditure"."Fund Transaction Details"."Transaction Item Type" ='EXPENDITURE') BY "Funds Expenditure"."Fund Ledger"."Fund Ledger Name"),0) s_5
FROM "Funds Expenditure"
WHERE
(("Transaction Date"."Transaction Date Fiscal Year" = 2019) AND (SUM(FILTER("Fund Transactions"."Transaction Amount" USING "Fund Transaction Details"."Transaction Item Type" = 'ALLOCATION') BY "Fund Ledger"."Fund Ledger Name") IS NOT NULL) AND ("Fund Ledger"."Fund Ledger Status" = 'ACTIVE') AND ("Fund Ledger"."Fund Type" = 'Summary fund'))
ORDER BY 1, 2, 3, 4
FETCH FIRST 250001 ROWS ONLY
