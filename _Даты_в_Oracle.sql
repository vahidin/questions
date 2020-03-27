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

-- Добавление одного месяца ( функция ADD_MONTHS возвращает последний день следующего месяца)
SELECT 'Начальная дата' AS descr, tdate AS new_date
  FROM (SELECT to_date('29.02.2020', 'dd.mm.yyyy') tdate FROM dual)
 UNION
SELECT 'Через месяц', add_months(tdate, 1)
  FROM (SELECT to_date('29.02.2020', 'dd.mm.yyyy') tdate FROM dual)
 UNION
SELECT 'Через год', add_months(tdate, 12) 
  FROM (SELECT to_date('29.02.2020', 'dd.mm.yyyy') tdate FROM dual)
 ORDER BY (2);

 	DESCR	          NEW_DATE
----------------  -----------
1	Начальная дата	29.02.2020
2	Через месяц	    31.03.2020
3	Через год	      28.02.2021

/* nолучение разности между двумя значениями DАТЕ */
SELECT NUMTOYMINTERVAL (TRUNC(months_between(dt2,dt1)),'month')  AS years_months,
       months_between  (dt2,dt1)                                 AS months_btwn,
       NUMTODSINTERVAL (dt2-dt1,'day')                           AS days,
       NUMTOYMINTERVAL (TRUNC(months_between (dt2,dt1)),'month') AS months 
  FROM (SELECT to_date('29.02.2000 01:02:03','dd.mm.yyyy hh24:mi:ss') AS dt1,
               to_date('15.03.2001 11:22:33','dd.mm.yyyy hh24:mi:ss') AS dt2
          FROM dual);

 	YEARS_MONTHS	MONTHS_BTWN	     DAYS	                          MONTHS
--------------- ---------------- ------------------------------ -------------
1	+000000001-00	12,5622871863799 +000000380 10:20:30.000000000	+000000001-00


/* nолучение разности между двумя ТIМЕSТSTAMP (результатом этой операции будет INTERVAL) */
SELECT SYSTIMESTAMP FROM dual;

SELECT dt2 - dt1
FROM ( SELECT to_timestamp ('29.02.2000 01:02:03.122000', 'dd.mm.yyyy hh24:mi:ss.ff') AS dt1,
              to_timestamp ('15.03.2001 11:22:33.000000', 'dd.mm.yyyy hh24:mi:ss.ff') AS dt2
         FROM dual );
 	DT2-DT1
--------------------------------
1	+000000380 10:20:29.878000000


-- Выводим только минуты
SELECT to_char(SYSDATE,'mi') FROM dual;
-- Усекаем до минут
SELECT TRUNC(SYSDATE,'mi') FROM dual;
-- Вычесть 1 час 
SELECT SYSDATE - 1/24 FROM dual;
-- Вычесть 10 минут
SELECT SYSDATE - 10/24/60 FROM dual;



/* Выбрать периоды по 7 дней */
WITH reg_period(period_from, period_to, n_period) AS
    (SELECT to_date('01.05.2018 00:00:00', 'dd.mm.yyyy hh24:mi:ss') AS period_from,
            (to_date('01.05.2018 00:00:00', 'dd.mm.yyyy hh24:mi:ss') + 6) AS period_to,
            1 AS n_period
       FROM dual
      UNION ALL
     SELECT (period_from + 7) AS period_from,
       CASE WHEN period_to = to_date('09.07.2018', 'dd.mm.yyyy') 
            THEN to_date('18.07.2018', 'dd.mm.yyyy')
            ELSE (period_to + 7) 
        END AS period_to,
            (n_period + 1) AS n_period
       FROM reg_period
      WHERE period_to <= to_date('09.07.2018 23:59:59', 'dd.mm.yyyy hh24:mi:ss'))
SELECT * FROM reg_period;

    PERIOD_FROM PERIOD_TO   N_PERIOD
--------------- ----------  ---------
 1  01.05.2018  07.05.2018          1
 2  08.05.2018  14.05.2018          2
 3  15.05.2018  21.05.2018          3
 4  22.05.2018  28.05.2018          4
 5  29.05.2018  04.06.2018          5
 6  05.06.2018  11.06.2018          6
 7  12.06.2018  18.06.2018          7
 8  19.06.2018  25.06.2018          8
 9  26.06.2018  02.07.2018          9
10  03.07.2018  09.07.2018         10
11  10.07.2018  18.07.2018         11
