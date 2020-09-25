/*
 * @Author: Kaiser
 * @Date: 2020-08-13 06:58:48
 * @Last Modified by: Kaiser
 * @Last Modified time: 2020-08-14 06:39:46
 * @Description:
 */
/**
 * 生成 pascel 三角
 * 迭代计算过程
 * @param {number}} row
 */
function getPascalByIteration(row) {
  const triangle = [];
  let curRowIndex = 0;
  while (row > curRowIndex) {
    // 初始值设置
    if (!triangle[curRowIndex]) triangle[curRowIndex] = [];
    const curCol = triangle[curRowIndex];
    if (curRowIndex === 0) {
      curCol[0] = 1;
      curRowIndex++;
      continue;
    }
    let curColIndex = 0;
    // 处理当前行
    while (curRowIndex >= curColIndex) {
      // 前一行
      const preRow = triangle[curRowIndex - 1];
      curCol[curColIndex] =
        Number(preRow[curColIndex - 1] || 0) + Number(preRow[curColIndex] || 0);
      curColIndex++;
    }
    curRowIndex++;
  }
  return triangle;
}

/**
 * 获取pascel中的一个对象
 * 递归计算过程
 * @param {*} row
 * @param {*} col
 * @returns {number} 坐标对应的值
 */
function getPascalItemByRecursion(row, col) {
  // 列大于行, 返回 0
  if (col > row) return new Error('row 必须小于 row');
  // 行,列小于0, 返回 0
  if (col < 0 || row < 0) return 0;
  // 第一行, 返回 0
  if (row === 0) return 1;
  // 头 or 尾
  if (col === 0 || col === row) {
    return getPascalItemByRecursion(row - 1, row - 1);
  }
  // 中间
  return (
    getPascalItemByRecursion(row - 1, col) +
    getPascalItemByRecursion(row - 1, col - 1)
  );
}

function factorial(n) {
  return factorialIter(1, 1, n);
}

function factorialIter(product, counter, maxCount) {
  if (counter > maxCount) {
    return product;
  }
  return factorialIter(counter * product, ++counter, maxCount);
}

/**
 * 获取pascel中的一个对象
 * 迭代计算过程
 * @param {*} row
 * @param {*} col
 * @returns {number} 坐标对应的值
 * (row, col)=row!/(col!⋅(row−col)!)
 */
function getPascalItemByIteration(row, col) {
  // 列大于行, 返回 0
  if (col > row) return new Error('row 必须小于 row');
  // 行,列小于0, 返回 0
  if (col < 0 || row < 0) return 0;
  // 第一行, 返回 0
  if (row === 0) return 1;
  return factorial(row) / (factorial(row - col) * factorial(col));
}

function start(title, fun, row = 0, col = 0) {
  console.time(title);
  console.log(title, fun(row, col));
  console.timeEnd(title);
}

start('递归: ', getPascalItemByRecursion, 32, 15);
// start('迭代: ', getPascalItemByIteration, 100, 50);
