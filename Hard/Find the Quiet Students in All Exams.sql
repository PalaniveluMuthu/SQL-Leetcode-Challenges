/*
Table: Student

+---------------------+---------+
| Column Name         | Type    |
+---------------------+---------+
| student_id          | int     |
| student_name        | varchar |
+---------------------+---------+
student_id is the primary key (column with unique values) for this table.
student_name is the name of the student.
 

Table: Exam

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| exam_id       | int     |
| student_id    | int     |
| score         | int     |
+---------------+---------+
(exam_id, student_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates that the student with student_id had a score points in the exam with id exam_id.
 

A quiet student is the one who took at least one exam and did not score the highest or the lowest score.

Write a solution to report the students (student_id, student_name) being quiet in all exams. Do not return the student who has never taken any exam.

Return the result table ordered by student_id.

The result format is in the following example.

 

Example 1:

Input: 
Student table:
+-------------+---------------+
| student_id  | student_name  |
+-------------+---------------+
| 1           | Daniel        |
| 2           | Jade          |
| 3           | Stella        |
| 4           | Jonathan      |
| 5           | Will          |
+-------------+---------------+
Exam table:
+------------+--------------+-----------+
| exam_id    | student_id   | score     |
+------------+--------------+-----------+
| 10         |     1        |    70     |
| 10         |     2        |    80     |
| 10         |     3        |    90     |
| 20         |     1        |    80     |
| 30         |     1        |    70     |
| 30         |     3        |    80     |
| 30         |     4        |    90     |
| 40         |     1        |    60     |
| 40         |     2        |    70     |
| 40         |     4        |    80     |
+------------+--------------+-----------+
Output: 
+-------------+---------------+
| student_id  | student_name  |
+-------------+---------------+
| 2           | Jade          |
+-------------+---------------+
Explanation: 
For exam 1: Student 1 and 3 hold the lowest and high scores respectively.
For exam 2: Student 1 hold both highest and lowest score.
For exam 3 and 4: Studnet 1 and 4 hold the lowest and high scores respectively.
Student 2 and 5 have never got the highest or lowest in any of the exams.
Since student 5 is not taking any exam, he is excluded from the result.
So, we only return the information of Student 2.
*/

--## Two Solution in MS SQL Server

--## Option 1 ( With Analytical Function)

WITH CTE AS
(
  SELECT e.student_id , e.exam_id ,s.student_name,
         RANK() OVER (PARTITION BY e.exam_id ORDER BY e.score ) AS MinScore_Rnk,
         RANK() OVER (PARTITION BY e.exam_id ORDER BY e.score DESC) AS MaxScore_Rnk
  FROM 
  Exam e
  INNER JOIN
  Student s
  ON e.student_id = s.student_id
)
SELECT DISTINCT student_id ,student_name 
FROM CTE 
WHERE student_id NOT IN (SELECT student_id FROM CTE WHERE MinScore_Rnk = 1 OR MaxScore_Rnk=1)
ORDER BY 1;

--## Option Two (With Tmp Table )
WITH tmp as
(
    SELECT distinct student_id 
    FROM 
    Exam e
    INNER JOIN
    (
        SELECT exam_id , MAX(score) score FROM Exam group by exam_id
        Union All 
        SELECT exam_id , MIN(score) score FROM Exam group by exam_id
    )m
    ON
    e.score = m.score AND
    e.exam_id = m.exam_id
)

SELECT DISTINCT s.student_id,s.student_name 
FROM
Student s
INNER JOIN 
Exam e
on s.student_id = e.student_id 
WHERE 
S.Student_id NOT IN (Select student_id from tmp)
order by S.student_id;