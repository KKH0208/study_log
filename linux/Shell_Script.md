## 셸 스크립트 연습문제들과 정답을 해설해놓은 곳입니다. 
## 문제 출저는 chatgpt입니다 
 
# 1. 2*1부터 9*9의 결과를 출력하세요 

```bash
#!/bin/bash

for i in {2..9}; do
    for j in {2..9}; do
        echo "$i * $j = $((i*j))"
    done
done 
```

# 2. 사용자로부터 숫자 3개를 입력받아 합계를 출력하는 스크립트를 작성하시오.

```bash
#!/bin/bash

echo "input three number"
read a b c
sum=$((a+b+c))
echo "sum is $sum"

```

# 3. 현재 디렉토리 안 .txt 파일의 개수를 세고, 각 파일 이름과 총 개수를 출력하시오.
```bash
#!/bin/bash
file_num=$(ls -1 | grep "\.txt$"| wc -l | xargs) # xargs로 앞뒤 공백 안없애면 출력포멧이 이상함
echo "file number is $file_num"
echo "file name is below"
ls -1 | grep "\.txt$"
```

이게 좀 더러우면 밑에 방식이 더 깔끔하고 안전함 

```bash 
#!/bin/bash
count=0

for file in *.txt; do
    [ -f $file ] || continue # 파일 아닌 디렉토리면 세지말고 넘어가자 
    echo "file: $file"
    ((count++))
done

echo "file num : $count"
```

# 4. logfile.log 파일에서 ERROR가 포함된 줄만 추출하여 error.log로 저장하고,추출한 줄의 수를 마지막에 출력하시오.
이미 error.log가 있어도 덮어쓰기.

테스트용 logfile.log 내용 
```
INFO 2025-08-20 10:00:01 Server started
ERROR 2025-08-20 10:05:12 Failed to connect to database
INFO 2025-08-20 10:10:23 User logged in
WARNING 2025-08-20 10:15:34 Disk space low
ERROR 2025-08-20 10:20:45 Unable to read config file
INFO 2025-08-20 10:25:00 Backup completed
```
***

```bash
#!/bin/bash
count=0

grep "ERROR" logfile.log > error.log
count=$(wc -l < error.log | xargs) # < 대신 | 쓰면 파일 이름까지 출력되니까 리다이랙트가 깔끔
echo "error num is $count"
```

# 5. 현재 디렉토리에 있는 모든 .log 파일 중에서,오늘 날짜(예: 2025-08-20)가 포함된 줄만 추출하여 각 파일별로 파일명_today.log로 저장하는 스크립트를 작성하시오.

예시 로그파일 
```bash
2025-08-19 user1 login
2025-08-20 user2 login
2025-08-20 user3 logout
```
***

```bash
#!/bin/bash
today="2025-08-20"

for file in *.log; do
    newfile="${file}_today.log"
    grep $today $file > $newfile
    echo "processing $file >>>> $newfile "
done
```

# 6. users.txt 파일에는 사용자 이름이 한 줄에 하나씩 저장되어 있다.각 사용자 홈 디렉토리에 backup 폴더가 있는지 확인하고, 있으면 "Exists", 없으면 "Missing" 출력하는 스크립트를 작성하시오.

users.txt 파일 예시 
```
alice
bob
carol
dave

```

***

핵심 문법 
```
while read 변수; do
    # 반복할 코드
done < 파일명
```
이렇게 쓰면 파일에서 한줄씩 꺼내서 변수에 넣어준다. 

***

#!/bin/bash
```bash
while read user; do
    if [ -d "/home/${user}/backup" ]; then
        echo "${user} : exists"
    else
        echo "${user} : missing"
    fi

    
done < users.txt
```



# 7. 현재 디렉토리에서 용량이 1MB 이상인 파일만 출력하는 스크립트를 작성하세요.

```bash
#!/bin/bash

find . -type f -size +1M 
```
단위가 키로바이트는 k, 바이트는 c다. 기가바이트는 G

# 8. 현재 디렉토리의 모든 .txt 파일 이름 앞에 old_를 붙이는 스크립트를 작성하세요.
```bash
#!/bin/bash

for file in *.txt; do

    [ -f $file ] || continue
    mv $file old_$file
done

```

