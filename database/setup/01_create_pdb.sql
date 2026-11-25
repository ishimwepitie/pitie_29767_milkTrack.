-- Name: ISHIMWE Pitie | Student ID: 29767 | Group: B | Project: MilkTrack
SET ECHO ON
CONNECT / AS SYSDBA
SHOW CON_NAME
CREATE PLUGGABLE DATABASE b_29767_pitie_milktrack_db
  ADMIN USER pdb_adm IDENTIFIED BY pdb_adm
  FILE_NAME_CONVERT = ('pdbseed', 'b_29767_pitie_milktrack_db');
ALTER PLUGGABLE DATABASE b_29767_pitie_milktrack_db OPEN;
ALTER PLUGGABLE DATABASE b_29767_pitie_milktrack_db SAVE STATE;
SELECT name, open_mode FROM v$pdbs;
SELECT con_name, state FROM dba_pdb_saved_states;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') AS now FROM dual;