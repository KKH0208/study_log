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








