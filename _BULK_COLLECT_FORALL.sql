/* ======================================================================
   У такого подхода есть существенный минус - для каждой записи из SELECT, 
   ORACLE приходиться менять контекст выполнения с SQL на PLSQL. 
*/
BEGIN
  FOR i IN (SELECT empno FROM SCOTT.EMP)
  LOOP 
	UPDATE SCOTT.EMP
	   SET sal = sal + (sal * .01)
         WHERE empno = i.empno;
	 dbms_output.put_line (i.empno);
  END LOOP;
  COMMIT;
END;


/* =====================================================================
   Использование BULK COLLECT и FORALL 
   Внутри FORALL может быть только одни DML запрос. 
	 Если нужно несколько запросов, то нужно использовать несколько FORALL
*/
DECLARE
  -- Создаем тип ассоциативного массива,
  -- где ЗНАЧЕНИЕ = SCOTT.EMP.empno%TYPE, а PLS_INTEGER это ключ.
  TYPE EMPNO_T IS TABLE OF SCOTT.EMP.empno%TYPE INDEX BY PLS_INTEGER;
  -- Объявляем переменную l_empno типа EMPNO_T
  l_empno EMPNO_T;
BEGIN
  -- Поместить все записи разом в коллекцию
  SELECT empno BULK COLLECT INTO l_empno FROM SCOTT.EMP;
  -- Конструкция FORALL выполняет весь UPDATE за один раз
  FORALL i IN 1 .. l_empno.COUNT
    UPDATE SCOTT.EMP 
       SET sal = sal + (sal * .01) 
     WHERE empno = l_empno(i);
  COMMIT;
END;


/* Создаем структуру для обновления двух таблиц */
CREATE TABLE SCOTT.EMP1 AS (SELECT * FROM SCOTT.EMP);
CREATE TABLE SCOTT.EMP2 AS (SELECT * FROM SCOTT.EMP);
--DROP TABLE SCOTT.EMP1 PURGE;
--DROP TABLE SCOTT.EMP2 PURGE;

/* Обновляем сразу в двух таблицах*/
DECLARE
  TYPE EMPNO_T IS TABLE OF SCOTT.EMP1.empno%TYPE INDEX BY PLS_INTEGER;
	TYPE SAL_T   IS TABLE OF SCOTT.EMP1.sal%TYPE;
	l_empno EMPNO_T;
	l_sal SAL_T;

BEGIN
  SELECT empno, sal BULK COLLECT 
	  INTO l_empno, l_sal 
		FROM SCOTT.EMP1;

	FORALL i IN 1..l_empno.COUNT SAVE EXCEPTIONS
	UPDATE SCOTT.EMP1
	   SET sal = l_sal(i) + (l_sal(i) * .01)
	 WHERE empno = l_empno(i);

	FORALL i IN 1..l_empno.COUNT SAVE EXCEPTIONS	
	UPDATE SCOTT.EMP2
	   SET sal = l_sal(i) + (l_sal(i) / .02)
	 WHERE empno = l_empno(i);
	 
EXCEPTION
   WHEN OTHERS THEN
	 dbms_output.put_line(sqlerrm);
	 dbms_output.put_line('Number of ERRORS: ' || SQL%BULK_EXCEPTIONS.COUNT);
   FOR i IN 1..SQL%BULK_EXCEPTIONS.COUNT LOOP
	     dbms_output.put_line('Error ' || i || ' occurred during iteration ' || SQL%BULK_EXCEPTIONS(i).ERROR_INDEX);
       dbms_output.put_line('Oracle error is ' ||SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE));
    END LOOP; 

END;

/*
Вывод ОШИБОК, здесь номера строк с ошибками:
--------------------------------------------
ORA-24381: error(s) in array DML
Number of ERRORS: 6
Error 1 occurred during iteration 4
Oracle error is ORA-01438: value larger than specified precision allowed for this column
Error 2 occurred during iteration 6
Oracle error is ORA-01438: value larger than specified precision allowed for this column
Error 3 occurred during iteration 7
Oracle error is ORA-01438: value larger than specified precision allowed for this column
Error 4 occurred during iteration 8
Oracle error is ORA-01438: value larger than specified precision allowed for this column
Error 5 occurred during iteration 9
Oracle error is ORA-01438: value larger than specified precision allowed for this column
Error 6 occurred during iteration 13
Oracle error is ORA-01438: value larger than specified precision allowed for this column
*/


/* Проверяем */
SELECT t.empno, t.sal, t1.sal AS sal_1, t2.sal AS sal2 
  FROM SCOTT.EMP t, SCOTT.EMP1 t1, SCOTT.EMP2 t2
 WHERE t.empno  = t1.empno
   AND t.empno  = t2.empno
   AND t1.empno = t2.empno;
	 
  EMPNO      SAL   SAL_1   SAL_2
-------  ------- ------- -------
 1 7369   800,00  808,00 40800,00
 2 7499  1600,00 1616,00 81600,00
 3 7521  1250,00 1262,50 63750,00
 4 7566  2975,00 3004,75  2975,00
 5 7654  1250,00 1262,50 63750,00
 6 7698  2850,00 2878,50  2850,00
 7 7782  2450,00 2474,50  2450,00
 8 7788  3000,00 3030,00  3000,00
 9 7839  5000,00 5050,00  5000,00
10 7844  1500,00 1515,00 76500,00
11 7876  1100,00 1111,00 56100,00
12 7900   950,00  959,50 48450,00
13 7902  3000,00 3030,00  3000,00
14 7934  1300,00 1313,00 66300,00
