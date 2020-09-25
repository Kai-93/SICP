/*
 * @Author: Kaiser
 * @Date: 2020-08-12 13:02:24
 * @Last Modified by: Kaiser
 * @Last Modified time: 2020-08-13 06:58:02
 * @Description:
 */
/**
 * 递归计算过程
 * @param {*} n
 */
function f1(n) {
  if (n < 3) {
    return n;
  }
  return f1(n - 1) + 2 * f1(n - 2) + 3 * f1(n - 3);
}

/**
 * 迭代计算过程
 * @param {*} n
 */
function f2(n) {
  return f2_iter(2, 1, 0, 0, n);
}

/**
 * 保存了相关n的计算结果
 * @param {number} a
 * @param {number} b
 * @param {number} c
 * @param {number} i 当前运算到了哪一步
 * @param {number} n 需要计算的轮数
 */
function f2_iter(a, b, c, i, n) {
  // 计算结束
  if (i === n) {
    return c;
  }
  // 大于3
  return f2_iter(
    a + 2 * b + 3 * c, // 新a
    a, // 新b
    b, // 新c
    i + 1, // 下一轮计算过程的下标
    n // 需要计算的轮数
  );
}

console.log(f2(4));
