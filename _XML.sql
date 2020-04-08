/* Разбор XML средствами Oracle. */

-- Пример создания экземпляра XMLType, с содержимым, передаваемым в строке
SELECT XMLType(
'<hello-world>
  <word seq="1">Hello</word>
  <word seq="2">world</word>
</hello-world>') xml
FROM dual;

-- Выбираем фрагменты XML
SELECT  t.xml.extract('//word')                AS c1
       ,t.xml.extract('//word[position()=1]')  AS c2
       ,t.xml.extract('//word[@seq=2]/text()') AS c3
  FROM (
        SELECT XMLType(
        '<hello-world>
          <word seq="1">Hello</word>
          <word seq="2">world</word>
        </hello-world>') xml
        FROM dual )t;
        
     C1                        C2                          C3
----------------------------  --------------------------  -----
  <word seq="1">Hello</word>  <word seq="1">Hello</word>  world
  <word seq="2">world</word>
