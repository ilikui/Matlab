echo off

rem  the path of the git command


set git = D:\Git\bin\git.exe

 git add *
 
 WScript.sleep 5000
 
 git commit -m "update"
 
 git push
 
 git 
 git status

pause