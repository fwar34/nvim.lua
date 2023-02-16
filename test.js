// var myObject = {
//     myWord: 'hello',
//     myFunc: function() {
//         return this.myWord.toUpperCase();
//     }
// };
// 
// console.log(myObject.myFunc());
// 
// function otherFunc(s) {
//     return (this.myWord + s).toUpperCase();
// }
// 
// console.log(otherFunc.call(myObject, 'feng'));
// console.log(otherFunc.apply(myObject, ['feng22']));
// 
// var func3 = otherFunc.bind(myObject);
// console.log(func3('feng33'));

// ------------------------------------------------------------
new Promise(function (resolve, _) {
    console.log(1111);
    resolve(2222);
}).then(function (value) {
    console.log('then1');
    console.log(value);
    return 3333;
}).then(function (value) {
    console.log('then2');
    console.log(value);
    throw "An error";
}).catch(function (err) {
    console.log(err);
});

// ------------------------------------------------------------

function print(message, delay) {
    return new Promise(function(resolve, _) {
        setTimeout(function() {
            console.log(message);
            resolve();
        }, delay);
    })
}

print('1', 1000).then(function() {
    // 添加了 return 下个 then 的触发是这个 print 里面返回的 promise 里面的 resolve 触发的，
    // 而这个返回的 promise 里面的操作是个定时器，所以下个 then 就是在这个
    // 定时器触发的时候执行（因为返回的 promise 中 resolve 是在定时器触发的时候执行的），
    // 而不加 return 的时候下个 then 就是直接执行（所以相当于 4 秒定时器设置后立即设置了 3 秒定时器，
    // 所以结果是 3 秒先触发，再过 1 秒后 4 秒定时器触发）
    return print('4', 4000); 
}).then(function() {
    print('3', 3000);
})
