echo off

cls

echo.

set jarName=agile-object-handle-1.0-SNAPSHOT.jar
set configName=account.xml
set configAttachmentSize=attachmentsize.xml

if "%~1"=="" (
    echo パラメータが不足です.
    goto error_fisnish
)

if "%~2"=="" (
    echo パラメータが不足です.
    goto error_fisnish
)

if "%~3"=="" (
    echo パラメータが不足です.
    goto error_fisnish
)

if not exist %jarName% (
    echo %jarName%が存在しません.
    goto error_fisnish
)

if not exist %configName% (
    echo %configName%が存在しません.
    goto error_fisnish
)

if "%~1"=="3" (
    if not exist %configAttachmentSize% (
        echo %configAttachmentSize%が存在しません.
        goto error_fisnish
    )
)

echo ★★★BATファイルからパラメータ：★★★
echo JobID : %1
echo ユーザストーリーID : %2
if "%~1"=="1" echo ステータス : %3
if "%~1"=="2" echo 追加ノート : %3
if "%~1"=="3" echo ファイルパス : %3
if "%~1"=="4" echo Defectの名前 : %3

echo.

setlocal enableextensions disabledelayedexpansion
set "user="
for /f "tokens=3 delims=<>" %%a in (
    'find /i "<username>" ^< "%configName%"'
) do set "user=%%a"
set "pass="
for /f "tokens=3 delims=<>" %%a in (
    'find /i "<password>" ^< "%configName%"'
) do set "pass=%%a"

echo ★★★JARファイルのパラメータ：★★★
echo JobID : %1
echo ユーザー名 : %user%
echo ユーザストーリーID : %2
if "%~1"=="1" echo ステータス : %3
if "%~1"=="2" echo 追加ノート : %3
if "%~1"=="3" echo ファイルパス : %3
if "%~1"=="4" echo Defectの名前 : %3

echo.

echo ★★★BATファイルからJARファイルを実行中... ★★★
java -jar %jarName% %1 %user% %pass% %2 %3

echo JARの返却コード %ERRORLEVEL%

if not %ERRORLEVEL%==0 (
    goto error_fisnish
) else (
    goto ok_finish
)

:ok_finish
echo 正常完了.
timeout 10
exit 0
:error_fisnish
echo 異常完了.
timeout 10
exit 1