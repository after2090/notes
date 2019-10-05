#DQL语言

#基础查询
/*
语法：
select 查询列表 from 表名;
*/
USE myemployees;

SELECT last_name FROM employees;
SELECT last_name,salary,email FROM employees;
SELECT * FROM employees;

SELECT 100;
SELECT 'john';
SELECT 100 % 98;

SELECT VERSION();

# 起别名
SELECT 100 % 98 AS 结果;
SELECT last_name AS 姓, first_name AS 名 FROM employees;

SELECT last_name 姓, first_name 名 FROM employees;

SELECT salary AS 'out put' FROM employees;

# 去重
SELECT DISTINCT department_id FROM employees;

# +号的作用
/*
只是运算符
*/
SELECT last_name + first_name AS 姓名 FROM employees;  # 不能查出姓名

SELECT CONCAT('a','b','c') AS result;
SELECT CONCAT(last_name, first_name) AS result FROM employees;

# 其他与练习
DESC departments;  # 查看表的状态

SELECT * FROM `departments`;
SELECT DISTINCT job_id FROM employees;
SELECT CONCAT(`employee_id`, ',', `last_name`, ',', `email`, IFNULL(`commission_pct`, 0)) AS out_put FROM employees;
SELECT IFNULL(`commission_pct`, 0) AS rate, `commission_pct` FROM employees;
	

/*此处为query002内容*/


#排序查询
/*
select 查询列表
from 表
(where 筛选条件)
order by 排序列表 asc|desc

asc代表升序，desc代表降序，如果不写，默认升序
order by 单个字段、多个字段、表达式、函数、别名
order by 一般放在查询语句的最后面，limit子句除外
*/

SELECT * FROM employees ORDER BY salary DESC;
SELECT * FROM employees ORDER BY salary ASC;

SELECT * FROM employees WHERE `department_id`>=90 ORDER BY `hiredate`;

SELECT *,salary*12*(1+IFNULL(commission_pct,0)) FROM employees
ORDER BY salary*12*(1+IFNULL(commission_pct,0)) ASC;

SELECT *,salary*12*(1+IFNULL(commission_pct,0)) AS annual_salary
FROM employees
ORDER BY salary_year ASC;

SELECT last_name, salary
FROM employees
ORDER BY LENGTH(last_name) DESC;

SELECT * 
FROM employees
ORDER BY salary ASC, employee_id DESC;

SELECT last_name, department_id, salary*12*(1+IFNULL(commission_pct,0)) AS annual_salary
FROM employees
ORDER BY annual_salary DESC, last_name ASC;

SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 8000 AND 17000
ORDER BY salary DESC;

SELECT * FROM employees
WHERE email LIKE '%e%'
ORDER BY LENGTH(email) DESC, department_id ASC;


/*
常见函数
	字符函数
	length
	concat
	substr
	instr
	trim
	upper
	lower
	lpad
	rpad
	replace
	
	数学函数
	round
	ceil
	floor
	truncate
	mod
	
	日期函数
	now
	curdate
	curtime
	year
	month
	monthname
	day
	hour
	minute
	second
	str_to_date
	date_format
	
	其他函数
	version
	datebase
	user
	
	控制函数
	if
	case
*/

# 一、字符函数
# 1.length 获取参数值的字节个数
SELECT LENGTH('john');
SELECT LENGTH('张三丰hahaha');

SHOW VARIABLES LIKE '%char%';

# 2.caoncat 拼接字符串
SELECT CONCAT(last_name, '_', first_name) FROM employees;

# 3.upper lower
SELECT UPPER('john');
SELECT LOWER('joHn');

SELECT CONCAT(UPPER(last_name), LOWER(first_name)) FROM employees;

# 4.substr substring
# 注意：索引从1开始
# 截取从指定索引处后面所有字符
SELECT SUBSTR('李莫愁爱上了陆展元',7) AS out_put;
# 截取从指定索引处指定字符长度的字符
SELECT SUBSTR('李莫愁爱上了陆展元', 1, 3);

SELECT CONCAT(UPPER(SUBSTR(last_name,1,1)),SUBSTR(last_name,2),'_',UPPER(SUBSTR(first_name,1,1)),SUBSTR(first_name,2))
FROM employees;

# 5. instr 返回子串第一次出现的起始索引，如果找不到返回0
SELECT INSTR('杨不悔爱上了殷六侠', '殷六侠') AS out_put;

# 6. trim 去掉前后字符 默认空格
SELECT LENGTH(TRIM('   张翠山   ')) AS out_put;
SELECT TRIM('a' FROM 'aaaaaaaaaa张aaaaaaa翠aaaaaaaaa山aaaa') AS out_put;

# 7. lpad 用指定字符实现左填充指定长度
SELECT LPAD('殷素素', 2, '*') AS out_put;

# 8. rpad 用指定字符实现右填充指定长度
SELECT RPAD('殷素素', 12, 'ab') AS out_put;

# 9. repalace 替换
SELECT REPLACE('张周芷若无忌爱上了周芷若', '周芷若', '赵敏') AS out_put;

# 二、数学函数
# round 四舍五入
SELECT ROUND(-1.65)；
SELECT ROUND(1.567, 4);

# ceil 向上取整：返回>=该参数的最小整数
SELECT CEIL(-1.00002);

# floor 向下取整：返回<=该参数的最大整数
SELECT FLOOR(-9.99);

# truncate 截断
SELECT TRUNCATE(1.65, 1);

# mod 取余
# mod(a, b): a-a/b*b
SELECT MOD(-10, -3);

# 三、日期函数
# now 返回当前系统日期+时间
SELECT NOW();

# curdate 返回当前系统日期，不包含时间
SELECT CURDATE();

# curtime 返回当前时间，不包含日期
SELECT CURTIME();

# 可以获取指定的部分，年、月、日、小时、分钟、秒
SELECT YEAR(NOW()) AS YEAR;
SELECT YEAR(hiredate) FROM employees;
SELECT MONTH(NOW());
SELECT MONTHNAME(NOW());

# str_to_date 将日期格式的字符转换成指定格式的日期
SELECT STR_TO_DATE('1998-3-2', '%Y-%c-%d') AS out_put;
SELECT * FROM employees WHERE hiredate = '1992-4-3';
SELECT * FROM employees WHERE hiredate = STR_TO_DATE('4-3 1992', '%c-%d %Y');

# date_format 将日期转换成字符
SELECT DATE_FORMAT(NOW(), '%y年%m月%d日') AS out_put;
SELECT last_name, DATE_FORMAT(hiredate, '%m月/%d日 %y年')
FROM employees WHERE commission_pct IS NOT NULL;

# 四、其他函数
SELECT VERSION();
SELECT DATABASE();
SELECT USER();

# 五、流程控制函数
# 1.if函数 if else 的效果
SELECT IF(10>5, '大', '小');
SELECT last_name, commission_pct, IF(commission_pct IS NULL, '没奖金', '有奖金')
FROM employees;

# 2.case函数（或结构）
/*
switch case 的效果
case 要判断的字段或表达式
when 常量1 then 要显示的值1或语句1(;)
when 常量2 then 要显示的值2或语句2(;)
...
else 要显示的值n或语句n;
end
*/
SELECT last_name, salary, department_id,
CASE department_id
WHEN 30 THEN salary*1.1
WHEN 40 THEN salary*1.2
WHEN 50 THEN salary*1.3
ELSE salary
END AS new_salary
FROM employees;
/*
类似于多重if
case
when 条件1 then 要显示的值1或语句1(;)
when 条件2 then 要显示的值2或语句2(;)
...
else 要显示的值n或语句n;
end
*/

SELECT last_name, salary,
CASE
WHEN salary>20000 THEN 'A'
WHEN salary>15000 THEN 'B'
WHEN salary>10000 THEN 'C'
ELSE 'D'
END AS level_salary
FROM employees;

# 练习
SELECT NOW();

SELECT employee_id, last_name, salary, salary*1.2 AS new_salary
FROM employees;

