git push origin :v8
git tag -d v8
git tag v8

git push origin :latest
git tag -d latest
git tag latest

git push origin master --tags 

IF "%1"=="nopause" GOTO No1
    pause
:No1 