# 9. 사용자에게 숫자를 입력받아, 0이 입력될 때까지 계속 합계를 계산하는 스크립트를 작성하세요.
```bash

#!/bin/bash

sum=0
input=1;
while [ $input -ne 0 ] ; do 
    echo "input number: "
    read input
    ((sum+=input)) 
done 

echo "sum : $sum"
```

# 10. logfile.log 파일에서 "INFO" / "WARN" / "ERROR" 각 라인의 개수를 화면에 출력하는 스크립트를 작성하세요.


```bash
#!/bin/bash

INFO=$(grep -c "INFO" logfile.log)
WARN=$(grep -c "WARN" logfile.log)
ERROR=$(grep -c "ERROR" logfile.log)

echo "INFO : $INFO"
echo "WARN : $WARN"
echo "ERRORO : $ERROR"
```

grep -c 가 단어를 포함한 줄의 개수를 세주는것 

# 11. 현재 디렉토리에서 가장 최근에 수정된 파일 이름을 출력하는 스크립트를 작성하세요.

#!/bin/bash
```bash
recentFile=$(ls -t | head -n 1)
echo "recentFile is $recentFile"
```

ls -t가 수정시간 기준 내림차순 정렬해줌 

# 12. 현재 디렉토리의 .txt 파일 중, 각 파일의 라인 수를 출력하는 스크립트 작성
```bash
#!/bin/bash

for file in *.txt; do 
    if [ -f "$file" ]; then 

        line=$(wc -l < "$file" | xargs)
        echo "file $file's line number is $line"
    fi
done
```

파일 이름에 공백이 있을걸 감안해서 "$file" 이렇게 따옴표로 묶어주는 습관을 들이자 
wc -l "$file" 이렇게 하면 출력에 파일이름도 나와서 더러우니 <로 리다이렉트

# 13. logfile.log에서 "ERROR"가 포함된 라인만 error.log로 저장

```bash
#!/bin/bash
grep  "ERROR" logfile.log > error.log
```

# 14. 디렉토리 내 모든 .log 파일의 마지막 5줄을 출력

```bash 
#!/bin/bash
for file in *.log; do 
    echo "file name : $file"
    tail -n 5 "$file"
    echo "**********************************"
done
```



# 15. 사용자 입력으로 디렉토리 경로를 받아, 그 안의 파일 개수 출력

```bash 
#!/bin/bash
echo "plz input the path: "
read path

if [ -d $path ]; then
    echo "file num is $(ls ${path} | wc -l | xargs)" 
else
    echo "it's not a dictory"
fi

```
# 16. 배열에 숫자 5개 저장 → 배열 합계와 평균 계산 후 출력


```bash
#!/bin/bash
arr=(1 2 3 4 5)
sum=0
avg=0
for num in "${arr[@]}" ; do # 요소안에 띄어쓰기가 있을수도 있으니 ${arr[@]}에 ""를 꼭 붙여주자
    ((sum+=num))    # 값 대입할거 아니니까 $ 안붙여도 됨 
done
echo "sum:$sum"
avg=$((sum/${#arr[@]})) # 얘는 avg에 값을 넣어야 하니까 앞에 $를 붙임 
echo "avg:$avg"

배열 선언은 콤마로 구분짓지 않고 띄어쓰기로만 구분하는게 정석임
```
# 17. 디렉토리 내 가장 큰 파일 이름과 크기 출력
```bash
#!/bin/bash

echo "largest file is $(ls -S | head -n 1)"
echo " size is  $(ls -lhS | head -n 2 | tail -n 1 | awk '{print $5}') "

파일 용량 순으로 정렬할땐 ls -S 
이때 용량에 단위 붙이려면 -h옵션 
head-tail이거 리눅스 마스터 문제용이 아니라 실제로도 쓰는 구나..
```

# 18. 1~50 숫자 중 3의 배수만 출력하고 합계도 계산
```bash
#!/bin/bash

sum=0

for num in {1..50}; do 
    if [ $((num%3)) -eq 0 ]; then 
        ((sum +=num)) 
        echo "multiples of 3 :$num"
    fi
done

echo "sum is $sum"

```

# 19. 현재 디렉토리에서 1MB 이상 파일만 찾아 이름과 크기 출력
```bash
#!/bin/bash

find . -type f -size +1M -exec ls -lh {} \; | awk '{print $9 "\t" $5}' | sed 's/^\.//'

```

find 에서 찾은 결과-exec [실행할 명령어] {} \; 이런식으로 써도 되고 이게 헷갈리면 
find . -type f -size +1c | ls -lh 이렇게 넘겨서 써도 상관 없음 

