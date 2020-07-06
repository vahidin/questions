/*
  ������� ���������� (+)
*/

������� ������ ������� (��� ����� ���� Oracle ������ ������ ��� 9) �� ������ � ������� ���������� � SQL ������� �������� �������, ��� ��� �� ����� ��������� "������".
� ��� ������. 
�� ������ �� ����������� � 9-� ������ ��������� ANSI ��� ������� ����������, "������" ��������� � ������. ���, ������, �� ������ ������� ���� � ��� ����� ���������. ���������� ����� ���� ������� � ���������� "�������" �� ������� ����������.
����������� ���� � ��� ��� �������: FND_USER � HR_EMPLOYEES. ������-��, HR_EMPLOYEES ��� view, �� ����� ��� ��������� ������� ������� ��������. ����������� ��� �� ������� EMPLOYEE_ID, ������� ������������ � �����. ������ � HR_EMPLOYEES ��� ��� � ��������� ����, � � FND_USER ���� ������� �� �������� ������������.
���������� ���� ������ � ������� �������� ���:

SELECT fu.*
      ,he.*
  FROM hr_employees he
      ,fnd_user fu
 WHERE he.employee_id = fu.employee_id

� ������ ������.
��� �� ������� "������"?
����� ����������� �� ����������� � �� ������� �� ����, ��� �� ����� �������� � �������.

��������, ��� ����� ��� ���� ������������� (������, ��� ������� ���������� � 'S') ���������� �� ������� ��� ��������. ���������� � ��� ���������� � ������� HR_EMPLOYEES.full_name
� ���� ������ ������ ����� ��������� ���:

SELECT fu.user_name
      ,he.full_name
  FROM hr_employees he
      ,fnd_user fu
 WHERE he.employee_id(+) = fu.employee_id
   AND fu.user_name LIKE 'S%'

������� �������� � ���, ��� "������" �������� � ��� ������� ��� ����� ������������� ��������, ������ ������ � �����������.

���� � ������� HR_EMPLOYEES ������� employee_id �������� ��������� ������, � �������� � ��� ������������� �� ����� � ��������. ������ "������" ����� ��������� ������ � ���� �������.
� ��� �� ����.
� ������ ������, �� ������� � ���, ��� � ��������� ���������� ������ (��� ������������ ����� ���) ������� FND_USER "�������". �� ���������� ����� ���� �� ������� �������������, ��� ����� �� �������, ����� ����� �������������� ���������� (���), ���� ��� ����������.
������ ��� ����� �� ������������?
�� ������, ��� � ������������ � ������� FND_USER ����� ������������� �������� � ������� EMPLOYEE_ID. ������ ��� ���� ������� � FND_USER (��� employee_id IS NULL) � HR_EMPLOYEES ����� ������ � �� ������. ������ ������� "������" �������� �� ������� ������� HR_EMPLOYEES

������.
�������� ����� ������� ��������:

SELECT fu.user_name
      ,(SELECT he.full_name
          FROM hr_employees he
         WHERE he.employee_id = fu.employee_id)
  FROM fnd_user fu
 WHERE fu.user_name LIKE 'S%'

� ����� ���� �������� ��������, ��� ���������� ������������� "�������". ���� FND_USER ������������ ������� �� ����� FROM. � ���������� � ��� ������������� �����������, ������� ���� � ������, ���� ���.
�������� ������� ������ ������� �������� ��, ��� ��������� ��������� ������� ������ ���� ��������. � ���� ��� ����� �� ������������ �� ������ full_name, �� � employee_num, creation_date � �.�.

������ ��������.
��� ���� �����������, � ������� ������� ���������� �� '�' ����� ����� ����� �������������, � �������� ��� �������� � �������. ����� ������������� ���������� � ������� FND_USER.user_name.
� ���� ������ ������ ����� ��������� ���:

SELECT fu.user_name
      ,he.full_name
  FROM hr_employees he
      ,fnd_user fu
 WHERE he.employee_id = fu.employee_id(+)
   AND he.full_name LIKE '�%'

