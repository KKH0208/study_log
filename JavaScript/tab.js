// 첫번째 버튼이 눌리면 오렌지랑 show클레스를 붙이기 그리고 기존에 붙어져 
//있던거 빼기 
//근데 어디에 붙어있는지 모르니까 모든 버튼에 붙은 오렌지랑 쇼를 제거 


// document.querySelectorAll('.tab-button')[0].addEventListener('click',function(){
//     for(let i=0;i<3;i++){
//         document.querySelectorAll('.tab-button')[i].classList.remove('orange')
//         document.querySelectorAll('.tab-content')[i].classList.remove('show')
//     }
//     document.querySelectorAll('.tab-button')[0].classList.add('orange')
//     document.querySelectorAll('.tab-content')[0].classList.add('show')
// })

// document.querySelectorAll('.tab-button')[1].addEventListener('click',function(){
//     for(let i=0;i<3;i++){
//         document.querySelectorAll('.tab-button')[i].classList.remove('orange')
//         document.querySelectorAll('.tab-content')[i].classList.remove('show')
//     }
//     document.querySelectorAll('.tab-button')[1].classList.add('orange')
//     document.querySelectorAll('.tab-content')[1].classList.add('show')
// })

// document.querySelectorAll('.tab-button')[2].addEventListener('click',function(){
//     for(let i=0;i<3;i++){
//         document.querySelectorAll('.tab-button')[i].classList.remove('orange')
//         document.querySelectorAll('.tab-content')[i].classList.remove('show')
//     }
//     document.querySelectorAll('.tab-button')[2].classList.add('orange')
//     document.querySelectorAll('.tab-content')[2].classList.add('show')
// })

var num=document.querySelectorAll('.tab-button').length
for (let j=0;j<num;j++){
    document.querySelectorAll('.tab-button')[j].addEventListener('click',function(){
    for(let i=0;i<num;i++){
        document.querySelectorAll('.tab-button')[i].classList.remove('orange')
        document.querySelectorAll('.tab-content')[i].classList.remove('show')
    }
    document.querySelectorAll('.tab-button')[j].classList.add('orange')
    document.querySelectorAll('.tab-content')[j].classList.add('show')
})
}

