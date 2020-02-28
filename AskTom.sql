SELECT v.segment_name, 
       v.segment_type, 
       v.bytes/1024 AS kb,
       v.blocks,
       v.extents,
       v.initial_extent
  FROM User_Segments v;

SELECT * FROM v$undostat;
