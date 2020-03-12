/* ������-������� */
����� ��������� ��� ������-�������:
CREATE TABLE t1 (x INT PRIMARY KEY,
                 y VARCHAR2(25),
                 z DATE)
ORGANIZATION INDEX;

CREATE TABLE t2 (x INT PRIMARY KEY,
                 y VARCHAR2(25),
                 z DATE)
ORGANIZATION INDEX OVERFLOW;

CREATE TABLE t3 (x INT PRIMARY KEY,
                 y VARCHAR2(25),
                 z DATE)
ORGANIZATION INDEX OVERFLOW INCLUDING y;

SELECT dbms_metadata.get_ddl('TABLE', 'T1')
  FROM dual;
--------------------------------------------------------------------------------

������ ��� ������ ������� �������� ������-������� ��� ������:
CREATE TABLE iot ( owner, object_type, object_name,
                   CONSTRAINT iot_pk PRIMARY KEY (owner, object_type, object_name) )
ORGANIZATION INDEX NOCOMPRESS
AS
SELECT DISTINCT owner, object_type, object_name FROM All_Objects;

������ ����� �������� ������������ ������������.
��� ����� �� �������� ������� ANALYZE INDEX VALIDATE STRUCTURE . 
��� ������� ��������� ������������ ������������� ������������������ �� ����� INDEX_STATS, 
������� ����� ��������� ����� ������� ���� ������ � ����������� �� ���������� ���������� ������� ANALYZE .

ANALYZE INDEX iot_pk VALIDATE STRUCTURE;

����� ����������, ��� ������ � ������� ������ ���������� 398 �������� ������ (��� ��������� ���� ������) 
� 3 ����� ��������� (����� ����� � Oracle ����������� ��� ��������� �� ��������� � ������) ��� ���������� �������� ������.
������������ ������������ ���������� ����� 2,9 ����� (2859716 ������).

SELECT v.lf_blks, v.br_blks, v.used_space, v.opt_cmpr_count, v.opt_cmpr_pctsave 
  FROM Index_Stats v;
	LF_BLKS	BR_BLKS	USED_SPACE	OPT_CMPR_COUNT	OPT_CMPR_PCTSAVE
--------------------------------------------------------------
1	398	    3	      2859716	    2	              33

������� OPT_CMPR_COUNT ( optimum compression count - ����������� ������� ������) ������� ���������: 
"���� �� �������� ���� � ����� COMPRESS 2, �� ������� �������� ������ ������� ������". 
������� OPT_CMPR_PCTSAVE (optimum compression percentage saved - ������� �������� ��� ����������� ������� ������) 
������� � ���, ��� ���� ������� COMPRESS 2, �� ����� ���� �� ���������� �������� ����
����� ������ ���������, � ������ ������� �� ����� ��� ����� ���� ��������� ������������, ������� �� �������� ������.

����� ��������� ��� ������, ���������� ������-������� � ������ COMPRESS 1:

ALTER TABLE iot MOVE COMPRESS 1;

ANALYZE INDEX iot_pk VALIDATE STRUCTURE;

SELECT v.lf_blks, v.br_blks, v.used_space, v.opt_cmpr_count, v.opt_cmpr_pctsave 
  FROM Index_Stats v;
	LF_BLKS	BR_BLKS	USED_SPACE	OPT_CMPR_COUNT	OPT_CMPR_PCTSAVE
-------------------------------------------------------------- 
1	346	    3	      2486742	    2	              23


ALTER TABLE iot MOVE COMPRESS 2;

ANALYZE INDEX iot_pk VALIDATE STRUCTURE;

SELECT v.lf_blks, v.br_blks, v.used_space, v.opt_cmpr_count, v.opt_cmpr_pctsave 
  FROM Index_Stats v;
	LF_BLKS	BR_BLKS	USED_SPACE	OPT_CMPR_COUNT	OPT_CMPR_PCTSAVE
--------------------------------------------------------------  
1	266	    3	      1906515	    2	              0

������ �� ����������� ��������� ������ �� ���� ��� ���������� �������� ������, 
��� � ������ ������ ����������� ������������ �� �������� l,9 �����.

������ ������ ���������� ���� ����� ���������� ���� �� ������-��������:
- ��� �������� ���������, �� ������ �� ��������;
- �� ������� �� ����� ���� ������������ ����� ��������� �������. 

BEGIN dbms_metadata.set_transform_param (dbms_metadata.SESSION_TRANSFORM, 'STORAGE', FALSE); END;

SELECT dbms_metadata.get_ddl('TABLE','T2') FROM dual;
<CLOB>
---------------------------
1 CREATE TABLE "SCOTT"."T2" 
   ( "X" NUMBER(*,0), 
	   "Y" VARCHAR2(25), 
	   "Z" DATE, 
	   PRIMARY KEY ("X") ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
     TABLESPACE "SYSTEM" 
     PCTTHRESHOLD 50 OVERFLOW
     PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 LOGGING
     TABLESPACE "SYSTEM"


SELECT dbms_metadata.get_ddl('TABLE','T3') FROM dual;
<CLOB>
--------------------------
 CREATE TABLE "SCOTT"."T3" 
   ( "X" NUMBER(*,0), 
	   "Y" VARCHAR2(25), 
	   "Z" DATE, 
	   PRIMARY KEY ("X") ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
     TABLESPACE "SYSTEM" 
     PCTTHRESHOLD 50 INCLUDING "Y" OVERFLOW
     PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 LOGGING
     TABLESPACE "SYSTEM" 



