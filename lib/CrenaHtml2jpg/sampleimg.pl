$line = 0;
open(FP,"sampleurl.txt");
while(<FP>){
	chop($_);  #CR-LF
	$x = unpack("CC",substr($_,-1,1));
	if($x == 0xd || $x == 0xa){
		chop($_);
	}

	$url = "http://" . $_;

	s/[\~\.-_:\/\%\&]//g;

	$file = $_ . ".jpg";

	$line++;

	print $line . " - [" . $file . "] " . $url . "\n";

	#-----------------------------------------------
	# $cmd = CrenaHtml2jpg.exe -o' . $file . ' -fjpeg -w800x600 -s117x90 -q92 -t25 -u' . $url . '"';
	# �ł��A�A���ACrenaHtml2jpg.exe���I���Ɏ��s���ă��b�N��ԂɂȂ�Ǝ��ɐi�߂Ȃ��B
	# proccmd�Ń^�C���A�E�g�ݒ肵�āACrenaHtml2jpg.exe���Ăяo�����@�ōs���B
	#-----------------------------------------------

	#-----------------------------------------------------------------
	#���v���O��������Acrenahtml2jpg���Ăяo���ꍇ�̃p�����[�^�n���̗�
    # proccmd -w 30 -c "CrenaHtml2jpg.exe -otest.jpg -fjpeg -w800x600 -s800x600 -q92 -t25 -u""http://www.google.co.jp/search?hl=ja&lr=lang_ja&num=10&q=%e3%83%86%e3%82%b9%e3%83%88"""
	# -u�I�v�V������URL��&���V�F�����s�ɉe�����y�ڂ��ꍇ�́A""...""�̂悤��""�ň͂ނ��ƁB
	# ���""...""�ň͂߂΁A���L�薳�����C�ɂ��Ȃ��ėǂ��B
	#-----------------------------------------------------------------
    # ���d�v�I
    #  proccmd���g���Ƃ��́A-u�I�v�V�����͍Ō�Ɏw�肵�ĉ������B�擪�Ɏw�肷��ƃG���[�ɂȂ鎞������܂��B
    #

	$cmd = 'proccmd -w 30 -c "CrenaHtml2jpg.exe -o' 
		. $file 
		. ' -fjpeg -w800x1200 -s120x180 -h0 -q92 -t25 -u""' . $url . '"""';

	print $cmd . "\n\n";

	`$cmd`;

	#-----------------------------------------------
	#CrenaHtml2jpg���G���[���ăv���Z�X���c��ꍇ�́A
	#kill �R�}���h�ŋ����I��������B
	# ���L���R�����g�A�E�g���邱�ƂŎ��s�ł��܂��B
	#-----------------------------------------------

	#	$cmd = 'kill CrenaHtml2jpg';
	#	`$cmd`;
}

exit;