SELECT last_name, LENGTH(last_name)
FROM employees
ORDER BY SUBSTR(last_name, 1, 1);

SELECT CONCAT(last_name,' earns ',salary,' monthly but wants ',salary*3) AS dream_salary
FROM employees
WHERE salary = 24000;

SELECT job_id AS job_level,
CASE job_id
WHEN 'AD_PRES' THEN 'A'
WHEN 'ST_MAN' THEN 'B'
WHEN 'IT_PROG' THEN 'C'
WHEN 'SA_REP' THEN 'D'
WHEN 'ST_CLERK' THEN 'E'
END AS GRADE
FROM employees;


# 分组函数
/*
用作统计使用，又称为聚合函数或统计函数或组函数
分类：
sum 求和
avg 平均值
max 最大值
min 最小值
count 计算个数

1. sum avg 一般用于处理数值型
   max min count 可以处理任何类型

2. 是否忽略null值:以上分组函数都忽略null值

3. 可以和distinct搭配实现去重的运算

4. count函数
一般使用count(*)统计行数

5. 和分组函数一同查询的字段要求是group by后的字段

*/

# 1. 简单使用
SELECT SUM(salary) FROM employees;
SELECT AVG(salary) FROM employees;
SELECT MIN(salary) FROM employees;
SELECT MAX(salary) FROM employees;
SELECT COUNT(salary) FROM employees;

# 2. 参数支持哪些类型

SELECT SUM(last_name), AVG(last_name) FROM employees;

SELECT MAX(last_name), MIN(last_name) FROM employees;
SELECT MAX(hiredate), MIN(hiredate) FROM employees;

SELECT COUNT(commission_pct) FROM employees;

# 3. 是否忽略null
SELECT SUM(commission_pct), AVG(commission_pct),
SUM(commission_pct)/35, AVG(commission_pct)/107
FROM employees;

SELECT MAX(commission_pct), MIN(commission_pct) FROM employees;

# 4. 和distinct搭配
SELECT SUM(DISTINCT salary), SUM(salary) FROM employees;

SELECT COUNT(DISTINCT salary), COUNT(salary) FROM employees;

# 5. count函数详细介绍
SELECT COUNT(salary) FROM employees;
SELECT COUNT(*) FROM employees; # 用于统计行数
SELECT COUNT('崔侠') FROM employees;
/*
效率：
MYISAM存储引擎下，count(*)效率高
INNODB存储引擎下，count(*)和count(1)效率差不多，比count(字段)高
*/
SELECT COUNT(salary) FROM employees;

# 6. 和分组函数一同查询的字段有限制
SELECT AVG(salary), employee_id FROM employees;

# 练习
SELECT MAX(salary),MIN(salary),ROUND(AVG(salary), 2),SUM(salary)
FROM employees;

SELECT DATEDIFF(NOW(), '1995-4-3');
SELECT DATEDIFF(MAX(hiredate),MIN(hiredate)) AS difference
FROM employees;

SELECT COUNT(*)
FROM employees
WHERE department_id = 90;


# 分组查询
/*
select 分组函数，列（要求出现在group by的后面）
from 表
(where 筛选条件)
group by 分组的列表
(order by 子句)
注意：查询列表必须特殊，要求是分组函数和group by后出现的字段

1.分组查询中的筛选条件分为两类
			数据源			位置				关键字
分组前筛选	原始表			group by子句前	where
分组后筛选	分组后的结果集	group by子句后	having
(1)分组函数做条件肯定是放在having子句中
(2)能用分组前筛选的，优先考虑使用分组前筛选

2.group by 子句支持单个字段分组，多个字段分组（多个字段之间用逗号隔开没有顺序要求），表达式或函数（用得较少）

3.也可以添加排序（排序放在整个分组查询的最后）
*/

# 简单分组查询
SELECT MAX(salary), job_id
FROM employees
GROUP BY job_id;

SELECT COUNT(*), location_id
FROM departments
GROUP BY location_id;

SELECT ROUND(AVG(salary),2), department_id
FROM employees
WHERE email LIKE '%a%'
GROUP BY department_id

SELECT MAX(salary), manager_id
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY manager_id;

# 添加复杂的筛选条件
# 添加分组后的筛选
# 查询那个部门的员工个数>2
# 先查询每个部门员工数
SELECT COUNT(*), department_id
FROM employees
GROUP BY department_id;
# 根据上一步结果进行筛选
SELECT COUNT(*), department_id
FROM employees
GROUP BY department_id
HAVING COUNT(*)>2;

# 查询每个工种有奖金的员工的最高工资>12000的工种编号和最高工资
# ①查询每个工种有奖金的员工的最高工资
SELECT job_id, MAX(salary)
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY job_id;
# ②根据①的结果继续筛选，最高工资>12000
SELECT job_id, MAX(salary)
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY job_id
HAVING MAX(salary)>12000;

/*
查询领导编号>102的每个领导手下的最低工资>5000的领导编号是哪个及其最低工资
*/
SELECT manager_id, MIN(salary)
FROM employees
WHERE manager_id>102
GROUP BY manager_id
HAVING MIN(salary)>5000;

# 按表达式或函数分组

# 按员工姓名长度分组，查询每一组员工个数，筛选员工个数>5的有哪些
SELECT COUNT(*) AS c, LENGTH(last_name) AS len_name
FROM employees
GROUP BY len_name
HAVING c>5;

# 按多个字段分组

# 查询每个部门每个工种员工的平均工资
SELECT AVG(salary), department_id, job_id
FROM employees
GROUP BY department_id, job_id;

# 添加排序
SELECT AVG(salary), department_id, job_id
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id, job_id
HAVING AVG(salary)>10000
ORDER BY AVG(salary) DESC;

# 练习
SELECT job_id, MAX(salary), MIN(salary), AVG(salary), SUM(salary)
FROM employees
GROUP BY job_id
ORDER BY job_id ASC;

SELECT MAX(salary) - MIN(salary) AS difference
FROM employees;

SELECT manager_id, MIN(salary)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN(salary)>=6000;

SELECT department_id,COUNT(*),AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY AVG(salary) DESC;

SELECT COUNT(*),job_id
FROM employees
GROUP BY job_id;


# 连接查询
/*
又称多表查询，当查询的字段来自多个表时，就会用到连接查询

笛卡尔乘积现象：表1有m行，表2有n行，结果=m*n行
发生原因：没有有效的连接条件
如何避免：添加有效的连接条件

分类：
	按年代分类：
	sql92标准：仅仅支持内连接
	sql99标准（推荐）：支持内连接+外连接（左外和右外）+交叉连接
	
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

SELECT NAME,boyName FROM beauty, boys
WHERE beauty.boyfriend_id = boys.id;

#一、sql92标准
/*
（1）多表等值连接的结果为多表的交集部分
（2）n表连接，至少需要n-1个连接条件
（3）多表的顺序没有要求
（4）一般需要为表起别名
（5）可以搭配前面的所有子句使用，如排序、分组、筛选
*/
# 1. 等值连接
SELECT NAME,boyName
FROM beauty, boys
WHERE beauty.boyfriend_id = boys.id;

SELECT last_name,department_name
FROM employees,departments
WHERE employees.`department_id`=departments.`department_id`;

#为表起别名
/*
提高语句的简洁度
区分多个重名的字段
注意：如果为表起了别名，则查询字段就不能使用原来的表名去限定
*/
SELECT last_name,e.job_id,job_title
FROM employees AS e,jobs AS j
WHERE e.`job_id`=j.`job_id`;

#两个表的顺序可以调换
SELECT last_name, e.job_id, job_title
FROM jobs AS j, employees AS e
WHERE j.`job_id`=e.`job_id`;

#可以加筛选
SELECT last_name, department_name, commission_pct
FROM employees e, departments d
WHERE e.`department_id` = d.`department_id`
AND e.`commission_pct` IS NOT NULL;

