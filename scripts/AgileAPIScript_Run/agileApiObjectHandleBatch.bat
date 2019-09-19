echo off

cls

echo.

set jarName=agile-object-handle-1.0-SNAPSHOT.jar
set configName=account.xml
set configAttachmentSize=attachmentsize.xml

if "%~1"=="" (
    echo �p�����[�^���s���ł�.
    goto error_fisnish
)

if "%~2"=="" (
    echo �p�����[�^���s���ł�.
    goto error_fisnish
)

if "%~3"=="" (
    echo �p�����[�^���s���ł�.
    goto error_fisnish
)

if not exist %jarName% (
    echo %jarName%�����݂��܂���.
    goto error_fisnish
)

if not exist %configName% (
    echo %configName%�����݂��܂���.
    goto error_fisnish
)

if "%~1"=="3" (
    if not exist %configAttachmentSize% (
        echo %configAttachmentSize%�����݂��܂���.
        goto error_fisnish
    )
)

echo ������BAT�t�@�C������p�����[�^�F������
echo JobID : %1
echo ���[�U�X�g�[���[ID : %2
if "%~1"=="1" echo �X�e�[�^�X : %3
if "%~1"=="2" echo �ǉ��m�[�g : %3
if "%~1"=="3" echo �t�@�C���p�X : %3
if "%~1"=="4" echo Defect�̖��O : %3

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

echo ������JAR�t�@�C���̃p�����[�^�F������
echo JobID : %1
echo ���[�U�[�� : %user%
echo ���[�U�X�g�[���[ID : %2
if "%~1"=="1" echo �X�e�[�^�X : %3
if "%~1"=="2" echo �ǉ��m�[�g : %3
if "%~1"=="3" echo �t�@�C���p�X : %3
if "%~1"=="4" echo Defect�̖��O : %3

echo.

echo ������BAT�t�@�C������JAR�t�@�C�������s��... ������
java -jar %jarName% %1 %user% %pass% %2 %3

echo JAR�̕ԋp�R�[�h %ERRORLEVEL%

if not %ERRORLEVEL%==0 (
    goto error_fisnish
) else (
    goto ok_finish
)

:ok_finish
echo ���튮��.
timeout 10
exit 0
:error_fisnish
echo �ُ튮��.
timeout 10
exit 1