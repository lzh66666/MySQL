#进阶8：分页查询 ★
/*
 应用场景：当要显示的数据，一页显示不全，需要分页提交sql请求
 语法：
	select 查询列表
	from 表
	【（join type） join 表2
	on 连接条件
	where 筛选条件
	group by 分组字段
	having 分组后的筛选
	order by 排序的字段】
	limit 【offset】,size;
	
	offset 要显示条目的其实索引（起始索引从0开始）
	size 要显示的条目个数
	
特点：
	①limit语句放在查询语句的最后
	②公式
	要显示的页数 page，每页的条目数size
	select 查询列表
	from 表
	limit (page-1)*size,size
*/

#案例1：查询前五条员工信息
SELECT * FROM employees LIMIT 0,5;
SELECT * FROM employees LIMIT 5;

#案例2：查询第11条--第25条
SELECT * FROM employees LIMIT 10,15;

#案例3：有奖金的员工信息，并且工资较高的前10名显示出来
SELECT * 
FROM employees 
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC
LIMIT 10;



#案例：查询平均工作最低的部门信息
#方式一：
#①各部门的平均成绩
SELECT AVG(salary),department_id
FROM employees
GROUP BY department_id
#②查询①结果上的最低平均工资
SELECT MIN(ag)
FROM(
	SELECT AVG(salary) ag,department_id
	FROM employees
	GROUP BY department_id
) ag_deg
#③查询哪个部门编号的平均工资=②
SELECT AVG(salary),department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary)=(
SELECT MIN(ag)
	FROM(
		SELECT AVG(salary) ag,department_id
		FROM employees
		GROUP BY department_id
	) ag_deg
)
#④查询部门信息
SELECT d.*
FROM departments d
WHERE d.department_id = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
	HAVING AVG(salary)=(
	SELECT MIN(ag)
		FROM(
			SELECT AVG(salary) ag,department_id
			FROM employees
			GROUP BY department_id
		) ag_deg
	)
)

#方式二：
#①各部门的平均成绩
SELECT AVG(salary),department_id
FROM employees
GROUP BY department_id
#②求出最低平均工资的部门编号
SELECT department_id
FROM employees
GROUP BY department_id
ORDER BY AVG(salary)
LIMIT 1;
#③查询部门信息
SELECT *
FROM departments
WHERE department_id=(
	SELECT department_id
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary)
	LIMIT 1
);


#案例：查询平均工作最低的部门信息和该部门的平均工资
#连接查询
#①各部门的平均成绩
SELECT AVG(salary),department_id
FROM employees
GROUP BY department_id
#②求出最低平均工资的部门编号
SELECT AVG(salary),department_id
FROM employees
GROUP BY department_id
ORDER BY AVG(salary)
LIMIT 1;
#③查询部门信息
SELECT d.*,ag
FROM departments d
JOIN (
	SELECT AVG(salary) ag,department_id
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary)
	LIMIT 1
) ag_dep
ON d.`department_id` = ag_dep.department_id
