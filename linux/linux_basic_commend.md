## 리눅스 기초 정리 
이곳은 기본적인 명령어들 및 리눅스 기초 개념들을 정리한 곳입니다

### 기본적인 명령어들
기본적인 파일&디렉토리 관리 명령어는 `cd`, `pwd`, `ls`, `mkdir`, `rmdir`, `rm`, `touch`, `mv`(파일 이동/이름변경), `cp`(파일 복사하기)가 있다. 

쉘이 $면 일반사용자, #이면 루트라는 뜻임

일반사용자일떄 관리자 권한으로 실행하겠다는 `sudo`(superuser do )임. 대신, 이 명령어를 쓰려면 sudo그룹에 들어가있어야 함. 

사용자를 바꾸는건 `su`(switch user)임. 내가 일반인데 관리자로 바꾸려면 `sudo su -root`라고 치기

`ls -l` 은 long의 약자로 더 자세하게 출력해줌 맨 앞이 d면 디렉토리, 일반파일이면 -임

파일 찾을때 `find ./ -name *.py` 이런식으로 현재 디렉토리에서 이름이 .py로 끝나는 파일을 찾기 가능 

`cat` 파일이름 으로 내용 볼 수 있음 

`grep 찾을단어 파일이름` : 파일에서 찾을 단어를 찾아줌

`file 파일이름` : 얘가 뭔 파일인지 알려줌 

`history` : 지금까지 뭔 명령어 썼는지 다 나옴. 100번째 명령어 다시 쓰고 싶으면 !100
화면이 작아서 위쪽 못볼때 shift+pageup하셈 아니면 `history | less` 하면 방향키로 가능 

`wget`: 인터넷에서 파일을 다운받을 수 있다. 

`알트 {f1|f2|...}` 누르면 창을 바꿀 수 있음  

아마존 내 서버 접속하는법
`ssh -i "개인키 저장경로" 유저이름@서버ip`


***
### 파일편집기
파일편집기는 모든 유닉스에 다 있는데 근본은 VI, 트렌드한건 GNU nano,vim 이렇게 3가지 정도 있다.
vi쓰는법은 `vi 파일이름`으로 파일을 편집기로 열 수 있다. 
i를 누르면 insert모드로, 내용을 수정할 수 있다. 
수정이 끝났으면 esc를 눌러서 insert모드를 빠져나오고, :wq하면 저장하고 빠져나온다. 이정도만 알아도 굿  


***
### 리다이렉션
입출력 방향을 바꾸는것임. 
만약 히스토리 출력내용을 화면이 아니라 파일에 넣고싶다면 `history > test` 이렇게 하면 됨 
다만 원래 파일에 있던 내용은 다 지워짐.  그래서  `history >> test` 이렇게 써야 뒤쪽에 추가됨 
>,>>는 1>,1>>와 같은 뜻이다. 1은 표준출력을 뜻한다. 2>, 2>>는 표준에러를 뜻한다. 

쉽게 생각해서, 어느 한 프로세스에는 표준입력(stdin)과 표준출력(stdout), 표준에러(stderr)가 있다. 
명령의 결과가 터미널에 제대로 출력되면 그게 표준출력이고, 만약 에러가 난다면 에러 내용이 표준에러로 출력된다. 
`command 1> output.txt 2> error.txt` 이런식으로, command결과가 정상적으로 출력되면 output에, 만약 에러가 난다면 error에 저장되도록 할 수 있다. 


***
### 파일 압축하기 
보통 두단계인데 1. 파일을 묶음(오히려 용량 늘어남)-> 2. 압축함 
압축 안하고 묶기만 하면 엄청 커지니까 거의 압축하긴 함 
`tar -zcf name.tar.gz file1 file2 file3...` : name.tar.gz라는 이름으로 압축파일을 만듦
`tar -zxvf name.tar.gz` : 압축 파일을 풀기 

***
### 쉘과 커널 
커널이란 하드웨어를 제어할 수 있는 운영체제의 핵심구성요소이다. 
사용자(쉘) -- 커널 -- 하드웨어 
이런 느낌으로 중간자 역할을 한다. 

