# 一听 - 基于JSP+MySQL的在线音乐播放系统
一个基于 **JSP + Servlet + MySQL** 开发的传统Java Web在线音乐平台，为用户提供完整的音乐播放、歌单管理、歌手分类等功能，适合作为Java Web课程设计或毕业设计项目。

---

##  项目特色
- **高颜值UI设计**：采用渐变紫为主色调，搭配毛玻璃卡片、黑胶唱片动效，打造现代感十足的视觉体验
- **完整用户系统**：支持邮箱验证码注册、账号登录、状态持久化，安全可靠
- **核心播放功能**：
  - 黑胶唱片式播放界面，支持进度条拖拽、音量调节、倍速播放
  - 完整播放队列管理，支持切歌、循环播放
  - 「我的喜欢」歌单，支持歌曲收藏、歌单分类管理
- **  丰富内容生态**：
  - 首页歌单推荐轮播，多风格歌单随心听（热歌、DJ、伤感、流行等）
  - 歌手分类页，按地区/性别筛选歌手，支持搜索快速定位
- **传统Java Web架构**：基于JSP+Servlet开发，结构清晰，适合学习和二次开发
- **数据安全**：MySQL数据库存储用户信息、音乐数据、收藏记录，支持数据持久化
- **智能AI预留**：预留智能AI入口，可扩展AI推荐、AI点歌等高级功能

---

##  项目预览
###  登录注册


###  首页与播放




###  我的喜欢与歌手分类




---

##  技术栈
### 后端技术
- **核心框架**：JSP + Servlet
- **数据库**：MySQL 8.0+
- **服务器**：Tomcat 9.x / 10.x
- **JDBC**：原生JDBC连接数据库，封装DBUtils工具类
- **其他**：Java 8+、Jackson（JSON处理）

### 前端技术
- **页面框架**：HTML5 + CSS3 + JavaScript
- **UI样式**：渐变、动画、响应式布局
- **交互增强**：原生JS实现轮播、播放控制、表单验证

---

## 🚀 快速开始
### 环境要求
- JDK 1.8+
- Tomcat 9.x / 10.x
- MySQL 8.0+
- Maven（可选，用于依赖管理）

### 1. 数据库配置
1.  创建数据库 `ai_music`（字符集 `utf8mb4`，排序规则 `utf8mb4_general_ci`）
2.  执行项目根目录下的 `sql/ai_music.sql` 脚本，初始化表结构和测试数据
    ```sql
     -- 用户表
CREATE TABLE User (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '用户ID',
    username VARCHAR(50) NOT NULL COMMENT '用户名',
    password VARCHAR(255) NOT NULL COMMENT '用户密码',
    nickname VARCHAR(50) NOT NULL COMMENT '昵称',
    email VARCHAR(100) NOT NULL COMMENT '邮箱',
    avatar VARCHAR(255) COMMENT '头像',
    resume VARCHAR(255) COMMENT '简历',
    createtime DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updatetime DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间'
);

-- 歌手表
CREATE TABLE Singer (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '歌手ID',
    singerName VARCHAR(100) NOT NULL COMMENT '歌手名称',
    type INT COMMENT '类型(1:男歌手,2:女歌手,3:组合/乐队)',
    birthday DATE COMMENT '生日',
    nationality VARCHAR(50) COMMENT '国籍',
    resume VARCHAR(255) COMMENT '简历',
    avatar VARCHAR(255) COMMENT '头像',
    createtime DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updatetime DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);
    -- 核心表结构示例

    -- 更多表结构详见sql脚本
    ```
3.  修改 `src/main/resources/db.properties` 中的数据库连接信息
    ```properties
    jdbc.driver=com.mysql.cj.jdbc.Driver
    jdbc.url=jdbc:mysql://localhost:3306/yt_music
    jdbc.username=root
    jdbc.password=你的数据库密码
    ```

### 2. 项目部署
1.  将项目导入IDEA/Eclipse，配置Tomcat服务器
2.  确保Tomcat的JDK版本与项目JDK版本一致
3.  部署项目到Tomcat的 `webapps` 目录，或通过IDE直接启动
4.  启动Tomcat，访问 `http://localhost:8080/ai-yi-ting/` 即可进入系统

### 3. 测试账号
自己注册+登入

