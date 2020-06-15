SELECT saw_0, saw_1, saw_2, saw_3, saw_4, saw_5 
FROM (
		(
			SELECT "Fund Ledger"."Parent Fund Ledger Name" saw_0, 
				"Fund Ledger"."Fund Ledger Name" saw_1, 
				RSUM("Fund Transactions"."Transaction Expenditure Amount" BY "Fund Ledger"."Fund Ledger Name") saw_2, 
				RSUM("Fund Transactions"."Transaction Allocation Amount" BY "Fund Ledger"."Fund Ledger Name") saw_3, 
				CAST(CAST("Transaction Date"."Transaction Date" AS VARCHAR(10)) AS DATE) saw_4, 
				"Fund Transaction Details"."Transaction Item Type" saw_5 
			FROM "Funds Expenditure" 
			WHERE ("Fiscal Period"."Fiscal Period Description" = 'FY-2019') 
				AND ("Fund Ledger"."Fund Type" = 'Summary fund') 
				AND ("Fund Ledger"."Fund Ledger Status" = 'ACTIVE') 
				AND ("Fund Ledger"."Fund Ledger Name" = 'Main Collections') 
				AND (
					(RSUM("Fund Transactions"."Transaction Expenditure Amount" BY "Fund Ledger"."Fund Ledger Name") IS NOT NULL) 
					AND (RSUM("Fund Transactions"."Transaction Expenditure Amount" BY "Fund Ledger"."Fund Ledger Name") <> 0)
				)
		) 
		UNION 
		(
			SELECT "Fund Ledger"."Parent Fund Ledger Name" saw_0, "Fund Ledger"."Fund Ledger Name" saw_1, 
				RSUM("Fund Transactions"."Transaction Encumbrance Amount" BY "Fund Ledger"."Fund Ledger Name") saw_2, 
				RSUM("Fund Transactions"."Transaction Allocation Amount" BY "Fund Ledger"."Fund Ledger Name") saw_3, 
				CAST(CAST("PO Line"."Renewal Date" AS VARCHAR(10)) AS DATE) saw_4, 
				"Fund Transaction Details"."Transaction Item Type" saw_5 
			FROM "Funds Expenditure" 
			WHERE ("Fiscal Period"."Fiscal Period Description" = 'FY-2019') 
				AND ("Fund Ledger"."Fund Type" = 'Summary fund') 
				AND ("Fund Ledger"."Fund Ledger Status" = 'ACTIVE') 
				AND ("Fund Ledger"."Fund Ledger Name" = 'Main Collections') 
				AND ("PO Line"."Renewal Date" IS NOT NULL)
				AND (
					(RSUM("Fund Transactions"."Transaction Encumbrance Amount" BY "Fund Ledger"."Fund Ledger Name") IS NOT NULL) 
					AND (RSUM("Fund Transactions"."Transaction Encumbrance Amount" BY "Fund Ledger"."Fund Ledger Name") <> 0)
					)
		)
	) t1 
ORDER BY saw_0, saw_1, saw_4, saw_5