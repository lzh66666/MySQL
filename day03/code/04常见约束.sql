#常见约束

/*
 含义：一种限制，用于限制表中的数据，为了保证表中的数据的准确性和可靠性
 
 分类：六大约束
	not null ：非空，用于保证该字段的值不能为空
	比如姓名、学号
	default：默认，用于保证该字段有默认值
	比如性别
	primary key：主键，用于保证该字段的值具有唯一性，并且非空
	比如：学号、员工编号等
	unique：唯一，用于保证该字段的值是唯一性，可以为空
	比如座位号
	check：检查约束【mysql中不支持】
	比如年龄、性别
	foreing key：外键，用于限制两个表的关系，用于保证该字段的值必须来自于主表关联列的值
		在从表添加外键约束，用于引用指标中的某列的值
	比如学生表的专业编号，员工表的部门编号，员工表的工种编号

添加约束的时机：
	1、创建表示
	2、修改表时
	
约束的添加分类：
	列级约束：
		六大约束语法上都支持，但外键约束没有效果
	表级约束：
		除了非空、默认，其他的都支持
		
主键和约束的大对比：
		保证唯一性	是否可以为空	一个表中可以有多少个	是否允许组合
	主键	    √		     ×		至多有1个		  √不推荐
	唯一	    √		     √		可以有多个		  √不推荐
	
外键：
	1、要求在从表设置外键关系
	2、从表的外键列的类型和主表的关联列的类型要求一致或兼容，名称无要求
	3、主表的关联列必须是一个key（一般是主键或唯一）
	4、插入数据时，先插入主表，在插入从表
	   删除数据时，先删除从表，再删除主表
	

	insert into major values(1,'java');
	insert into major values(2,'h5');
	delete from stuinfo;
	SELECT * FROM stuinfo;
	insert into stuinfo values(1,'john','男',null,19,1,1);
	insert into stuinfo values(1,'lily','男',null,19,2,2);
	
	DROP TABLE IF EXISTS major;
	CREATE TABLE major(
		id INT PRIMARY KEY,
		majorName VARCHAR(20)
	);
	
	DROP TABLE IF EXISTS stuinfo;
	CREATE TABLE stuinfo(
		id INT ,
		stuName VARCHAR(20),
		gender CHAR(1),
		seat INT,
		age INT,
		majorid INT,
		seat2 INT,
		
		PRIMARY KEY (id,stuName),
		UNIQUE (seat,seat2),
		CHECK(gender= '男' OR gender = '女'),
		FOREIGN KEY (majorid) REFERENCES major(id)
	);
*/

CREATE TABLE 表名(
	字段名 字段类型 列级约束,
	字段名 字段类型,
	...
	表级约束
);

#一、创建表时添加约束
#1、添加列级约束

/*
 语法：
 直接在字段名和类型后面追加约束类型即可
 只支持：默认、非空、主键、唯一
*/

DROP DATABASE students;
CREATE DATABASE students DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE students;

SELECT * FROM stuinfo;
CREATE TABLE stuinfo(
	id INT PRIMARY KEY,#外键
	stuName VARCHAR(20) NOT NULL,#非空
	gender CHAR (1) CHECK(gender='男' OR gender ='女'),#检查，mysql不支持，但不报错
	seat INT UNIQUE,#唯一
	age INT DEFAULT 18,#默认约束
	majorid INT REFERENCES major(id)#外键,列级添加不支持，但不报错
	
);

CREATE TABLE major(
	id INT PRIMARY KEY,
	majorName VARCHAR(20)
);
DESC stuinfo;

#查看stuinfo表中的所有索引，包括主键、外键、唯一键
SHOW INDEX FROM stuinfo;

#2、添加表级约束
/*
 语法：在各个字段的最下面
 【constraint 约束名】 约束类型（字段名）
*/

DROP TABLE IF EXISTS stuinfo;
CREATE TABLE stuinfo(
	id INT ,
	stuName VARCHAR(20),
	gender CHAR(1),
	seat INT,
	age INT,
	majorid INT,
	
	CONSTRAINT pk PRIMARY KEY (id),
	CONSTRAINT uq UNIQUE (seat),
	CONSTRAINT ck CHECK(gender= '男' OR gender = '女'),
	CONSTRAINT fk_stuinfo_major FOREIGN KEY (majorid) REFERENCES major(id)
);
CREATE TABLE stuinfo(
	id INT ,
	stuName VARCHAR(20),
	gender CHAR(1),
	seat INT,
	age INT,
	majorid INT,
	seat2 INT,
	
	PRIMARY KEY (id,stuName),
	UNIQUE (seat),
	CHECK(gender= '男' OR gender = '女'),
	FOREIGN KEY (majorid) REFERENCES major(id)
);
SHOW INDEX FROM stuinfo;

#通用的写法：	★
CREATE TABLE IF NOT EXISTS stuinfo(
	id INT PRIMARY KEY,
	stuName VARCHAR(20) NOT NULL,
	sex CHAR(1),
	age INT DEFAULT 18,
	seat INT UNIQUE,
	majorid INT,
	CONSTRAINT fk_stuinfo_major FOREIGN KEY (majorid) REFERENCES major(id)
);

#二、修改表时添加约束
/*
 1、添加列级约束
 alter table 表名 modify column 字段名 字段类型 新约束;
 2、表级约束
 alter table 表名 add 【constrain 约束名】约束类型（字段名）【外键的引用】;
*/
DROP TABLE IF EXISTS stuinfo;
CREATE TABLE stuinfo(
	id INT ,
	stuName VARCHAR(20),
	gender CHAR(1),
	seat INT,
	age INT,
	majorid INT,
	seat2 INT
);
#1、添加非空约束
DESC stuinfo;
ALTER TABLE stuinfo MODIFY COLUMN stuName VARCHAR(20) NOT NULL;
#2、添加默认约束
ALTER TABLE stuinfo MODIFY COLUMN age INT DEFAULT 18;
#3、添加主键
#①列级约束
ALTER TABLE stuinfo MODIFY COLUMN id INT PRIMARY KEY;
#②表级约束
ALTER TABLE stuinfo ADD PRIMARY KEY(id);
#4、添加唯一
#①列级约束
ALTER TABLE stuinfo MODIFY COLUMN seat INT UNIQUE;
#②表级约束
ALTER TABLE stuinfo ADD UNIQUE(seat);
#5、添加外键
ALTER TABLE stuinfo ADD CONSTRAINT fk_stuinfo_major FOREIGN KEY(majorid) REFERENCES major(id);

#三、删除表时删除约束
#1、删除非空约束
ALTER TABLE stuinfo MODIFY COLUMN stuName VARCHAR(20) NULL;
ALTER TABLE stuinfo MODIFY COLUMN stuName VARCHAR(20);
#2、删除默认约束
ALTER TABLE stuinfo MODIFY COLUMN age INT;
#3、删除主键
ALTER TABLE stuinfo MODIFY COLUMN id INT;
ALTER TABLE stuinfo DROP PRIMARY KEY;
#4、删除唯一
ALTER TABLE stuinfo DROP INDEX seat;
#4、删除外键
ALTER TABLE stuinfo DROP FOREIGN KEY fk_stuinfo_major;
SHOW INDEX FROM stuinfo;