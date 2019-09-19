#!/bin/sh

jarName=agile-object-handle-1.0-SNAPSHOT.jar
configName=account.xml
configAttachmentSize=attachmentsize.xml

if [ -z "$1" ]
then
	echo "パラメータが不足です。"
	timeout 3 echo "異常完了."
	exit -1
fi

if [ -z "$2" ]
then
	echo "パラメータが不足です。"
	timeout 3 echo "異常完了."
	exit -1
fi

if [ -z "$3" ]
then
	echo "パラメータが不足です。"
	timeout 3 echo "異常完了."
	exit -1
fi

if [ ! -f $jarName ]
then
	echo "$jarNameが存在しません。"
	timeout 3 echo "異常完了."
	exit -1
fi

if [ ! -f $configName ]
then
	echo "$configNameが存在しません。"
	timeout 3 echo "異常完了."
	exit -1
fi

if test "$1" = "3"
then
	if [ ! -f $configAttachmentSize ]
	then
		echo "$configAttachmentSizeが存在しません。"
		timeout 3 echo "異常完了."
		exit -1
	fi
fi

echo ***SHファイルからパラメータ***
echo JobID: $1
echo ユーザストーリーID: $2

case "$1" in
	"1") echo ステータス: $3;;
	"2") echo 追加ノート: $3;;
	"3") echo ファイルパス: $3;;
	"4") echo Defectの名前: $3;;
esac

echo

username=$(awk -F'[<>]' '/<username>/{print $3}' account.xml)
password=$(awk -F'[<>]' '/<password>/{print $3}' account.xml)

echo ***JARファイルからパラメータ***
echo JobID: $1
echo ユーザー名: $username
echo ユーザストーリーID: $2

case "$1" in
	"1") echo ステータス: $3;;
	"2") echo 追加ノート: $3;;
	"3") echo ファイルパス: $3;;
	"4") echo Defectの名前: $3;;
esac
echo
echo ***SHファイルからJARファイルを実行中...***
java -jar -Xms1024m -Xmx1024m $jarName $1 $username $password $2 $3

res=$?
echo JARファイルの返却コード $res

if [ $res -gt 0 ]; then
	timeout 3 echo "異常完了."
	exit 1
else
	timeout 3 echo "正常完了."
	exit 0
fi
