#!/bin/bash
#tar와 find 결합: /var/www/html 디렉토리 내에서 최근 7일 이내에 수정된 .php 파일들을 찾아, 이 파일들만 backup.tar.gz 파일로 압축하는 스크립트를 작성하세요.



find /var/www/html -mtime -7 -type f -name "*.php" -print0 | xargs -0 tar czvf backup.tar.gz 

#find ~~~ -print0  이렇게 맨 뒤에 붙여주면 파일사이에 널문자(파일의 끝을 알려줌)를 삽입해줌. 눈에는 안보이지만 
#xargs는 표준 입력으로 받은 데이터를 명령어의 인자로 만들어 실행해주는 명령어
#위 코드처럼 쓰면 널문자 기준으로 인자를 구분해서 tar명령어의 인자로 넘겨줌 

