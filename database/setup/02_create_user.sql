-- Name: ISHIMWE Pitie | Student ID: 29767 | Group: B | Project: MilkTrack
SET ECHO ON
CONNECT / AS SYSDBA
ALTER SESSION SET CONTAINER = b_29767_pitie_milktrack_db;
CREATE USER pitie_admin IDENTIFIED BY pitie;
GRANT DBA TO pitie_admin;
GRANT CREATE SESSION TO pitie_admin;
CONNECT pitie_admin/pitie@//localhost:1521/b_29767_pitie_milktrack_db
SHOW USER
SHOW CON_NAME
SELECT granted_role FROM user_role_privs;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') AS now FROM dual;