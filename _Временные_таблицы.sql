/* ��������� ������� */
   
   ��������� ������� Oracle ������ �� ��������� ������� � ������ ����������� ����� ������, 
�� � ������ ��������: ��� ������������ ����������. 
�� �������� �� ���� ��� ��� ���� ������, � �� ���� ��� ��� ������ �������� ��������� � ���� ���� ������. 
��������� ������� ���������� ������ - ��� ����� �������������� � ������� ������ ��� �������, �� ����� 
������ ��������� n������ �� ��� ���, ���� ��� ����� �� �������� � ��� ������. 
��� ����, ��� ��� ���������� ����������, ��������� ��������� �������������, ������� ��������� �� ���, 
�������� n��������, ������� ���������� ����������� SQL ��� ������ �� ���, � �.�.
   ��������� ������� ����� ���� �������� �� ������ (������ ����������� � ������� ����� ����������, 
�� �� ����� ����������� � ��������� ������������).
   ��������� ������� ����� ����� ���� �������� �� ���������� (������ �������� ����� ��������). 
���� �������� n����� ���� � ������� ���������. � �������� ������� ����������� ������� SCOTT.EMP.

CREATE GLOBAL TEMPORARY TABLE TEMP_TABLE_SESSION
ON COMMIT PRESERVE ROWS
AS SELECT * FROM SCOTT.EMP WHERE 1=0;

����������� ON COMMIT PRESERVE ROWS ������ ��������� ������� ���������� �� ������. 
������ ����� ���������� � ���� ������� �� ��� ���, ���� ����� �� ���������� ��� ���� 
��� �� ����� ��������� ������� � ������� DELETE ��� TRUNCATE . ��� ������ �������� ������ �������� ������, 
������� ������ ����� �� ����� �� ������ ���� ����� ���������� ��������.

CREATE GLOBAL TEMPORARY TABLE TEMP_TABLE_TRANSACTION
ON COMMIT DELETE ROWS
AS SELECT * FROM SCOTT.EMP WHERE 1=0;

����������� ON COMMIT DELETE ROWS ������ ��������� ������� ���������� �� ����������. 
����� ����� ���������� ��������, ������ ��������. ������ ��������� �� ���� ����������� ������� ��������� ���������, 
���������� ��� ������� - ������� ��������� �������� � �������������� �������� ��������� ������ �� �������. 
������ ������� ��������� �� ������� ����� ����� ����� ������ ������:

INSERT INTO TEMP_TABLE_SESSION SELECT * FROM SCOTT.EMP;
SELECT * FROM TEMP_TABLE_SESSION;

INSERT INTO TEMP_TABLE_TRANSACTION SELECT * FROM SCOTT.EMP;
SELECT * FROM TEMP_TABLE_TRANSACTION;

� ������ �� ���� ��������� ������ �������� �� 14 �����, � �� ����� � ���� ���������:

SELECT session_cnt, transaction_cnt
  FROM (SELECT COUNT(*) session_cnt FROM TEMP_TABLE_SESSION),
       (SELECT COUNT(*) transaction_cnt FROM TEMP_TABLE_TRANSACTION);

 	SESSION_CNT	TRANSACTION_CNT
-----------------------------
1	         14	             14

COMMIT;

��� ��� ����������� ��������, �� ������ ������ �� ��������� �������, ���������� �� ������, 
�� �� ������ �� ��������� �������, ���������� �� ����������: 

SELECT session_cnt, transaction_cnt
  FROM (SELECT COUNT(*) session_cnt FROM TEMP_TABLE_SESSION),
       (SELECT COUNT(*) transaction_cnt FROM TEMP_TABLE_TRANSACTION);
       
 	SESSION_CNT	TRANSACTION_CNT
-----------------------------
1	         14	              0

����� ���������, ���� �� ������� ������� ��� ���������, � ����� ����������������� �������� ������ � ��� 
(� ������� ������ ��� ����������), ����� ���������:

SELECT table_name, temporary, duration FROM USER_TABLES;

  TABLE_NAME              TEMPORARY  DURATION
----------------------------------------------------  
1 EMP                     N 
2 DEPT                    N 
3 TEMP_TABLE_SESSION      Y          SYS$SESSION
4 TEMP_TABLE_TRANSACTION  Y          SYS$TRANSACTION


/* ������� */
DROP TABLE SCOTT.TEMP_TABLE_SESSION PURGE;
DROP TABLE SCOTT.TEMP_TABLE_TRANSACTION PURGE;
