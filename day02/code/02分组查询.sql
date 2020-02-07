#进阶五：分组查询

/*
 语法：
	select 分组函数，列（要求出现在group by的后面）
	from 表
	【where 筛选条件】
	group by 分组列表
	【order by 子句】
注意：
	查询列表必须特殊，要求是分组函数和group by后出现的字段
	
特点：
	1、分组查询中的筛选条件分为两类
			数据源			位置			关键字
	分组前筛选	原始表			group by子句的前面	where
	分组后筛选	分组后的结果表		group by子句的后面	having
	
	①分组函数做条件肯定是放在having子句中
	②能用分组前筛选的，就优先考虑分组前筛选
	2、group by子句支持单个字段分组、多个字段分组（用逗号隔开没有顺序要求）、表达式或函数（较少）
	3、也可以添加排序（排序放在整个分组查询的最后）
*/
#引入：查询每个部门的平均成绩
SELECT AVG(salary) FROM employees;

#案例一：查询每个工种的最高工资
SELECT MAX(salary),job_id
FROM employees
GROUP BY job_id;

#案例二：查询每个位置上的部门个数
SELECT COUNT(*),location_id
FROM departments
GROUP BY location_id;

#添加分组前的筛选条件
#案例一：查询邮箱中包含a字符的，每个部门的平均工资

SELECT AVG(salary),department_id
FROM employees
WHERE email LIKE '%a%'
GROUP BY department_id;

#案例二：查询有奖金的每个领导手下员工最高工资
SELECT MAX(salary),manager_id
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY manager_id;

#添加分组后的筛选条件

#案例一: 查询哪个部门的员工个数>2
#①查询每个部门的员工个数
SELECT COUNT(*),department_id
FROM employees
GROUP BY department_id;
#②根据①的结果进行筛选，查询那个部门的员工个数>2
SELECT COUNT(*),department_id
FROM employees
GROUP BY department_id
HAVING COUNT(*)>2;

#案例二：查询每个工种有奖金的员工的最高工资>12000的工种编号和最高工资
#①查询每个工种有奖金的员工的最高工资
SELECT MAX(salary),job_id
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY job_id;
#②根据①的结果继续筛选，最高工资>12000
SELECT MAX(salary),job_id
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY job_id
HAVING MAX(salary) > 12000;

#案例三：查询领导编号>102的每个领导手下的最低工资>5000的领导编号是哪个，以及最低工资
#①查询每个领导手下的员工固定最低工资
SELECT MIN(salary),manager_id
FROM employees
GROUP BY manager_id
#②添加筛选条件：编号>102
SELECT MIN(salary),manager_id
FROM employees
WHERE manager_id>102
GROUP BY manager_id
#③添加筛选条件：最低工资>5000
SELECT MIN(salary),manager_id
FROM employees
WHERE manager_id>102
GROUP BY manager_id
HAVING MIN(salary) > 5000;

#按表达式或函数分组

#案例：按员工姓名的唱的分组，查询每一组员工个数，筛选员工个数>5的有哪些
#①查询每个长度的员工个数
SELECT COUNT(*) ,LENGTH(last_name) AS len_name
FROM employees
GROUP BY LENGTH(last_name);
#②添加筛选条件
SELECT COUNT(*) AS c ,LENGTH(last_name) AS len_name
FROM employees
GROUP BY LENGTH(last_name)
HAVING c > 5;

#按多个字段分组

#案例：查询每个部门每个工种的员工的平均工资
SELECT AVG(salary),department_id,job_id
FROM employees
GROUP BY department_id,job_id

#添加排序
#案例：查询每个部门每个工种的员工的平均工资，并且按平均工资的高低显示
SELECT AVG(salary),department_id,job_id
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id,job_id
HAVING AVG(salary) > 10000
ORDER BY AVG(salary)DESC;