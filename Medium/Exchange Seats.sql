/*
Table: Seat

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| student     | varchar |
+-------------+---------+
id is the primary key (unique value) column for this table.
Each row of this table indicates the name and the ID of a student.
id is a continuous increment.
 

Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

Return the result table ordered by id in ascending order.

The result format is in the following example.

 

Example 1:

Input: 
Seat table:
+----+---------+
| id | student |
+----+---------+
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
+----+---------+
Output: 
+----+---------+
| id | student |
+----+---------+
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |
+----+---------+
Explanation: 
Note that if the number of students is odd, there is no need to change the last one's seat.
*/

-- Solution in MySQL 

# Write your MySQL query statement below

SELECT id , Case when Mod(id,2)=0 then Pre_Name
                 When Mod(id,2)=1 and Next_Name is not null then Next_Name 
                 when Mod(id,2)=1 and Next_Name is null then student
                 end student
FROM
(
SELECT id,Student,Lag(student,1) over(order by id asc) Pre_Name , Lead(student,1) over(order by id asc) Next_Name
FROM 
Seat
)a
order by id asc;
