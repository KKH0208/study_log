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




# 14. 디렉토리 내 모든 .log 파일의 마지막 5줄을 출력
# 15. 사용자 입력으로 디렉토리 경로를 받아, 그 안의 파일 개수 출력
# 16. 배열에 숫자 5개 저장 → 배열 합계와 평균 계산 후 출력
# 17. 디렉토리 내 가장 큰 파일 이름과 크기 출력
# 18. user.txt 파일에서 사용자 이름만 추출하여 새로운 파일로 저장
# 19. 1~50 숫자 중 3의 배수만 출력하고 합계도 계산
# 20. 현재 디렉토리에서 1MB 이상 파일만 찾아 이름과 크기 출력
# 21. logfile.log에서 "WARN"과 "ERROR"를 동시에 포함하는 라인 출력



