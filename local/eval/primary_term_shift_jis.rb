# -*- coding: cp932 -*-

# M1�̌��C����́C4������9���܂ł̍�Ə�Ԃ��ۂ�����
require "csv"
require "kconv"

`rm db/development.sqlite3`
`touch db/development.sqlite3`
`rake db:migrate`

require "./config/environment"

FileUtils.rm_rf("repository")
FileUtils.rm_rf("app/assets/images/thumbnail")
Dir::mkdir("repository")
Dir::mkdir("app/assets/images/thumbnail")
Dir::chdir("repository"){
  FileUtils.touch "erase_me"
  `git init`
  repo = Grit::Repo.new "."
  new_blob = Grit::Blob.create(repo, {:name => "erase_me",
                                 :data => File.read("erase_me")})
  repo.add(new_blob.name.force_encoding(Encoding::Windows_31J))
  repo.commit_index "initial commit."
}

# * Ruby�׋���
Work.create(:name => "Ruby�׋���") # id: 1
  Task.create(:name => "�X���C�h�쐬", :work_id => 1)
    Bookmark.create(:name => "�X���C�h�쐬", :start_time => Time.parse("2011/04/15 16:00"), :end_time => Time.parse("2011/04/15 18:00"), :task_id => 1)
    Bookmark.create(:name => "�X���C�h�쐬2", :start_time => Time.parse("2011/04/28 10:00"), :end_time => Time.parse("2011/04/28 12:00"), :task_id => 1)
    Bookmark.create(:name => "�X���C�h�쐬3", :start_time => Time.parse("2011/05/13 10:00"), :end_time => Time.parse("2011/05/13 12:00"), :task_id => 1)
    Bookmark.create(:name => "�X���C�h�쐬�Ɠ���", :start_time => Time.parse("2011/05/13 13:00"), :end_time => Time.parse("2011/05/13 19:00"), :task_id => 1)
  Task.create(:name => "���̏���", :work_id => 1)
    Bookmark.create(:name => "Rails�C���X�g�[���̏���", :start_time => Time.parse("2011/05/12 13:00"), :end_time => Time.parse("2011/05/12 14:00"), :task_id => 2)
    Bookmark.create(:name => "����LAN�̐ݒ�", :start_time => Time.parse("2011/05/12 14:00"), :end_time => Time.parse("2011/05/12 16:00"), :task_id => 2)

