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



