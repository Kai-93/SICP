/*
 * @Author: Kaiser
 * @Date: 2020-08-10 17:51:35
 * @Last Modified by: Kaiser
 * @Last Modified time: 2020-08-11 07:41:07
 * @Description:
 */
function square(a) {
  return a * a;
}

function average(a, b) {
  return (a + b) / 2;
}

function goodEnough(guess, x) {
  return Math.abs(square(guess) - x) < 0.001;
}

function improve(guess, x) {
  return average(guess, x / guess);
}

function sqrtIter(guess, x) {
  if (goodEnough(guess, x)) {
    return guess;
  }
  return sqrtIter(improve(guess, x), x);
}

function sqrt(x) {
  return sqrtIter(1, x);
}
console.log(sqrt(4));
