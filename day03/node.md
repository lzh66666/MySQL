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
    DQL(Data Query Language) 数据查询语言
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

##排序查询

###一、语法
    select 查询列表
    from 表
    where 筛选条件
    order by 排序列表 【asc|desc】

###二、特点
    1、asc ：升序，如果不写默认升序
       desc：降序

    2、排序列表 支持 单个字段、多个字段、函数、表达式、别名
        # 例子, 根据年薪进行排序
        SELECT
            *, (salary * (1 + ifnull( commission_pct, 0))  * 12) as year_salary
        FROM
            employees 
        ORDER BY
            year_salary DESC;
        # 按照员工的姓名的长度进行排序
        select 
            *, concat(first_name, ' ', last_name) as 'name'
        from 
            employees
        order by
            length(name) desc;
           
        
    3、order by的位置一般放在查询语句的最后（除limit语句之外）

##常见函数

###一、概述
    功能：类似于java中的方法
    好处：提高重用性和隐藏实现细节
    调用：select 函数名(实参列表),和程序中的函数使用方法类似.

###二、单行函数

####1、字符函数
    concat:连接
    substr:截取子串
        # sql中的索引都是从1开始的
        # 只有一个参数表示从指定索引往后截取剩下的.
        select substr('中国人民站起来了', 4) as out_put;
        # 两个参数时, 第一个参数是起始索引位置, 第二个参数是截取的长度
        select substr('中国人民站起来了', 2, 3) as out_put; 
    upper:变大写
    lower：变小写
    replace：替换  全部替换
        select replace('aaaabbbbcccc', 'b', 'x');  --> aaaaxxxxcccc
    length：获取字节长度, 需要根据编码类型来看
        select length('汉字123')  --> 9
    trim:去前后空格
        # 去除前后指定的字符, 默认是去除空格
        select trim('a' from 'aaaa中国aaa人aaaaa');  ---> 中国aaa人
    lpad：用指定字符左填充
        select lpad('ab', 5, 'x');  --> abxxx
        select rpad('abcde', 3, 'x');  --> abc   相当于被截取了
    rpad：用指定字符右填充
    instr:获取子串第一次出现的索引, 不存在则返回0, 索引位置从1开始

####2、数学函数
    ceil:向上取整
    round：四舍五入
    mod:取模
        # mod的算法: a % b = a - a / b * b 除是整除
        select mod(-10, -3); --> -1
        select mod(-10, 3);  --> -1
    floor：向下取整
    truncate:截断  truncate(1.652656,1);=======>1.6
    rand:获取随机数，返回0-1之间的小数

####3、日期函数
    now：返回当前日期+时间
    year:返回年
    month：返回月
    day:返回日
    date_format:将日期转换成字符
    curdate:返回当前日期
    str_to_date:将字符转换成日期
    curtime：返回当前时间
    hour:小时
    minute:分钟
    second：秒
    datediff:返回两个日期相差的天数
    monthname:以英文形式返回月

####4、其他函数
    version 当前数据库服务器的版本
    database 当前打开的数据库
    user当前用户
    password('字符')：返回该字符的密码形式
    md5('字符'):返回该字符的md5加密形式

####5、流程控制函数
    1、if(条件表达式，表达式1，表达式2)：如果条件表达式成立，返回表达式1，否则返回表达式2
    2、 case 情况1
    case 变量或表达式或字段
    when 常量1 then 值1
    when 常量2 then 值2
    ...
    else 值n
    end
        # 例子
        /*
        部门id是30, 工资1.1
        部门id是40, 工资1.2
        部门id是50, 工资1.3
        否则, 不变  
        */
        SELECT
            salary AS 原始工资,
            department_id,
        CASE
            department_id 
            WHEN 30 THEN
            salary * 1.1 
            WHEN 40 THEN
            salary * 1.2 
            WHEN 50 THEN
            salary * 1.3 ELSE salary 
            END AS 新工资 
        FROM
            employees;

    3、 case 情况2
    case 
    when 条件1 then 值1
    when 条件2 then 值2
    ...
    else 值n
    end
    # 例子
        /*
        工资> 20000 a级别
        工资> 15000 a级别
        工资> 10000 a级别
        否则, d
        */  
        select 
            salary as '工资',
        case
            when salary > 20000 then 'A'
            when salary > 15000 then 'B'
            when salary > 10000 then 'C'
            else 'D'
            end as '工资级别'
        from 
            employees;

