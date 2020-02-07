#DDL
/*
 数据定义语言
 
 库和表的管理
 一、库的管理
 创建、修改、删除
 二、表的管理
 创建、修改、删除
 
 创建：create
 修改：alter
 删除：drop
*/

#一、库的管理
#1、库的创建
/*
语法：
create database 库名
*/

#案例：创建库Books
CREATE DATABASE IF NOT EXISTS books DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

#2、库的修改	以前可以
RENAME DATABASE books TO book;
#但可以更改库的字符集
ALTER DATABASE books CHARACTER SET utf8;

#3、库的删除
DROP DATABASE IF EXISTS books;


#二、表的管理
#1、表的创建★
/*
 create table 表名(
	列名 列的类型【(长度) 约束】,
	列名 列的类型【(长度) 约束】,
	列名 列的类型【(长度) 约束】
	...,
	列名 列的类型【(长度) 约束】
 )
*/
#案例：创建表book
CREATE TABLE IF NOT EXISTS book(
	id INT,#编号
	bName VARCHAR(20),#图书名
	price DOUBLE,#价格
	author INT,#作者编号
	publishDate DATETIME #出版日期
);

DESC book;

#案例：创建表author
CREATE TABLE IF NOT EXISTS author(
	id INT,
	au_name VARCHAR(20),
	nation VARCHAR(10)
);
DESC author;

#2、表的修改
/*
 alter table 表名 add|drop|modify|change column 列名 【类型 约束】
*/
#①修改列名
ALTER TABLE book CHANGE COLUMN publishDate pubDate DATETIME;
#②修改列的类型或约束
ALTER TABLE book MODIFY COLUMN pubdate TIMESTAMP;
#③添加新列
ALTER TABLE author ADD COLUMN annual DOUBLE;
#④删除列
ALTER TABLE author DROP COLUMN annual;
#⑤修改表名
ALTER TABLE author RENAME TO book_author;

#3、表的删除
DROP TABLE IF EXISTS book_author;
SHOW TABLES;

#通用的写法	★
DROP DATABASE IF EXISTS 旧库名;
CREATE DATABASE 新库名;

DROP TABLE IF EXISTS 旧表名;
CREATE TABLE 新表名();

#4、表的复制
SELECT * FROM author;
INSERT INTO author VALUES
(1,'村上春树','日本'),
(2,'莫言','中国'),
(3,'冯唐','中国'),
(4,'金庸','中国')
#1、仅仅复制表的结构
CREATE TABLE copy LIKE author;
#2、复制表的结构+数据
CREATE TABLE copy2
SELECT * FROM author;

#只复制数据
CREATE TABLE copy3
SELECT id,au_name
FROM author 
WHERE nation='中国';
SELECT * FROM copy3;

#仅仅复制某些字段
CREATE TABLE copy4
SELECT id,au_name
FROM author
WHERE 0;
SELECT * FROM copy4;