/* Даты в Oracle */

  WITH t AS (SELECT TRUNC(SYSDATE) d FROM dual)
SELECT 'ГОД - первый день' AS descr, TRUNC(d,'YY') AS new_date FROM t
 UNION ALL
SELECT 'ГОД - последний день', ADD_MONTHS(TRUNC(d,'YY'), 12) - 1 FROM t
 UNION ALL
SELECT 'КВАРТАЛ - первый день', TRUNC(d,'Q') FROM t
 UNION ALL
SELECT 'КВАРТАЛ - последний день', TRUNC(add_months(d,3),'Q') - 1 FROM t
 UNION ALL
SELECT 'МЕСЯЦ - первый день', TRUNC(d,'MM') FROM t
 UNION ALL
SELECT 'МЕСЯЦ - последний день', LAST_DAY(d) FROM t
 UNION ALL
-- какой день недели считается первым, зависит от параметра NLS_TERRITORY
SELECT 'НЕДЕЛЯ - первый день', TRUNC(d,'D') FROM t
 UNION ALL
SELECT 'НЕДЕЛЯ - последний день', TRUNC(d,'D') + 6 FROM t;
 
DESCR                     NEW_DATE
------------------------  -----------
ГОД - первый день         01.01.2012
ГОД - последний день      31.12.2012
КВАРТАЛ - первый день     01.10.2012
КВАРТАЛ - последний день  31.12.2012
МЕСЯЦ - первый день       01.11.2012
МЕСЯЦ - последний день    30.11.2012
НЕДЕЛЯ - первый день      05.11.2012
НЕДЕЛЯ - последний день   11.11.2012


SELECT 'Начальная дата' AS descr,
       tdate AS res
  FROM (SELECT to_date('29.02.2020', 'dd.mm.yyyy') tdate
          FROM dual)
 UNION
SELECT 'Через месяц',
       add_months(tdate, 1)
  FROM (SELECT to_date('29.02.2020', 'dd.mm.yyyy') tdate
          FROM dual)
 UNION
SELECT 'Через год',
       add_months(tdate, 12)
  FROM (SELECT to_date('29.02.2020', 'dd.mm.yyyy') tdate
          FROM dual)
 ORDER BY (2);

 	DESCR	          RES
----------------  ----------
1	Начальная дата	29.02.2020
2	Через месяц	    31.03.2020
3	Через год	      28.02.2021

