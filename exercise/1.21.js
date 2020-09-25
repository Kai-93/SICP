/*
 * @Author: Kaiser
 * @Date: 2020-08-15 23:30:19
 * @Last Modified by: Kaiser
 * @Last Modified time: 2020-08-16 17:28:01
 * @Description: 找n的最小公因数
 */
/**
 * 查找n的最小公因数
 * @param {number} n
 */
function smallestDivisor(n, usePlus = false) {
  return findDivisorByIteration(n, 2, usePlus);
}

/**
 * 判断当前猜测对象(testDivisor)是否n的最小公因数
 * @param {*} n 目标值
 * @param {*} 当前猜测对象
 */
function findDivisorByRecursion(n, testDivisor) {
  // 超过限度了
  if (testDivisor * testDivisor > n) {
    return n;
  }
  // 被整除了
  if (n % testDivisor === 0) {
    return testDivisor;
  }
  return findDivisor(n, testDivisor + 1);
}

function findDivisorByIteration(n, testDivisor, usePlus) {
  while (testDivisor * testDivisor < n) {
    // 被整除了
    if (n % testDivisor === 0) {
      return testDivisor;
    }
    if (usePlus) {
      testDivisor++;
    } else {
      testDivisor = getNextTestDivisor(testDivisor);
    }
  }
  // 超过限度了
  if (testDivisor * testDivisor > n) {
    return n;
  }
  // 被整除了
  if (n % testDivisor === 0) {
    return testDivisor;
  }
}

function getNextTestDivisor(n) {
  if (n === 2) {
    return 3;
  }
  return n + 2;
}

module.exports.smallestDivisor = smallestDivisor;
