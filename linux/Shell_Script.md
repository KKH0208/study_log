## 셸 스크립트 연습문제들과 정답을 해설해놓은 곳입니다. 

1. 2*1부터 9*9의 결과를 출력하세요 

```bash
#!/bin/bash

for i in {2..9}; do
    for j in {2..9}; do
        echo "$i * $j = $((i*j))"
    done
done
```

2. 사용자로부터 숫자 3개를 입력받아 합계를 출력하는 스크립트를 작성하시오.

```bash
#!/bin/bash
echo "input three number"
read a b c
sum=$((a+b+c))
echo "sum is $sum"

```

3. 현재 디렉토리 안 .txt 파일의 개수를 세고, 각 파일 이름과 총 개수를 출력하시오.
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

4. logfile.log 파일에서 ERROR가 포함된 줄만 추출하여 error.log로 저장하고,추출한 줄의 수를 마지막에 출력하시오.
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

5. 현재 디렉토리에 있는 모든 .log 파일 중에서,오늘 날짜(예: 2025-08-20)가 포함된 줄만 추출하여 각 파일별로 파일명_today.log로 저장하는 스크립트를 작성하시오.

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

6. users.txt 파일에는 사용자 이름이 한 줄에 하나씩 저장되어 있다.각 사용자 홈 디렉토리에 backup 폴더가 있는지 확인하고, 있으면 "Exists", 없으면 "Missing" 출력하는 스크립트를 작성하시오.

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