SELECT department_name, city
FROM departments d, locations l
WHERE d.`location_id`=l.`location_id`
AND city LIKE '_o%';

#可以加分组
SELECT COUNT(*) AS cnt, city
FROM departments d, locations l
WHERE d.`location_id` = l.`location_id`
GROUP BY city;

SELECT department_name,d.manager_id,MIN(salary)
FROM departments d, employees e
WHERE d.`department_id` = e.`department_id`
AND commission_pct IS NOT NULL
GROUP BY department_name, d.manager_id;

#可以加排序
SELECT job_title,COUNT(*) cnt
FROM jobs j, employees e
WHERE j.`job_id` = e.`job_id`
GROUP BY job_title
ORDER BY COUNT(*) DESC;

#实现三表连接
SELECT last_name, department_name, city
FROM employees e, departments d, locations l
WHERE e.`department_id` = d.`department_id`
AND d.`location_id` = l.`location_id`
AND city LIKE 's%'
ORDER BY department_name DESC;

# 2. 非等值连接
CREATE TABLE job_grades
(grade_level VARCHAR(3),
 lowest_sal  INT,
 highest_sal INT);

INSERT INTO job_grades
VALUES ('A', 1000, 2999);

INSERT INTO job_grades
VALUES ('B', 3000, 5999);

INSERT INTO job_grades
VALUES('C', 6000, 9999);

INSERT INTO job_grades
VALUES('D', 10000, 14999);

INSERT INTO job_grades
VALUES('E', 15000, 24999);

INSERT INTO job_grades
VALUES('F', 25000, 40000);

SELECT * FROM job_grades;

SELECT salary, grade_level
FROM employees e, job_grades g
WHERE e.`salary` BETWEEN g.`lowest_sal` AND g.`highest_sal`
AND g.grade_level = 'A';

# 3. 自连接
SELECT e.employee_id,e.last_name,m.employee_id,m.last_name
FROM employees e, employees m
WHERE e.`manager_id` = m.`employee_id`;

# 练习
SELECT MAX(salary), AVG(salary)
FROM employees;

SELECT job_id
FROM jobs
WHERE job_id LIKE '%a%e%';

SELECT PASSWORD('李明');
SELECT MD5('李明');

SELECT last_name, e.department_id, department_name
FROM `employees` e,`departments` d
WHERE e.`department_id` = d.`department_id`;

SELECT job_id,location_id
FROM employees e, departments d
WHERE e.`department_id` = d.`department_id`
AND e.`department_id` = 90;

SELECT job_title, department_name, MIN(salary)
FROM employees e, departments d, jobs j
WHERE e.`department_id` = d.`department_id`
AND e.`job_id` = j.`job_id`
GROUP BY job_title, department_name;

SELECT country_id
FROM departments d, locations l
WHERE d.`location_id` = l.`location_id`
GROUP BY country_id
HAVING COUNT(*)>2;

SELECT e.last_name, e.employee_id, m.last_name, m.employee_id
FROM employees e, employees m
WHERE e.`manager_id` = m.`employee_id`;


# sql99语法
/*
语法：
select 查询列表
from 表1 别名 [连接类型]
join 表2 别名
on 连接条件
[where 筛选条件]
[group by]
[having]
[order by]

分类：
内连接 * inner
外连接
	左外 * left [outer]
	右外 * right [outer]
	全外 full [outer]
交叉连接 cross

*/

/*
一 内连接
select 查询列表
from 表1 别名
inner join 表2 别名
on 连接条件

分类：
等值
非等值
自连接

特点：
(1)添加排序、分组、筛选
(2)inner可以省略
(3)筛选条件放在where后面，连接条件放在on后面，提高分离性，便于阅读
(4)inner join连接和sql92中的等值连接效果一样，查询多表的交集
*/

# 1. 等值连接
SELECT last_name, department_name
FROM employees e
INNER JOIN departments d
ON e.`department_id`= d.`department_id`;

SELECT last_name, job_title
FROM employees e
INNER JOIN jobs j
ON e.`job_id`=j.`job_id`
WHERE last_name LIKE '%e%';

SELECT city, COUNT(*)
FROM departments d
INNER JOIN locations l
ON d.`location_id`=l.`location_id`
GROUP BY city
HAVING COUNT(*)>3;

SELECT department_name, COUNT(*)
FROM departments d
INNER JOIN employees e
ON d.`department_id`=e.`department_id`
GROUP BY department_name
HAVING COUNT(*)>3
ORDER BY COUNT(*) DESC;

SELECT last_name,department_name,job_title
FROM employees e
INNER JOIN departments d ON e.`department_id`=d.`department_id`
INNER JOIN jobs j ON e.`job_id`=j.`job_id`
ORDER BY department_name DESC;

# 2.非等值连接
SELECT salary, grade_level
FROM employees e
INNER JOIN job_grades g
ON e.`salary` BETWEEN g.`lowest_sal` AND g.`highest_sal`;

SELECT COUNT(*), grade_level
FROM employees e
INNER JOIN job_grades g
ON e.`salary` BETWEEN g.`lowest_sal` AND g.`highest_sal`
GROUP BY grade_level
HAVING COUNT(*) > 20
ORDER BY COUNT(*) DESC;

# 3. 自连接
SELECT e.last_name, m.last_name
FROM employees e
INNER JOIN employees m
ON e.`manager_id` = m.`employee_id`
WHERE e.`last_name` LIKE '%k%';

# 二、外连接
/*
用于查询一个表中有，另一个表中没有的记录

特点：
1. 外连接的查询结果为主表中的所有记录
	如果从表中有和它匹配的，则显示匹配的值
	如果从表中没有和它匹配的，则显示NULL
	外连接查询结果=内连接结果+主表中有而从表没有的记录
2. 左外连接，left join左边的是主表
   右外连接，right join右边的是主表
3. 左外和右外交换两个表的顺序，可以实现同样的效果
*/

SELECT * FROM boys;
SELECT * FROM beauty;
# 左外连接
SELECT b.name
FROM beauty b
LEFT OUTER JOIN boys bo
ON b.`boyfriend_id` = bo.`id`
WHERE bo.`id` IS NULL;
# 右外连接
SELECT b.name
FROM boys bo
RIGHT OUTER JOIN beauty b
ON b.`boyfriend_id` = bo.`id`
WHERE bo.`id` IS NULL;

SELECT d.*, e.`employee_id`
FROM departments d
LEFT OUTER JOIN employees e
ON d.`department_id` = e.`department_id`
WHERE e.`employee_id` IS NULL;
GROUP BY d.`department_id`
HAVING COUNT(*)=1;

# 全外连接（不支持）

# 交叉连接（笛卡尔乘积）
SELECT b.*, bo.*
FROM beauty b
CROSS JOIN boys bo;

# sql92 和 sql99
/*
功能：sql99支持的较多
可读性：sql99实现连接条件和筛选条件的分离，可读性较高
*/

SELECT *
FROM beauty;

SELECT b.`id`, b.`name`, bo.*
FROM beauty b
LEFT OUTER JOIN boys bo
ON b.`boyfriend_id` = bo.`id`
WHERE b.`id` > 3;

SELECT l.`city`, d.*
FROM departments d
RIGHT OUTER JOIN locations l
ON d.`location_id` = l.`location_id`
WHERE d.`department_id` IS NULL;

SELECT d.`department_name`, e.*
FROM departments d
LEFT OUTER JOIN employees e
ON d.`department_id` = e.`department_id`
WHERE d.`department_name` IN ('SAL', 'IT');


# 子查询
/*
含义：
出现在其他语句中的select语句，成为子查询或内查询
外部的查询语句，成为主查询或外查询

分类：
按子查询出现的位置：
	select后面
		仅支持标量子查询
	from后面
		支持表子查询
	where或having后面 ☆
		标量子查询 ☆
		列子查询 ☆
		行子查询（较少）
	exists后面（相关子查询）
		表子查询
按结果集的行列数不同：
	标量子查询（结果集只有一行一列）
	列子查询（结果集一列多行）
	行子查询（结果集一行多列）
	表子查询（结果集多行多列）
*/

