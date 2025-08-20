#!/bin/bash

for file in *.txt; do 
    if [ -f "$file" ]; then 

        line=$(wc -l < "$file" | xargs)
        echo "file $file's line number is $line"
    fi
done

#파일 이름에 공백이 있을걸 감안해서 "$file" 이렇게 따옴표로 묶어주는 습관을 들이자 
# wc -l "$file" 이렇게 하면 출력에 파일이름도 나와서 더러우니 <로 리다이렉트
