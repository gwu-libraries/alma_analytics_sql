SELECT 
    creserves.course_code,
    creserves.course_name,
    COUNT(loans.loan_id) number_of_loans
FROM
(SELECT
   "Fulfillment"."Bibliographic Details"."MMS Id" mms_id,
   "Fulfillment"."Loan Date"."Loan Date" loan_date,
   "Fulfillment"."Loan Date"."Loan Time" loan_time,
   "Fulfillment"."Loan Details"."Barcode" barcode,
   "Fulfillment"."Loan Details"."Item Loan Id" loan_id,
   "Fulfillment"."Return Date"."Return Date" return_date,
   "Fulfillment"."Return Date"."Return Time" return_time,
   CASE WHEN "Fulfillment"."Borrower Details"."Primary Identifier" !='None' THEN "Fulfillment"."Borrower Details"."Primary Identifier" ELSE "Fulfillment"."Loan Details"."User ID Encryption" END borrower_id
FROM "Fulfillment"
WHERE
    ("Loan Date"."Loan Date" >= date '2022-08-29') AND ("Loan Date"."Loan Date" <= date '2022-12-16')  AND ("Item Location at time of loan"."Location Name" IN ('Eckles Reserves', 'Requestable Reserves', 'Reserves (2 hours + overnight)', 'Reserves (2 hours + overnight) dup', 'Reserves (2 hours + overnight) ret', 'Reserves (2 hours)', 'Reserves (2 hours) dup', 'Reserves (2 hours) ret', 'Reserves (3 hours)', 'Reserves 2 hours', 'Reserves 2 hours, overnight')) AND ("Loan Details"."In House Loan Indicator" = 'N')
) loans
INNER JOIN 
(SELECT 
    "Bibliographic Details"."Title" title, 
    "Bibliographic Details"."Title Author Combined and Normalized" title_author, 
    "Bibliographic Details"."MMS Id" mms_id 
FROM "Course Reserves" WHERE "Reading List"."Reading List Code" IN ('Top Textbooks - Fall 2022')
) ttbooks 
ON loans.mms_id=ttbooks.mms_id
INNER JOIN
(SELECT 
    "Course"."Course Code" course_code, 
    "Course"."Course Name" course_name, 
    "Bibliographic Details"."Title Author Combined and Normalized" title_author, 
    "Bibliographic Details"."MMS Id" mms_id
FROM "Course Reserves" 
WHERE ("Reading List"."Reading List Name" NOT LIKE 'Top Textbooks%')  AND ("Course"."Course Code" LIKE '%Fall 2022%')
) creserves
ON creserves.mms_id = ttbooks.mms_id
GROUP BY creserves.course_code, creserves.course_name