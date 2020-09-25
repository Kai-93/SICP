/*
 * @Author: Kaiser
 * @Date: 2020-08-14 06:03:35
 * @Last Modified by: Kaiser
 * @Last Modified time: 2020-08-14 06:07:56
 * @Description:
 */
function factorial(n) {
  return factorialIter(1, 1, n);
}

function factorialIter(product, counter, maxCount) {
  if (counter > maxCount) {
    return product;
  }
  return factorialIter(counter * product, ++counter, maxCount);
}

console.log(factorial(3));