# 一、where或having后面
/*
# 1.标量子查询（单行子查询）
# 2.列子查询（多行子查询）
# 3.行子查询

特点：
①子查询放在小括号内
②子查询一般放在条件的右侧
③标量子查询,一般搭配单行操作符使用 > < >= <= = <>
 列子查询,一般搭配多行操作符使用 in any all
④子查询的执行优先于主查询执行，主查询的条件用到了子查询的结果

*/

# 1.标量子查询
SELECT *
FROM employees
WHERE salary > (
	SELECT salary 
	FROM employees
	WHERE last_name = 'Abel'
);

SELECT last_name, job_id, salary
FROM employees
WHERE job_id = (
	SELECT job_id
	FROM employees
	WHERE employee_id = 141
)
AND salary > (
	SELECT salary 
	FROM employees
	WHERE employee_id = 143
);

SELECT last_name, job_id, salary
FROM employees
WHERE salary = (
	SELECT MIN(salary)
	FROM employees
);

SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (
	SELECT MIN(salary)
	FROM employees
	WHERE department_id = 50
);

# 2.列子查询 in, not in, all, any/some
SELECT last_name
FROM employees
WHERE department_id IN (
	SELECT DISTINCT department_id
	FROM departments
	WHERE location_id IN (1400, 1700)
);

SELECT DISTINCT salary
FROM employees
WHERE job_id = 'IT_PROG'

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary < ANY(
	SELECT DISTINCT salary
	FROM employees
	WHERE job_id = 'IT_PROG'
)
AND job_id <> 'IT_PROG';

# 3. 行子查询
SELECT *
FROM employees
WHERE employee_id = (
	SELECT MIN(employee_id)
	FROM employees
)
AND salary = (
	SELECT MAX(salary)
	FROM employees
);
#等同于下面
SELECT *
FROM employees
WHERE (employee_id, salary) = (
	SELECT MIN(employee_id), MAX(salary)
	FROM employees
);

# 二、select后面 仅仅支持标量子查询
SELECT d.*, (
	SELECT COUNT(*)
	FROM employees e
	WHERE e.department_id = d.department_id
) 个数
FROM departments d;

SELECT department_name
FROM departments d
INNER JOIN employees e
ON d.`department_id`=e.`department_id`
WHERE e.`employee_id`=102;

# 三、from后面
/*
将子查询结果充当一张表，要求必须起别名
*/
SELECT ag_dep.*, g.grade_level
FROM(
	SELECT department_id, AVG(salary) ag
	FROM employees
	GROUP BY department_id
) ag_dep
INNER JOIN job_grades g
ON ag_dep.ag BETWEEN lowest_sal AND highest_sal;

# 四、exists后面（相关子查询）
/*
语法：
exists(完整的查询语句)
结果：
1或0
*/
SELECT EXISTS(SELECT employee_id FROM employees WHERE salary=2)

SELECT department_name
FROM departments d
WHERE EXISTS(
	SELECT *
	FROM employees e
	WHERE d.department_id=e.department_id
);

SELECT department_name
FROM departments d
WHERE department_id IN(
	SELECT DISTINCT department_id
	FROM employees
);


SELECT bo.*
FROM boys bo
WHERE bo.id NOT IN(
	SELECT boyfriend_id
	FROM beauty
);

SELECT bo.*
FROM boys bo
WHERE NOT EXISTS(
	SELECT boyfriend_id
	FROM beauty b
)

# 练习
SELECT last_name, salary, department_id
FROM employees
WHERE department_id = (
	SELECT department_id
	FROM employees
	WHERE last_name = 'zlotkey'
);

SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (
	SELECT AVG(salary)
	FROM employees
);

SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id

SELECT employee_id, last_name, salary, e.department_id
FROM employees e
INNER JOIN(
	SELECT department_id, AVG(salary) ag
	FROM employees
	GROUP BY department_id
) ag_dep
ON e.department_id = ag_dep.department_id
WHERE e.salary > ag_dep.ag;

SELECT employee_id, last_name
FROM employees
WHERE department_id IN(
	SELECT DISTINCT department_id
	FROM employees
	WHERE last_name LIKE '%u%'
);

SELECT employee_id
FROM employees
WHERE department_id IN(
	SELECT department_id
	FROM departments
	WHERE location_id = 1700
);


SELECT last_name, salary
FROM employees
WHERE manager_id IN (
	SELECT employee_id
	FROM employees
	WHERE last_name = 'K_ing'
);

SELECT CONCAT(first_name, '.',last_name)
FROM employees
WHERE salary = (
	SELECT MAX(salary)
	FROM employees
);


# 分页查询 ☆
/*
应用场景：当要显示的数据，一页显示不全，需要分页提交sql请求
语法：
	select 查询列表
	from 表
	[join type join 表2
	on 连接条件
	where 筛选条件
	group by 分组字段
	having 分组后的筛选
	order by 排序的字段]
	limit [offset,] size;
	
	offset:要显示条目的起始索引（从0开始）
	size 要显示的条目个数
特点：
1.limit语句放在查询语句的最后
2.公式:
要显示的页数 page，每页的条目数 size
select 查询列表
from 表
limit (page-1)*size, size;
*/

SELECT *
FROM employees
LIMIT 5;

SELECT *
FROM employees
LIMIT 10,15;

SELECT *
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC
LIMIT 10;

# 子查询经典案例
SELECT last_name, salary
FROM employees
WHERE salary = (
	SELECT MIN(salary)
	FROM employees
);

SELECT *
FROM departments
WHERE department_id = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary)
	LIMIT 1
);

SELECT d.*, ag
FROM departments d
JOIN (
	SELECT department_id, AVG(salary) ag
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary)
	LIMIT 1
) ag_dep
ON d.department_id = ag_dep.department_id;

SELECT *
FROM jobs
WHERE job_id = (
	SELECT job_id
	FROM employees
	GROUP BY job_id
	ORDER BY AVG(salary) DESC
	LIMIT 1
);

SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
HAVING AVG(salary) > (
	SELECT AVG(salary)
	FROM employees
);

SELECT *
FROM employees
WHERE employee_id IN (
	SELECT DISTINCT manager_id
	FROM employees
)

SELECT MIN(salary)
FROM employees
WHERE department_id = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
	ORDER BY MAX(salary)
	LIMIT 1
)

SELECT e.last_name, e.department_id, e.email, e.salary
FROM employees e
INNER JOIN departments d
ON e.employee_id = d.manager_id
WHERE e.department_id = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary) DESC
	LIMIT 1
)


# 联合查询
/*
union 将多条查询语句的结果合并成一个结果

语法：
查询语句1
union
查询语句2
union
...

应用场景：
要查询的结果来自多个表，且没有直接的连接关系，但查询的信息一致

特点：
1.要求多条查询语句的查询列数一致
2.要求多条查询语句的每一列的类型和顺序最好一致
3.union默认去重，union all不去重
*/
SELECT *
FROM employees
WHERE email LIKE '%a%'
OR department_id > 90

SELECT * FROM employees WHERE email LIKE '%a%'
UNION
SELECT * FROM employees WHERE department_id > 90


#DML语言
/*
数据操作语言
插入 insert
修改 update
删除 delete
*/

#一、插入语句
#方式一：经典方式
/*
语法：
insert into 表名(列名，...)
values(值1，...);
*/

#1.插入的值的类型要与列的类型一致或兼容
INSERT INTO beauty(id,NAME,sex,borndate,phone,photo,boyfriend_id)
VALUES(13,'唐艺昕','女','1990-4-23','18988888888',NULL,2);

#2.不可以为null的列必须插入值，可以为null的列如何插入值
#方式一
INSERT INTO beauty(id,NAME,sex,borndate,phone,photo,boyfriend_id)
VALUES(13,'唐艺昕','女','1990-4-23','18988888888',NULL,2);
#方式二
INSERT INTO beauty(id,NAME,sex,phone)
VALUES(13,'唐艺昕','女','18988888888');

