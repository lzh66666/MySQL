#二、分组函数

/*
分类：
 sum求和、avg平均值、max最大值、min最小值、count计算个数
 特点：
 1、sum、avg一般处理数据类型
    min、avg用来处理任何类型
 2、是否忽略null值
    以上分组函数都忽略null值
 3、可以和distinct搭配使用
 4、count函数的单独介绍
   一般使用COUNT(*)统计行数
 5、和分组函数一同查询的字段要求是group by后的字段
*/

#1简单的使用

SELECT SUM(salary) FROM employees;
SELECT AVG(salary) FROM employees;
SELECT MAX(salary) FROM employees;
SELECT MIN(salary) FROM employees;
SELECT COUNT(salary) FROM employees;

SELECT SUM(salary),AVG(salary),MAX(salary), MIN(salary),COUNT(salary) FROM employees;
SELECT SUM(salary),ROUND(AVG(salary),2),MAX(salary), MIN(salary),COUNT(salary) FROM employees;

#2、参数支持那些类型
SELECT MAX(last_name),MAX(last_name) FROM employees;

#3、是否忽略null值(忽略）
SELECT  SUM(`commission_pct`),AVG(`commission_pct`) FROM employees;

#4、和distinct搭配
SELECT SUM(DISTINCT salary),SUM(salary) FROM employees;

#5、count函数的详细介绍
SELECT COUNT(salary) FROM employees;
/*
行数的计算
效率：
MYISAM存储引擎下，COUNT(*)的效率高
INNODB存储引擎下，COUNT(*)COUNT(1)的效率差不多，比COUNT(字段)效率高
*/
SELECT COUNT(*) FROM employees;
SELECT COUNT(1) FROM employees;

#6、和分组函数一同查询的字段有限制
SELECT AVG(salary),`employee_id` FROM employees;