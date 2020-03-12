
SELECT * FROM All_Directories;
/* ������� ���������� */
DROP   DIRECTORY IMPEXP_DIR;
/
CREATE DIRECTORY IMPEXP_DIR AS 'C:\TEMP\IMPEXP_DIR'; -- ���������� �� �������

/* ������� ������� ������� */
SELECT * FROM IMPEXP_DIR_TAB;
DROP TABLE IMPEXP_DIR_TAB;
/
CREATE TABLE IMPEXP_DIR_TAB
(
c1 VARCHAR2(1000),
c2 VARCHAR2(1000),
c3 VARCHAR2(1000),
c4 VARCHAR2(1000),
c5 VARCHAR2(1000)
)
ORGANIZATION EXTERNAL 
(
--TYPE ORACLE_LOADER -- ��������� ������ ��������� ������ � �������
--TYPE ORACLE_DATAPUMP -- ��������� � ��������� ������
DEFAULT DIRECTORY IMPEXP_DIR
ACCESS PARAMETERS 
(
RECORDS DELIMITED BY NEWLINE
BADFILE log_file_dir:'bad.log'
LOGFILE log_file_dir:'log.log'
FIELDS TERMINATED BY ";" LDRTRIM
MISSING FIELD VALUES ARE NULL
)
LOCATION ('94055.csv')
);

/* �������� ������ � ���� */
DECLARE
  fHandle UTL_FILE.FILE_TYPE; --������������ ��� ������ �������� ����� ������������ �������;
BEGIN
    fHandle := UTL_FILE.FOPEN ('IMPEXP_DIR', '94055_exp5.csv', 'w');
  FOR cur IN (select t.c1,t.c2,t.c3,t.c4,t.c5 from IMPEXP_DIR_TAB t) LOOP
    UTL_FILE.PUT_line (fHandle,cur.c1||';'||cur.c2||';'||cur.c3||';'||cur.c4||';'||cur.c5);
  END LOOP;
  UTL_FILE.FCLOSE (fHandle);
END;

SELECT COUNT(*) FROM All_Objects;