###三、分组函数
####1、分类
    max 最大值
    min 最小值
    sum 和
    avg 平均值
    count 计算个数
####2、特点
    1、 语法
    select max(字段) from 表名;

    2、支持的类型
    sum和avg一般用于处理数值型
    max、min、count可以处理任何数据类型

    3、以上分组函数都忽略null

    4、都可以搭配distinct使用，实现去重的统计
    select sum(distinct 字段) from 表;

    5、count函数
    count(字段)：统计该字段非空值的个数
    count(*):统计结果集的行数
    案例：查询每个部门的员工个数
    1 xx    10
    2 dd    20
    3 mm    20
    4 aa    40
    5 hh    40

    count(1):统计结果集的行数

    效率上：
    MyISAM存储引擎，count(*)最高
    InnoDB存储引擎，count(*)和count(1)效率>count(字段)

    6、和分组函数一同查询的字段，要求是group by后出现的字段

##分组查询

###一、语法
    select 分组函数，分组后的字段     ⑤
    from 表                           ①
    【where 筛选条件】                ②
    group by 分组的字段               ③
    【having 分组后的筛选】           ④
    【order by 排序列表】             ⑥

###二、特点
               使用关键字   筛选的表       位置
    分组前筛选   where      原始表        group by的前面
    分组后筛选   having     分组后的结果   group by 的后面

###三、分组类型
    1. 通用分组， 按单个字段分组
    # 查询领导编号>102的每个领导手下的最低工资>5000的领导编号是哪个,以及最低工资
    select 
        manager_id,
        min(salary) as min_salary
    from 
        employees
    where 
        manager_id > 102
    group by 
        manager_id
    having 
        min_salary > 5000;

    2. group by 支持使用函数的结果来进行分组
    # having和group by 都支持使用别名来进行分组和筛选
    # 按员工的名的长度分组, 查询每一组的员工个数, 并且员工个数>5的有哪些.
    select 
        length(last_name) as length_name,
        count(*) as count_num
    from 
        employees
    group by
        length_name
    having 
        count_num > 5;

    3. 支持多个字段进行分组

    # 查询每个部门每个工种的员工的平均工资, 并按工资排序
    # 这种类似于联合主键一样， 部门id和工种一样的才算是一组
    select  
        avg(salary),
        department_id,
        job_id
    from 
        employees
    group by
        department_id, job_id
    having 
        avg(salary) > 10000
    order by
        avg(salary);

##连接查询
###一、含义
    当查询中涉及到了多个表的字段，需要使用多表连接
    select 字段1，字段2
    from 表1，表2,...;

    笛卡尔乘积：当查询多个表时，没有添加有效的连接条件，导致多个表所有行实现完全连接
    如何解决：添加有效的连接条件

###二、分类
    按年代分类：
    sql92：
        等值  
        非等值
        自连接
        也支持一部分外连接（用于oracle、sqlserver，mysql不支持）
    sql99【推荐使用】
    内连接
        等值
        非等值
        自连接     
    外连接
        左外
        右外
        全外（mysql不支持）
    交叉连接

###三、SQL92语法
    1、等值连接
    语法：
        select 查询列表
        from 表1 别名,表2 别名
        where 表1.key=表2.key
        【and 筛选条件】
        【group by 分组字段】
        【having 分组后的筛选】
        【order by 排序字段】
    特点：
        ① 一般为表起别名
        ②多表的顺序可以调换
        ③n表连接至少需要n-1个连接条件
        ④等值连接的结果是多表的交集部分

    2、非等值连接
    语法：
        select 查询列表
        from 表1 别名,表2 别名
        where 非等值的连接条件
        【and 筛选条件】
        【group by 分组字段】
        【having 分组后的筛选】
        【order by 排序字段】

    3、自连接
    语法：
        select 查询列表
        from 表 别名1,表 别名2
        where 等值的连接条件
        【and 筛选条件】
        【group by 分组字段】
        【having 分组后的筛选】
        【order by 排序字段】