������ ����� �������, ������ "������" �������� � ������� FND_USER.
� ������ ������, �� ������� � ���, ��� � ��������� ���������� ������ (��� ���� ����������� ����� user_name) ������� HR_EMPLOYEES "�������". �� ���������� ����� ���� �� ������� �����������, ��� ����� �� �������, ����� ����� �������������� ���������� (user_name), ���� ��� ����������.
������ ��� ����� �� ������������?
�� ������, ��� ��� ���������� �� ������� HR_EMPLOYEES ����� ������������� ������ � ������� FND_USER � ��������������� ��������� ������� EMPLOYEE_ID. ������ ��� ���� ������� � HR_EMPLOYEES �� ������ �� ������ � FND_USER. ������ ������� "������" �������� �� ������� ������� FND_USER.

������ � ��� ��� �� ��.
� ��� ���� �� ����� �������� ������ ������ � �����������, � ������������� ������������������ � �������. ������ �� ��� �����, ��� ��� ���� ����������� ����� ���� �� ������� ������������, � ��� ���� ������������� ����� ���� �� ������� ����������. �.�. "������" ����� ��� �� � ����� ������. ������ ����� ��������� ������� �� ��������������.

���������� ������ ������� ���������� ���� ������ �� �������(��� �������� ����������), ������ ���� ���� �� ����� ����������� ������ �� ������� ����������.
��� ���������� ������ ������� ���������� ������ ������� ���������� (FULL OUTER JOIN). � � ���� ������ �������� ��������������� ����������� ANSI.
� ��������� ��� ����� ���:

SELECT fu.user_name
      ,he.full_name
  FROM hr_employees he FULL OUTER JOIN fnd_user fu
    ON he.employee_id = fu.employee_id

������� �����, ����� ������� ���������.
���� ���� �� ���� � ������ ������� ����������, �� ����� ������ ����� �� ������ �������� �������, � ����� �����������. "������" � ������� ���������� ������ (����� WHERE) ������ �� ������� ����������� �������.

�� � ����������, ����� ������������ ����������.
� ��� ���� � ������� ������ ��� ��� �������? �������� ��� ����� ��� �������� ������������ (������� FND_GLOBAL.user_id) ����� ����� �������� �������� ����������.
���������� � ��������� �������� � ������� PER_PHONES. ��� ������� ����������� � HR_EMPLOYEES �� �������:

   per_phones.parent_table = 'PER_ALL_PEOPLE_F'
   AND per_phones.parent_id = hr_employees.employee_id

�� ��� ���� ��������, ��� �� � ���� ����������� ���� ������ � ���������.
�������� ������ ����� ��������� ���:

SELECT fu.user_name
      ,he.full_name
      ,pp.phone_number
  FROM fnd_user fu
      ,hr_employees he
      ,per_phones pp
 WHERE /* ��������� fnd_user � hr_employees */
       he.employee_id(+) = fu.employee_id
       /* ��������� hr_employees � per_phones */
   AND pp.parent_id(+) = he.employee_id
   AND pp.parent_table(+) = 'PER_ALL_PEOPLE_F'
       /* ������ ����������� */
   AND pp.phone_type(+) = 'W1' -- ������� �������
   AND SYSDATE BETWEEN pp.date_from(+) AND NVL(pp.date_to(+), SYSDATE) -- ���������� ������
   AND fu.user_id = FND_GLOBAL.user_id -- ��� �������� ������������

������� ���������.
������� ��������� �������.
� ������ ���� ���������� ������� � ����������� �������.
� ���� fnd_user � hr_employees ������� - fnd_user, ������� "������" �� ������� hr_employees.
� ���� hr_employees � per_phones ������� hr_employees, ������� "������" �������� �� ������� per_phones � ��� �������� ����� "������" �� �������� �� ������� hr_employees.
� ������ �������� "������" �������� ��� ��� ������, ������� ���� ���-������ ���� ��������������� � �� �������� � ������� ������� �������.