# �\�t�g�E�F�A�J���@
Work.create(:name => "��w�@�̍u�`") # id: 2
  Work.create(:name => "�\�t�g�E�F�A�J���@", :parent_id => 2) # id: 3
    Task.create(:name => "���K���", :work_id => 3)
      Bookmark.create(:name => "���K���", :start_time => Time.parse("2011/04/15 12:00"), :end_time => Time.parse("2011/04/15 15:00"), :task_id => 3)
      Bookmark.create(:name => "���K���̃��[�����M", :start_time => Time.parse("2011/04/18 17:00"), :end_time => Time.parse("2011/04/18 17:40"), :task_id => 3)
    Task.create(:name => "�u�`�̋c���^�쐬", :work_id => 3)
      Bookmark.create(:name => "�c���^�쐬", :start_time => Time.parse("2011/04/27 16:00"), :end_time => Time.parse("2011/04/27 19:00"), :task_id => 4)
      Bookmark.create(:name => "�c���^�쐬2", :start_time => Time.parse("2011/05/17 17:50"), :end_time => Time.parse("2011/05/17 20:00"), :task_id => 4)
      Bookmark.create(:name => "�c���^�쐬3", :start_time => Time.parse("2011/06/08 10:00"), :end_time => Time.parse("2011/06/08 13:00"), :task_id => 4)
    Task.create(:name => "�݌v", :work_id => 3)
      Bookmark.create(:name => "�V�X�e���Ɩ����ꗗ�쐬", :start_time => Time.parse("2011/04/27 16:00"), :end_time => Time.parse("2011/04/27 19:00"), :task_id => 5)
      Bookmark.create(:name => "�Ɩ���`���쐬", :start_time => Time.parse("2011/05/09 14:30"), :end_time => Time.parse("2011/05/09 16:00"), :task_id => 5)
      Bookmark.create(:name => "�Ɩ���`���C��", :start_time => Time.parse("2011/05/13 16:00"), :end_time => Time.parse("2011/05/13 17:00"), :task_id => 5)
      Bookmark.create(:name => "�����쐬1", :start_time => Time.parse("2011/05/19 12:00"), :end_time => Time.parse("2011/05/19 20:00"), :task_id => 5)
      Bookmark.create(:name => "�����쐬2", :start_time => Time.parse("2011/05/23 10:00"), :end_time => Time.parse("2011/05/23 11:00"), :task_id => 5)
      Bookmark.create(:name => "�����C��", :start_time => Time.parse("2011/05/23 15:00"), :end_time => Time.parse("2011/05/23 17:00"), :task_id => 5)
      Bookmark.create(:name => "�����쐬3", :start_time => Time.parse("2011/06/10 13:00"), :end_time => Time.parse("2011/06/10 18:00"), :task_id => 5)
      Bookmark.create(:name => "�����C��2", :start_time => Time.parse("2011/06/13 18:00"), :end_time => Time.parse("2011/06/13 20:00"), :task_id => 5)
      Bookmark.create(:name => "�v���O������������`���̏C��", :start_time => Time.parse("2011/06/20 17:50"), :end_time => Time.parse("2011/06/20 19:25"), :task_id => 5)
      Bookmark.create(:name => "�����쐬4", :start_time => Time.parse("2011/06/27 16:00"), :end_time => Time.parse("2011/06/27 18:00"), :task_id => 5)
    Task.create(:name => "����", :work_id => 3)
      Bookmark.create(:name => "����", :start_time => Time.parse("2011/06/30 10:00"), :end_time => Time.parse("2011/06/30 12:00"), :task_id => 6)
      Bookmark.create(:name => "����2", :start_time => Time.parse("2011/06/30 13:00"), :end_time => Time.parse("2011/06/30 19:00"), :task_id => 6)
      Bookmark.create(:name => "����3", :start_time => Time.parse("2011/06/30 20:00"), :end_time => Time.parse("2011/06/30 23:00"), :task_id => 6)
      Bookmark.create(:name => "����4", :start_time => Time.parse("2011/07/01 00:00"), :end_time => Time.parse("2011/07/01 05:00"), :task_id => 6)
    Task.create(:name => "�e�X�g", :work_id => 3)
      Bookmark.create(:name => "�e�X�g", :start_time => Time.parse("2011/07/08 13:00"), :end_time => Time.parse("2011/07/08 16:00"), :task_id => 7)
    Task.create(:name => "�f�o�b�O", :work_id => 3)
      Bookmark.create(:name => "�\�[�X�R�[�h�C��", :start_time => Time.parse("2011/07/12 13:00"), :end_time => Time.parse("2011/07/12 19:00"), :task_id => 8)
      Bookmark.create(:name => "�\�[�X�R�[�h�C��2", :start_time => Time.parse("2011/07/25 11:30"), :end_time => Time.parse("2011/07/25 12:00"), :task_id => 8)
    Task.create(:name => "���̑�", :work_id => 3)
      Bookmark.create(:name => "�\�[�X�R�[�h��o", :start_time => Time.parse("2011/06/30 13:00"), :end_time => Time.parse("2011/06/30 17:00"), :task_id => 9)

  Work.create(:name => "�V�X�e���v���O���~���O���_", :parent_id => 2)
    Task.create(:name => "�Љ�_���̑I��", :work_id => 4)
      Bookmark.create(:name => "�_���I��", :start_time => Time.parse("2011/04/21 12:00"), :end_time => Time.parse("2011/04/21 16:00"), :task_id => 10)
    Task.create(:name => "���\�̏���", :work_id => 4)
      Bookmark.create(:name => "�X���C�h�쐬1", :start_time => Time.parse("2011/06/05 00:00"), :end_time => Time.parse("2011/06/05 05:00"), :task_id => 11)
      Bookmark.create(:name => "�X���C�h�쐬2", :start_time => Time.parse("2011/06/06 08:00"), :end_time => Time.parse("2011/06/06 24:00"), :task_id => 11)
      Bookmark.create(:name => "�X���C�h�쐬3", :start_time => Time.parse("2011/06/07 00:00"), :end_time => Time.parse("2011/06/07 05:00"), :task_id => 11)
    Task.create(:name => "�u�`��̊��z���[��", :work_id => 4)
      Bookmark.create(:name => "���z��o", :start_time => Time.parse("2011/05/26 10:00"), :end_time => Time.parse("2011/05/26 13:00"), :task_id => 12)
      Bookmark.create(:name => "���z��o(6��15)", :start_time => Time.parse("2011/06/15 14:30"), :end_time => Time.parse("2011/06/15 16:00"), :task_id => 12)
      Bookmark.create(:name => "���z��o(6��22)", :start_time => Time.parse("2011/06/22 10:00"), :end_time => Time.parse("2011/06/22 12:00"), :task_id => 12)
      Bookmark.create(:name => "���z��o(7��12)", :start_time => Time.parse("2011/07/12 12:00"), :end_time => Time.parse("2011/07/12 13:00"), :task_id => 12)

  Work.create(:name => "�v���O���~���O���@�_", :parent_id => 2)
    Task.create(:name => "�v���|�[�U���̍쐬", :work_id => 5)  
      Bookmark.create(:name => "�v���|�[�U���̍쐬1", :start_time => Time.parse("2011/04/18 14:00"), :end_time => Time.parse("2011/04/18 18:00"), :task_id => 13)
      Bookmark.create(:name => "�v���|�[�U���̍쐬2", :start_time => Time.parse("2011/04/19 10:00"), :end_time => Time.parse("2011/04/19 13:00"), :task_id => 13)
      Bookmark.create(:name => "�v���|�[�U���̏C��", :start_time => Time.parse("2011/04/25 10:00"), :end_time => Time.parse("2011/04/25 13:00"), :task_id => 13)
    Task.create(:name => "���\����", :work_id => 5)
      Bookmark.create(:name => "�X���C�h�쐬", :start_time => Time.parse("2011/04/28 10:00"), :end_time => Time.parse("2011/04/28 14:00"), :task_id => 14)
      Bookmark.create(:name => "�X���C�h�쐬2", :start_time => Time.parse("2011/05/11 13:00"), :end_time => Time.parse("2011/05/11 18:00"), :task_id => 14)
      Bookmark.create(:name => "�X���C�h�C��", :start_time => Time.parse("2011/05/12 16:00"), :end_time => Time.parse("2011/05/12 20:00"), :task_id => 14)
    Task.create(:name => "����ւ̉�", :work_id => 5)
      Bookmark.create(:name => "����ւ̉񓚍쐬", :start_time => Time.parse("2011/06/14 17:50"), :end_time => Time.parse("2011/06/14 21:30"), :task_id => 15)
      Bookmark.create(:name => "����ւ̉񓚍쐬2", :start_time => Time.parse("2011/06/21 14:00"), :end_time => Time.parse("2011/06/21 19:00"), :task_id => 15)
    Task.create(:name => "�c���^�̍쐬", :work_id => 5)
      Bookmark.create(:name => "�c���^�쐬", :start_time => Time.parse("2011/04/20 14:30"), :end_time => Time.parse("2011/04/20 16:00"), :task_id => 16)
      Bookmark.create(:name => "�c���^�쐬2", :start_time => Time.parse("2011/04/27 14:30"), :end_time => Time.parse("2011/04/27 16:30"), :task_id => 16)

