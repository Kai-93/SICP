/*
 * @Author: Kaiser
 * @Date: 2020-08-06 17:50:01
 * @Last Modified by: Kaiser
 * @Last Modified time: 2020-08-15 10:48:59
 * @Description: 换零钱
 */

function getCount(total, coins) {
  var count = 5;
  var countOfTotal = 0;
  for (var i = 0; i < 2; i++) {
    for (var j = 0; j < 5; j++) {
      if (50 * i + 20 * j > total) {
        break;
      }
      for (var k = 0; k < 10; k++) {
        if (50 * i + 20 * j + 10 * k > total) {
          break;
        }
        for (var m = 0; m < 20; m++) {
          if (50 * i + 20 * j + 10 * k + 5 * m > total) {
            break;
          }
          for (var n = 0; n < 100; n++) {
            if (50 * i + 20 * j + 10 * k + 5 * m + n > total) {
              break;
            }
            countOfTotal++;
            if (50 * i + 20 * j + 10 * k + 5 * m + n === total) {
              count++;
            }
          }
        }
      }
    }
  }
  console.log('换零钱 - 常规: 循环 ', countOfTotal, ' 次');
  return count;
}

let totalOfRecursion = 0;

// 缓存
let cache = {};
function saveCache(total, kindsOfCoins, count) {
  if (total && kindsOfCoins && count) {
    if (!cache[total]) cache[total] = {};
    cache[total][kindsOfCoins] = count;
  }
}

function getCountByRecursion(total, coins) {
  totalOfRecursion++;
  if (total === 0) {
    return 1;
  }
  if (total < 0) {
    return 0;
  }
  if (coins.length === 0) {
    return 0;
  }
  // 不包含当前硬币的组合的兑换次数
  const timesNotIncludingCurrentCoin = getCountByRecursion(
    total,
    coins.slice(1)
  );
  // saveCache(total, coins.slice(1).length, timesNotIncludingCurrentCoin);

  // 包含当前硬币的组合的兑换次数
  const timesIncludingCurrentCoin = getCountByRecursion(
    total - coins[0],
    coins
  );
  // saveCache(total - coins[0], coins.length, timesIncludingCurrentCoin);

  return timesNotIncludingCurrentCoin + timesIncludingCurrentCoin;
  // return (
  //   // 不包含当前硬币的组合
  //   getCountByRecursion(total, coins.slice(1)) +
  //   // 包含当前硬币的组合
  //   getCountByRecursion(total - coins[0], coins)
  // );
}

function getCountByRecursion2(amount, coins) {
  const dp = new Array(amount + 1); // 数组长度为101,保存在不同总额可以用conins中的不同面值的币兑换的种类, 下标为金额
  dp.fill(0); // 全置为0
  dp[0] = 1;
  let count = 0;
  // 遍历每一个币值
  for (let i = 0; i < coins.length; i++) {
    // 遍历从1到amount
    for (let j = 1; j <= amount; j++) {
      // 币值 <= j, 才能符合兑换的起始条件
      count++;
      if (coins[i] <= j) {
        // j币值的兑换种数 = 当前j币值的兑换种数 + j减当前币值(既余量)对应的种数
        dp[j] = dp[j] + dp[j - coins[i]];
      }
    }
  }
  console.log('换零钱 - 递归2: 循环 ', count, ' 次');
  return dp[amount];
}

function start(title, fun, total = 100, coins = [50, 20, 10, 5, 1]) {
  console.time(title);
  console.log(title, fun(total, coins), '种组合');
  console.timeEnd(title);
}

// start('换零钱 - 常规: ', getCount);
// console.log('\n');

start('换零钱 - 递归1: ', getCountByRecursion);
console.log(cache);
// console.log('换零钱 - 递归1: 循环 ', totalOfRecursion, ' 次');
// console.log('\n');

// start('换零钱 - 递归2: ', getCountByRecursion2);
