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
	 TYPE EMPNO_T IS TABLE OF SCOTT.EMP.empno%TYPE
	 INDEX BY PLS_INTEGER;
	 -- Объявляем переменную l_empno_t типа EMPNO_T
	 l_empno_t EMPNO_T;
BEGIN
   -- Поместить все записи разом в коллекцию
	 SELECT empno 
	   BULK COLLECT INTO l_empno_t
	   FROM SCOTT.EMP;
	 -- Конструкция FORALL выполняет весь UPDATE за один раз
	 FORALL i IN 1..l_empno_t.COUNT
	 	UPDATE SCOTT.EMP
		   SET sal = sal + (sal * .01)
     WHERE empno = l_empno_t(i);
	 COMMIT;
END;
