create tablespace lw_09_1
datafile '/oracle/u02/oradata/DLadutkodb/lw_09_1.dat'
size 150M
    autoextend on next 50M
logging
segment space management auto
extent management local;


create tablespace lw_09_2
datafile '/oracle/u02/oradata/DLadutkodb/lw_09_2.dat'
size 150M
    autoextend on next 50M
logging
segment space management auto
extent management local;


create tablespace lw_09
datafile '/oracle/u02/oradata/DLadutkodb/lw_09.dat'
size 150M
    autoextend on next 50M
logging
segment space management auto
extent management local;