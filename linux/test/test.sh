#!/bin/bash 
echo "확장자를 입력하세요: " 
read option 
total_byte=$(find /data -name "*$option" -type f -exec du -b {} + | awk '{sum+=$1} END {print sum}')
total_mb=$((total_byte/1024/1024))

echo "확장자: $option, 총 용량: ${total_mb}Mb"


#du -b 로 해야 바이트 단위로 나와서 정확한 계산 가능. 
# `find … -exec 명령 {} \;` 이건 명령을 파일 개수마다 실행 -> 느림 
# `find … -exec 명령 {} +` 하나의 파일로 만들어서 명령 실행 -> 빠름 
#  그래서 명령이 한꺼번에 처리 가능한 명령이라면 앵간하면 + 하면 빠름 
# sum변수는 awk안에서 선언한 변수는 초기값0보장 
# awk '{ } END { } ' 이런식으로 앞에 다 끝나면 엔드 뒤 실행도 가능 