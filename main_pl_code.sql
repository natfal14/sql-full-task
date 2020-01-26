SET SERVEROUTPUT ON SIZE 10000000000
DECLARE
    CURSOR COURSES_CUR IS
        SELECT * FROM COURSES;
        
    CURSOR ST_CUR IS
        SELECT * FROM STUDENTS;
    
    INDX NUMBER(4) := 1;
    START_DAY DATE;
    END_DAY DATE;
    NO_DAYS NUMBER(4);
    V_RND_PRICE COURSES.CRS_PRICE%TYPE;
    V_RND_NAME VARCHAR2(50);
    SR_INDX NUMBER(4) := 1;

BEGIN

    FOR V_CUR IN COURSES_CUR LOOP 
    
        V_RND_NAME := V_CUR.CRS_NAME || '_G1';    
    
        START_DAY := NEXT_DAY(SYSDATE, SUBSTR(V_CUR.RND_DAYS, 1, 3));
        END_DAY := START_DAY;
        NO_DAYS := V_CUR.CRS_HOURS/4;
        
        FOR I IN 1..(NO_DAYS/2 - 1) LOOP
            END_DAY := NEXT_DAY(END_DAY, SUBSTR(V_CUR.RND_DAYS, 1, 3));
            IF MOD(NO_DAYS, 2) = 0 THEN
                END_DAY := NEXT_DAY(END_DAY, SUBSTR(V_CUR.RND_DAYS, 5, 3));
            END IF;
        END LOOP;
        
        V_RND_PRICE := V_CUR.CRS_PRICE - 0.1*V_CUR.CRS_PRICE;
        
        INSERT INTO ROUNDS
            (RND_ID, RND_NAME, RND_START_DATE, RND_END_DATE, RND_PRICE, CRS_ID)
        VALUES
            (INDX, V_RND_NAME, START_DAY, END_DAY, V_RND_PRICE, V_CUR.CRS_ID);
        
        FOR V_CUR2 IN ST_CUR LOOP
            INSERT INTO STUDENTS_ROUNDS
                (ID, ST_ID, RND_ID, PAID_AMOUNT)
            VALUES
                (SR_INDX, V_CUR2.ST_ID, INDX, V_RND_PRICE);
            
            SR_INDX := SR_INDX + 1;
        END LOOP;    

        INDX := INDX + 1;
    END LOOP;

END;