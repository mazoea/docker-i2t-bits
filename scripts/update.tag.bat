git push origin :v8 :latest
git tag -d v8 latest
git tag v8 latest
git push origin master --tags 

IF "%1"=="nopause" GOTO No1
    pause
:No1 