#### 커널이 존재하는 이유 
커널이 없으면 하드웨어를 직접 제어할 수 있게되니 보안문제가 커지고 매우 위험하다. 

#### 쉘
쉘은 내 명령을 커널에게 전달하는 프로그램이다. 대표적으로 bash, zsh가 있다. 
무슨 쉘을 쓰던간에 목적은 커널에게 명령을 하는거니 취향에 맞는 쉘을 쓰면된다. 
지금 무슨 쉘을 쓰고 있는지 확인하려면 `echo $0` 로 확인하자. 
쉘을 바꾸고 싶으면 `cat /etc/shells` 로 무슨 쉘을 사용 가능한지 확인하고, `chsh -s /bin/zsh` 로 바꾸자. 


***
### 유저관리 
`adduser 사용자명` : 유저 추가
`passwd 사용자명` : 비밀번호 추가하기
`userdel 사용자명` : 유저 삭제 
`id 사용자명` : 사용자의 정보를 볼 수 있다. 어디 그룹에 속해있고 등등...

`groupadd 그룹명` : 새로운 그룹을 작성 
`usermod -aG 그룹명 사용자명` : 그룹에 사용자를 추가 

`passwd -l 사용자명` : 사용자의 계정을 잠금
`passwd -u 사용자명` : 사용자의 계정잠금 해제

유저정보, 그룹정보를 보고싶다면 `/etc/passwd`와 `/etc/group`를 확인하자 

***
### 백그라운드 실행
프로그램을 실행하다가 ctrl z 를 누르면 백그라운드로 가서 stop상태가 된다. 백그라운드 상태에서 계속 실행시키려면 `bg`
다시 frontground로 돌릴려면 `fg`
현재 대기중인 백그라운드 상황을 보려면 `jobs`

***
### 데몬 
기본적으로 백그라운드에서 계속 돌아가고 있는 프로그램을 데몬이라고 함. 마치 냉장고처럼 하루종일 혼자 돌아가는것이 데몬임
`/etc/init.d` 에 보면 데몬프로그램들이 있음 
`service 프로그램이름 start` : 데몬프로그램 실행 
`service 프로그램이름 stop` : 중지


***
### cron
크론이란 정기적으로 명령어를 실행시켜주는 도구이다. 
`crontab -e` 로 크론 관리창으로 넘어갈 수 있다. 여기에 명령을 추가하면 끝이다. 
`*/1 * * * * date>>date.log` 이렇게 추가하면 매분마다 명령을 실행한다. 
언제마다 어느 명령어를 실행할지만 추가해주면 된다. 

***
### 비밀번호 대신 비대칭키를 쓰자. 
ssh로 접속할때 비밀번호를 입력받아서 접속가능하게 하면 보안상 위험 + 귀찮기까지 하다. 
따라서, ssh공개키와 비밀키를 생성하고 서버는 공개키를, 개개인에게는 비밀키를 지급해서 편하고 안전하게 접속가능하게 하자. 
서버의 공개키는  `~/.ssh/authorized_keys`에 저장하면 된다. 그러면 접속할때 개인키를 확인해서 맞으면 접속 가능하게 됨 

***
### PATH환경변수 설정 
우리가 ls명령을 쓰면 컴퓨터는 어떻게 ls가 뭔지 이해하고 실행하는걸까? 
이유는 ls를 PATH환경변수에 등록해놨기 때문이다.
`echo $PATH`를 실행하면 `/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin`라고 뜬다. 
이 말은, ls라는 명령어를 앞에서부터 차례대로 읽으면서 ls가 있다면 그걸 실행하는것이다. 

#### ~/.bash.rc에 대해 
.bash.rc파일은 처음 bash가 실행됬을떄 자동으로 실행해주는 명령어를 써놓는 곳이다. 
예를들어, 내가 git bash를 켰는데 초기 위치가 홈디렉토리다. 하지만 내가 작업중인 디렉토리로 바로 열리게 하고싶을땐 .bash.rc에 `cd 작업중인디렉토리`를 추가하기만 하면 된다 
