#进阶4：常见函数

/*
 好处：1、隐藏了实现细节 2、提高代码的重用性
 通用： select 函数名（实参列表） 【from表】
 特点：
	①叫什么（函数名）
	②干什么（函数功能）
 分类：
	1、单行函数
	如：concat、length、ifnull等
	2、分组函数
	
	功能：做统计使用，又称为统计函数、聚合函数、组函数
*/

#一、字符函数

#1、length获取参数值的字节个数
SELECT LENGTH('john');
SELECT LENGTH('卢泽华');

SHOW VARIABLES LIKE '%char%';

#2、concat 拼接字符串
SELECT  CONCAT (last_name,'_',first_name) 姓名 FROM employees;

#3、upper、lower
SELECT UPPER('John');
SELECT LOWER('John');
SELECT  CONCAT (UPPER(last_name),'_',LOWER(first_name)) 姓名 FROM employees;

#4、substr、substring
#注意：索引从0开始
SELECT SUBSTR('李莫愁爱上了路站元',7) out_put;
SELECT SUBSTR('李莫愁爱上了路站元',1,3) out_put;
#案例：姓名中首字母大写，其他字符小写然后用拼接显示出来
SELECT  CONCAT (UPPER(SUBSTR(last_name,1,1)),'_',LOWER(SUBSTR(last_name,2))) 姓名 FROM employees;

#5、instr:返回子串第一次出现的索引，如果找不到则返回0
SELECT INSTR('杨不悔爱上了尹柳霞','尹柳霞') AS out_put;

#6、trim
SELECT LENGTH(TRIM('    张翠三    ')) AS out_put;
SELECT TRIM('a' FROM'aaaaaaaaaaaa张aa翠aaaa三aaaaaaaaaaaaaa') AS out_put;

#7、lpad:用指定的字符实现左填充指定长度
SELECT LPAD('殷素素',10,'*') AS out_put;

#8、rpad:用指定的字符实现右填充指定长度
SELECT RPAD('殷素素',12,'ab') AS out_put;

#9、replace 替换
SELECT REPLACE('周芷若周芷若周芷若周芷若周芷若周芷若','周芷若','赵敏') AS out_put;

#二、数学函数

#round 四舍五入
SELECT ROUND(1.65);
SELECT ROUND(1.567,2);

#ceil 向上取整    返回≤该参数的最小整数
SELECT CEIL(-1.30);

#floor 向下取整
SELECT FLOOR(-9.99);

#truncate 截断
SELECT TRUNCATE(1.652656,1);

#mod 取余
SELECT 10 MOD 3;
SELECT MOD(10,3);

#三、日期函数

#datediff
SELECT DATEDIFF(NOW(),'1997-10-22');

#now()	返回当前日期+时间
SELECT NOW();

#curdate()	返回当前日期（不包含时间）
SELECT CURDATE();

#curtime	返回当前时间
SELECT CURTIME();

#可以获取指定的部分，年。月、日、小时、分钟、秒（YEAR、MONTH、DAY、HOUR、SECOND）
SELECT YEAR(NOW()) 年;
SELECT YEAR(NOW()) 年;
SELECT YEAR('1998-01-02') 年;
SELECT YEAR(hiredate) 年 FROM employees;
SELECT MONTH(NOW());
SELECT MONTHNAME(NOW());#英文

#str_to_date	将字符转换成日期
SELECT STR_TO_DATE('2020-2-3','%Y-%c-%d') AS out_put;
#查询入职日期为1992-6-3的员工信息
SELECT * FROM employees WHERE hiredate = '1992-4-3';
SELECT * FROM employees WHERE hiredate = STR_TO_DATE('4-3 1992','%c-%d %Y');

#date_format 将日期转换成字符
SELECT DATE_FORMAT(NOW(),'%y年%m月%d日') AS out_put;

#查询有奖金的员工名和入职日期（xx月xx日 xx年）
SELECT last_name,DATE_FORMAT(hiredate,'%m月%d日 %Y') 入职日期
FROM employees
WHERE commission_pct IS NOT NULL;

#四、其他函数
SELECT VERSION();
SELECT DATABASE();
SELECT USER();

#五、流程控制函数
#1、if函数：if else效果
SELECT IF(10>5,'大','小');
SELECT last_name,commission_pct,IF(commission_pct IS NULL,'没奖金，呵呵','有奖金，嘻嘻')
FROM employees;

#2、case函数的使用一：switch case 的效果
/*
switch(常量或表达式）{
	case 常量1:语句1;break;
	...
	default:语句n;break;
}

mysql中
case 要判断的字段或表达式
when 常量1 then 要显示的语句1或值1;
when 常量2 then 要显示的语句2或值2;
...
else 要显示的语句n或值n;
*/

/*
 部门号 = 30  显示原工资的1.1倍
 部门号 = 40  显示原工资的2.2倍
 部门号 = 50  显示原工资的3.3倍
 其他部门不变
 end
*/

SELECT salary 原始工资,department_id,
CASE department_id
WHEN 30 THEN salary*1.1
WHEN 40 THEN salary*2.2
WHEN 50 THEN salary*3.3
ELSE salary
END AS 新工资
FROM employees;

#3case函数的使用二：类似于   多重if

/*
if(条件1){
	语句1;
}else if(条件2){
	语句2;
}
...
else{
	语句n;
}

mysql 中

case 
when(条件2) then 要显示的值1或语句2;
when(条件2) then 要显示的值1或语句2;
...
else  要显示的值n或语句n
end
*/

#案例：查询员工的工资情况
/*
 如果工资>20000----------->显示A级别
 如果工资>15000----------->显示B级别
 如果工资>10000----------->显示C级别
 否则--------------------->显示D级别
*/
SELECT salary,
CASE
WHEN salary > 20000 THEN 'A'
WHEN salary > 15000 THEN 'B'
WHEN salary > 10000 THEN 'C'
ELSE 'D'
END AS 工资级别
FROM employees;