###四、SQL99语法
    1、内连接
    语法：
    select 查询列表
    from 表1 别名
    【inner】 join 表2 别名 on 连接条件
    where 筛选条件
    group by 分组列表
    having 分组后的筛选
    order by 排序列表
    limit 子句;
    特点：
    ①表的顺序可以调换
    ②内连接的结果=多表的交集
    ③n表连接至少需要n-1个连接条件
    分类：
    等值连接
    非等值连接
    自连接

    2、外连接
    语法：
    select 查询列表
    from 表1 别名
    left|right|full【outer】 join 表2 别名 on 连接条件
    where 筛选条件
    group by 分组列表
    having 分组后的筛选
    order by 排序列表
    limit 子句;
    特点：
    ①查询的结果=主表中所有的行，如果从表和它匹配的将显示匹配行，如果从表没有匹配的则显示null
    ②left join 左边的就是主表，right join 右边的就是主表
      full join 两边都是主表
    ③一般用于查询除了交集部分的剩余的不匹配的行

    3、交叉连接
    语法：
    select 查询列表
    from 表1 别名
    cross join 表2 别名;
    特点：
    类似于笛卡尔乘积

##子查询

###一、含义
    嵌套在其他语句内部的select语句称为子查询或内查询，
    外面的语句可以是insert、update、delete、select等，一般select作为外面语句较多
    外面如果为select语句，则此语句称为外查询或主查询

###二、分类
####1、按出现位置
    select后面：
            仅仅支持标量子查询
    from后面：
            表子查询
    where或having后面：★★
            标量子查询  ★
            列子查询    ★
            行子查询
    exists后面：
            标量子查询
            列子查询
            行子查询
            表子查询

####2、按结果集的行列
    标量子查询（单行子查询）：结果集为一行一列
    列子查询（多行子查询）：结果集为多行一列
    行子查询：结果集为多行多列
    表子查询：结果集为多行多列


###三、示例
    where或having后面
    1、标量子查询
    案例：查询最低工资的员工姓名和工资
    ①最低工资
    select min(salary) from employees
    ②查询员工的姓名和工资，要求工资=①
    select last_name,salary
    from employees
    where salary=(
        select min(salary) from employees
    );

    2、列子查询
    案例：查询所有是领导的员工姓名
    ①查询所有员工的 manager_id
    select manager_id
    from employees
    ②查询姓名，employee_id属于①列表的一个
    select last_name
    from employees
    where employee_id in(
        select manager_id
        from employees
    );
    # 查询有员工表的部门名字, 相当于拿着部门表的每条记录去和员工表的记录做筛选, 看是否存在值
    # exists本质上是返回一个bool值类型的数据
    select department_name
    from departments as d
    where exists(
            select d.department_id from employees  as e
            where d.department_id = e.department_id
    )

##分页查询

###一、应用场景
    当要查询的条目数太多，一页显示不全

###二、语法
    select 查询列表
    from 表
    limit 【offset,】size;
    注意：
    offset代表的是起始的条目索引，默认从0开始
    size代表的是显示的条目数
    公式：
    假如要显示的页数为page，每一页条目数为size
    from 表
    limit (page-1)*size,size;


    连接的总的顺序语法：(这里存疑?)
    select 查询列表     ⑦
    from 表1 别名       ①
    连接类型 join 表2   ②
    on 连接条件         ③
    where 筛选          ④
    group by 分组列表   ⑤
    having 筛选         ⑥
    order by排序列表    ⑧
    limit 起始条目索引，条目数;  ⑨

##联合查询
###一、含义
    union：合并、联合，将多次查询结果合并成一个结果

###二、语法
    查询语句1
    union 【all】
    查询语句2
    union 【all】
    ...

###三、意义
    1、将一条比较复杂的查询语句拆分成多条语句
    2、适用于查询多个表的时候，查询的列基本是一致

