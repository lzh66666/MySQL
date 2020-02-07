#数据库的相关概念

##一、数据库的好处
    1、持久化数据到本地
    2、可以实现结构化查询，方便管理


##二、数据库的常见概念  ☆
    1、DB：数据库，保存一组有组织的数据的容器
    2、DBMS：数据库管理系统，又称为数据库软件（产品），用于管理DB中的数据
    3、SQL：结构化查询语言，用于和DBMS通信的语言

##三、数据库存储的特点
    1、将数据放到表中，表再放到库中
    2、一个数据库中可以有多个表，每个表都有一个名字，用来标识自己，表具有唯一性。
    3、表具有一些特征，这些特性定义了数据在表中如何存储，类似java中“类”的设计。
    4、表由列组成，我们也称为字段。所有表都是由一个或多个列组成的，每一列类似java中的属性。
    5、表中的数据是按行执行存储的，每一行类似于java中的“对象”。

##四、常见的数据库管理系统
    mysql、oracle、db2、sqlserver...

#MySQL的介绍

##一、MySQL的背景
    前身属于瑞典的一家公司 MySQL AB
    06年被sun公司收购
    09年sun被oracle收购
##二、MySQL的优点
    1、开源、免费、成本低
    2、性能高、移植性好
    3、体积小、便于安装
##三、MySQL产品的安装
    属于c/s架构的软件，一般来讲安装服务端
    企业版
    社区版
##四、MySQL服务的启动和停止
    方式一：计算机--右键管理--服务
    方式二：通过管理员身份运行
    net start 服务名（启动服务）（MySQL55）
    net stop 服务名（停止服务）（MySQL55）

##五、MySQL服务的登录与退出
    方式一：通过MySQL自带的客户端
    只限于root用户

    方式二：通过windows自带的客户端
    登录：
    mysql 【-h主机名(localhost) -P端口号(3306)】 -u用户名(root) -p密码(admin)
    eg：mysql -h localhost -P3306 -u root -padmin
        mysql -u root -padmin
    退出：
    exit或者Ctrl+C

##六、MySQL的常见命令
    1、查看当前所有的数据库
    show databases;
    2、打开指定的库
    use 库名;
    3、查看当前库的所有表
    show tables;
    4、查看其他库的所有表
    show tables from 库名;
    5、创建表
    create table 表名(
        列名 列类型,（如：name varchar<20>,)
        列名 列类型，
        ...
    );
    6、查看表结构
    desc 表名;
    7、查看服务器的版本
    方式一：登录到mysql服务端
    select version();
    方式二：没有登录到mysql服务端
    mysql --version
    或
    mysql --V

##七、MySQL的语法规范
    1、不区分大小写，建议关键字大写，表名列名小写
    2、每条命令最好用分号结尾（还有一种\g)
    3、每条命令可以根据需要，可以进行缩进或换行
    4、注释
        单行注释：#注释文字
        单行注释：-- 注释文字（注意：注释文字前有一个空格）
        多行注释：/*注释文字*/


#DQL语言

##基础查询

###一、语法
    select 查询列表
    from 表名;

###二、特点
    1、查询列表可以使字段、常量、表达式、函数、也可以是多个
    2、查询结果是一个虚拟表

###三、实例
    1、查询某个字段
    select 字段名 from 表名;
    2、查询多个字段
    select 字段名,字段名 from 表名;
    3、查询所有字段
    select * from 表名
    4、查询常量
    select 常量值：
    注意：字符型和日期型的常量值必须用单引号引起来，数值型不需要
    5、查询函数
    select函数名(实参列表);
    6、查询表达式
    select 100/125;
    7、起别名
    ①as
    ②空格
    8、去重
    select distinct 字段名 from 表名;
    9、+
    作用：做加法运算
    select 数值+数值; 直接运算
    select 字符+数值; 先试图将字符转换成数值，如果转换成功，则继续运算，否则转换成0，在做运算
    select null+值; 结果为null
    10、【补充】contact函数
    功能：拼接字符
    select concat(字符1,字符2,...);
    11、【补充】ifnull函数
    功能：判断某字段或表达式是否为null，如果为null，返回给定的值，否则返回原本的值
    select ifnull(commission_pct,0) from employees;
    12、【补充】isnull函数
    功能：判断某字段或表达式是否为null，如果是，则返回1，否则返回0
    select isnull(commission_pct,0) from employees;

##条件查询

###一、语法
    select 查询列表
    from 表名
    where 筛选条件;

###二、筛选条件的分类
    1、简单运算符
    > < = <> != >= <= <=>安全等于
    2、逻辑运算符
    && and
    || of
    !  not
    3、模糊查询
    like：一般搭通配符使用，用于判断字符型或数值型
    通配符：%任意多个字符，_任意单个字符。
    between and
    in
    is null / is not null：用于判断null值
    is null 和 <=> 的 PK

