CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    full_name  TEXT NOT NULL,
    city       TEXT,
    reg_date   DATE
);

CREATE TABLE instructors (
    instructor_id SERIAL PRIMARY KEY,
    full_name     TEXT NOT NULL,
    specialization TEXT
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name TEXT NOT NULL,
    category    TEXT,
    instructor_id INT REFERENCES instructors(instructor_id)
);

CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id  INT REFERENCES courses(course_id),
    enroll_date DATE
);

CREATE TABLE progress (
    progress_id SERIAL PRIMARY KEY,
    enrollment_id INT REFERENCES enrollments(enrollment_id),
    lesson_number INT,
    score NUMERIC(5,2),     -- оцінка за урок
    completed BOOLEAN
);

# **INSERT даних у таблиці**

# **students — студенти**

sql

`INSERT INTO students (full_name, city, reg_date) VALUES
('Anna Kovalenko', 'Kyiv', '2024-01-12'),
('Dmytro Shevchenko', 'Lviv', '2024-02-05'),
('Olena Bondar', 'Kharkiv', '2024-03-18'),
('Serhii Melnyk', 'Odesa', '2024-01-25'),
('Iryna Tkachenko', 'Dnipro', '2024-04-02'),
('Maksym Horbunov', 'Kyiv', '2024-02-20'),
('Kateryna Polishchuk', 'Lviv', '2024-03-01'),
('Yurii Kravets', 'Kharkiv', '2024-03-22'),
('Sofiia Levchenko', 'Odesa', '2024-04-10'),
('Vladyslav Chernenko', 'Kyiv', '2024-01-30');`

# **instructors — викладачі**

sql

`INSERT INTO instructors (full_name, specialization) VALUES
('Oleh Marchenko', 'Data Science'),
('Tetiana Ivanova', 'Web Development'),
('Roman Sydorenko', 'Machine Learning'),
('Natalia Hlushko', 'UI/UX Design'),
('Andrii Petrenko', 'Databases');`

# **courses — курси**

sql

`INSERT INTO courses (course_name, category, instructor_id) VALUES
('Python for Beginners', 'Programming', 1),
('Data Analysis with SQL', 'Data Science', 5),
('Machine Learning Basics', 'Machine Learning', 3),
('Frontend Development with React', 'Web Development', 2),
('UI/UX Fundamentals', 'Design', 4),
('Advanced SQL Analytics', 'Data Science', 5),
('Deep Learning Intro', 'Machine Learning', 3),
('JavaScript Essentials', 'Programming', 2);`

# **enrollments — записи студентів на курси**

sql

`INSERT INTO enrollments (student_id, course_id, enroll_date) VALUES
(1, 1, '2024-02-01'),
(1, 2, '2024-02-10'),
(2, 2, '2024-02-15'),
(2, 4, '2024-03-01'),
(3, 3, '2024-03-20'),
(3, 6, '2024-03-25'),
(4, 1, '2024-02-05'),
(4, 5, '2024-04-01'),
(5, 2, '2024-04-05'),
(5, 7, '2024-04-12'),
(6, 4, '2024-03-10'),
(7, 5, '2024-03-15'),
(8, 6, '2024-04-02'),
(9, 3, '2024-04-15'),
(10, 1, '2024-02-20');`

# **progress — прогрес студентів**

> Для кожного enrollment_id створюю кілька уроків із оцінками та статусом.
> 

sql

`INSERT INTO progress (enrollment_id, lesson_number, score, completed) VALUES
-- Enrollment 1 (Anna, Python)
(1, 1, 85, TRUE),
(1, 2, 90, TRUE),
(1, 3, 88, TRUE),

-- Enrollment 2 (Anna, SQL)
(2, 1, 92, TRUE),
(2, 2, 87, TRUE),
(2, 3, 95, TRUE),

-- Enrollment 3 (Dmytro, SQL)
(3, 1, 78, TRUE),
(3, 2, 82, TRUE),
(3, 3, 80, FALSE),

-- Enrollment 4 (Dmytro, React)
(4, 1, 88, TRUE),
(4, 2, 90, TRUE),

-- Enrollment 5 (Olena, ML)
(5, 1, 91, TRUE),
(5, 2, 89, TRUE),
(5, 3, 93, TRUE),

-- Enrollment 6 (Olena, Advanced SQL)
(6, 1, 85, TRUE),
(6, 2, 87, TRUE),

-- Enrollment 7 (Serhii, Python)
(7, 1, 70, TRUE),
(7, 2, 75, FALSE),

-- Enrollment 8 (Serhii, UI/UX)
(8, 1, 95, TRUE),
(8, 2, 97, TRUE),

-- Enrollment 9 (Iryna, SQL)
(9, 1, 88, TRUE),
(9, 2, 92, TRUE),
(9, 3, 90, TRUE),

-- Enrollment 10 (Iryna, Deep Learning)
(10, 1, 84, TRUE),
(10, 2, 86, TRUE),

-- Enrollment 11 (Maksym, React)
(11, 1, 80, TRUE),
(11, 2, 82, TRUE),

-- Enrollment 12 (Kateryna, UI/UX)
(12, 1, 98, TRUE),
(12, 2, 96, TRUE),

-- Enrollment 13 (Yurii, Advanced SQL)
(13, 1, 75, TRUE),
(13, 2, 78, TRUE),

-- Enrollment 14 (Sofiia, ML)
(14, 1, 89, TRUE),
(14, 2, 91, TRUE),
(14, 3, 94, TRUE),

-- Enrollment 15 (Vladyslav, Python)
(15, 1, 82, TRUE),
(15, 2, 85, TRUE),
(15, 3, 88, TRUE);`

### **Задача 1. Базові SELECT**

##1. Вивести всіх студентів, які зареєструвалися після 2024-01-01.

