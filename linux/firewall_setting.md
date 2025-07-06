## 방화벽 설정하기 

### 애초에 방화벽이란?
내 서버로 오는 모든 네트워크 요청을 검사해서, 허용된 포트만 열고 나머지는 차단하는것 

리눅스에는 대표적으로 쉽고 간단한 `ufw`라는 방화벽 툴이 있기때문에 이걸 이용한다. 

***

### 방화벽 세팅 순서
1. ufw 설치 
    `sudo apt install ufw`

2. 현재 상태 확인 
    `sudo ufw status` 
    inactive인지 active인지 확인 

3. 기본정책 설정 
    일단 기본적으로 들어오는 요청은 전부 거부하고 나가는 요청은 전부 허용하는 방침 
    `sudo ufw default deny incoming`
    `sudo ufw default allow outgoing`

4. 허용할 포트를 허용 
    우리는 일단 22(ssh), 80(http), 443(https) 3개만 허용할거임 
    `sudo ufw allow OpenSSH`
    `sudo ufw allow 80`
    `sudo ufw allow 443`

5. 설정 끝났으면 방화벽 활성화 
    `sudo ufw enable`

***

### Fail2ban 설정하기 
우리가 위에서 ssh를 허용했는데 만약 공격자가 브루트포스로 비밀번호를 무차별적으로 대입해서 뚫으려고 하면 뚫릴수도 있다. 그래서 특정 ip가 비밀번호를 연속적으로 틀리면 ip를 일정시간동안 차단하기 위해 Fail2ban을 사용한다. 
Fail2ban은 데몬프로그램으로 로그인 로그를 정기적으로 확인함

### 설정순서
1. 설치
    `sudo apt install fail2ban`

2. 기존 설정파일 복사
    `sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local`
    기본 템플릿을 복사해서 우리 입맛대로 커스텀하는게 일반적임 

3. 설정파일 수정 
    `sudo vi /etc/fail2ban/jail.local`로 연 다음에 
    \[sshd\]
    enabled = true
    port = ssh
    maxretry = 5
    bantime = 600
    findtime = 600

    즉, ssh포트에 대해 600초 내에 5번이상 틀리면 600초동안 밴하겠다고 설정 
    
4. 실행
    `sudo systemctl enable fail2ban` : 부팅시 자동 실행되게 설정
    `sudo systemctl start fail2ban` : 지금 당장 실행
    다음부턴 알아서 실행되니까 굳이 설정 안해도 됨 

5. 동작확인 
    `sudo fail2ban-client status` 
    `sudo fail2ban-client status sshd`
