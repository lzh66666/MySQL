#进阶六：连接查询
/*
  含义：又称多表查询，当查询的字段来自于多个表时，就会用到连接查询
 
  笛卡尔乘积现象  表一 有m行 表二 有n行  结果：n*m行
 
  发生原因：没有有效的连接条件
  如何避免：添加有效的连接条件
  
  分类：
	按年代分类：
	sql92标准：仅仅支持内连接
	sql99标准【推荐】：支持内连接+外连接(左外和右外)+交叉连接
	
	按功能分类：
	内连接：
		等值连接
		非等值连接
		自连接
	外连接：
		左外连接
		右外连接
		全外连接
	交叉连接
*/

SELECT * FROM beauty;
SELECT * FROM boys;

SELECT NAME,boyname FROM beauty,boys
WHERE beauty.boyfriend_id = boys.id;

#一、sql92标准

#1、等值连接
/*
  ①多表等值连接的结果为多表的交集部分
  ②n表连接，至少需要n-1个连接条件
  ③多表的顺序没有要求
  ④一般需要为表起别名
  ⑤可以搭配前面介绍的所有句子使用，比如：排序、筛选、分组
*/
#案例一：查询女神名和对应的男神名
SELECT NAME,boyname 
FROM beauty,boys
WHERE beauty.boyfriend_id = boys.id;

#案例二：查询员工名和对应的部门名
SELECT last_name,department_name
FROM employees,departments
WHERE employees.`department_id` = departments.`department_id`;

##2、为表起别名
/*
 好处：
       ①提高表的简洁度
       ②区分多个重名的字段
       
       
  注意：如果为表起了别名，就不能再用原来的表名去限定
*/
#查询员工名。工种号、工种名
SELECT e.last_name,e.job_id,j.job_title
FROM employees AS e,jobs AS j
WHERE e.`job_id` = j.`job_id`;

##3、两个表名的顺序是否可以调换(可以）

#查询员工名。工种号、工种名
SELECT e.last_name,e.job_id,j.job_title
FROM jobs AS j,employees AS e
WHERE e.`job_id` = j.`job_id`;

##4、可以加筛选？可以

#案例一：查询有奖金的员工名、部门名
SELECT `last_name`,`department_name`
FROM `employees` e,`departments` d
WHERE e.`department_id` = d.`department_id`
AND e.`commission_pct` IS NOT NULL;

#案例二：查询城市名中第二个字符为o的部门名和城市名
SELECT `department_name`,`city`
FROM `departments` d,`locations` l
WHERE d.`location_id` = l.`location_id`
AND city LIKE '_o%';

##5、可以加分组？

#案例一：查询每个城市的部门个数
SELECT COUNT(*) 个数,city
FROM `departments` d,`locations` l
WHERE d.`location_id` = l.`location_id`
GROUP BY city;

#案例二：查询有奖金的每个部门的部门名和部门的领导编号和该部门的最低工资
SELECT `department_name`,d.`manager_id`,MIN(`salary`)
FROM `employees` e,`departments` d
WHERE d.`department_id` = e.`department_id`
AND commission_pct IS NOT NULL
GROUP BY department_name,d.manager_id;

##6、可以加排序

#案例查询每个工种名和员工的个数，并且按员工个数降序
SELECT `job_title`,COUNT(*)
FROM `jobs` j, `employees` e
WHERE e.`job_id` = j.`job_id`
GROUP BY job_title
ORDER BY COUNT(*) DESC;

##7、可以实现三表连接

#案例：查询员工名、部门名和所在的城市
SELECT `last_name`,`department_name`,`city`
FROM `employees` e,`departments` d,`locations` l
WHERE e.`department_id` = d.`department_id`
AND   d.`location_id` = l.`location_id`
AND   city LIKE 's%'
ORDER BY department_name DESC;

#2、非等值连接
#案例一：查询员工的工资和工资级别

SELECT salary,grade_level
FROM employees e,job_grades g
WHERE salary BETWEEN g.`lowest_sal` AND g.`highest_sal`
AND g.`grade_level` = 'A';


SELECT salary,employee_id FROM employees;
SELECT * FROM job_grades;
CREATE TABLE job_grades
(grade_level VARCHAR(3),
lowest_sal INT,
highest_sal INT);

INSERT INTO job_grades
VALUES('A',1000,2999);

INSERT INTO job_grades
VALUES('B',3000,5999);

INSERT INTO job_grades
VALUES('C',6000,9999);

INSERT INTO job_grades
VALUES('D',10000,14999);

INSERT INTO job_grades
VALUES('E',15000,24999);

INSERT INTO job_grades
VALUES('F',25000,40000);


#3、自连接
#案例：查询 员工名和上级的连接
SELECT e.employee_id,e.last_name,m.employee_id,m.last_name
FROM employees e,employees m
WHERE e.`manager_id` = m.`employee_id`;