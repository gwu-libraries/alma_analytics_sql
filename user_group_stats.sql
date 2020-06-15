SELECT users.user_group saw_0, users.num_users saw_1, loans.num_loans saw_2, loans.loan_status saw_3 FROM (SELECT "User Details"."User Group" user_group, COUNT(DISTINCT "User Details"."Primary Identifier") num_users FROM "Users") users LEFT JOIN (SELECT "Loan Details"."Loan Status" loan_status, COUNT(DISTINCT "Loan Details"."Item Loan Id") num_loans, "Borrower Details"."User Group" user_group FROM "Fulfillment") loans ON users.user_group = loans.user_group