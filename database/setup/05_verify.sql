-- Name: ISHIMWE Pitie | Student ID: 29767 | Group: B | Project: MilkTrack
SET ECHO ON
SET LINESIZE 200
COL tablespace_name FORMAT A20
COL username FORMAT A15
COL default_tablespace FORMAT A20
COL temporary_tablespace FORMAT A20
CONNECT / AS SYSDBA
SELECT name, open_mode FROM v$pdbs;
ALTER SESSION SET CONTAINER = b_29767_pitie_milktrack_db;
SHOW CON_NAME
SELECT username, default_tablespace, temporary_tablespace FROM dba_users WHERE username = 'PITIE_ADMIN';
SELECT tablespace_name, ROUND(bytes/1024/1024) size_mb, autoextensible, ROUND(maxbytes/1024/1024) max_mb
FROM dba_data_files WHERE tablespace_name LIKE 'MILKTRACK%'
UNION ALL
SELECT tablespace_name, ROUND(bytes/1024/1024), autoextensible, ROUND(maxbytes/1024/1024)
FROM dba_temp_files WHERE tablespace_name LIKE 'MILKTRACK%';
SELECT name, log_mode FROM v$database;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') AS now FROM dual;