sed 's/^\.//' -> 's/기존 문자/변경할 문자' 형태임. 

# 20 숫자 배열 (10 25 31 42 55 60 77 88 93)을 선언하고, 이 배열의 홀수만 출력하는 스크립트를 작성하세요.

```bash
#!/bin/bash

arr=(10 25 31 42 55 60 77 88 93)

for num in "${arr[@]}"; do 
    if [ $((num%2)) -ne 0 ]; then
        echo "$num "
    fi
done

```

# 21 사용자로부터 두 개의 숫자를 입력받아, 두 수의 합과 곱을 출력하는 calculate라는 함수를 만들고 이를 실행하는 스크립트를 작성하세요.

```bash 
#!/bin/bash

calculate(){ 
    local sum=$(($1+$2))
    local mul=$(($1*$2))
    echo "sum is $sum"
    echo "mul is $mul"
}

read num1 num2 
calculate "$num1" "$num2"

```

함수 안에서는 가급적 local을 써서 함수 안에서만 유효하게 해줍시다 



# 22. 현재 디렉토리에서 실행 권한(x)이 없는 파일들의 목록을 찾아, 해당 파일들에 실행 권한을 추가하는 스크립트를 작성하세요.
```bash
#!/bin/bash

find . -type f ! -executable -exec chmod +x {} \; 
```
참고로 이거는 하위 디렉터리 안에 파일까지 전부 실행권한 주는거임 

# 23. 사용자에게 start, stop, restart 중 하나의 옵션을 입력받아, 입력된 옵션에 따라 "서비스를 시작합니다.", "서비스를 중지합니다.", "서비스를 재시작합니다." 메시지를 각각 출력하는 스크립트를 작성하세요.
```bash
#!/bin/bash


read mesg
if [ $mesg = "start" ]; then
    echo "system start"
elif [ $mesg = "stop" ]; then
    echo "system stop"
elif [ $mesg = "restart" ]; then
    echo "system restart"
fi
```

근데 가독성 때문에 case문이 좋다고 하니 밑은 케이스문으로 바꾼 버전 

```bash 
#!/bin/bash

read mesg
case $mesg in 
    start)
        echo "system start"
        ;;
    stop)
        echo "system stop"
        ;;
    restart)
         echo "system restart"
         ;;
    *)
        echo "wrong option"
        ;;
esac
```

# 24. 오늘 날짜를 기준으로 YYYY-MM-DD 형식의 디렉토리를 생성하는 스크립트를 작성하세요. 만약 해당 디렉토리가 이미 존재하면 "이미 존재합니다."라는 메시지를 출력하세요.

```bash 

#!/bin/bash
today=$(date +%Y-%m-%d)

if [ -d "./$today" ]; then 
    echo "already exist"
else
    mkdir $today
fi
```


# 25. 특정 파일(report.txt)에서 "2025"를 "2026"으로 변경한 후, 그 결과를 화면에 출력만 하고 실제 파일은 수정하지 않는 스크립트를 작성하세요.

```bash
#!/bin/bash

sed 's/2025/2026/g' report.txt

```

sed는 내용을 직접 바꾸지 않고 화면에만 띄워줌. 직접 바꾸고 싶으면 sed -i옵션을 주면 됨 

# 26 cut 명령어 활용: hosts.txt 파일에 ip-address hostname 형식으로 데이터가 저장되어 있습니다. cut 명령어를 활용하여 호스트 이름만 추출하여 출력하는 스크립트를 작성하세요.
```bash

#!/bin/bash
cut -d '-' -f 2 hosts.txt
```

cut: 각 줄마다 기준으로 자를떄 씀 
-c 로 글자 수 기준으로 자를수도 있고 
-d 로 구분자 지정해서 자를 수도 있음.



# 27 시스템 정보 확인: 현재 시스템의 CPU 모델명과 코어 수를 출력하는 스크립트를 작성하세요. (/proc/cpuinfo 파일을 활용하세요)
```bash
#!/bin/bash
#시스템 정보 확인: 현재 시스템의 CPU 모델명과 코어 수를 출력하는 스크립트를 작성하세요. (/proc/cpuinfo 파일을 활용하세요)

model_name=$(grep "model name" /proc/cpuinfo | cut -d ':' -f 2 |head -n 1 )
model_core=$(grep "cpu cores" /proc/cpuinfo | cut -d ':' -f 2 |head -n 1 )

echo "model : $model_name"
echo "cores : $model_core"
```

