SELECT "Bibliographic Details"."Title" saw_0, 
	"Vendor"."Vendor Name" saw_1, 
	"PO Line"."PO Line Reference" saw_2, 
	"PO Line"."List Price" saw_3, 
	"PO Line"."Renewal Date" saw_4, 
	"Fund Transactions"."Transaction Expenditure Amount" saw_5, 
	"Fund Ledger"."Fund Ledger Name" saw_6, 
	"Fund Ledger"."Parent Fund Ledger Name" saw_7
FROM "Funds Expenditure" 
WHERE ("PO Line Type"."Continuity" = 'CONTINUOUS') 
	AND ("PO Line"."Status" = 'ACTIVE') 
	AND ("Fund Transaction Details"."Transaction Item Type" = 'EXPENDITURE') 
	AND ("Fund Ledger"."Fund Type" = 'Allocated fund')
	AND ("Fiscal Period"."Fiscal Period Description" = 'FY-2018')
	AND ("PO Line"."List Price" = 1)
	AND NOT ("PO Line"."PO Line Reference" IN (
		SELECT "PO Line"."PO Line Reference"
			FROM "Funds Expenditure"
			WHERE ("Fund Transaction Details"."Transaction Item Type" = 'EXPENDITURE')
					AND ("Fund Transactions"."Transaction Expenditure Amount" IS NULL)
					AND ("Fiscal Period"."Fiscal Period Description" = 'FY-2019')
		)