###四、特点
    1、要求多条查询语句的查询列数必须一致
    2、要求多条查询语句的查询的各列类型、顺序最好一致
    3、union 去重，union all包含重复项 即union默认是去重的.

##查询总结

###一、语法
    select 查询列表     ⑦
    from 表1 别名       ①
    连接类型 join 表2   ②
    on 连接条件         ③
    where 筛选          ④
    group by 分组列表   ⑤
    having 筛选         ⑥
    order by排序列表    ⑧
    limit 起始条目索引，条目数;  ⑨

#DML语言
    DML(Data Manipulation Language)数据操纵语言

##一、插入

###一、方式一：

    语法：
    insert into 表名(字段名,...) values(值,...);
    特点：
    1、要求值的类型和字段的类型要一致或兼容
    2、字段的个数和顺序不一定与原始表中的字段个数和顺序一致
    但必须保证值和字段一一对应
    3、假如表中有可以为null的字段，注意可以通过以下两种方式插入null值
    ①字段和值都省略
    ②字段写上，值使用null
    4、字段和值的个数必须一致
    5、字段名可以省略，默认所有列

###方式二：
    语法：
    insert into 表名 set 字段=值,字段=值,...;

###两种方式的区别：
    1.方式一支持一次插入多行，语法如下：
    insert into 表名【(字段名,..)】 values(值，..),(值，...),...;
    2.方式一支持子查询，语法如下：
    insert into 表名
    查询语句;

##二、修改：

###一、修改单表的记录★
    语法：update 表名 set 字段=值,字段=值 【where 筛选条件】;

###二、修改多表的记录【补充】
    语法：
    update 表1 别名 
    left|right|inner join 表2 别名 
    on 连接条件  
    set 字段=值,字段=值 
    where 筛选条件;

##三、删除：

###方式一：使用delete
    一、删除单表的记录★
    语法：delete from 表名 【where 筛选条件】【limit 条目数】
    二、级联删除[补充]
    语法：
    delete 别名1,别名2 from 表1 别名 
    inner|left|right join 表2 别名 
    on 连接条件
     【where 筛选条件】  

###方式二：使用truncate
    语法：truncate table 表名

###两种方式的区别【面试题】
    1.truncate删除后，如果再插入，标识列从1开始
      delete删除后，如果再插入，标识列从断点开始
    2.delete可以添加筛选条件
     truncate不可以添加筛选条件
    3.truncate效率较高
    4.truncate没有返回值
    delete可以返回受影响的行数
    5.truncate不可以回滚
    delete可以回滚

#DDL语言
    DDL(数据定义语言,Data Definition Language)

##一、库的管理
    一、创建库
    create database 【if not exists】 库名【 character set 字符集名】;

    二、修改库
    alter database 库名 character set 字符集名;

    三、删除库
    drop database 【if exists】 库名;

##二、表的管理
    一、创建表 ★
    create table 【if not exists】 表名(
        字段名 字段类型 【约束】,
        字段名 字段类型 【约束】,
        ...
        字段名 字段类型 【约束】 
    )

    二、修改表
    1.添加列
    alter table 表名 add column 列名 类型 【first|after 字段名】;
    2.修改列的类型或约束
    alter table 表名 modify column 列名 新类型 【新约束】;
    3.修改列名
    alter table 表名 change column 旧列名 新列名 类型;
    4 .删除列
    alter table 表名 drop column 列名;
    5.修改表名
    alter table 表名 rename 【to】 新表名;

    三、删除表
    drop table【if exists】 表名;

    四、复制表
    1、复制表的结构
    create table 表名 like 旧表;
    2、复制表的结构+数据
    create table 表名 
    select 查询列表 from 旧表【where 筛选】;

