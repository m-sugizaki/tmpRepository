#!/usr/bin/env bash
set -e
echo "Create RESULT index.html"
FN=`ls report/unit_test/*.xml | cut -d / -f3`
echo ${FN}
echo "<html>
<head>
<title>TravisCIビルド結果</title>
</head>
<body>
<h1>TravisCIビルド結果</h1>
<ul>
<li>ユニットテスト［<a href='./unit_test/units.html'>view</a>］</li>
<li>カバレッジ［<a href='./coverage/index.html'>view</a>］</li>
<li>E2Eテスト［<a href='./e2e_test/ProtractorTestReport.html'>view</a>］</li>
</ul>
</body>
</html>" > ./report/index.html