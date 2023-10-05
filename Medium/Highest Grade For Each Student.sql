/*
Table: Enrollments

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| student_id    | int     |
| course_id     | int     |
| grade         | int     |
+---------------+---------+
(student_id, course_id) is the primary key (combination of columns with unique values) of this table.
grade is never NULL.
 

Write a solution to find the highest grade with its corresponding course for each student. In case of a tie, you should find the course with the smallest course_id.

Return the result table ordered by student_id in ascending order.

The result format is in the following example.

 

Example 1:

Input: 
Enrollments table:
+------------+-------------------+
| student_id | course_id | grade |
+------------+-----------+-------+
| 2          | 2         | 95    |
| 2          | 3         | 95    |
| 1          | 1         | 90    |
| 1          | 2         | 99    |
| 3          | 1         | 80    |
| 3          | 2         | 75    |
| 3          | 3         | 82    |
+------------+-----------+-------+
Output: 
+------------+-------------------+
| student_id | course_id | grade |
+------------+-----------+-------+
| 1          | 2         | 99    |
| 2          | 2         | 95    |
| 3          | 3         | 82    |
+------------+-----------+-------+
*/

--- Solution in My SQL 

SELECT student_id,Min(course_id) as course_id , grade 
FROM 
Enrollments 
WHERE 
(Student_id,Grade) IN (SELECT Student_ID,Max(Grade) from Enrollments Group by Student_ID)
Group by Student_id
order by student_id;

--- Solution in SQL Server

SELECT a.student_id , MIN(a.course_id) as course_id ,a.grade
FROM
(
    SELECT e.student_id,e.course_id, e.grade 
    FROM 
        Enrollments e
    INNER JOIN
        (SELECT Student_ID,Max(Grade) grade from Enrollments Group by Student_ID) t
        ON
        e.student_id = t.student_id AND
        e.grade = t.grade
)a
GROUP BY a.student_id,a.grade
ORDER BY a.student_id;