#3.列的顺序是否可以调换：可以
INSERT INTO beauty(NAME,sex,id,phone)
VALUES('唐艺昕','女',13,'18988888888');

#4.列数和值的个数必须一致

#5.可以省略列名，默认所有列，而且列的顺序和表中列的顺序一致
INSERT INTO beauty
VALUES(...);

#方式二
/*
语法：
insert into 表名
set 列名=值,列名=值
*/
INSERT INTO beauty
SET id=19, NAME='刘涛', phone='999';

#两种方式比较
/*
1.方式一支持插入多行，方式二不支持
insert into beauty
values(...),
(...),
(...);

2.方式一支持子查询，方式二不支持
insert into beauty(id,name,phone)
select 26,'宋茜'，'118'
*/

#二、修改语句
/*
1.修改单表的记录 ☆
语法：
update 表名
set 列=新值, 列=新值, ...
where 筛选条件;

2.修改多表的记录
语法：
sql92语法
update 表1 别名, 表2 别名
set 列=值, ...
where 连接条件
and 筛选条件;

sql99语法
update 表1 别名
inner|left|right join 表2 别名
on 连接条件
set 列=值, ...
where 筛选条件;
*/

#1.修改单表的记录
UPDATE beauty
SET phone = '13899888899'
WHERE NAME LIKE '唐%'

UPDATE boys
SET boyName = '张飞', usercp = 10
WHERE id = 2

#2.修改多表的记录
UPDATE boys bo
INNER JOIN beauty b
ON bo.id=b.boyfriend_id
SET b.phone='114'
WHERE bo.boyName='张无忌'

UPDATE boys bo
RIGHT JOIN beauty b
ON bo.id=b.boyfriend_id
SET b.boyfriend_id=2
WHERE bo.id IS NULL;

#三、删除语句
/*
方式一：delete
语法：
1.单表删除 ☆
delete from 表名
where 筛选条件;
2.多表删除
sql92语法
delete 表?别名
from 表1 别名, 表2 别名
where 连接条件
and 筛选条件;

sql99语法
delete 表?别名
from 表1 别名
inner|left|right join 表2 别名
on 连接条件
where 筛选条件;

方式二： truncate
语法：
truncate table 表名;
*/
#方式一
#1.单表删除
DELETE FROM beauty
WHERE phone LIKE '%99'

#2.多表删除
DELETE b
FROM beauty b
INNER JOIN boys bo
ON b.boyfriend_id = bo.id
WHERE bo.boyName = '张无忌';

DELETE b, bo
FROM beauty b
INNER JOIN boys bo
ON b.boyfriend_id = bo.id
WHERE bo.boyName = '黄晓明';

#方式二：truncate 只能删除整个表
TRUNCATE TABLE boys;

#两种方式的区别 ☆
/*
1.delete可以加where条件，truncate不能加
2.truncate删除，效率稍高
3.假如要删除的表中有自增长列，
如果用delete删除后，再插入数据，自增长列的值从断点开始；
如果用truncate删除后，再插入数据，自增长列的值从1开始
4.truncate删除没有返回值，delete删除有返回值
5.truncate删除不能回滚，delete删除可以回滚
*/

#练习
USE myemployees;
DESC employees;

INSERT INTO my_employees
VALUES(),(),(),(),();

INSERT INTO users
VALUES(),(),();

UPDATE my_employees
SET last_name='drelxer'
WHERE id=3;

UPDATE my_employees
SET salary=1000
WHERE salary<900;

DELETE u, m
FROM users u
INNER JOIN my_employees m
ON u.userid = m.Userid
WHERE u.userid = 'Bbiri';

TRUNCATE TABLE users
TRUNCATE TABLE my_employees;


# DDL
/*
数据定义语言
库和表的管理
一、库的管理
创建、修改、删除
二、表的管理
创建、修改、删除

创建： create
修改： alter
删除： drop
*/

#一、库的管理
#1.库的创建
/*
语法：
create database [if not exists] 库名
*/
CREATE DATABASE IF NOT EXISTS books;

#2.库的修改：可以更改库的字符集
ALTER DATABASE books CHARACTER SET gbk;

#3.库的删除
DROP DATABASE IF EXISTS books;

#二、表的管理
#1.表的创建 ☆
/*
语法：
create table 表名(
	列名 列的类型[(长度) 约束], 
	列名 列的类型[(长度) 约束], 
	列名 列的类型[(长度) 约束], 
	列名 列的类型[(长度) 约束], 
	...
)
*/

CREATE TABLE book(
	id INT, #编号
	bname VARCHAR(20), #图书名
	price DOUBLE, #价格
	authorId INT, #作者编号
	publishDate DATETIME #出版日期
);

CREATE TABLE IF NOT EXISTS author(
	id INT,
	au_name VARCHAR(20),
	nation VARCHAR(10)
);

DESC book;
DESC author;

#2.表的修改
/*
语法：
alter table 表名 add|drop|modify|change column 列名 [列类型 约束];

(1)修改列名
(2)修改列的类型或约束
(3)添加新列
(4)删除列
(5)修改表名
*/
#(1)修改列名
ALTER TABLE book CHANGE COLUMN publishDate pubDate DATETIME;
#(2)修改列的类型或约束
ALTER TABLE book MODIFY COLUMN pubdate TIMESTAMP;
#(3)添加新列
ALTER TABLE book ADD COLUMN annual DOUBLE;
#(4)删除列
ALTER TABLE book DROP COLUMN annual;
#(5)修改表名
ALTER TABLE author RENAME TO book_author;

#3.表的删除
DROP TABLE IF EXISTS book_author;

SHOW TABLES;

#通用写法：
/*
drop database if exists 旧库名;
create database 新库名;

drop table if exists 旧表名;
create table 表名(...);
*/

#4.表的复制
INSERT INTO author VALUES
(1, '村上春树', '日本'),
(2, '莫言', '中国'),
(3, '冯唐', '中国'),
(4, '金庸', '中国');

SELECT * FROM author;
SELECT * FROM copy4;

#仅仅复制表的结构
CREATE TABLE copy LIKE author;

#复制表的结构 + 数据
CREATE TABLE copy2
SELECT * FROM author;

#只复制部分数据
CREATE TABLE copy3
SELECT id, au_name
FROM author
WHERE nation = '中国';

#仅仅复制某些字段
CREATE TABLE copy4
SELECT id, au_name
FROM author
WHERE 0;

#练习
USE test;

CREATE TABLE dept1(
	id INT(7),
	NAME VARCHAR(25)
);

CREATE TABLE dept2
SELECT department_id, department_name
FROM myemployees.departments;

CREATE TABLE emp5(
	id INT(7),
	first_name VARCHAR(25),
	last_name VARCHAR(25),
	dept_id INT(7)
);

ALTER TABLE emp5 MODIFY COLUMN last_name VARCHAR(50);
CREATE TABLE employees2 LIKE myemployees.`employees`;
DROP TABLE IF EXISTS emp5;
ALTER TABLE employees2 RENAME TO emp5;
ALTER TABLE emp5 ADD COLUMN test_column INT;
ALTER TABLE emp5 DROP COLUMN test_column;


#常见的数据类型
/*
数值型：
	整型
	小数：
		定点数
		浮点数
字符型：
	较短的文本：char varchar
	较长的文本：text blob(较长的二进制数据如图片)
日期型
*/

#一、整型
/*
分类：
tinyint	smallint	mediumint	int/interger	bigint
1		2	 		3	   		4				8
特点：
1.如果不设置无符号还是有符号，默认是有符号
如果想设置无符号，需要添加unsigned关键字
2.如果插入数值超出整形范围，报错
3.如果不设置长度，会有默认长度
长度代表了显示的最大宽度，如果不够会用0在左边填充(zerofill)
*/
#1.如何设置无符号和有符号
CREATE TABLE tab_int(
	t1 INT(7) ZEROFILL,
	t2 INT(7) ZEROFILL
);