# 28 tar와 find 결합: /var/www/html 디렉토리 내에서 최근 7일 이내에 수정된 .php 파일들을 찾아, 이 파일들만 backup.tar.gz 파일로 압축하는 스크립트를 작성하세요.
```bash
#!/bin/bash



find /var/www/html -mtime -7 -type f -name "*.php" -print0 | xargs -0 tar czvf backup.tar.gz 
```

find ~~~ -print0  이렇게 맨 뒤에 붙여주면 파일사이에 널문자(파일의 끝을 알려줌)를 삽입해줌. 눈에는 안보이지만 
xargs는 표준 입력으로 받은 데이터를 명령어의 인자로 만들어 실행해주는 명령어
위 코드처럼 쓰면 널문자 기준으로 인자를 구분해서 tar명령어의 인자로 넘겨줌 





# 29. 배열과 파일 처리: 현재 디렉토리에서 확장자가 .sh인 모든 셸 스크립트 파일의 이름을 배열에 저장한 후, 가장 크기가 큰 파일 이름과 가장 작은 파일 이름을 출력하는 스크립트를 작성하세요.
```bash
#!/bin/bash
arr=( *.sh ) #이러면 현재 디렉토리만 볼 수 있음 

if [ ${#arr[@]} -eq 0 ]; then
    echo "no .sh file exists"
    exit 1 
fi 

max_file=""
max_size=0
min_file=""
min_size=1000000000000 

for file in "${arr[@]}"; do
     size=$(stat -c %s "$file")
     if [ $max_size -lt $size ]; then
        max_size=$size
        max_file=$file
    fi

    if [ $min_size -gt $size ]; then 
        min_size=$size
        min_file=$file
    fi

done

echo "max file : $max_file"
echo "min file : $min_file"


# 기본적으로 숫자만 나오면 바이트 단위이기 때문에 000붙일때마다 단위가 올라감. 위에선  1테라를 상한으로.

```
# 30. 프로세스 관리 및 자동화: cron 서비스가 실행 중인지 확인하는 스크립트를 작성하세요. 만약 서비스가 중지되어 있으면 자동으로 시작시키고, "cron 서비스가 시작되었습니다."라는 메시지를 출력하세요. 실행 중이면 실행중이라고 출력하시오 
```bash
#!/bin/bash
if [ $(systemctl status crond | grep "active (running)" | wc -l ) -eq 1 ]; then 
    echo "cron is activated "
else 
    sudo systemctl start crond 
    echo "cron is started "
fi 

```

#근데 위에 방식은 좀 복잡하니 밑에로 쓰는게 깔끔 

```bash
if systemctl is-active --quiet crond ; then 
    echo "cron is activated "
else 
    sudo systemctl start crond 
    echo "cron is started "
fi 
```

#이러면 --quite로 인해 가동중이면 0, 아니면 1을 반환하게됨 






# 31. 로그 분석 응용: /var/log/secure 파일에서 최근 3일 동안 로그인에 실패한 사용자 계정 목록과 실패 횟수를 순서대로 출력하는 스크립트를 작성하세요. (로그 파일이 없는 경우 임의로 내용을 만들어 사용하세요.)
```bash
#!/bin/bash 

date=$(date -d '0 day ago' '+%b %e' ) # %b는 영어 월, %e는 영어 일, -d day ago하면 오늘 기준 전날 날이 나오네..
date="$date|$(date -d '1 day ago' '+%b %e' )"
date="$date|$(date -d '2 day ago' '+%b %e' )"

sudo grep -E "$date" /var/log/secure | grep -E  "authentication failure|Failed password" | \
awk -F'user=' '{print $2}' | awk '{print $1}' | \
sort | uniq -c | sort -nr # 일단 정렬하고, 정렬된 데이터를 "나온수 이름" 포멧으로 바꾸고, 다시 숫자(n) 기준으로 내림차순(r)

```
로그인 실패 로그는 다음과 같은 형태이다 
`Aug 22 08:38:09 ip-172-31-35-228 su[2114]: pam_unix(su-l:auth): authentication failure; logname=ec2-user uid=1000 euid=0 tty=/dev/pts/0 ruser=ec2-user rhost=  user=user01`

