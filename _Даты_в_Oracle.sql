/* ���� � oracle � �������� ������/��������� ���� */
with t as (select trunc(sysdate) d from dual)
--
select '��� - ������ ����' descr,trunc(d,'YY') new_date from t
union all
select '��� - ��������� ����', add_months(trunc(d,'YY'),12)-1 from t
union all
select '������� - ������ ����', trunc(d,'Q') from t
union all
select '������� - ��������� ����', trunc(add_months(d, 3), 'Q')-1 from t
union all
select '����� - ������ ����' ,trunc(d,'MM') from t
union all
-- LAST_DAY �� �������� �����
select '����� - ��������� ����',last_day(d) from t 
union all
-- ����� ���� ������ ��������� ������, ������� �� ��������� NLS_TERRITORY
select '������ - ������ ����', trunc(d,'D') from t 
union all
select '������ - ��������� ����', trunc(d,'D')+6 from t;
 
DESCR                    NEW_DATE
------------------------ -----------
��� - ������ ����        01.01.2012
��� - ��������� ����     31.12.2012
������� - ������ ����    01.10.2012
������� - ��������� ���� 31.12.2012
����� - ������ ����      01.11.2012
����� - ��������� ����   30.11.2012
������ - ������ ����     05.11.2012
������ - ��������� ����  11.11.2012