INSERT INTO tab_int
VALUES(123, 123);

DESC tab_int;
SELECT * FROM tab_int;
DROP TABLE IF EXISTS tab_int;
#2.如何设置无符号和有符号
INSERT INTO tab_int
VALUES(-123456, 123456789999);

#二、小数
/*
分类：
1.浮点型
float(M,D)
double(M,D)
2.定点型：更精确
dec(M,D)
decimal(M,D)
特点：
1.
M:整数部位+小数部位
D:小数部位
2.M和D都可以省略
如果是decimal，则M默认为10，D默认为0
如果是float和double，则会根据插入的数值的精度来决定精度
3.定点型的精确度较高，如果要求插入数值的精度较高如货币运算等则考虑使用
*/

CREATE TABLE tab_float(
	f1 FLOAT,
	f2 DOUBLE,
	f3 DECIMAL
);

INSERT tab_float VALUES(1523.4, 1523.4, 1523.4);
SELECT * FROM tab_float;
DROP TABLE tab_float;
DESC tab_float;

/*
原则：
所选择的类型越简单越好，能保存数值的类型越小越好
*/

#三、字符型
/*
较短的文本：
char 固定长度
varchar 可变长度

binary和varbinary用于保存较短的二进制
enum用于保存枚举
set用于保存集合

较长的文本：
text
blob(较大的二进制)

特点：
		写法			M的意思			空间的耗费		效率
char	char(M)		最大的字符数		比较耗费			高
					可以省略，默认为1

varchar	varchar(M)	最大的字符数		比较节省			低
					不可以省略

*/

#四、日期型
/*
分类：
date只保存日期
datetime保存日期+时间
timestamp保存日期+时间
time只保存时间
year只保存年

特点：
			字节		范围			时区等影响
datetime	8		1000-9999	不受
timestamp	4		1970-2038	受
*/
CREATE TABLE tab_date(
	t1 DATETIME,
	t2 TIMESTAMP
);

INSERT INTO tab_date VALUES(NOW(), NOW());

SELECT * FROM tab_date; 

SHOW VARIABLES LIKE 'time_zone';

SET time_zone='+9:00';


#常见约束
/*
含义：一种限制，用于限制表中的数据，为了保证表中数据的准确和可靠
create table 表名(
	字段名 字段类型 约束
)
分类：六大约束
	NOT NULL: 非空，保证该字段值不能为空
	比如 姓名、学号等
	DEFAULT: 默认，用于保证该字段有默认值
	比如 性别
	PRIMARY KEY: 主键，保证该字段的值具有唯一性并非空
	比如 学号、员工编号等
	UNIQUE: 唯一约束，保证该字段的值具有唯一性，可以为空
	比如 座位号
	CHECK: 检查约束(MySQL中不支持)
	FOREIGN KEY: 外键，限制两个表的关系，保证该字段的值必须来自于主表的关联列的值。
	在从表添加外键约束，引用主表中某列的值。
	比如 学生表的专业编辑安排，员工表的部门编号，员工表的工种编号

添加约束的时机：
	1.创建表时
	2.修改表时
	
约束的添加分类：
	列级约束：
		六大约束语法上都支持，但外键约束没有效果
	表级约束：
		除了非空、默认，其他的都支持
		
主键和唯一的对比：
		保证唯一性	是否允许为空		一个表中可以有多少个	是否允许组合
主键		Y			N				至多1个				允许，但不推荐
唯一		Y			Y(最多一个空)	可以有多个			允许，但不推荐

外键：
	1.要求在从表设置外键关系
	2.从表的外键列的类型和主表的关联列的类型要求一致或兼容，名称无要求
	3.主表的关联列必须是一个key(一般是主键或唯一)
	4.插入数据时，先插入主表，再插入从表
	5.删除数据时，先删除从表，再删除主表
*/

#一、创建表时添加约束
#1.添加列级约束
/*
语法：
直接在字段名和类型后面追加 约束类型
只支持：默认、非空、主键、唯一
*/

CREATE DATABASE students;
USE students;

CREATE TABLE major(
	id INT PRIMARY KEY,
	majorName VARCHAR(20)
);

CREATE TABLE stuinfo(
	id INT PRIMARY KEY, #主键
	stuName VARCHAR(20) NOT NULL, #非空
	gender CHAR(1) CHECK(gender IN ('男', '女')), #检查(mysql不支持)
	seat INT UNIQUE, #唯一
	age INT DEFAULT 18, #默认
	majorId INT REFERENCES major(id) #外键(无效)
);

DESC stuinfo;
#查看stuinfo表中所有的索引，包括主键、外键、唯一
SHOW INDEX FROM stuinfo;

#2.添加表级约束
/*
语法：在各个字段的最下面
[constraint 约束名] 约束类型(字段名)
*/
DROP TABLE IF EXISTS stuinfo;

CREATE TABLE stuinfo(
	id INT,
	stuName VARCHAR(20),
	gender CHAR(1),
	seat INT,
	age INT,
	majorId INT,
	
	CONSTRAINT pk PRIMARY KEY(id), #主键
	CONSTRAINT uq UNIQUE(seat), #唯一
	CONSTRAINT ck CHECK(gender IN ('男', '女')), #检查
	CONSTRAINT fk_stuinfo_major FOREIGN KEY(majorId) REFERENCES major(id) #外键
);


#通用写法：
CREATE TABLE IF NOT EXISTS stuinfo(
	id INT PRIMARY KEY,
	stuName VARCHAR(20) NOT NULL,
	gender CHAR(1),
	age INT DEFAULT 18,
	seat INT UNIQUE,
	majorId INT,
	CONSTRAINT fk_stuinfo_major FOREIGN KEY(majorId) REFERENCES major(id)
);


#二、修改表时添加约束
/*
1.添加列级约束
alter table 表名 modify column 字段名 字段类型 新约束;
2.添加表级约束
alter table 表名 add [constraint 约束名] 约束类型(字段名) 外键的引用;
*/
CREATE TABLE stuinfo(
	id INT,
	stuName VARCHAR(20),
	gender CHAR(1),
	seat INT,
	age INT,
	majorId INT
);
DESC stuinfo;
#1.添加非空约束
ALTER TABLE stuinfo MODIFY COLUMN stuName VARCHAR(20) NOT NULL;
#2.添加默认约束
ALTER TABLE stuinfo MODIFY COLUMN age INT DEFAULT 18;
#3.添加主键
#列级约束
ALTER TABLE stuinfo MODIFY COLUMN id INT PRIMARY KEY;
#表级约束
ALTER TABLE stuinfo ADD PRIMARY KEY(id);
#4.添加唯一
#列级约束
ALTER TABLE stuinfo MODIFY COLUMN seat INT UNIQUE;
#表级约束
ALTER TABLE stuinfo ADD UNIQUE;
#5.添加外键
ALTER TABLE stuinfo ADD CONSTRAINT fk_stuinfo_major FOREIGN KEY(majorId) REFERENCES major(id);


#三、修改表时删除约束
#1.删除非空约束
ALTER TABLE stuinfo MODIFY COLUMN stuName VARCHAR(20);
#2.删除默认约束
ALTER TABLE stuinfo MODIFY COLUMN age INT DEFAULT 18;
#3.删除主键
ALTER TABLE stuinfo MODIFY COLUMN id INT;
ALTER TABLE stuinfo DROP PRIMARY KEY;
#4.删除唯一
ALTER TABLE stuinfo DROP INDEX seat;
#5.删除外键
ALTER TABLE stuinfo DROP FOREIGN KEY fk_stuinfo_major;


#练习
ALTER TABLE emp2 MODIFY COLUMN id INT PRIMARY KEY;
ALTER TABLE emp2 ADD CONSTRAINT my_emp_id_pk PRIMARY KEY(id);

