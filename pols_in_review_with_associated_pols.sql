SELECT current_pols.pol_reference saw_0, current_pols.pol_title saw_1, current_pols.encumbrance saw_2, current_pols.mms_id saw_3, other_pols.pol_reference saw_4, other_pols.last_invoice_date saw_5, other_pols.pol_status FROM (SELECT "Funds Expenditure"."PO Line"."PO Line Reference" pol_reference, "Funds Expenditure"."PO Line"."PO Line Title" pol_title, "Funds Expenditure"."Fund Transactions"."Transaction Encumbrance Amount" encumbrance, "Bibliographic Details"."MMS Id" mms_id FROM "Funds Expenditure" WHERE (("PO Line Type"."PO Line Type Name" = 'Print Journal - Subscription') AND ("PO Line"."Status (Active)" = 'In Review') AND ("Fiscal Period"."Fiscal Period Filter" = 'Current Fiscal Year'))) current_pols LEFT JOIN (SELECT "Funds Expenditure"."PO Line"."PO Line Reference" pol_reference, "Bibliographic Details"."MMS Id" mms_id, MAX("Invoice Line"."Invoice-Creation Date") last_invoice_date, "PO Line"."Status" pol_status FROM "Funds Expenditure" WHERE (MAX("Invoice Line"."Invoice-Approval Date") >= date '2018-07-01') OR (MAX("Invoice Line"."Invoice-Creation Date") >= date '2018-07-01')) other_pols ON (current_pols.mms_id = other_pols.mms_id) WHERE (saw_0 <> saw_4) OR (saw_4 IS NULL)