### SSM_CRUD 项目简介

#### 主要技术点

- 后端框架采用 Sppring + SpringMVC + MyBatis 
- 前端框架采用 Bootstrap
- 数据库采用 MySQL
- 项目 Jar 包和依赖管理采用 Maven
- DAO 和 Service 采用 Mybatis Generator 逆向工程自动生成
- 页面分页采用 Mybatis-PageHelper

#### 开始搭建环境

1. 创建一个 Maven 工程

2. 引入项目需要的 Jar 包

   由于有 Maven 的支持，在此项目中，需要引入 Jar 包时，直接在 [Maven 仓库](https://mvnrepository.com/) 中搜索需要的 Jar 包，将下图中红框部分代码添加到 pom.xml 中并保存，开发工具就会自动下载添加的 Jar 包。

   ![](https://ws1.sinaimg.cn/large/006c8DHYly1fnsnzihdpaj30l30iywfg.jpg)

此项目中初期需要的基本 Jar 包有：

- spring

- spring webmvc

- spring jdbc

- spring test

- spring apects

- mybatis

- mybatis spring 整合

- mybatis generator

- mysql 驱动

- 连接池 c3p0

- servlet-api

  > **注意：这个 Jar 包 Tomcat 已经提供，在引入时需要注明**
  >
  > ```xml
  > <scope>provided</scope>
  > ```

- jstl 标准标签库

- junit 单元测试

- mybatis generator 

1. 引入 Bootstrap 前端框架

   下载 Bootstrap 框架，然后复制到项目的 webapp/static 目录下。

   ![](https://ws1.sinaimg.cn/large/006c8DHYly1fnso3xpcguj30cg06wmxc.jpg)

   在使用时，需要在页面引入 Bootstrap 的 js 与 css 文件

```html
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
```

​	同时还需要引入 Jquery ，将相关文件复制到 webapp/js 目录下。

```html
<script src="${APP_PATH}/static/js/jquery.js"></script>
```

> **注意：引入的时候，路径采用以 / 开始的相对路径 ，找资源是是以服务器的根路径。所以我们需要提前定义根路径**
>
> ```jsp
> <% pageContext.setAttribute("APP_PATH", request.getContextPath()) %>
> ```

1. 配置文件的编写
   - [web.xml](https://github.com/Sudrizzz/SSM_CRUD/blob/master/src/main/webapp/WEB-INF/web.xml)
   - spring 的配置文件 [applicationContext.xml](https://github.com/Sudrizzz/SSM_CRUD/blob/master/src/main/resources/applicationContext.xml)
   - springMVC 配置 [dispatcherServlet-servlet.xml](https://github.com/Sudrizzz/SSM_CRUD/blob/master/src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml)
   - mybatis 配置文件 [mybatis-config.xml](https://github.com/Sudrizzz/SSM_CRUD/blob/master/src/main/resources/mybatis-config.xml)

#### 建立数据库并创建表

创建一个名为 ssm_crud 的数据库，创建员工表 tbl_emp 和部门表 tbl_dept ，字段如下

- 员工表 tbl_emp

![](https://ws1.sinaimg.cn/large/006c8DHYly1fnso6ql9gtj30nv06lgm0.jpg)

- 部门表 tbl_dept

![](https://ws1.sinaimg.cn/large/006c8DHYly1fnso6xpbvrj30nl04p3yr.jpg)

其中，员工表中的 d_id 字段与部门表中的 dept_id 形成外键关联，方便查询员工时可以同时查出所在部门。

- 外键

  ![](https://ws1.sinaimg.cn/large/006c8DHYly1fnso75g6tlj30bz042jrg.jpg)

#### mybatis 逆向工程

1. 配置 mybatis generator 文件 [mbg.xml](https://github.com/Sudrizzz/SSM_CRUD/blob/master/mbg.xml)
2. 配置数据库连接文件 [dbconfig.properties](https://github.com/Sudrizzz/SSM_CRUD/blob/master/src/main/resources/dbconfig.properties)
3. 编写 mybatis 逆向工程测试代码 [MBGTest.java](https://github.com/Sudrizzz/SSM_CRUD/blob/master/src/main/java/com/atguigu/crud/test/MBGTest.java)
4. 运行 MBGTest.java 进行测试

#### 修改自动生成的 mapper 文件

mybatis 自动生成的 mapper 文件中，没有能同时查出员工信息和所在部门的 sql 语句，需要我们手动添加。

按照自动生成的 [EmployeeMapper.xml](https://github.com/Sudrizzz/SSM_CRUD/blob/master/src/main/resources/mapper/EmployeeMapper.xml) 中语句的样式，在其中添加能同时查出部门信息的 sql 语句。

添加带部门信息的 resultMap

```xml
<resultMap id="WithDeptResultMap" type="com.atguigu.crud.bean.Employee">
	<id column="emp_id" jdbcType="INTEGER" property="empId" />
	<result column="emp_name" jdbcType="VARCHAR" property="empName" />
	<result column="d_id" jdbcType="INTEGER" property="dId" />
	<result column="gender" jdbcType="CHAR" property="gender" />
	<result column="email" jdbcType="VARCHAR" property="email" />
	<!-- 联合查询出的部门字段封装 -->
	<association property="department" javaType="com.atguigu.crud.bean.Department">
		<id column="dept_id" property="deptId" />
		<result column="dept_name" property="deptName" />
	</association>
</resultMap>
```

添加带部门信息的 select 语句

```xml
<!-- 查询员工时带部门信息 -->
    <select id="selectByExampleWithDept" resultMap="WithDeptResultMap">
        select
        <if test="distinct">
            distinct
        </if>
        <include refid="WithDept_Column_List" />
        from tbl_emp e left join tbl_dept d on e.d_id = d.dept_id
        <if test="_parameter != null">
            <include refid="Example_Where_Clause" />
        </if>
        <if test="orderByClause != null">
            order by ${orderByClause}
        </if>
    </select>
    <select id="selectByPrimaryKeyWithDept" resultMap="WithDeptResultMap">
        select
        <include refid="WithDept_Column_List" />
        from tbl_emp e left join tbl_dept d on e.d_id = d.dept_id
        where emp_id = #{empId,jdbcType=INTEGER}
    </select>
```

接下来，编写一个测试类，往数据库中添加或修改数据，以检验 mapper 文件是否出现错误。详见 [MapperTest.java](https://github.com/Sudrizzz/SSM_CRUD/blob/master/src/main/java/com/atguigu/crud/test/MapperTest.java)

#### 开发环境基本搭建完成

