SELECT pol_data.pol_reference saw_0, pol_data.pol_title saw_1, pol_data.sent_date saw_2, invoice_data.last_invoice_date saw_3 FROM (SELECT "PO Line"."PO Line Reference" pol_reference, "Funds Expenditure"."PO Line"."PO Line Title" pol_title, "Funds Expenditure"."PO Line"."Sent Date" sent_date FROM "Funds Expenditure" WHERE ("PO Line"."Status (Active)" = 'In Review') AND ("PO Line"."Sent Date" < date '2017-03-22')) pol_data LEFT JOIN (SELECT "PO Line"."PO Line Reference" pol_reference, MAX("Invoice Line"."Invoice-Creation Date") last_invoice_date FROM "Funds Expenditure") invoice_data ON pol_data.pol_reference = invoice_data.pol_reference WHERE ((saw_3 IS NULL) OR (saw_3 < date '2017-03-22')) AND (saw_0 NOT IN (SELECT "PO Line"."PO Line Reference" FROM "Funds Expenditure" WHERE ("Fund Transactions"."Transaction Encumbrance Amount" != 0) AND ("Fiscal Period"."Fiscal Period Filter" = 'Current Fiscal Year')))