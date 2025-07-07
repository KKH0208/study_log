# 코딩애플 자바스크립트 기초강의 정리

## 자바스크립트를 쓰는 이유

요즘엔 다양한 걸로 쓰이지만 가장 근본은 html조작

## JS맛보기 코드

```html
<h1 id="hello">안녕하세요</h1>
<script>
  document.getElementById("hello").innerHTML = "안녕";
  document.getElementById("hello").style.color = "red";
  document.getElementById("hello").style.fontSize = "16px";
</script>
```

이런식으로 id가 hello인 요소들의 내용, 폰트색, 크기 다 JS로 조절 가능

## alert박스 만들기

> UI만드는 스텝-> 1. 미리 html,css를 만들어놓고 평소에는 숨겨놓고 2. 필요할때 보여달라고 코드짜기
> 즉, 평소에는 `display:none`으로 해놓고 필요할때 `display:block`으로

결과는

```html
<div class="alert-box" id="alert-window">알림창임</div>
<button onclick="document.getElementById('alert-window').style.display='block'">
  버튼
</button>
```

## 함수

자주 쓰는 js코드는 함수로 간단하게 쓸 수 있음.
`document.getElementById('alert-window').style.display='block'`는 너무 기니까

`function 열기() {document.getElementById("alert-window").style.display = "block";}` 로 정의하고 저 코드가 쓰일곳에 `열기()`를 대신 사용하면 편함

## 함수에 구멍 뚫기

열기,닫기 함수를 따로 만드는게 아니라 하나로 통합해보자

`function 알림창(구멍) {document.getElementById("alert-window").style.display = 구멍;}`

## id가 아닌 class명으로 찾기

`document.getElementsByClassName("message")[0]`
클래스는 여러태그에 있을 수 있기 때문에 위에서부터 몇번째를 원하는지 [0] 이런식으로 꼭 붙여야 함

## 이벤트리스너

함수로 축약했다고 해도 버튼에다가 onclick을 넣는건 좀 더러움. 그래서 버튼에 id로 close를 부여하고 자바스크립트에
`document.getElementById('close').addEventListener('click', function(){});`
추가하면 close아이디를 가진 놈이 클릭되면 이 함수를 실행하겠다 가능

click이 아니라 mouseover(마우스 갖다대기), scroll등으로 다양한 이벤트리스너 작성가능

## Bootstrap

### 부트스트랩이란?

우리가 자주 쓰는 UI를 직접 개발하긴 귀찮으니까 갖다쓰게 해주는 라이브러리

css를 갖다 쓰고싶으면
`<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css"rel="stylesheet"integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr"crossorigin="anonymous"/>`
를 head에 추가하면 됨. 
그리고 부트스트랩 사이트에서 원하는거 검색해서 갖다 쓰면 됨. 

참고로 head에 여러 스타일시트를 참조할때 맨 밑에 있는게 우선순위가 크기 때문에 잘 조절해서 써야함 


## 클래스 탈부착
평소에는 `<ul class="list-group">`으로 하고 안보이게 했는데 `<ul class="list-group show">`와 같이 클래스를 붙여서 보이게 하는 기법 
`document~~~ .classList.toggle('show')` 이렇게 하면 show가 있을때는 없애주고 없을때는 추가해줌

## 쿼리셀렉터 
지금까지는 id나 class에 따라 getelementby를 나눠썼는데 이게 좀 귀찮다. 
그래서 `querySelector`를 쓰자. 
document.querySelector('.alert-box')라고 하면 alert-box클래스중 맨 위에 나오는 애를 찾아줌. 
id로 찾으려면 #쓰면 되는거고. 
하나가 아니라 전부 찾고 싶으면 `querySelectorAll`을 쓰자. 



## 여러 자바스크립트 라이브러리 
지금까지 하고 느꼈겠지만 자바스크립트는 너무 길고 더러움. 그래서 좀 더 쉽게 바꿔주는 여러 라이브러리가 생김. 대표적으로 `jQuery`,`React`,`Vue`등이 있음. 리액트랑 뷰는 자바스크립트 좀 알아야 가능하니까 제일 쉬운 `jQuery`부터 만져보자

설치는 그냥 html파일 body태그 끝나기 전에 스크립트를 몰아넣으면 됨. 
jquery cnd 검색해서 스크립트 복붙하면 됨 

그러면 hello클래스의 내용을 바꿀려면  `$('.hello').html('바보');` 이렇게 하면 됨 


## one-way animation 만드는법

1. 시작스타일 class로 만들고 
2. 최종 스타일 class로 만들고 
3. 원할때 최종스타일로 변하라고 js짜로 
4. 시작스타일에 `transition: all 1s`추가 

예를들어 버튼을 누르면 모달창이 뜨게 만들려면 

.black-bg {
  (생략)
  visibility : hidden;
  opacity : 0;
}

.show-modal {
  visibility : visible;
  opacity : 1;
}

이렇게 시작과 최종스타일을 만들고 (참고로 애니메이션은 display속성  쓰지 말고 visibility속성을 써야 잘 동작함)
버튼을 누르면 show-modal클래스가 부착되게 하고 
시작스타일인 .black-bg에 `transition : all 1s;`만 추가하면 됨 


## 폼이 비어있으면 로그인 안하고 경고창 띄우기 
input으로 입력받은 값은 `document.getElementByID().value`로 알 수 있음
그 값이 비었는지는 `===''`로 비교 가능 

경고창 띄우고 폼전송 막으려면 `e.preventDefault()` 추가하면 됨 


## 다크모드 만들기 
아이디어는 버튼이 눌린 횟수를 변수가 기억해서 짝수면 라이트, 홀수면 다크로.
body태그에 클래스를 선언해서 버튼 누를때마다 클래스가 바뀌게 선언하면 될듯(아니면 클래스 탈부착하거나)

## 변수 종류 3가지 
var: 자유로운 변수 
let : 재선언 못함.
const : 재선언도 못하고 재할당도 못함. 