SELECT * 
FROM students
WHERE reg_date > '2024-01-01';

##2. Вивести всі курси категорії `"Data Science"`.

SELECT 
	course_name,
	category
FROM courses
WHERE category = 'Data Science'

## **Задача 2. Групування та агрегація**

1. Порахувати кількість студентів у кожному місті.

SELECT 
  city,
  COUNT(full_name)
FROM students
GROUP BY city;

2. Порахувати кількість курсів у кожній категорії.

SELECT
  category,
  COUNT(course_name)
FROM courses
GROUP BY category;

3. Порахувати середню оцінку по кожному курсу.

select 
course_name,
ROUND(AVG(score),2)
from courses AS c
LEFT JOIN enrollments AS en ON c.course_id = en.course_id
LEFT JOIN progress AS p ON en.enrollment_id = p.enrollment_id
GROUP BY course_name 
ORDER BY course_name ASC;


## **Задача 3. JOIN-аналіз**

1. Вивести список курсів разом з іменами викладачів.

SELECT 
  c.course_name,
  i.full_name
FROM courses AS c
INNER JOIN instructors AS i ON c.instructor_id = i.instructor_id;

2. Вивести студентів та назви курсів, на які вони записані.

SELECT 
s.full_name,
c.course_name
FROM students AS s
JOIN enrollments AS en ON s.student_id = en.student_id
JOIN courses AS c ON c.course_id = en.course_id
ORDER BY s.full_name

3. Порахувати, скільки студентів у кожного викладача.

SELECT 
i.full_name,
COUNT(DISTINCT en.student_id) AS count_student
FROM instructors AS i
LEFT JOIN courses AS c ON c.instructor_id = i.instructor_id
LEFT JOIN enrollments AS en ON en.course_id = c.course_id
GROUP BY i.full_name
ORDER BY i.full_name

## **Задача 4. Аналітика прогресу**

1. Порахувати середню оцінку кожного студента.
SELECT 
s.full_name,
ROUND(AVG(score),2)
from enrollments AS en 
LEFT JOIN students AS s ON s.student_id = en.student_id
LEFT JOIN progress AS p ON en.enrollment_id = p.enrollment_id
GROUP BY s.full_name 
ORDER BY s.full_name ASC;

2. Порахувати відсоток завершених уроків для кожного курсу.
SELECT 
 c.course_name,
 ROUND(
 SUM(
 	CASE 
	 	WHEN completed = TRUE THEN 1 
	ELSE 0 
	END) * 100 / COUNT(*), 2) AS pr_completed
from progress AS p
INNER JOIN enrollments AS en ON en.enrollment_id = p.enrollment_id
INNER JOIN courses AS c ON  c.course_id = en.course_id
GROUP BY c.course_name


SELECT 
 c.course_name,
 ROUND(
 SUM(
 	CASE 
	 	WHEN completed = TRUE THEN 1 
	ELSE 0 
	END) * 100 / COUNT(*), 2) AS pr_completed
from courses AS c
INNER JOIN enrollments AS en ON c.course_id = en.course_id 
INNER JOIN progress AS p ON en.enrollment_id = p.enrollment_id
GROUP BY c.course_name

3. Знайти студентів, які завершили всі уроки у своїх курсах.
SELECT 
 s.full_name,
 c.course_name,
 ROUND(
 SUM(
 	CASE 
	 	WHEN completed = TRUE THEN 1 
	ELSE 0 
	END) * 100 / COUNT(*), 2) AS pr_completed
FROM progress AS p
JOIN enrollments AS en ON en.enrollment_id = p.enrollment_id
JOIN courses AS c ON c.course_id = en.course_id
JOIN students AS s ON s.student_id = en.student_id
GROUP BY s.full_name, c.course_name
HAVING ROUND(
 SUM(
 	CASE 
	 	WHEN completed = TRUE THEN 1 
	ELSE 0 
	END) * 100 / COUNT(*), 2) = 100
ORDER BY s.full_name, c.course_name

## **Задача 5. Віконні функції**

1. Для кожного курсу визначити рейтинг студентів за середнім балом.

select 
s.full_name,
ROUND(AVG(score),2),
RANK() OVER (ORDER BY ROUND(AVG(score),2) DESC) AS rank
from courses AS c
JOIN enrollments AS en ON c.course_id = en.course_id
JOIN progress AS p ON en.enrollment_id = p.enrollment_id
JOIN students AS s ON s.student_id = en.student_id
GROUP BY s.full_name 
ORDER BY s.full_name ASC;

2. Порахувати кумулятивну кількість уроків, завершених студентом у хронологічному порядку.

SELECT 
  s.full_name AS full_name, 
  p.progress_id AS progress_id,
  SUM(CASE WHEN p.completed THEN 1 ELSE 0 END) OVER (
    PARTITION BY s.student_id
    ORDER BY p.progress_id
  ) AS cum_complete
FROM progress AS p
JOIN enrollments AS en ON en.enrollment_id = p.enrollment_id
JOIN courses AS c ON c.course_id = en.course_id
JOIN students AS s ON s.student_id = en.student_id
ORDER BY s.full_name, p.progress_id;


SELECT 
  s.full_name AS full_name,
 -- p.lesson_number,
 -- c.course_id,
  --p.progress_id AS progress_id,
  SUM(CASE WHEN p.completed THEN 1 ELSE 0 END) OVER (
    PARTITION BY s.student_id
    ORDER BY p.lesson_number
  ) AS cum_complete
FROM progress AS p
JOIN enrollments AS en ON en.enrollment_id = p.enrollment_id
JOIN courses AS c ON c.course_id = en.course_id
JOIN students AS s ON s.student_id = en.student_id

3. Для кожної категорії курсів знайти топ-1 курс за кількістю студентів.

