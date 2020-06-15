SELECT COUNT(DISTINCT portfolios.mms_id) num_bibs, SUM(pols.num_pols) num_pols, portfolios.bib_suppressed, portfolios.bib_lifecycle, portfolios.portfolio_status, portfolios.portfolio_lifecycle FROM (SELECT "Bibliographic Details"."MMS Id" mms_id, "Bibliographic Details"."Suppressed From Discovery" bib_suppressed, "Bibliographic Details"."Bibliographic Lifecycle" bib_lifecycle, "Portfolio"."Availability" portfolio_status, "Portfolio"."Creator" portfolio_origin, "Portfolio"."Lifecycle" portfolio_lifecycle FROM "E-Inventory" WHERE "Portfolio"."Creator" = 'P2E_JOB') portfolios LEFT JOIN (SELECT COUNT(DISTINCT "PO Line"."PO Line Reference") num_pols, "Bibliographic Details"."MMS Id" mms_id FROM "Funds Expenditure" WHERE "PO Line"."PO Line Reference" <> '-1') pols ON portfolios.mms_id = pols.mms_id GROUP BY portfolios.bib_suppressed, portfolios.bib_lifecycle, portfolios.portfolio_status, portfolios.portfolio_lifecycle