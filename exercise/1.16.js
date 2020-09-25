/*
 * @Author: Kaiser
 * @Date: 2020-08-14 06:43:28
 * @Last Modified by: Kaiser
 * @Last Modified time: 2020-08-15 18:16:20
 * @Description: 求幂
 */

function expt(b, n) {
  let result = 1;
  let count = 0;
  while (count < n) {
    result *= b;
    count++;
  }
  return result;
}

function fastExpt(b, n) {
  function exptIter(b, n, a) {
    if (n === 0) {
      return a;
    }
    // 偶数
    if (n % 2 === 0) {
      return exptIter(b * b, n / 2, a);
    }
    // 技术
    return exptIter(b, n - 1, a * b);
  }
  return exptIter(b, n, 1);
}

console.time(1);
console.log(expt(100, 10000));
console.timeEnd(1);

console.time(2);
console.log(fastExpt(100, 10000));
console.timeEnd(2);