Work.create(:name => "GN�����ō���")
  Work.create(:name => "��78��", :parent_id => 6)
    Task.create(:name => "�����쐬", :work_id => 7)
      Bookmark.create(:name => "�����쐬", :start_time => Time.parse("2011/04/20 10:00"), :end_time => Time.parse("2011/04/20 11:30"), :task_id => 17)
      Bookmark.create(:name => "�����쐬2", :start_time => Time.parse("2011/04/20 14:30"), :end_time => Time.parse("2011/04/20 18:00"), :task_id => 17)
      Bookmark.create(:name => "�����쐬3", :start_time => Time.parse("2011/04/21 10:00"), :end_time => Time.parse("2011/04/21 12:30"), :task_id => 17)
  Work.create(:name => "��79��", :parent_id => 6)
    Task.create(:name => "�����쐬", :work_id => 8)
      Bookmark.create(:name => "�����쐬", :start_time => Time.parse("2011/05/09 10:00"), :end_time => Time.parse("2011/05/09 12:30"), :task_id => 18)
    Task.create(:name => "�c���^", :work_id => 8)
      Bookmark.create(:name => "�c���^�쐬", :start_time => Time.parse("2011/05/10 17:00"), :end_time => Time.parse("2011/05/10 20:00"), :task_id => 19)
      Bookmark.create(:name => "�c���^�쐬2", :start_time => Time.parse("2011/05/11 10:00"), :end_time => Time.parse("2011/05/11 12:00"), :task_id => 19)
      Bookmark.create(:name => "�c���^�C��", :start_time => Time.parse("2011/05/11 18:30"), :end_time => Time.parse("2011/05/11 19:34"), :task_id => 19)
  Work.create(:name => "��81��", :parent_id => 6)
    Task.create(:name => "�c���^", :work_id => 9)
      Bookmark.create(:name => "�c���^�쐬", :start_time => Time.parse("2011/06/09 14:00"), :end_time => Time.parse("2011/06/09 19:00"), :task_id => 20)
  Work.create(:name => "��83��", :parent_id => 6)
    Task.create(:name => "�c���^", :work_id => 10)
      Bookmark.create(:name => "�c���^�쐬", :start_time => Time.parse("2011/07/13 14:30"), :end_time => Time.parse("2011/04/13 17:00"), :task_id => 21)
  Work.create(:name => "��85��", :parent_id => 6)
    Task.create(:name => "�c���^", :work_id => 11)
      Bookmark.create(:name => "�c���^�쐬", :start_time => Time.parse("2011/08/23 10:00"), :end_time => Time.parse("2011/08/23 12:30"), :task_id => 22)
