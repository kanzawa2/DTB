REM CrenaHtml2jpg.exe�𒼐ڎ��s����ꍇ
REM CrenaHtml2jpg.exe -otest.jpg -fjpeg -w800x600 -s117x90 -q92 -t25 -u"http://www.yahoo.co.jp"
REM -u��URL��"�ň͂�ł��ǂ��B


CrenaHtml2jpg.exe -otest.jpg -fjpeg -w800x600 -s117x90 -q92 -t25 -uhttp://www.yahoo.co.jp
echo %ERRORLEVEL%



REM URL�Ɂ������܂܂��ꍇ�B-u��URL�́A"�ň͂ނ��ƁB

CrenaHtml2jpg.exe -otest.jpg -fjpeg -w800x600 -s800x600 -q92 -t25 -u"http://www.google.co.jp/search?hl=ja&lr=lang_ja&num=10&q=%e3%83%86%e3%82%b9%e3%83%88"
echo %ERRORLEVEL%

REM CrenaHtml2jpg.exe��proccmd����Ăяo���ꍇ:�킴�ƃG���[�B�Q�l
proccmd -w 30 -c "CrenaHtml2jpg.exe -owwwgooglecojp.jpg -fjpeg -w800x600 -s117x90 -q92 -t25 -uhttp://aaa.yahoo.co.jp"
echo %ERRORLEVEL%

REM �ȉ�,�t�@�C�����ɋ󔒁A�t�q�k�ɋ󔒂��܂ޗ�
REM -----------------------------------------------------------------
REM CrenaHtml2jpg.exe -o"C:\Documents and Settings\test test1.jpg" -fjpeg -w800x600 -s117x90 -q92 -t25 -uhttp://www.yahoo.co.jp
REM CrenaHtml2jpg.exe -o"teseeerrrt yyy.jpg" -fjpeg -w800x600 -s117x90 -q92 -t25 -u"http://www.picolix.jp/ver sion.html"
REM -----------------------------------------------------------------

REM proccmd�i���v���O��������Ăяo���j�Ƀt�@�C�����ɋ󔒁A�t�q�k��&���܂ޕ������n���ꍇ�B
REM ---------------------------------------------------------------------
REM proccmd -w 30 -c "CrenaHtml2jpg.exe -o\"C:\Documents and Settings\test.jpg\" -fjpeg -w800x600 -s117x90 -q92 -t25 -u""http://www.google.co.jp/search?hl=ja&lr=lang_ja&q=����
"""
REM -----------------------------------------------------------------