##三、数据类型
    一、数值型
    1、整型
    tinyint、smallint、mediumint、int/integer、bigint
    1         2        3          4            8
    特点：
    ①都可以设置无符号和有符号，默认有符号，通过unsigned设置无符号
    ②如果超出了范围，会报out or range异常，插入临界值(5.5), 后面版本报错
    ③长度可以不指定，默认会有一个长度
    长度代表显示的最大宽度，如果不够则左边用0填充，但需要搭配zerofill，并且默认变为无符号整型
    2、浮点型
    定点数：decimal(M,D)
    浮点数:
        float(M,D)   4
        double(M,D)  8
    特点：
    ①M代表整数部位+小数部位的个数，D代表小数部位
    ②如果超出范围，则报out or range异常，并且插入临界值
    ③M和D都可以省略，但对于定点数，M默认为10，D默认为0
    ④如果精度要求较高，则优先考虑使用定点数

    二、字符型
    char、varchar、binary、varbinary、enum、set、text、blob
    char：固定长度的字符，写法为char(M)，最大长度不能超过M，其中M可以省略，默认为1
    varchar：可变长度的字符，写法为varchar(M)，最大长度不能超过M，其中M不可以省略

    三、日期型
    year年
    date日期
    time时间
    datetime 日期+时间          8      
    timestamp 日期+时间         4   比较容易受时区、语法模式、版本的影响，更能反映当前时区的真实时间

##四常见的约束

###一、常见的约束

    NOT NULL：非空，该字段的值必填
    UNIQUE：唯一，该字段的值不可重复
    DEFAULT：默认，该字段的值不用手动插入有默认值
    CHECK：检查，mysql不支持
    PRIMARY KEY：主键，该字段的值不可重复并且非空  unique+not null
    FOREIGN KEY：外键，该字段的值引用了另外的表的字段
    主键和唯一
    1、区别：
    ①、一个表至多有一个主键，但可以有多个唯一
    ②、主键不允许为空，唯一可以为空
    2、相同点
    都具有唯一性
    都支持组合键，但不推荐
    ★注意: 唯一约束在5.7版本允许多个值为空
    外键：
    1、用于限制两个表的关系，从表的字段值引用了主表的某字段值
    2、外键列和主表的被引用列要求类型一致，意义一样，名称无要求
    3、主表的被引用列要求是一个key（一般就是主键）
    4、插入数据，先插入主表
    删除数据，先删除从表
    可以通过以下两种方式来删除主表的记录
    #方式一：级联删除
    ALTER TABLE stuinfo ADD CONSTRAINT fk_stu_major FOREIGN KEY(majorid) REFERENCES major(id) ON DELETE CASCADE;
    #方式二：级联置空
    ALTER TABLE stuinfo ADD CONSTRAINT fk_stu_major FOREIGN KEY(majorid) REFERENCES major(id) ON DELETE SET NULL;

###二、创建表时添加约束
    create table 表名(
        字段名 字段类型 not null,#非空
        字段名 字段类型 primary key,#主键
        字段名 字段类型 unique,#唯一
        字段名 字段类型 default 值,#默认
        constraint 约束名 foreign key(字段名) references 主表（被引用列）
    )
    注意：
                    支持类型            可以起约束名          
    列级约束        除了外键            不可以
    表级约束        除了非空和默认      可以，但对主键无效
    列级约束可以在一个字段上追加多个，中间用空格隔开，没有顺序要求

###三、修改表时添加或删除约束
    1、非空
    添加非空
    alter table 表名 modify column 字段名 字段类型 not null;
    删除非空
    alter table 表名 modify column 字段名 字段类型 ;
    2、默认
    添加默认
    alter table 表名 modify column 字段名 字段类型 default 值;
    删除默认
    alter table 表名 modify column 字段名 字段类型 ;
    3、主键
    添加主键
    alter table 表名 add【 constraint 约束名】 primary key(字段名);
    删除主键
    alter table 表名 drop primary key;
    4、唯一
    添加唯一
    alter table 表名 add【 constraint 约束名】 unique(字段名);
    删除唯一
    alter table 表名 drop index 索引名;
    5、外键
    添加外键
    alter table 表名 add【 constraint 约束名】 foreign key(字段名) references 主表（被引用列）;
    删除外键
    alter table 表名 drop foreign key 约束名;

