CREATE OR REPLACE VIEW SCOTT.EMP_DEPT_V AS
SELECT e.ename,
       e.job,
       d.loc
  FROM SCOTT.EMP  e,
       SCOTT.DEPT d
 WHERE e.deptno = d.deptno;

DROP VIEW EMP_DEPT_V;
