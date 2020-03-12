/* ƒаты в oracle Ч получить первый/последний день */
with t as (select trunc(sysdate) d from dual)
--
select '√ќƒ - первый день' descr,trunc(d,'YY') new_date from t
union all
select '√ќƒ - последний день', add_months(trunc(d,'YY'),12)-1 from t
union all
select ' ¬ј–“јЋ - первый день', trunc(d,'Q') from t
union all
select ' ¬ј–“јЋ - последний день', trunc(add_months(d, 3), 'Q')-1 from t
union all
select 'ћ≈—я÷ - первый день' ,trunc(d,'MM') from t
union all
-- LAST_DAY не измен€ет врем€
select 'ћ≈—я÷ - последний день',last_day(d) from t 
union all
-- какой день недели считаетс€ первым, зависит от параметра NLS_TERRITORY
select 'Ќ≈ƒ≈Ћя - первый день', trunc(d,'D') from t 
union all
select 'Ќ≈ƒ≈Ћя - последний день', trunc(d,'D')+6 from t;
 
DESCR                    NEW_DATE
------------------------ -----------
√ќƒ - первый день        01.01.2012
√ќƒ - последний день     31.12.2012
 ¬ј–“јЋ - первый день    01.10.2012
 ¬ј–“јЋ - последний день 31.12.2012
ћ≈—я÷ - первый день      01.11.2012
ћ≈—я÷ - последний день   30.11.2012
Ќ≈ƒ≈Ћя - первый день     05.11.2012
Ќ≈ƒ≈Ћя - последний день  11.11.2012
