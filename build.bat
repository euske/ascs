@set FLEX_HOME=..\flex_sdk4
@set PROJECT_NAME=foo
@java -Duser.country=US -jar %FLEX_HOME%\lib\mxmlc.jar +flexlib=%FLEX_HOME%\frameworks -static-rsls -o main.swf  -compiler.source-path=./src src\%PROJECT_NAME%\Main.as
@if errorlevel 1 ( pause ) else ( start /B .\main.html )
