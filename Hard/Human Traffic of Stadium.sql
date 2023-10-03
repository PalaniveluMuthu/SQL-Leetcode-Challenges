/*
Table: Stadium

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| visit_date    | date    |
| people        | int     |
+---------------+---------+
visit_date is the column with unique values for this table.
Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
As the id increases, the date increases as well.
 

Write a solution to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each.

Return the result table ordered by visit_date in ascending order.

The result format is in the following example.

 

Example 1:

Input: 
Stadium table:
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 1    | 2017-01-01 | 10        |
| 2    | 2017-01-02 | 109       |
| 3    | 2017-01-03 | 150       |
| 4    | 2017-01-04 | 99        |
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-09 | 188       |
+------+------------+-----------+
Output: 
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-09 | 188       |
+------+------------+-----------+
Explanation: 
The four rows with ids 5, 6, 7, and 8 have consecutive ids and each of them has >= 100 people attended. Note that row 8 was included even though the visit_date was not the next day after row 7.
The rows with ids 2 and 3 are not included because we need at least three consecutive ids.
*/

-- Solution in MS SQL Server

With tmp_final as
(
SELECT id,visit_date,people ,
        Lead_1 - id as Lead_diff_1 ,
        Lead_2 - id as Lead_diff_2 ,
        Lead_3 - id as Lead_diff_3 ,
        id - lag_1 as Lag_diff_1 ,
        id - lag_2 as Lag_diff_2 ,
        id - lag_3 as Lag_diff_3 
FROM 
(
SELECT id , visit_date , people , 
        Lead(id,1,0) over(order by id asc) Lead_1 , 
        Lead(id,2,0) over(order by id asc) Lead_2 , 
        Lead(id,3,0) over(order by id asc) Lead_3 ,
        
        Lag(id,1,0) over(order by id asc) Lag_1 , 
        Lag(id,2,0) over(order by id asc) Lag_2 , 
        Lag(id,3,0) over(order by id asc) lag_3 

FROM Stadium 
WHERE 
people > 99 
)a
)

SELECT id,visit_date,people FROM tmp_final WHERE Lead_diff_1 = 1 AND Lag_diff_1 = 1 
UNION 
SELECT id,visit_date,people FROM tmp_final WHERE Lead_diff_1 = 1 AND Lead_diff_2 = 2 
UNION 
SELECT id,visit_date,people FROM tmp_final WHERE Lag_diff_1 = 1 AND Lag_diff_2 = 2 ;