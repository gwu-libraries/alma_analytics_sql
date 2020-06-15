SELECT e_inventory.title saw_0, e_inventory.mms_id saw_1, e_inventory.portfolio_id saw_2, physical_inventory.num_physical_items saw_3, physical_inventory.suppressed_bib saw_4 FROM (SELECT "E-Inventory"."Bibliographic Details"."MMS Id" mms_id, "E-Inventory"."Bibliographic Details"."Title" title, "E-Inventory"."Portfolio"."Portfolio Id" portfolio_id FROM "E-Inventory" WHERE ("Portfolio"."Availability" = 'Not Available')) e_inventory INNER JOIN (SELECT "Physical Items"."Bibliographic Details"."MMS Id" mms_id, "Physical Items"."Bibliographic Details"."Suppressed From Discovery" suppressed_bib, "Physical Items"."Physical Item Details"."Num of Items (In Repository)" num_physical_items FROM "Physical Items" WHERE "Physical Items"."Physical Item Details"."Num of Items (In Repository)" > 0) physical_inventory ON e_inventory.mms_id = physical_inventory.mms_id