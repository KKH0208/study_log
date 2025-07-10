function cal(list,avg){
    var result=0
    list.forEach(val => {
        result+=val
    });
    result/=list.length;
    if (result<avg){
        console.log(`평균보다 ${avg-result}점이 더 올랐네요!`)
    }else{
        console.log(`평균보다 ${result-avg}점이 더 떨어졌네요 ㅈㅈ!`)

    }

}
cal([10, 20, 30, 40, 50], 40)
cal([40, 40, 40], 20)