logname이랑 ruser의 차이는 모르겠다.. 암튼 ec2-user가 user=user01계정에 로그인 시도했지만 authentication failure가 떴다는 것을 알 수 있음. 

근데 실제로는 다양한 인증실패 유형이 있어서 저게 답은 아님.. 다양한 조건분기가 더 필요하긴 하겠다..


# 32. 함수와 매개변수 응용: 함수를 하나 만들고, 이 함수에 "all", "start", "stop" 중 하나의 인자를 전달하면, 각 인자에 따라 "모든 서비스", "시작 서비스", "중지 서비스"를 출력하는 스크립트를 작성하세요.
```bash
#!/bin/bash 

func(){
    case $1 in
        all) 
            echo "all service"  
            ;;
        start)
            echo "start service"
            ;;
        stop) 
            echo "stop service"
            ;;
        *) 
            echo "Invalid option. Please enter all, start, or stop."
            ;;
    esac 

}      

echo "input the option"
read option 
func "$option"
```


# 33 . 파일 동기화 및 조건부 실행: /data/source 디렉토리와 /data/dest 디렉토리의 파일 개수를 비교하여, source 디렉토리의 파일이 더 많을 경우 rsync 명령어로 두 디렉토리를 동기화하는 스크립트를 작성하세요. 동기화 후 성공 메시지를 출력하세요.
```bash
#!/bin/bash 

home="/Users/yourname/Desktop/git/study_log/linux/test"
source="$home/data/source"
dest="$home/data/dest"

if [ ! -d $source ]; then 
    echo "source dir is not exist"
    exit 1 
fi 

if [ ! -d $dest ]; then 
    echo "dest dir is not exist"
    exit 1 
fi 

source_num=$(find $source -type f | wc -l)
dest_num=$(find $dest -type f | wc -l)

if [ ${source_num} -gt ${dest_num}  ]; then 
    echo "source dir has more file. start synchronizaion..."
    rsync -av --progress "$source"/ "$dest"/ # a: 모든 옵션 한번에 적용  v: 무슨 파일 동기화됬는지 progress: 실시간 완료도
    # 참고로 파일 이름에 공백 있을까봐 ""로 감싼거고, 관례적으로 마지막에 /붙인다고 함(안붙이면 안 내용이 아니라 디렉토리부터 동기화돼서?)

    if [ $? -eq 0 ]; then 
        echo "sync success"
    else
        echo "error occured"
    fi 
else 
    echo "already synchronized"
fi 

```

# 34 /var/log/secure 파일에서 최근 7일 동안 특정 사용자(ec2-user)의 로그인 성공/실패 횟수를 집계하는 스크립트를 작성하세요.
### 출력 형식은 다음과 같이 하세요:
### ec2-user: 성공 10회, 실패 3회

임시 파일은 
```
Aug 22 08:00:01 ip-172-31-35-228 sshd[1010]: Accepted password for ec2-user from 1.2.3.4 port 22 ssh2
Aug 22 08:05:12 ip-172-31-35-228 sshd[1011]: Failed password for ec2-user from 1.2.3.4 port 22 ssh2
Aug 22 09:15:22 ip-172-31-35-228 sshd[1012]: Accepted password for ec2-user from 1.2.3.4 port 22 ssh2
Aug 21 07:45:10 ip-172-31-35-228 sshd[1013]: Failed password for ec2-user from 1.2.3.4 port 22 ssh2
Aug 21 08:00:00 ip-172-31-35-228 sshd[1014]: Accepted password for ec2-user from 1.2.3.4 port 22 ssh2
Aug 20 12:30:01 ip-172-31-35-228 sshd[1015]: Failed password for ec2-user from 1.2.3.4 port 22 ssh2
Aug 20 12:35:05 ip-172-31-35-228 sshd[1016]: Accepted password for ec2-user from 1.2.3.4 port 22 ssh2

```
라고 하자. 

```bash
#!/bin/bash 
path="./secure.log"
user="ec2-user"
success=$(grep "Accepted password for $user" "$path" | wc -l | xargs )
fail=$(grep "Failed password for $user" "$path" | wc -l | xargs)

echo -e "username: $user \nsuccess : $success \nfail: $fail "

```

약간 무식한 방법이긴 하네.. 근데 제일 정확한 방법인거 같기도 하고.. 

