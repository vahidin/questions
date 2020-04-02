CREATE TABLE t (x INT, y INT);
INSERT INTO t VALUES (1,1);
SELECT * FROM t;
CREATE OR REPLACE TRIGGER t_buffer
BEFORE UPDATE ON t FOR EACH ROW
BEGIN
       dbms_output.put_line
       ('old.x = ' || :old.x ||
       ', old.y = ' || :old.y
       );
       dbms_output.put_line
       ('new.x = ' || :new.x ||
       ', new.y = ' || :new.y
       );
  END;
  
UPDATE t SET x = x + 1;
