SELECT 
		"Fund Ledger"."Parent Fund Ledger Name" saw_0, 
		"Fund Ledger"."Fund Ledger Name" saw_1, 
		SELECT(CAST(CAST("Transaction Date"."Transaction Date" AS VARCHAR(10)) AS DATE FROM "Funds Expenditure") saw_2, 
		"PO Line"."PO Line Reference" saw_3, 
		"PO Line"."Renewal Date" saw_4, 
		"PO Line"."Status" saw_5, 
		SUM("Fund Transactions"."Transaction Encumbrance Amount" BY "PO Line"."PO Line Reference") saw_6, 
		"Fund Transactions"."Transaction Expenditure Amount" saw_7 
	FROM 
		"Funds Expenditure" 
	WHERE 
		("Fiscal Period"."Fiscal Period Description" = 'FY-2019') 
		AND ("Fund Ledger"."Fund Type" = 'Summary fund') 
		AND ("Fund Ledger"."Fund Ledger Status" = 'ACTIVE') 
		AND ("Fund Ledger"."Fund Ledger Name" = 'Main Collections') 
		AND ("PO Line"."Status" IN ('ACTIVE', 'CLOSED'))
