/*
Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
 

Write a solution to find the second highest salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).

The result format is in the following example.

 

Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+
*/

-- Solution in MS SQL Server

select max(salary) as SecondHighestSalary
from employee
where salary ! = (Select max(salary)
                   from employee)


-- Solution in MySQL 

With tmp as
(
SELECT salary, DENSE_RANK() OVER (ORDER BY SALARY DESC) Sal_rnk 
FROM Employee
)

SELECT distinct  Case when (select count(*) from tmp) > 1 Then (select distinct salary from tmp where Sal_rnk=2) else null end as SecondHighestSalary 
FROM tmp ;