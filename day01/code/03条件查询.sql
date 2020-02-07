#进阶二：条件查询
/*

语法：
	selsect 
		查询列表
	from
		表名
	where
		筛选条件
分类：
	一、按条件表达式筛选
	条件运算符：>  <  =  <>  >=  <=
	二、按逻辑表达式筛选
	逻辑运算符：
	作用：用于连接条件表达式的
		    && || !
		    and or not
	三、模糊查询
		like
		between and
		in
		is null | is not null
*/

#一、按条件表达式筛选

#实例一：查询工资>12000的员工信息
SELECT 
	*
FROM
	employees
WHERE
	salary > 12000;
	
#案例二：查询部门编号不等于90的员工名和部门编号
SELECT
	last_name,
	department_id
FROM
	employees
WHERE
	department_id <> 90;
	
#二、按逻辑表达式筛选

#案例一：查询工资在10000到20000之间的员工名，工资及奖金
SELECT
	last_name,
	salary,
	commission_pct
FROM
	employees
WHERE
	salary>=10000 
AND 
	salary<=20000;
	
#案例二：查询部门编号不是在90到110之间，或者工资高于15000的员工信息
SELECT
	*
FROM
	employees
WHERE
	NOT(department_id>=90 AND department_id<=110)OR salary>15000;
	
#三、模糊查询

/*
like
特点：
①一般和通配符搭配使用
	通配符
	%任意多个字符，包含0个字符
	_任意单个字符 

between and
in
is null | is not null
*/

#1、like
#案例一：查询员工名中包含字符a的员工信息

SELECT
	*
FROM
	employees
WHERE
	last_name LIKE '%a%';
	
#案例二：查询员工名中第三个字符为e，第五个字符为a的员工名和工资

SELECT
	last_name,
	salary
FROM
	employees
WHERE
	last_name LIKE '__n_l%';
	
#案例三：查询员工名中第二个字符为_的员工名

SELECT
	last_name
FROM
	employees
WHERE
	#last_name like '_\_%';
	last_name LIKE '_$_%' ESCAPE '$';
	
#2、between and
/*
 ①可以提高语句的简洁度
 ②包含临界值
 ③临界值顺序不要颠倒
 
*/
#案例一：查询员工编号在100到120之间的员工信息
SELECT
	*
FROM
	employees
WHERE
	`employee_id` >= 100 && `employee_id` <= 120;
	
#=====================================================
SELECT
	*
FROM
	employees
WHERE
	`employee_id` BETWEEN 100 AND 120;
	
#3、in

/*
 含义：判断某字段的值是否属于in列表中的某一项
 特点：
	①使用in提高语句简洁度
	②in列表的值类型必须一致或兼容
	③不能使用通配符
*/
#案例：查询员工的工种编号 IT_PROG AD_VP AD_PRES的一个员工名和工种编号

SELECT
	last_name,
	job_id
FROM
	employees
WHERE
	job_id = 'IT_PROG' OR job_id = 'AD_VP' OR job_id = 'AD_PRES';
#=============================================================
SELECT
	last_name,
	job_id
FROM
	employees
WHERE
	job_id IN('IT_PROG','AD_VP','AD_PRES');

#4、is null
/*
 =或<>不能判断null值
 is null 和 is not null 可以判断null值
*/
#案例一：查询没有奖金的员工名和奖金率
SELECT
	last_name,
	commission_pct
FROM
	employees
WHERE
	commission_pct IS NULL;
	
#案例二：查询有奖金的员工名和奖金率
SELECT
	last_name,
	commission_pct
FROM
	employees
WHERE
	commission_pct IS NOT NULL;
	
#案例三：查询奖金为12000的员工名和奖金率=======以下错误
SELECT
	last_name,
	salary
FROM
	employees
WHERE
	salary IS 12000;
	
#安全等于 <=>
#案例一：查询没有奖金的员工名和奖金率
SELECT
	last_name,
	commission_pct
FROM
	employees
WHERE
	salary <=> NULL;
#案例二：查询奖金为12000的员工名和奖金率
SELECT
	last_name,
	salary
FROM
	employees
WHERE
	salary <=> 12000;
	
#is null PK <=>
/*
 is null：仅可以判断null值，可读性较高，建议使用
 <=>    : 既可以判断null值，又可以判断数值，可读性较低
*/