---

##  项目结构
```
yt_music/
├── src/main/
│   ├── java/com/aiyiting/
│   │   ├── controller/      # Servlet控制器（登录、注册、播放、歌单等）
│   │   ├── dao/             # 数据访问层（数据库操作）
│   │   ├── entity/          # 实体类（User、Music、Singer、Playlist等）
│   │   ├── service/         # 业务逻辑层
│   │   ├── utils/           # 工具类（JDBC工具、邮件工具、验证码工具等）
│   │   └── filter/          # 过滤器（登录拦截、编码过滤等）
│   ├── resources/           # 配置文件（db.properties、sql脚本）
│   └── webapp/              # 前端资源
│       ├── css/             # 样式文件
│       ├── js/              # 交互脚本
│       ├── img/             # 图片资源
│       ├── music/           # 音乐文件
│       ├── pages/           # JSP页面（登录、首页、播放页等）
│       └── WEB-INF/         # web.xml配置
├── pom.xml                  # Maven依赖配置（可选）
└── README_ZH.md
```

---

##  功能模块详解
### 1. 用户认证系统
- **注册**：用户名、昵称、邮箱验证码、密码双重校验，防止恶意注册
- **登录**：用户名+密码登录，Session存储登录状态，自动登录持久化
- **退出登录**：清除Session，返回登录页
- **权限控制**：过滤器拦截未登录用户，保护核心页面

### 2. 音乐播放系统
- **黑胶播放界面**：唱片旋转动画，沉浸式播放体验
- **播放控制**：上一曲/下一曲/暂停/播放、进度条拖拽、音量调节、倍速播放
- **播放队列**：右侧队列面板，支持切换歌曲、清空队列
- **收藏功能**：一键收藏喜欢的歌曲，同步到「我的喜欢」歌单

### 3. 内容管理系统
- **歌单推荐**：首页轮播歌单，多风格分类（热歌、DJ、伤感、流行等）
- **我的喜欢**：收藏歌曲列表，支持歌单分类、全部播放
- **歌手分类**：按地区（中国/新加坡）、类型（男/女/组合）筛选歌手，支持搜索
- **歌单管理**：支持创建、编辑、删除自定义歌单

### 4. 安全与工具
- **邮箱验证码**：注册时发送验证码到邮箱，验证用户身份
- **密码加密**：MD5加密存储用户密码，保障数据安全
- **登录拦截**：过滤器拦截未登录访问，防止越权操作
- **编码统一**：全局UTF-8编码，解决中文乱码问题

---

##  后续迭代计划
- [ ] 接入真实音乐API，实现海量曲库在线播放
- [ ] 完善智能AI功能：AI歌单推荐、AI点歌、AI生成歌单
- [ ] 增加歌词显示、逐字滚动、翻译功能
- [ ] 支持评论、分享、下载等社交功能
- [ ] 适配移动端，开发响应式布局
- [ ] 增加暗黑模式、主题切换功能
- [ ] 优化数据库性能，增加缓存机制

---

## 贡献指南
欢迎提交Issue和Pull Request来完善项目！
1.  Fork 本仓库
2.  创建特性分支 (`git checkout -b feature/AmazingFeature`)
3.  提交更改 (`git commit -m 'Add some AmazingFeature'`)
4.  推送到分支 (`git push origin feature/AmazingFeature`)
5.  开启 Pull Request

---

## 许可证
本项目基于 [MIT License](LICENSE) 开源，可自由使用、修改和分发。

---

## 致谢
感谢JSP/Servlet、MySQL、Tomcat等开源技术的支持，以及所有为项目提供帮助的开发者！

---

##  联系我
如有问题或建议，欢迎通过以下方式联系：
- 邮箱：3588172935@qq.com
- GitHub：[你的GitHub主页]

---

> 用音乐治愈生活，用代码创造美好 🎧✨

---

### 补充说明
- 可根据实际项目情况，补充**部署详细步骤**、**接口文档**、**常见问题排查**等内容
- 数据库脚本、配置文件路径可根据项目实际结构调整
- 如需添加课程设计/毕业设计相关说明，可在文档中补充项目背景、设计思路等内容

需要我帮你补充**数据库表结构设计文档**、**部署常见问题排查**，或者生成对应的英文README.md吗？