# 35. 서버에 있는 /var/log 디렉토리 내 모든 .log 파일의 용량을 확인하고, 용량이 10MB 이상인 파일만 출력하는 스크립트를 작성하세요.
### 출력 형식 예시는 다음과 같이 하세요:  
### 파일명: /var/log/messages, 용량: 15MB
### 파일명: /var/log/secure, 용량: 12MB

```bash
#!/bin/bash 

path="/var/log"
size_limit=10M
find $path -name "*.log" -type f -size +$size_limit -exec du -h {} \; | while read size file; do 
    echo "file name: $file, volumn: $size " 
done 
```

# 36 /etc/passwd 파일에서 로그인 쉘이 /bin/bash인 사용자만 출력하는 스크립트를 작성하세요.
### 출력 형식:
### 사용자명: root
### 사용자명: user1
```bash
#!/bin/bash 

while read line; do 
    shell=$(echo "$line" | awk -F':' '{print $7}')
    if [ $shell = "/bin/bash" ]; then 
        username=$(echo "$line" | awk -F':' '{print $1}')
        echo "username: $username"
    fi 
done < /etc/passwd 
```
근데 이거 awk만 쓰면 한줄로 끝낼 수 있음 
`awk -F':' '$7 == "/bin/bash" {print "username: " $1} /etc/passwd'`

awk에서 비교는 무조건 `==` 연산자만 써야함. `=`는 대입임 

# 37 /tmp 디렉토리 내 모든 파일과 디렉토리의 권한을 확인하고, 실행 권한이 있는 파일만 출력하는 스크립트를 작성하세요.
### 출력 형식:
### 파일명: /tmp/test.sh, 권한: -rwxr-xr-x
### 파일명: /tmp/runme, 권한: -rwx------
```bash
#!/bin/bash 
sudo find /tmp -type f -executable | while read file; do 
    perm=$(ls -l $file | awk '{print $1}' )
    echo "file name: $file, perm : $perm "
done
```

`find /tmp -type f | while read file; do ... done` 이런식으로 결과를 한줄씩 넘겨서 file변수가 읽던지 
`while read file; do ... done < filelist.txt` 이런식으로 파일로 읽던지 
내부 동작이야 다르지만 결국 출력은 같다 이말이네..

# 38 /var/log/wtmp 파일에는 시스템에 로그인/로그아웃 기록이 남아 있습니다. last 명령어를 이용해서 최근 로그인한 사용자 목록과 로그인 횟수를 출력하는 스크립트를 작성하세요.
### 조건:
### 사용자명과 로그인 횟수를 출력
### 내림차순으로 로그인 횟수가 많은 순서로 정렬

### 출력 예시:
### 사용자명: ec2-user, 로그인 횟수: 12
### 사용자명: root, 로그인 횟수: 3

### 참고로 내부 정책으로 따로 백업해놓지 않는한 wtmp에는 모든 엣날 기록까지 다 남아있음 

```bash
#!/bin/bash 

last | awk '{print $1}' |grep -v "^$"| grep -v "wtmp"|  sort | uniq -c | sort -nr | awk '{print "사용자명: " $2 ", 로그인 횟수:" $1}'

```
last명령 하면 빈 줄도 있고 wtmp만 출력되는 줄이 있기 때문에 그 패턴은 다 없애고 시작. 
빈줄은 `grep -v "^$"`로 없애자. ""하면 모든 줄이 매칭되니 하지 말고. 
저 소트 유니크 소트 패턴은 엄청 자주 나오네 


# 39 /var/log 디렉토리와 /home/username 디렉토리가 있다. 각 디렉토리 안에 있는 일반 파일 개수를 세어서 파일수가 더 많은 디렉토리 
# 출력하고 같으면 같다고 출력하라 

```bash 
#!/bin/bash 

log_num=$(sudo find /var/log -type f | wc -l)
user_num=$(sudo find ~ -type f | wc -l)

if [ $log_num -gt $user_num ]; then 
    echo "log has more file : $log_num"
elif 
    [ $user_num -gt $log_num ]; then 
    echo "user has more file: $user_num "
else
    echo "same"
fi 

```

# 40 /data 디렉토리에서 사용자가 입력한 확장자를 가진 파일들을 찾고 그 파일들의 **총 용량(MB 단위)**을 계산하여 출력하세요.
### ex: 확장자: .log, 총 용량: 152MB
```bash
#!/bin/bash 
echo "확장자를 입력하세요: " 
read option 
total_byte=$(find /data -name "*$option" -type f -exec du -b {} + | awk '{sum+=$1} END {print sum}')
total_mb=$((total_byte/1024/1024))

echo "확장자: $option, 총 용량: ${total_mb}Mb"
```

