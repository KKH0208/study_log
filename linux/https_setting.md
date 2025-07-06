# https 설정하는법 

## 1. https란 
처음 웹서버를 세우면 http프로토콜로 데이터를 주고받는다. 하지만 보안상 문제가 많기 때문에 SSL/TSL프로토콜을 추가한것이 https이다. 

## 2. https가 필요한 이유 
패킷을 암호화하기 때문에 누가 도청해도 해석하지 못하게 함 

## 3. 구현 방법 
우선 나는 웹서버로 apache2를 사용중이다. 사전조건으로 내 사이트가 도메인을 가지고 있어야 한다. 
다음으로 인증서를 발급받아야 하는데 발급해주는 기관을 CA라고 한다. 여러 CA가 있지만 그중에서 무료인 Let's Encrypt를 사용하겠다.

1. Let's Encrypt를 사용하기 위해 Certbot을 설치한다. 

`sudo apt install certbot python3-certbot-apache`

2. 내 도메인 주소를 등록해야한다. 
`/etc/apache2/sites-available/000-default.conf`로 들어가서 `ServerName example.com`에 내 도메인 주소를 입력한다. 

3. 인증서 발급하기 
`sudo certbot --apache`로 내 사이트에 인증서를 발급받는다. 


주의: Let's Encrypt는 90일 뒤에 만료라 갱신을 해줘야 함. crontab으로 자동으로 하게 만들 수 있을듯.