=begin
* GN�J���ō���
  2011/04/21 17:00 - 19:30 LastNote�J��(��37��GN�J���ō���)
  2011/04/22 12:30 - 15:30 LastNote�J��(��38��GN�J���ō���)
  2011/05/16 10:00 - 12:40 LastNote�J��(��39��GN�J���ō���)
=end
Work.create(:name => "�v�Z�@����")
  Task.create(:name => "�c���^�쐬", :work_id => 12)
    Bookmark.create(:name => "�c���^�쐬", :start_time => Time.parse("2011/06/08 12:00"), :end_time => Time.parse("2011/06/08 15:00"), :task_id => 23)

Work.create(:name => "���C��^�c") # id: 13
  Task.create(:name => "�o���m�F", :work_id => 13)
    Bookmark.create(:name => "���C��̏o���m�F", :start_time => Time.parse("2011/05/29 08:30"), :end_time => Time.parse("2011/05/29 09:30"), :task_id => 24)
  Task.create(:name => "�H���A�����M�[�̒���", :work_id => 13)
    Bookmark.create(:name => "���C��O�̐H���A�����M�[�̒���", :start_time => Time.parse("2011/06/13 17:00"), :end_time => Time.parse("2011/06/13 18:00"), :task_id => 25)
  Task.create(:name => "�k�b��ɂ��Ă̘A��", :work_id => 13)
    Bookmark.create(:name => "�k�b��̈�i�ɂ��Ẵ��[�����M", :start_time => Time.parse("2011/07/18 15:00"), :end_time => Time.parse("2011/07/18 15:40"), :task_id => 26)
  Task.create(:name => "���ȉ�", :work_id => 13)
    Bookmark.create(:name => "���ȉ�̋c���^�쐬", :start_time => Time.parse("2011/08/31 12:30"), :end_time => Time.parse("2011/08/31 13:00"), :task_id => 27)
  Work.create(:name => "���Ɠ����̌���", :parent_id => 13)
    Work.create(:name => "���̌���", :parent_id => 14)
      Task.create(:name => "���̌��I��", :work_id => 15)
        Bookmark.create(:name => "���C����̌��I��", :start_time => Time.parse("2011/04/25 15:00"), :end_time => Time.parse("2011/04/25 17:00"), :task_id => 28)
  Work.create(:name => "����", :parent_id => 13)
    Task.create(:name => "�ʐ^�Ƙ^���f�[�^�̋��L", :work_id => 16)    
      Bookmark.create(:name => "�����̎ʐ^�Ƙ^���f�[�^�̒u����ɂ��ĘA��", :start_time => Time.parse("2011/05/14 10:00"), :end_time => Time.parse("2011/05/14 11:00"), :task_id => 29)

  Work.create(:name => "���C�̏���", :parent_id => 13)
    Work.create(:name => "�������\", :parent_id => 17)
      Task.create(:name => "���\��]�҂̒���", :work_id => 18)
        Bookmark.create(:name => "���\��]�҂̊m�F���[���̑��M", :start_time => Time.parse("2011/05/29 08:30"), :end_time => Time.parse("2011/05/29 09:30"), :task_id => 30)
    Work.create(:name => "�f�B�x�[�g", :parent_id => 17)
      Task.create(:name => "�f�B�x�[�g�e�[�}�Ă̕�W", :work_id => 19)
        Bookmark.create(:name => "�f�B�x�[�g�̏���(�e�[�}�Ă̕�W)", :start_time => Time.parse("2011/07/04 10:00"), :end_time => Time.parse("2011/07/04 10:40"), :task_id => 31)
      Task.create(:name => "�e�[�}�Ă̍���", :work_id => 19)
        Bookmark.create(:name => "�e�[�}�Ă̍���", :start_time => Time.parse("2011/07/17 10:00"), :end_time => Time.parse("2011/07/17 12:00"), :task_id => 32)
      Task.create(:name => "���[�̍��m", :work_id => 19)
        Bookmark.create(:name => "�e�[�}�Ă̓��[�ʒm", :start_time => Time.parse("2011/07/18 11:00"), :end_time => Time.parse("2011/07/18 11:20"), :task_id => 33)
      Task.create(:name => "���[���ʂ̕�", :work_id => 19)
        Bookmark.create(:name => "���[���ʂ̒ʒm���[���̑��M", :start_time => Time.parse("2011/07/30 16:00"), :end_time => Time.parse("2011/07/30 17:00"), :task_id => 34)
  Work.create(:name => "���N���G�[�V�����̏���", :parent_id => 13)
    Work.create(:name => "���V���̏���", :parent_id => 20)
      Task.create(:name => "���[���쐬", :work_id => 21)
        Bookmark.create(:name => "���N���G�[�V�����̃��[���쐬", :start_time => Time.parse("2011/08/01 10:00"), :end_time => Time.parse("2011/08/01 11:00"), :task_id => 35)
      Task.create(:name => "�p��̊m��", :work_id => 21)
        Bookmark.create(:name => "�p��̊m��", :start_time => Time.parse("2011/05/22 10:00"), :end_time => Time.parse("2011/05/22 12:00"), :task_id => 36)
    Work.create(:name => "�J�V���̏���", :parent_id => 20)
      Task.create(:name => "�N�C�Y���̍쐬�˗�", :work_id => 22)
        Bookmark.create(:name => "�N�C�Y�̍쐬�˗�", :start_time => Time.parse("2011/07/07 17:00"), :end_time => Time.parse("2011/07/07 17:30"), :task_id => 37)
      Task.create(:name => "�N�C�Y���̓���", :work_id => 22)
        Bookmark.create(:name => "�N�C�Y���̓���", :start_time => Time.parse("2011/08/25 10:00"), :end_time => Time.parse("2011/08/25 14:00"), :task_id => 38)
  Task.create(:name => "������̍쐬", :work_id => 13)
    Bookmark.create(:name => "������̑��č쐬", :start_time => Time.parse("2011/06/29 10:00"), :end_time => Time.parse("2011/06/29 14:00"), :task_id => 39)
    Bookmark.create(:name => "������̑��č쐬2", :start_time => Time.parse("2011/06/29 14:30"), :end_time => Time.parse("2011/06/29 16:00"), :task_id => 39)
    Bookmark.create(:name => "�����葐�ďC��", :start_time => Time.parse("2011/07/03 14:00"), :end_time => Time.parse("2011/07/03 14:30"), :task_id => 39)
    Bookmark.create(:name => "�����葐�ďC��2", :start_time => Time.parse("2011/07/06 17:30"), :end_time => Time.parse("2011/07/06 18:00"), :task_id => 39)
    Bookmark.create(:name => "������̏C��(�f�B�x�[�g�ɂ���)", :start_time => Time.parse("2011/07/30 17:00"), :end_time => Time.parse("2011/07/30 17:20"), :task_id => 39)
    Bookmark.create(:name => "������̏C��(��������C�K�v�@��)", :start_time => Time.parse("2011/08/07 12:00"), :end_time => Time.parse("2011/08/07 14:00"), :task_id => 39)
    Bookmark.create(:name => "������̏C��(����)", :start_time => Time.parse("2011/08/21 09:00"), :end_time => Time.parse("2011/08/21 10:00"), :task_id => 39)
    Bookmark.create(:name => "������̔z�z�ɂ��ĘA��", :start_time => Time.parse("2011/08/22 17:00"), :end_time => Time.parse("2011/08/22 17:30"), :task_id => 39)
    Bookmark.create(:name => "������̏C��(�`�[������)", :start_time => Time.parse("2011/08/23 10:00"), :end_time => Time.parse("2011/08/23 11:00"), :task_id => 39)
    Bookmark.create(:name => "������̏C��(�����C���C���e)", :start_time => Time.parse("2011/08/24 14:30"), :end_time => Time.parse("2011/08/24 15:30"), :task_id => 39)
  Work.create(:name => "��v�֌W", :parent_id => 13)
    Task.create(:name => "���Ϗ��̍쐬", :work_id => 23)
      Bookmark.create(:name => "���C��̌��ς���̍쐬", :start_time => Time.parse("2011/07/23 09:00"), :end_time => Time.parse("2011/07/23 10:30"), :task_id => 40)
    Task.create(:name => "�̎����̓����", :work_id => 23)
      Bookmark.create(:name => "���C��̗̎����̓���쐬", :start_time => Time.parse("2011/08/31 11:00"), :end_time => Time.parse("2011/08/31 12:00"), :task_id => 41)
    Task.create(:name => "��v�����ɖ��ׂ��", :work_id => 23)
      Bookmark.create(:name => "���C��̖��ׂ�������ɕ�", :start_time => Time.parse("2011/08/31 12:00"), :end_time => Time.parse("2011/08/31 12:30"), :task_id => 42)
    Work.create(:name => "�⏕��", :parent_id => 23)
      Task.create(:name => "���C��̎Q���Җ���̍쐬", :work_id => 24)
        Bookmark.create(:name => "���C��Q���Җ���̍쐬", :start_time => Time.parse("2011/09/14 10:00"), :end_time => Time.parse("2011/09/14 12:00"), :task_id => 43)
      Task.create(:name => "�⏕���̎󂯎��", :work_id => 24)
        Bookmark.create(:name => "���C��̕⏕���̎󂯎��", :start_time => Time.parse("2011/11/14 14:30"), :end_time => Time.parse("2011/11/14 15:00"), :task_id => 44)
      Task.create(:name => "�⏕���̕Ԋ�", :work_id => 24)
        Bookmark.create(:name => "���C��̕⏕���̕ԋ��A��", :start_time => Time.parse("2011/11/19 14:00"), :end_time => Time.parse("2011/11/19 15:00"), :task_id => 45)


####################################
# �������̓o�^
History

dir = WindowsLibs.make_path(["c:","Users","Fukuda", "Dropbox", "DTB�̕]��", "files"])
Dir::chdir("c:/Users/Fukuda/Dropbox/DTB�̕]��/files"){
  bm = Bookmark.find_by_name "���C��̏o���m�F"
  h = FileHistory.create(:path => dir+"\\2012�N�x���C��̏o���Ɣ��\��]�҂̊m�F.txt",
                        :title => "2012�N�x���C��̏o���Ɣ��\��]�҂̊m�F.txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
 
  bm = Bookmark.find_by_name "���C��O�̐H���A�����M�[�̒���"
  h = FileHistory.create(:path => dir+"\\�H���A�����M�[�̒���.txt", 
                         :title => "�H���A�����M�[�̒���.txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)

  bm = Bookmark.find_by_name "�k�b��̈�i�ɂ��Ẵ��[�����M"
  h = FileHistory.create(:path => dir+"\\���C��̈�i�ɂ���.txt",
                        :title => "���C��̈�i�ɂ���.txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  

  bm = Bookmark.find_by_name "���ȉ�̋c���^�쐬"
  h = FileHistory.create(:path => dir+"\\2012�N�x���C��̔��ȕ�.txt",
                         :title => "2012�N�x���C��̔��ȕ�.txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  
  
  bm = Bookmark.find_by_name "���C����̌��I��"
  #  h = FileHistory.create(:path => dir+"",
  #                        :title => "")
  #  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  
  
  bm = Bookmark.find_by_name "�����̎ʐ^�Ƙ^���f�[�^�̒u����ɂ��ĘA��"
  h = FileHistory.create(:path => dir+"",
                         :title => "")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  
  
  bm = Bookmark.find_by_name "���\��]�҂̊m�F���[���̑��M"
  h = FileHistory.create(:path => dir+"\\2012�N�x���C��̏o���Ɣ��\��]�҂̊m�F.txt",
                        :title => "2012�N�x���C��̏o���Ɣ��\��]�҂̊m�F.txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  
 
 bm = Bookmark.find_by_name "�f�B�x�[�g�̏���(�e�[�}�Ă̕�W)"
  h = FileHistory.create(:path => dir+"\\�f�B�x�[�g\\�f�B�x�[�g�̃e�[�}�ĕ�W.txt",
                        :title => "�f�B�x�[�g�̃e�[�}�ĕ�W.txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  
  bm = Bookmark.find_by_name "�e�[�}�Ă̓��[�ʒm"
  h = FileHistory.create(:path => dir+"\\�f�B�x�[�g\\���C��ɂ�����f�B�x�[�g�e�[�}�̓��[.txt",
                         :title => "���C��ɂ�����f�B�x�[�g�e�[�}�̓��[.txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  

  bm = Bookmark.find_by_name "���[���ʂ̒ʒm���[���̑��M"
  h = FileHistory.create(:path => dir+"\\�f�B�x�[�g\\���C��ɂ�����f�B�x�[�g�e�[�}�Ă̓��[���ʂɂ���.txt",
                        :title => "���C��ɂ�����f�B�x�[�g�e�[�}�Ă̓��[���ʂɂ���.txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  
  
  bm = Bookmark.find_by_name "���N���G�[�V�����̃��[���쐬"
  h = FileHistory.create(:path => dir+"\\���N���G�[�V����\\���N���G�[�V�����̃��[����.txt",
                         :title => "���N���G�[�V�����̃��[����.txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  
  bm = Bookmark.find_by_name "�p��̊m��"
  h = FileHistory.create(:path => dir+"\\���N���G�[�V����\\���C��Ɋւ���ؗp���ɂ���.txt",
                         :title => "���C��Ɋւ���ؗp���ɂ���.txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  
  bm = Bookmark.find_by_name "�N�C�Y�̍쐬�˗�"
  h = FileHistory.create(:path => dir+"\\���N���G�[�V����\\���C��ŗ��p����N�C�Y�̍쐬�̂��肢.txt",
                         :title => "���C��ŗ��p����N�C�Y�̍쐬�̂��肢.txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  
  
  bm = Bookmark.find_by_name "�N�C�Y���̓���"
  h = FileHistory.create(:path => dir+"\\���N���G�[�V����\\���C��̃N�C�Y.txt",
                         :title => "���C��̃N�C�Y.txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  h = FileHistory.create(:path => dir+"\\���N���G�[�V����\\���C��̃N�C�Y���.pdf",
                         :title => "���C��̃N�C�Y���.pdf")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  
  
  bm = Bookmark.find_by_name "������̑��č쐬"
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̍쐬1\\���C��̂�����ɂ���.txt",
                         :title => "���C��̂�����ɂ���.txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̍쐬1\\2012�N�x���C��̂�����.doc",
                         :title => "2012�N�x���C��̂�����.doc")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̍쐬1\\2012�N�x���C��̂�����.pdf",
                         :title => "2012�N�x���C��̂�����.pdf")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  
  
  bm = Bookmark.find_by_name "������̑��č쐬2"
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̍쐬2\\���C��̂�����(��2)�ɂ���.txt",
                         :title => "���C��̂�����(��2)�ɂ���.txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̍쐬2\\2012�N�x���C��̂�����(��2).doc",
                         :title => "2012�N�x���C��̂�����(��2).doc")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̍쐬2\\2012�N�x���C��̂�����(��2).pdf",
                         :title => "2012�N�x���C��̂�����(��2).pdf")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  
  
  bm = Bookmark.find_by_name "�����葐�ďC��"
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̍쐬3\\���C��̂�����(��3)�ɂ���.txt",
                         :title => "���C��̂�����(��3)�ɂ���.txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̍쐬3\\2012�N�x���C��̂�����(��3).doc",
                         :title => "2012�N�x���C��̂�����(��3).doc")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̍쐬3\\2012�N�x���C��̂�����(��3).pdf",
                         :title => "2012�N�x���C��̂�����(��3).pdf")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  

  bm = Bookmark.find_by_name "�����葐�ďC��2"
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̍쐬4\\",
                         :title => "")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  
  
  bm = Bookmark.find_by_name "������̏C��(�f�B�x�[�g�ɂ���)"
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̍쐬4\\���C��̂�����(��4)�ɂ���.txt",
                       :title => "���C��̂�����(��4)�ɂ���.txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̍쐬4\\2012�N�x���C��̂�����(��4).doc",
                       :title => "2012�N�x���C��̂�����(��4).doc")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̍쐬4\\2012�N�x���C��̂�����(��4).pdf",
                       :title => "2012�N�x���C��̂�����(��4).pdf")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  

  bm = Bookmark.find_by_name "������̏C��(��������C�K�v�@��)"
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̍쐬5\\2012�N�x���C��̂�����(8��7��).txt",
                        :title => "2012�N�x���C��̂�����(8��7��).txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̍쐬5\\2012�N�x���C��̂�����-20120807.doc",
                        :title => "2012�N�x���C��̂�����-20120807.doc")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  

  bm = Bookmark.find_by_name "������̏C��(����)"
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̍쐬6\\2012�N�x���C��̂�����(8��21��).txt",
                        :title => "2012�N�x���C��̂�����(8��21��).txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̍쐬6\\2012�N�x���C��̂�����-20120821.doc",
                        :title => "2012�N�x���C��̂�����-20120821.doc")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  

  bm = Bookmark.find_by_name "������̔z�z�ɂ��ĘA��"
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̔z�z�ɂ���.txt",
                        :title => "������̔z�z�ɂ���.txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  

  bm = Bookmark.find_by_name "������̏C��(�`�[������)"
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̍쐬7\\2012�N�x���C��̂�����(8��23��).txt",
                        :title => "2012�N�x���C��̂�����(8��23��).txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̍쐬7\\2012�N�x���C��̂�����-20120823.doc",
                        :title => "2012�N�x���C��̂�����-20120823.doc")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  

  bm = Bookmark.find_by_name "������̏C��(�����C���C���e)"
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̍쐬8\\2012�N�x���C��̂�����(8��24��).txt",
                        :title => "2012�N�x���C��̂�����(8��24��).txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  h = FileHistory.create(:path => dir+"\\������̍쐬\\������̍쐬8\\2012�N�x���C��̂�����-20120824.doc",
                        :title => "2012�N�x���C��̂�����-20120824.doc")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  

  bm = Bookmark.find_by_name "���C��̌��ς���̍쐬"
  h = FileHistory.create(:path => dir+"\\��v�֘A\\���Ϗ��̍쐬\\2012�N�x���C��̌��Ϗ�.txt",
                         :title => "2012�N�x���C��̌��Ϗ�.txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  h = FileHistory.create(:path => dir+"\\��v�֘A\\���Ϗ��̍쐬\\2012�N�x���C��-����(��).pdf",
                         :title => "2012�N�x���C��-����(��).pdf")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  

  bm = Bookmark.find_by_name "���C��̗̎����̓���쐬"
  h = FileHistory.create(:path => dir+"\\��v�֘A\\�̎����̓����\\2012�N�x���C��̗̎����Ɋւ���.txt",
                        :title => "")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  

  bm = Bookmark.find_by_name "���C��̖��ׂ�������ɕ�"
  h = FileHistory.create(:path => dir+"\\��v�֘A\\����\\2012�N�x���C��̖���.txt",
                        :title => "2012�N�x���C��̖���.txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  

  bm = Bookmark.find_by_name "���C��Q���Җ���̍쐬"
  h = FileHistory.create(:path => dir+"\\��v�֘A\\���C���̕Ԋ�\\2012�N�x���C��Q���Җ���.xls",
                        :title => "2012�N�x���C��Q���Җ���.xls")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  

  bm = Bookmark.find_by_name "���C��̕⏕���̎󂯎��"
  h = FileHistory.create(:path => dir+"\\��v�֘A\\���C���̕Ԋ�\\���C��̕⏕���̎󂯎��.txt",
                        :title => "���C��̕⏕���̎󂯎��.txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
  

  bm = Bookmark.find_by_name "���C��̕⏕���̕ԋ��A��"
  h = FileHistory.create(:path => dir+"\\��v�֘A\\���C���̕Ԋ�\\���C���̕ԋ��̂��A��.txt",
                         :title => "���C���̕ԋ��̂��A��.txt")
  Timeline.create(:bookmark_id => bm.id, :history_id => h.id)
}


Task.find(32).destroy
