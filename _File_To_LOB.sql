/* �������� ������ �� ����� � LOB */

DECLARE

  l_ServDir VARCHAR2(4000) := 'TEMP'; -- ������ ���������� �� �������
  l_FileName VARCHAR2(200) := 'test.txt'; -- ����������� ����
  l_blob  BLOB;
  l_clob  CLOB;
  l_bfile BFILE;

BEGIN
  
  -- ������� � ������� ������, ������������� ������� BLOB � CLOB �
  -- EMPTY_BLOB(), EMPTY_CLOB() � ��������� �� �������� � ����� ������.
  INSERT INTO SCOTT.TABL
  VALUES (1, l_FileName, EMPTY_BLOB(), EMPTY_CLOB())
  RETURNING File_Blob, File_Clob INTO l_blob, l_clob;
  
  -- ������� ������ BFILE
  l_bfile := bfilename(l_ServDir, l_FileName);
  
  -- ��������� ������ LO�
  dbms_lob.fileopen(l_bfile);
  
  -- ��������� ��� ���������� ����� � ������� LOB
  -- dbms_lob.getlength(l_bfile) ���������� ������ BFILE, ���������� �������� (��� �����)
  dbms_lob.loadfromfile(l_blob, l_bfile, dbms_lob.getlength(l_bfile));
  
  -- ��������� �������� ����� ���� BFILE, � ������� BLOB ��������
  dbms_lob.fileclose(l_bfile);

  l_bfile := bfilename(l_ServDir, l_FileName);
  dbms_lob.fileopen(l_bfile);
  dbms_lob.loadfromfile(l_clob, l_bfile, dbms_lob.getlength(l_bfile));
  dbms_lob.fileclose(l_bfile);
  
  COMMIT;

END;
