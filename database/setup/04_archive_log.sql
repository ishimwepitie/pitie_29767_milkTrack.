-- Name: ISHIMWE Pitie | Student ID: 29767 | Group: B | Project: MilkTrack
-- Archive logging is a CDB (instance) setting, not a PDB setting.
-- All PDBs share the same redo logs and archived logs of the container.
-- A single PDB has no redo log of its own, so it cannot have its own mode.
-- Changing it needs SYSDBA access and a restart of the whole CDB.
SET ECHO ON
CONNECT / AS SYSDBA
SELECT name, log_mode FROM v$database;
ARCHIVE LOG LIST
-- Local installation only. Skip the next 4 lines if the mode is already ARCHIVELOG:
SHUTDOWN IMMEDIATE
STARTUP MOUNT
ALTER DATABASE ARCHIVELOG;
ALTER DATABASE OPEN;
SELECT name, log_mode FROM v$database;
ARCHIVE LOG LIST