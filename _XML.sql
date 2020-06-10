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


SELECT d.extract('//ENTITY//ATTRIBUTE[@name="SURNAME"]/@value').getStringVal() surname
  FROM TABLE(XMLSequence(XMLType('<?xml version="1.0" encoding="windows-1257" ?>
<RESPONSE>
  <DATA REQUEST_ID="111">
    <ENTITY name="PACKAGE_001">
      <ATTRIBUTE name="PERS_ID" value="1111" />
      <ATTRIBUTE name="FIRST_NAME" value="OLGA" />
      <ATTRIBUTE name="SURNAME" value="NOVIKOVA" />
    </ENTITY>
    <ENTITY name="PACKAGE_001">
      <ATTRIBUTE name="PERS_ID" value="2222" />
      <ATTRIBUTE name="FIRST_NAME" value="ANNA" />
      <ATTRIBUTE name="SURNAME" value="ANTONOVA" />
    </ENTITY>
  </DATA>
</RESPONSE>').extract('RESPONSE/DATA/ENTITY'))) d;

   SURNAME
-----------
1	 NOVIKOVA
2	 ANTONOVA
