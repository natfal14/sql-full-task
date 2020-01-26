# sql-full-task
This project includes the created STUDENTS & COURSES tables that are used in the PL/SQL code.

The aim of the project was to create a new round out of each course that starts and ends depending on the round days of each course (i.e. if the course days are Sundays and Fridays, the round starts on the next Sunday of the current date).

Each round was inserted into a new ROUNDS table using a cursor.

Each student is inserted into a STUDENT_ROUNDS table using also a cursor where they are linked to one round of the ROUNDS table.
The price of each round is also discounted by 10%.
