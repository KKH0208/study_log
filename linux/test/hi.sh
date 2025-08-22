#!/bin/bash
# 29. 배열과 파일 처리: 현재 디렉토리에서 확장자가 .sh인 모든 셸 스크립트 파일의 이름을 배열에 저장한 후, 가장 크기가 큰 파일 이름과 가장 작은 파일 이름을 출력하는 스크립트를 작성하세요.
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

