/* Проверка  статистики по таблице */
SELECT t.last_analyzed,
       t.table_name,
       t.owner,
       t.num_rows,
       t.sample_size
  FROM DBA_TABLES t
 WHERE t.TABLE_NAME = 'CSC_CONNECT_OUT'
 ORDER BY t.last_analyzed;

/* Просматривать статистические данные по всем таблицам в базе данных */
SELECT *
  FROM DBA_TAB_STATISTICS t
 WHERE t.TABLE_NAME = 'CSC_CONNECT_OUT';

/* Просматривать статистические данные по столбцам */
SELECT column_name,
       num_distinct
  FROM DBA_TAB_COL_STATISTICS
 WHERE table_name = 'CSC_CONNECT_OUT';

/* Узнать, как в текущий момент выглядит режим оптимизатора в базе данных */
SELECT NAME,
       VALUE
  FROM V$PARAMETER
 WHERE NAME = 'optimizer_mode';
