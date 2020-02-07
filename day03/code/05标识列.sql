#标识列

/*
 又称为自增长列
 含义：可以不用手动的插入值，系统提供默认的序列值
 
 特点：
 1、标识列必须和主键搭配么？不一定，但要求是一个key
 2、一个表中可以有几个标识列？至多一个
 3、标识列的类型只能是数值型
 4、标识列可以通过SET auto_increment_increment = 10;设置步长
    也可以通过手动插入值，设置起始值
*/

#一、创建表时设置标识列

SELECT * FROM tab_identity;
DROP TABLE IF EXISTS tab_identity;
CREATE TABLE tab_identity(
	id INT,
	NAME VARCHAR(20)
	
);
CREATE TABLE tab_identity(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(20)
	
);
CREATE TABLE tab_identity(
	id INT UNIQUE AUTO_INCREMENT,
	NAME VARCHAR(20),
	seat INT
	
);
TRUNCATE TABLE tab_identity;
INSERT INTO tab_identity VALUES(NULL,'john');
INSERT INTO tab_identity(NAME) VALUES('lucy');
SELECT * FROM tab_identity;

SHOW VARIABLES LIKE 'auto_increment%';

SET auto_increment_increment = 1;

#二、修改表时设置标识列
ALTER TABLE tab_identity MODIFY COLUMN id INT PRIMARY KEY AUTO_INCREMENT;

#三、修改表示删除标识列
ALTER TABLE tab_identity MODIFY COLUMN id INT;