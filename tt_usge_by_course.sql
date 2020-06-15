SELECT COUNT(loans.item_loan_id) saw_0, courses.course_code, course_count.num_courses, titles.mms_id FROM (SELECT  "Loan Details"."Item Id" item_id, "Loan Details"."Item Loan Id" item_loan_id FROM "Fulfillment" WHERE ("Loan Date"."Loan Date" >= date '2020-01-01') AND ("Loan Policy"."Policy Name" = '3 hr loan') AND ("Loan Details"."In House Loan Indicator" = 'N')) loans INNER JOIN (SELECT "Physical Item Details"."Item Id" item_id, "Bibliographic Details"."MMS Id" mms_id FROM "Physical Items" WHERE "Temporary Location"."Temporary Location Name" IN ('Reserves (3 hours)', 'Eckles Reserves')) items ON loans.item_id = items.item_id INNER JOIN (SELECT "Bibliographic Details"."MMS Id" mms_id FROM "Course Reserves" WHERE "Reading List"."Reading List Code" = 'Top Textbooks - Spring 2020') titles ON items.mms_id = titles.mms_id INNER JOIN (SELECT "Course"."Course Code" course_code, "Bibliographic Details"."MMS Id" mms_id FROM "Course Reserves" WHERE ("Course"."Course Status" = 'Active') AND ("Course"."Course Code" <> 'Top Textbooks - Spring 2020')) courses ON courses.mms_id = titles.mms_id INNER JOIN (SELECT COUNT("Course"."Course Code") num_courses, "Bibliographic Details"."MMS Id" mms_id FROM "Course Reserves" WHERE ("Course"."Course Status" = 'Active') AND ("Course"."Course Code" <> 'Top Textbooks - Spring 2020') GROUP BY "Bibliographic Details"."MMS Id") course_count ON course_count.mms_id = titles.mms_id GROUP BY courses.course_code, titles.mms_id, course_count.num_courses