ALTER TABLE dept2 MODIFY COLUMN id INT PRIMARY KEY;
ALTER TABLE dept2 ADD CONSTRAINT my_dept_id_pk PRIMARY KEY(id);

ALTER TABLE emp2 ADD COLUMN dept_id INT;
ALTER TABLE emp2 ADD CONSTRAINT fk_emp2_dept2 FOREIGN KEY(dept_id) REFERENCES dept2(id);

/*
		位置			支持的约束类型			是否可以起约束名
列级约束	列的后面		语法都支持，外键没效果	不可以
表级约束	所有列的下面	默认和非空不支持			可以(主键没有效果)
*/

#标识列
/*
又称为自增长列
含义：可以不用手动插入值，系统提供默认的序列值

特点：
1.标识列不必须和主键搭配，但必须是一个key
2.一个表至多有一个标识列
3.标识列的类型只能是数值型
4.标识列可以通过SET auto_increment_increment=?;设置步长
可以通过手动插入值，设置起始值

*/
#一、创建表时设置标识列
CREATE TABLE tab_identity(
	id INT PRIMARY KEY AUTO_INCREMENT,
	tname VARCHAR(20)
);

INSERT INTO tab_identity VALUES(NULL, 'john');
SELECT * FROM tab_identity;
DROP TABLE IF EXISTS tab_identity;

SHOW VARIABLES LIKE '%auto_increment%';

SET auto_increment_increment = 1;

#二、修改表时设置标识列
ALTER TABLE tab_identity MODIFY COLUMN id INT PRIMARY KEY AUTO_INCREMENT;

#三、修改表时删除标识列
ALTER TABLE tab_identity MODIFY COLUMN id INT PRIMARY KEY;


# TCL
/*
Transaction Control Language 事务控制语言

事务：
一个或一组sql语句组成一个执行单元，
这个执行单元要么全部执行，
要么全部不执行。

mysql存储类型：innodb,myisam,memory等，其中innodb支持事务，myisam,memory等不支持事务

事务的ACID属性：
A 原子性(Atomicity)：事务是一个不可分割的工作单位，事务中的操作要么都发生，要么都不发生。
C 一致性(Consistenct)：事务必须使数据库从一个一致性状态变换到另外一个一致性状态。
I 隔离性(Isolation)：一个事务的执行不能被其他事务干扰。
D 持久性(Durability)：一个事务一旦被提交，它对数据库中数据的改变是永久性的。

事务的创建：
隐式事务：事务没有明显的开启和结束的标记
如insert update delete语句

显式事务：事务具有明显的开启和结束的标记
前提：必须先设置自动提交功能为禁用
set autocommit = 0; (只对当前会话有效)

步骤1：开启事务
set autocommit = 0;
start transaction; (可选)

步骤2：编写事务中的sql语句(select insert update delete 即增删改查)
语句1;
语句2;
...

步骤3：结束事务
commit; 结束事务
rollback; 回滚事务

并发问题：
脏读
不可重复读
幻读

事务的隔离级别：
					脏读		不可重复读	幻读
read uncommitted 	Y		Y			Y
read committed 		N		Y			Y
repeatable read		N		N			Y
serializable		N		N			N
mysql中默认第三个隔离级别 repeatable read
oracle中默认第二个隔离级别 read committed

查看隔离级别：
select @@tx_isolation;
设置隔离级别：
set session|global transaction isolation level 隔离级别;

设置保存点：
savepoint 节点名;
回滚到节点：
rollback to 节点名;

delete和truncate在事务使用时的区别
delete支持回滚，truncate不支持回滚
*/

SHOW ENGINES;
SHOW VARIABLES LIKE 'autocommit';

USE test;

DROP TABLE IF EXISTS account;

CREATE TABLE account(
	id INT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(20),
	balance DOUBLE
);

INSERT INTO account(username, balance)
VALUES('张无忌', 1000), ('赵敏', 1000);

SELECT * FROM account;

SET autocommit = 0;
START TRANSACTION;
UPDATE account SET balance = 1000 WHERE username = '张无忌';
UPDATE account SET balance = 1000 WHERE username = '赵敏';
ROLLBACK;

SET autocommit = 0;
START TRANSACTION;
DELETE FROM account WHERE id=2;
SAVEPOINT a; #设置保存点
DELETE FROM account WHERE id=1;
ROLLBACK TO a; #回滚到保存点


#视图
/*
含义：虚拟表，和普通表一样使用
mysql 5.1版本出现的新特性，是通过表动态生成的数据

视图与表的对比：
		创建语法的关键字	是否实际占用物理空间	使用
视图		create view	 	没有(只保存sql逻辑)	增删改查，一般不能增删改
表		create table	占用					增删改查

*/

#一、创建视图
/*
语法：
create view 视图名
as
查询语句;
*/

USE myemployees;

CREATE VIEW v1
AS
SELECT last_name,department_name,job_title
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN jobs j
ON j.job_id = e.job_id;

SELECT * 
FROM v1
WHERE last_name LIKE '%a%';


CREATE VIEW v2
AS
SELECT AVG(salary) ag, department_id
FROM employees
GROUP BY department_id;

SELECT v2.ag, g.grade_level
FROM v2
JOIN job_grades g
ON v2.`ag` BETWEEN g.`lowest_sal` AND g.`highest_sal`;

SELECT * 
FROM v2
ORDER BY ag
LIMIT 1;

#二、视图的修改
/*
方式一：
create or replace view 视图名
as
查询语句;

方式二：
alter view 视图名
as
查询语句;
*/

#三、删除视图
/*
语法：
drop view 视图名,视图名, ...;

*/

DROP VIEW v1, v2, v3;

#四、查看视图
DESC v1;
SHOW CREATE VIEW v1;

#练习
CREATE OR REPLACE VIEW emp_v1
AS
SELECT last_name, salary, email
FROM employees
WHERE phone_number LIKE '011%';

SELECT * FROM emp_v1;

CREATE OR REPLACE VIEW emp_v2
AS
SELECT MAX(salary) mx, department_id
FROM employees
GROUP BY department_id
HAVING MAX(salary)>12000

SELECT d.*, m.mx
FROM departments d
JOIN emp_v2 m
ON m.department_id = d.department_id;

#五、视图的更新
DROP VIEW v1, emp_v1;
CREATE OR REPLACE VIEW v1
AS
SELECT last_name, email, salary*12*(1+IFNULL(commission_pct, 0)) "annual salary"
FROM employees;
SELECT * FROM v1;

#1.插入
INSERT INTO v1 VALUES('张飞', 'zf@qq.com', 100000);

#2.修改
UPDATE v1 SET last_name = '张无忌' WHERE last_name = '张飞';

#3.删除
DELETE FROM v1 WHERE last_name = '张无忌';

#具备以下特点的视图不允许更新
/*
1.包含以下关键字的sql语句：分组函数,distinct,group by,having,union或union all
2.常量视图
3.select中包含子查询
4.join
5.from一个不能更新的视图
6.where子句的子查询引用了from子句中的表
*/

#练习
USE test;

CREATE TABLE bookType(
	id INT PRIMARY KEY,
	tname VARCHAR(20)
);

CREATE TABLE book(
	bid INT PRIMARY KEY,
	bname VARCHAR(20) UNIQUE NOT NULL,
	price FLOAT DEFAULT 10,
	btypeId INT,
	CONSTRAINT fk FOREIGN KEY(btypeId) REFERENCES bookType(id)
);

SET autocommit = 0;
START TRANSACTION;
INSERT INTO book VALUES(1, '小李飞刀', 100, 1);
COMMIT;

CREATE VIEW myv1
AS
SELECT bname, tname
FROM book b
JOIN bookType t
ON b.btypeid = t.id
WHERE price>100;

CREATE OR REPLACE VIEW myv1
AS
SELECT bname, tname
FROM book b
JOIN bookType t
ON b.btypeid = t.id
WHERE price BETWEEN 90 AND 120;