/* 
   ORA-01427: ��������� ��������� ������ ���������� ����� ����� ������!!!
   ����� ������������ ������ ����:
*/
SELECT
       (SELECT DECODE(COUNT(*), 0,NULL, 1,MAX(t2.column), 'ORA-01427')
          FROM table2
         WHERE ...)
  FROM table1 t1
 WHERE ...


/* 
   � ������ ������� ���� ������������ ����� - ��� ������ ������ �� SELECT, 
   ORACLE ����������� ������ �������� ���������� � SQL �� PLSQL. 
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


/* 
   ������������� BULK COLLECT � FORALL 
   ������ FORALL ����� ���� ������ ���� DML ������. 
	 ���� ����� ��������� ��������, �� ����� ������������ ��������� FORALL
*/
DECLARE
   -- ������� ��� �������������� �������,
   -- ��� �������� = SCOTT.EMP.empno%TYPE, � PLS_INTEGER ��� ����.
	 TYPE EMPNO_T IS TABLE OF SCOTT.EMP.empno%TYPE
	 INDEX BY PLS_INTEGER;
	 -- ��������� ���������� l_empno_t ���� EMPNO_T
	 l_empno_t EMPNO_T;
BEGIN
   -- ��������� ��� ������ ����� � ���������
	 SELECT empno 
	   BULK COLLECT INTO l_empno_t
	   FROM SCOTT.EMP;
	 -- ����������� FORALL ��������� ���� UPDATE �� ���� ���
	 FORALL i IN 1..l_empno_t.COUNT
	 	UPDATE SCOTT.EMP
		   SET sal = sal + (sal * .01)
     WHERE empno = l_empno_t(i);
	 COMMIT;
END;

SELECT * FROM SCOTT.emp;

/* ������������� ������ */
DECLARE
  -- ������� ��� �������������� �������,
  -- ��� �������� = SCOTT.EMP.ename%TYPE, � PLS_INTEGER ��� ����.
  TYPE ENAME_T IS TABLE OF SCOTT.EMP.ename%TYPE INDEX BY PLS_INTEGER;
  TYPE LOC_T   IS TABLE OF SCOTT.DEPT.loc%TYPE  INDEX BY PLS_INTEGER;
  -- ���������� ���������� �� ���� ����.
  l_ename_t ENAME_T;
  l_loc_t   LOC_T;

  l_row PLS_INTEGER;

  -- ���������� �������
  CURSOR ename_loc_cur IS
    SELECT e.ename,
           d.loc
      FROM SCOTT.EMP  e,
           SCOTT.DEPT d
     WHERE e.deptno = d.deptno;

BEGIN
  -- ���������� ����������
  FOR i IN ename_loc_cur
  LOOP
    l_ename_t(ename_loc_cur%ROWCOUNT) := i.ename;
  
    l_loc_t(ename_loc_cur%ROWCOUNT) := i.loc;
  END LOOP;

  -- ������ ������ ���������� (1)
  l_row := l_ename_t.FIRST;

  dbms_output.put_line(rpad('   ENAME', 10, ' ') || 'LOCATION');
  dbms_output.put_line('-------------------');

  -- ����� ���������
  WHILE (l_row IS NOT NULL)
  LOOP
    dbms_output.put_line(lpad(l_row, 2, ' ') || ' ' ||
                         rpad(l_ename_t(l_row), 7, ' ') || l_loc_t(l_row));
    l_row := l_ename_t.NEXT(l_row);
  END LOOP;
END;

   ENAME  LOCATION
-------------------
 1 SMITH  DALLAS
 2 ALLEN  CHICAGO
 3 WARD   CHICAGO
 4 JONES  DALLAS
 5 MARTIN CHICAGO
 6 BLAKE  CHICAGO
 7 CLARK  NEW YORK
 8 SCOTT  DALLAS
 9 KING   NEW YORK
10 TURNER CHICAGO
11 ADAMS  DALLAS
12 JAMES  CHICAGO
13 FORD   DALLAS
14 MILLER NEW YORK
