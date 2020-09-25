/*
 * @Author: Kaiser
 * @Date: 2020-08-16 11:00:35
 * @Last Modified by: Kaiser
 * @Last Modified time: 2020-08-16 17:34:26
 * @Description: 从n开始找出最小的素数
 */
const { smallestDivisor } = require('./1.21.js');

/**
 * 返回从n开始的下一个奇数,不包含n
 * @param {number} n
 */
function nextOdd(n) {
  if (n % 2 === 1) {
    return n + 2;
  }
  return n + 1;
}

/**
 * 查找从n开始的第一个素数
 * @param {number} n
 */
function findPrimeFromN(n) {
  n = nextOdd(n);
  if (isPrime(n)) {
    return n;
  }
  return findPrimeFromN(n);
}

/**
 * n是否是素数
 * @param {number} n
 */
function isPrime(n) {
  return smallestDivisor(n) === n;
}

/**
 * 查找从n开始的maxCount个素数
 * @param {*} n
 * @param {*} maxCount
 */
function findPrimesFromN(n, maxCount) {
  let count = 0;
  let primes = [];
  console.time('耗时: ');
  while (count < maxCount) {
    let curN = primes.length ? primes[primes.length - 1] : n;
    primes.push(findPrimeFromN(curN));
    count++;
  }
  console.timeEnd('耗时: ');
  return primes;
}

// function timedPrimeTest(n) {
//   console.log('\n', n);
//   startPrimeTest(n, Date.now());
// }

// function startPrimeTest(n, startTime) {
//   if (isPrime(n)) {
//     reportPrime(Date.now() - startTime);
//   }
// }

// function reportPrime(elapsedTime) {
//   console.log(' *** ', elapsedTime / 1000, 'ms');
// }

findPrimesFromN(1, 50, true);
findPrimesFromN(1, 50);
console.log('\n');

findPrimesFromN(10, 50, true);
findPrimesFromN(10, 50);
console.log('\n');

findPrimesFromN(100, 50, true);
findPrimesFromN(100, 50);
console.log('\n');

findPrimesFromN(1000, 50, true);
findPrimesFromN(1000, 50);
console.log('\n');

findPrimesFromN(10000, 50, true);
findPrimesFromN(10000, 50);
console.log('\n');

findPrimesFromN(100000, 50, true);
findPrimesFromN(100000, 50);
console.log('\n');

findPrimesFromN(1000000, 50, true);
findPrimesFromN(1000000, 50);
console.log('\n');

findPrimesFromN(10000000, 50, true);
findPrimesFromN(10000000, 50);
console.log('\n');

findPrimesFromN(100000000, 50, true);
findPrimesFromN(100000000, 50);
console.log('\n');

findPrimesFromN(1000000000, 50, true);
findPrimesFromN(1000000000, 50);
console.log('\n');

findPrimesFromN(1000000000, 50, true);
findPrimesFromN(1000000000, 50);
console.log('\n');

findPrimesFromN(10000000000, 50, true);
findPrimesFromN(10000000000, 50);
console.log('\n');

findPrimesFromN(100000000000, 50, true);
findPrimesFromN(100000000000, 50);
console.log('\n');