DROP VIEW myv1;


#变量
/*
系统变量：
	全局变量
	会话变量

自定义变量：
	用户变量
	局部变量

*/

#一、系统变量
/*
变量由系统提供，不是用户定义，属于服务器层面
使用语法：
1.查看所有的系统变量
show global|[session] variables;
2.查看满足条件的部分系统变量
show global|[session] variables like '%char%';
3.查看指定的某个系统变量的值
select @@global|[session].系统变量名;
4.为某个系统变量赋值
方式一：
set global|[session] 系统变量名 = 值;
方式二：
set @@global|[session].系统变量名 = 值;

注意：
如果是全局级别，需要加global，
如果是会话级别，需要加session，
如果不写，默认是session
*/

#1.全局变量
/*
作用域：服务器每次启动将为所有全局变量赋初始值，
针对于所有会话（连接）有效，但不能跨重启。

*/
SHOW GLOBAL VARIABLES;
SHOW GLOBAL VARIABLES LIKE '%char%';
SELECT @@global.autocommit;
SELECT @@global.tx_isolation;
SET @@global.autocommit = 0;

#2.会话变量
/*
作用域：仅仅针对于当前会话（连接）有效
*/
SHOW SESSION VARIABLES;
SHOW SESSION VARIABLES LIKE '%char%';
SELECT @@session.autocommit;
SELECT @@tx_isolation;
SET @@session.tx_isolation = 'read-uncommitted';
SET SESSION tx_isolation = 'read-committed';

#二、自定义变量
/*
变量是用户自定义的，不是由系统提供的
使用步骤：
声明
赋值
使用（查看、比较、运算等）

1.用户变量

作用域：针对于当前会话（连接）有效，同于会话变量的作用域
应用在任何地方，也就是begin end里面或begin end外面

(1)声明并初始化
set @用户变量名=值; 或
set @用户变量名:=值; 或
select @用户变量名:=值;
(2)赋值（更新用户变量的值）
方式一：set或select
set @用户变量名=值; 或
set @用户变量名:=值; 或
select @用户变量名:=值;
方式二：select into 
select 字段 into @用户变量名 from 表;
(3)使用（查看用户变量的值）
select @用户变量名;


#2.局部变量

作用域：仅仅在定义它的begin end中有效
应用在begin end中的第一句话！！！

(1)声明
declare 变量名 类型;
declare 变量名 类型 default 值;
(2)赋值
方式一：set或select
set 局部变量名=值; 或
set 局部变量名:=值; 或
select @局部变量名:=值;
方式二：select into 
select 字段 into 局部变量名 from 表;
(3)使用
select 局部变量名;

对比用户变量和局部变量：
		作用域			定义和使用的位置					语法
用户变量 当前会话			会话中的任何地方					必须加@，不用限定类型
局部变量 begin end中		只能在begin end中，且为第一句话	一般不加@，需要限定类型
*/

SET @m=1;
SET @n=2;
SET @sum=@m+@n;
SELECT @sum;

#需要在begin end中
DECLARE m INT DEFAULT 1;
DECLARE n INT DEFAULT 2;
DECLARE SUM INT;
SET SUM=m+n;
SELECT SUM;


#存储过程和函数
/*
存储过程和函数：类似于java中的方法
好处：
1.提高代码的重用性
2.简化操作
3.减少编译次数，减少和数据库的连接次数，提高效率

存储过程
含义：一组预先编译好的SQL语句的集合，可理解成批处理语句
1.提高代码的重用性
2.简化操作
3.减少编译次数，减少和数据库的连接次数，提高效率

一、创建语法
create procedure 存储过程名(参数列表)
begin
	存储过程体(一组合法的SQL语句)
end

注意：
1.参数列表包含三部分
参数模式 参数名 参数类型
如：
in stuname varchar(20)
参数模式：
in	该参数可以作为输入，也就是该参数需要调用方传入值
out	该参数可以作为输出，也就是该参数可以作为返回值
inout	该参数既可以作为输出又可以作为输出，也就是既需要传入值，又可以返回值
2.如果存储过程体只有一句话，begin end可以省略
存储过程体中的每条SQL语句的结尾要求必须加分号，
存储过程的结尾可以使用delimiter重新设置
语法：
delimiter 结束标记

二、调用语法
call 存储过程名(实参列表);

*/
SELECT * FROM admin;
#1.空参列表
DELIMITER $
CREATE PROCEDURE myp1()
BEGIN
	INSERT INTO admin(username, pasword)
	VALUES('john1', '0000'),('rose', '0000');
END $

CALL myp1()$

#2.带in模式参数的存储过程
#3.带out模式参数的存储过程
#4.带inout模式参数的存储过程

#二、删除存储过程
/*
语法：
drop procedure 存储过程名;
*/

#三、查看存储过程的信息
/*
语法：
show create procedure 存储过程名;
*/


#函数
/*
含义：一组预先编译好的SQL语句的集合，可理解成批处理语句
1.提高代码的重用性
2.简化操作
3.减少编译次数，减少和数据库的连接次数，提高效率

区别：
存储过程：可以有0个返回，也可以有多个返回，适合做批量插入、批量更新。
函数：有且仅有1个返回，适合做处理数据后返回一个结果。

一、创建语法
create function 函数名(参数列表) returns 返回类型
begin
	函数体
end

注意：
1.参数列表包含两部分：
参数名 参数类型
2.函数体：肯定会有return语句，如果没有会报错
3.函数体中仅有一句话时可以省略begin end
4.使用delimiter语句设置结束标记

二、调用语法
select 函数名(参数列表)

三、查看函数
show create function 函数名;

四、删除函数
drop function 函数名;
*/

DELIMITER $

CREATE FUNCTION test_fun1()(num1 FLOAT, num2 FLOAT) RETURNS FLOAT
BEGIN
	DECLARE sum_ FLOAT DEFAULT 0;
	SET sum_ = num1 + num2;
	RETURN sum_
END $

SELECT test_fun1(1, 2)$


#流程控制结构
/*
顺序结构：程序从上往下依次执行
分支结构：程序从两条或多条路径中选择一条去执行
循环结构：程序在满足一定条件的基础上，重复执行一段代码

一、分支结构
1.if函数
功能： 实现简单的双分支
语法：
if(表达式1, 表达式2, 表达式3)
执行顺序：
如果表达式1成立，则if函数返回表达式2的值，否则返回表达式3的值
应用：任何地方

2.case结构
情况1：类似于java中的switch语句，一般用于实现等值判断
语法：
	case 变量|表达式|字段|
	when 要判断的值 then 返回的值1或语句1;
	when 要判断的值 then 返回的值2或语句2;
	...
	else 要返回的值n或语句n;
	end case;

情况2：类似于java中的多重if语句，一般用于实现区间判断
语法：
	case
	when 要判断的条件1 then 返回的值1或语句1;
	when 要判断的条件2 then 返回的值2或语句2;
	...
	else 要返回的值n或语句n;
	end case;

特点：
(1)可以作为表达式，嵌套在其他语句中使用，可以放在任何地方
可以作为独立的语句使用，只能放在begin end中
(2)如果when中的值满足或条件成立，则执行对应的then后面的语句，并且结束case
如果都不满则，则执行else中的语句或值
(3)else可以省略，如果else省略了，并且所有when条件都不满足，则返回null

3.if结构
功能：实现多重分支

语法：
if 条件1 then 语句1;
elseif 条件2 then 语句2；
...
[else 语句n;]
end if;

应用在begin end中

二、循环结构
分类：
while loop repeat

循环控制：
iterate 类似于continue 结束本次循环，继续下一次
leave 类似于break 结束当前所在循环

1.while
语法：
[标签:] while 循环条件 do
	循环体;
end while [标签];

2.loop
语法：
[标签:] loop
	循环体;
end loop [标签];
可以用来模拟简单的死循环

3.repeat
语法：
[标签:] repeat
	循环体;
until 结束循环的条件
end repeat [标签];
*/
