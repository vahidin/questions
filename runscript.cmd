@echo off
cls
chcp 1251
echo ------------------------------------------------------------------------------------------- >> runscript.log
sqlplus SCOTT/TIGER@XE @runscript.PDC >> runscript.log