###四、自增长列
    特点：
    1、不用手动插入值，可以自动提供序列值，默认从1开始，步长为1
    auto_increment_increment
    如果要更改起始值：手动插入值
    如果要更改步长：更改系统变量
    set auto_increment_increment=值;
    2、一个表至多有一个自增长列
    3、自增长列只能支持数值型
    4、自增长列必须为一个key
    一、创建表时设置自增长列
    create table 表(
        字段名 字段类型 约束 auto_increment
    )
    二、修改表时设置自增长列
    alter table 表 modify column 字段名 字段类型 约束 auto_increment
    三、删除自增长列
    alter table 表 modify column 字段名 字段类型 约束 

#TCL语言
##一、事务：

    一、含义
    事务：一条或多条sql语句组成一个执行单位，一组sql语句要么都执行要么都不执行

    二、特点（ACID）
    A 原子性：一个事务是不可再分割的整体，要么都执行要么都不执行
    C 一致性：一个事务可以使数据从一个一致状态切换到另外一个一致的状态
    I 隔离性：一个事务不受其他事务的干扰，多个事务互相隔离的
    D 持久性：一个事务一旦提交了，则永久的持久化到本地

    三、事务的使用步骤 ★
    了解：
    隐式（自动）事务：没有明显的开启和结束，本身就是一条事务可以自动提交，比如insert、update、delete
    显式事务：具有明显的开启和结束
    使用显式事务：
    ①开启事务 
        1. set autocommit=0; 用来禁止使用当前会话的自动提交。这就相当于一直处于事务状态.
        2. start transaction 或 begin;#可以省略
    ②编写一组逻辑sql语句
    注意：sql语句支持的是insert、update、delete
    设置回滚点：
    savepoint 回滚点名;
    ③结束事务
    提交：commit;
    回滚：rollback;
    回滚到指定的地方：rollback to 回滚点名;

    四、并发事务
    1、事务的并发问题是如何发生的？
    多个事务 同时 操作 同一个数据库的相同数据时
    2、并发问题都有哪些？
    脏读：一个事务读取了其他事务还没有提交的数据，读到的是其他事务“更新”的数据
    不可重复读：一个事务多次读取，结果不一样
    幻读：一个事务读取了其他事务还没有提交的数据，只是读到的是
    其他事务“插入”的数据
    3、如何解决并发问题
    通过设置隔离级别来解决并发问题
    4. 查看及设置当前事务的隔离级别
    select @@tx_isolation;
    # 设置当前会话的事务隔离级别
    set session transaction isolation level read uncommitted;  # 读未提交
    set session transaction isolation level read committed;    # 读已提交
    set session transaction isolation level repeatable read;   # 可重复读  默认的隔离级别
    set session transaction isolation level serializable ;     # 串行化， 最高的隔离级别
    # 查看...
    mysql> select @@tx_isolation;
    +------------------+
    | @@tx_isolation   |
    +------------------+
    | READ-UNCOMMITTED |
    +------------------+

    5、隔离级别
                                 脏读          不可重复读        幻读
    read uncommitted:读未提交     ×                ×              ×        
    read committed：读已提交      √                ×              ×
    repeatable read：可重复读     √                √              ×
    serializable：串行化          √                √              √

##二、视图：

###一、含义
    mysql5.1版本出现的新特性，本身是一个虚拟表，它的数据来自于表，通过执行时动态生成。
    好处：
    1、简化sql语句
    2、提高了sql的重用性
    3、保护基表的数据，提高了安全性
###二、创建
    create view 视图名
    as
    查询语句;

###三、修改
    方式一：
    create or replace view 视图名
    as
    查询语句;
    方式二：
    alter view 视图名
    as
    查询语句

###四、删除
    drop view 视图1，视图2,...;

###五、查看
    desc 视图名;
    show create view 视图名;

###六、使用
    1.插入 insert
    2.修改 update
    3.删除 delete
    4.查看 select
    注意：视图一般用于查询的，而不是更新的，所以具备以下特点的视图都不允许更新
    ① 包含分组函数、group by、distinct、having、union、
    ② join
    ③ 常量视图
    ④ where后的子查询用到了from中的表
    ⑤ 用到了不可更新的视图

###七、视图和表的对比
            关键字       是否占用物理空间            使用
    视图     view        占用较小，只保存sql逻辑      一般用于查询
    表       table       保存实际的数据             增删改查
