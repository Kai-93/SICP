/*
 * @Author: Kaiser
 * @Date: 2020-08-07 13:10:12
 * @Last Modified by: Kaiser
 * @Last Modified time: 2020-08-10 12:57:32
 * @Description: 练习1.3 请定义一个过程,它以三个数为参数,返回其中较大的两个数之和
 */
function fun(a, b, c) {
  if (a > b) {
    if (b > c) {
      return square(a, b);
    } else {
      return square(a, c);
    }
  } else {
    if (a > c) {
      return square(b, a);
    } else {
      return square(b, c);
    }
  }
}

function square(a, b) {
  return a * a + b * b;
}
console.log(fun(10, 2, 3));
