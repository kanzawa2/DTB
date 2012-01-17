using System;
using System.Diagnostics;


public class TaskKill
{

�@�@static int Main(string[] args)
�@�@{

        string manual=""+
"TASKKILL { [/F] [/PID �v���Z�XID | /IM �C���[�W��] }\r\n\r\n"+
"����:\r\n"+
"    ���̃R�}���h ���C�� �c�[���́A�v���Z�X���I�����邽�߂Ɏg���܂��B\r\n"+
"    �v���Z�X ID �܂��̓C���[�W�����g���ďI���ł��܂��B\r\n"+
"    Windows XP Home Edition �����̊ȈՔ�TASKKILL�ł��B\r\n\r\n"+
"�p�����[�^�ꗗ:\r\n"+
"    /F                        �v���Z�X�̋����I�����w�肵�܂��B\r\n\r\n\r\n"+
"    /PID   �v���Z�XID         �I��������v���Z�X�� PID ���w�肵�܂��B\r\n\r\n\r\n"+
"    /IM    �C���[�W��         �I��������v���Z�X�̃C���[�W�����w�肵�܂��B\r\n\r\n\r\n"+
"    /?                        ���̃w���v�܂��͎g�p�@��\�����܂��B\r\n\r\n"+
"��:\r\n"+
"    TASKKILL /IM notepad.exe\r\n"+
"    TASKKILL /PID 1230 /PID 1241 /PID 1253\r\n"+
"    TASKKILL /F /IM notepad.exe /IM mspaint.exe\r\n";



  �@  �@int fFlag   = 0;
        int imFlag  = 0;
        int pidFlag = 0;


�@    �@//�\����� + �}�j���A���\�� + �����I���t���OON

        for(int i=0;i<args.Length;i++)
        {
            if(args[i]=="/?")
            {
                 Console.WriteLine(manual);
                 return 0;
            }
            // /F�i�����I���j�I�v�V���������邩�ǂ���
            if(args[i]=="/F" || args[i]=="/f")
            {
                fFlag=1;
            }
            else if(args[i]=="/IM" || args[i]=="/im")
            {
                if(i == args.Length-1){
                    Console.Write("�G���[: �����ȍ\���ł��B'"+ args[i] +"' �ɒl���w�肵�Ă��������B\r\n"
                                 +"\"TASKKILL /?\" �Ɠ��͂���Ǝg�p�@���\������܂��B\r\n");
                    return 1;
                }
                imFlag=1;
                i++;
            }
            else if(args[i]=="/PID" || args[i]=="/pid")
            {
                if(i == args.Length-1){
                    Console.Write("�G���[: �����ȍ\���ł��B'"+ args[i] +"' �ɒl���w�肵�Ă��������B\r\n"
                                 +"\"TASKKILL /?\" �Ɠ��͂���Ǝg�p�@���\������܂��B\r\n");
                    return 1;
                }
                try
                {
                    int.Parse(args[i+1]);
                }
                catch
                {
                    Console.Write("�G���[: �����ȍ\���ł��B /PID �I�v�V�����ɂ͐��l���w�肵�Ă��������B\r\n\r\n"
                                 +"\"TASKKILL /?\" �Ɠ��͂���Ǝg�p�@���\������܂��B\r\n");
                    return 1;
                }
                pidFlag=1;
                i++;
            }
            else
            {
                Console.WriteLine("�G���[: �����Ȉ���/�I�v�V�����ł� - '" + args[i] +"'�B");
                return 1;
            }
        }


        if(imFlag==1 && pidFlag==1)
        {
            Console.Write("�G���[: �����ȍ\���ł��B /PID �� /IM �𓯎��Ɏw��ł��܂���B"
                         +"\r\n\r\n\"TASKKILL /?\" �Ɠ��͂���Ǝg�p�@���\������܂��B\r\n");
            return 1;
        }

�@    �@//�v���Z�X�I�������̃��[�v
        //�\����͍ς݂�O��

        for(int i=0;i<args.Length;i++)
        {
            if(args[i]=="/F" || args[i]=="/f")
            {
                // �Ȃɂ����Ȃ�
            }
            else if(args[i]=="/IM" || args[i]=="/im")
            {
                string strBefore = args[i+1];
                string strAfter;
                strAfter = strBefore.Replace(".exe", "");

                Process[] myProcesses = Process.GetProcessesByName(strAfter);
                foreach (Process myProcess in myProcesses)
                {
                    if (fFlag==0)
                    {
                        if(myProcess.CloseMainWindow()){
                           Console.Write("����: �v���Z�X \"" + myProcess.ProcessName 
                                       + ".exe\" (PID "+ myProcess.Id.ToString() +") �͋����I������܂����B\r\n");
                        }
                    }
                    else
                    {
                        myProcess.Kill();
                        Console.Write("����: �v���Z�X \"" + myProcess.ProcessName 
                                    + ".exe\" (PID "+ myProcess.Id.ToString() +") �͋����I������܂����B\r\n");
                    }
                 }
                 i++;
            }
            else if(args[i]=="/PID" || args[i]=="/pid")
            {
                try
                {
                    Process myProcess = Process.GetProcessById(int.Parse(args[i+1]));
                    if (fFlag==0)
                    {
                        if(myProcess.CloseMainWindow()){
                           Console.Write("����: �v���Z�X \"" + myProcess.ProcessName 
                                       + ".exe\" (PID "+ myProcess.Id.ToString() +") �͋����I������܂����B\r\n");
                        }
                    }
                    else
                    {
                        myProcess.Kill();
                        Console.Write("����: �v���Z�X \"" + myProcess.ProcessName 
                                    + ".exe\" (PID "+ myProcess.Id.ToString() +") �͋����I������܂����B\r\n");
                    }
                }
                catch
                {
                    Console.WriteLine("�G���[: �v���Z�X \"" + args[i+1] + "\" ��������܂���ł����B");
                }
                i++;
            }
        }
        return 0;
    }
}
