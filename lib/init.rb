require 'Win32API'
require 'net/http'
require 'win32ole'
require 'nkf'

wsh = WIN32OLE.new('WScript.Shell')
wsh.Popup(NKF.nkf("-s", "�f�X�N�g�b�v�u�b�N�}�[�N���N�����܂�\nWeb�y�[�W���J�����܂ł��҂���������"))


a = Net::HTTP.new('localhost', 3000)
b = nil
while b == nil
  b = a.get("/") rescue b = nil
  sleep 3
end

shellexecute = Win32API.new('shell32.dll','ShellExecuteA',%w(p p p p p i),'i')
shellexecute.call(0, 'open', 'http://localhost:3000/desktop_bookmark', 0, 0, 1)