du -b 로 해야 바이트 단위로 나와서 정확한 계산 가능. 
`find … -exec 명령 {} \;` 이건 명령을 파일 개수마다 실행 -> 느림 
`find … -exec 명령 {} +` 하나의 파일로 만들어서 명령 실행 -> 빠름 
그래서 명령이 한꺼번에 처리 가능한 명령이라면 앵간하면 + 하면 빠름 
sum변수는 awk안에서 선언한 변수는 초기값0보장 
awk '{ } END { } ' 이런식으로 앞에 다 끝나면 엔드 뒤 실행도 가능 


# 41 현재 디렉토리에 있는 모든 파일 이름을 대상으로 파일 이름에 공백이 있으면 언더바(_)로 변경, 변경한 파일 이름과 변경 전 이름을 출력하시오 

```bash 
#!/bin/bash
# 41 현재 디렉토리에 있는 모든 파일 이름을 대상으로 파일 이름에 공백이 있으면 언더바(_)로 변경, 변경한 파일 이름과 변경 전 이름을 출력하시오 

for file in *; do 
    [ -f "$file" ]  || continue 
    if [[ $file =~ \  ]]; then 
        newname=${file// /_}
        mv "$file" $newname
        echo "변경 전 : $file"
        echo "변경 후 : $newname"
    fi 
done 

```
${변수//찾을문자/바꿀문자} 이런식으로 공백을 _로 바꿀 수 있네. 
`[[ $file =~ \  ]]` 이건 왼쪽 문자열이 오른쪽 정규식에 맞는지 확인. 공백은 여기선 '\ '으로 표기. 따라서 공백이  하나라도 있으면 참 

# 42 시스템의 메모리 사용량을 확인하고, 만약 사용률이 80% 이상이면"메모리 사용량이 높습니다."라는 경고 메시지를 출력하고, 그렇지 않으면 "정상입니다."라는 메시지를 출력하는 스크립트를 작성하세요.

```bash 
#!/bin/bash

usage=$(free | awk '/Mem:/ {print int($3/$2 * 100.0)}')
echo "usage: $usage"
if [ $usage -ge 80 ]; then 
    echo "메모리 사용량이 높습니다 "
else
    echo "정상입니다"

fi
```

`awk ' /문자열/ {}'` 이거는 문자열이 포함되어있는 줄에 대해서만 {}을 실행하겠다는 뜻 


# 43 서버 /var/log 안의 로그 파일(*.log)이 있습니다. 로그 형식은 다음과 같습니다
```
[2025-08-24 13:20:15] ERROR Failed to connect to DB
[2025-08-24 13:20:20] INFO User login: kim
[2025-08-24 13:21:05] WARN Disk usage 85%
```
### 모든 로그 파일(*.log)을 읽어 처리
### 로그 레벨별(ERROR, WARN, INFO) 발생 횟수 계산
### 최종 결과를 log_summary.txt에 출력

출력 예시는 다음과 같음 


```
총 로그 수: 150
ERROR: 10
WARN: 5
INFO: 135



```bash
#!/bin/bash

out_file=log_summary.txt
>"$out_file" # 이런식으로 파일에 아무내용없이 리다이랙션 하면 파일 없으면 만들어주고 있으면 초기화해줌 

shopt -s nullglob # 배시셸 상세옵션 설정하는것. -s는 시작. 만약 .log로 끝나는 파일이 아무것도 없으면 *.log가 배열에 들어가는 것을 방지
FILES=(/var/log/*.log)
[ ${#FILES[@]} -eq 0 ] && { echo "no log file exist" >&2 ; exit 1; } # 표준 에러로 출력해야 나중에 관리 편함 


ERROR=$(grep -h "ERROR" /var/log/*.log | wc -l)
WARN=$(grep -h "WARN" /var/log/*.log | wc -l)
INFO=$(grep -h "INFO" /var/log/*.log | wc -l)

TOTAL=$((ERROR + WARN + INFO))

echo "총 로그 수:$TOTAL" > "$out_file"
echo "ERROR : $ERROR" >> "$out_file"
echo "WARN : $WARN" >> "$out_file"
echo "INFO : $INFO" >> "$out_file"
echo >> "$out_file"

```
