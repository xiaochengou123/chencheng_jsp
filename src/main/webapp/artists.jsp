<%--
  Created by IntelliJ IDEA.
  User: dog
  Date: 2026/1/5
  Time: 08:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>歌手分类</title>
    <link rel="stylesheet" href="static/css/main.css">
    <link rel="stylesheet" href="static/css/index.css">
    <style>
        .navbar-right img { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; }
        /* 筛选按钮基础样式 - 修复active样式选择器错误（原代码是 .filter-option .active，应为 .filter-option.active） */
        .filter-option {
            padding: 6px 16px;
            border: none;
            border-radius: 20px;
            margin-right: 8px;
            cursor: pointer;
            font-size: 14px;
            background-color: #f0f2f5;
            color: #666;
            transition: all 0.2s;
        }
        /* 修复：把空格去掉，空格表示子元素，这里需要的是同时有两个类的元素 */
        .filter-option.active{
            background-color: #6b72ff;
            color: #fff;
        }
        .filter-option:hover {
            background-color: #e5e7ff;
        }
        a{
            text-decoration: none;
        }
        .exit{
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="app-container">
    <!-- 左侧菜单栏 -->
    <aside class="sidebar">
        <div class="logo-section">
            <span>ai 一听</span>
        </div>
        <nav class="menu-nav">
            <ul class="menu-list">
                <li class="menu-item">
                    <a href="songSheetPage" class="menu-link">
                        <img src="static/images/首页-active.png" class="menu-icon-img active-img" alt="" style="display: none;">
                        <img src="static/images/首页.png" class="menu-icon-img normal-img" alt="">
                        <span class="menu-text">首页</span>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="FavoriteServlet" class="menu-link">
                        <img src="static/images/喜欢-active.png" class="menu-icon-img active-img" alt="" style="display: none;">
                        <img src="static/images/喜欢.png" class="menu-icon-img normal-img" alt="">
                        <span class="menu-text">我的喜欢</span>
                    </a>
                </li>
                <li class="menu-item active">
                    <a href="artists" class="menu-link">
                        <img src="static/images/歌手分类-active.png" class="menu-icon-img active-img" alt="">
                        <img src="static/images/歌手分类.png" class="menu-icon-img normal-img" alt="" style="display: none;">
                        <span class="menu-text">歌手分类</span>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="ai.jsp" class="menu-link">
                        <img src="static/images/ai-active.png" class="menu-icon-img active-img" alt="" style="display: none;">
                        <img src="static/images/ai.png" class="menu-icon-img normal-img" alt="">
                        <span class="menu-text">智能AI</span>
                    </a>
                </li>
            </ul>
        </nav>
    </aside>

    <!-- 右侧主内容区域 -->
    <main class="main-content">
        <div class="top-navbar">
            <div class="navbar-left">
                <div class="navbar-title"></div>
            </div>
            <div class="navbar-right">
                <span class="username"></span>
                <img src="" alt="用户头像" class="avatar"/>
                <span class="exit"><img src="static/images/退出.png" style="width: 13px;height: 13px;" alt=""/>退出</span>
            </div>
        </div>

        <div class="content-area">
            <div class="artists-page">
                <!-- 搜索区域：回显搜索词 -->
                <div class="search-section">
                    <div class="search-container">
                        <input type="text" class="search-input" placeholder="搜索歌手" value="${singerName}">
                        <button class="search-btn">
                            <img src="static/images/搜索.png" style="width: 24px; height: 24px;" alt="">
                        </button>
                    </div>
                </div>

                <!-- 分类标题和重置区域 -->
                <div class="category-header">
                    <h2 class="category-title">歌手分类</h2>
                    <button class="reset-btn" id="resetBtn">重置</button>
                </div>

                <!-- 筛选区域：回显选中状态 -->
                <div class="filter-section">
                    <div class="filter-group">
                        <div class="filter-label">地区</div>
                        <div class="filter-options">
                            <button class="filter-option ${region == 'all' ? 'active' : ''}" data-type="region" data-value="all">全部</button>
                            <c:forEach items="${nationalities}" var="nation">
                                <button class="filter-option ${region == nation ? 'active' : ''}" data-type="region" data-value="${nation}">${nation}</button>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="filter-group">
                        <div class="filter-label">类型</div>
                        <div class="filter-options">
                            <button class="filter-option ${gender == 'all' ? 'active' : ''}" data-type="gender" data-value="all">全部</button>
                            <button class="filter-option ${gender == 'male' ? 'active' : ''}" data-type="gender" data-value="male">男歌手</button>
                            <button class="filter-option ${gender == 'female' ? 'active' : ''}" data-type="gender" data-value="female">女歌手</button>
                            <button class="filter-option ${gender == 'group' ? 'active' : ''}" data-type="gender" data-value="group">组合</button>
                        </div>
                    </div>
                </div>

                <!-- 歌手列表：确保循环能显示 -->
                <div class="artists-grid">
                    <c:if test="${empty SingerList}">
                        <div style="grid-column: 1/-1; text-align: center; color: #999; padding: 20px;">
                            暂无歌手数据
                        </div>
                    </c:if>
                    <c:forEach items="${SingerList}" var="singer">
                        <a href="<c:url value="/artists_detail?singer_id=${singer.id}"/>">
                            <div class="artist-card">
                                <div class="artist-avatar">
                                    <img src="${singer.avatar}" alt="${singer.singerName}头像">
                                </div>
                                <div class="artist-info">
                                    <div class="artist-name">${singer.singerName}</div>
                                    <div class="artist-type">${singer.type==1?"男歌手" : singer.type==2?"女歌手" : "组合"}</div>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </div>
    </main>
</div>

<script>
    // 1. 用户信息容错（避免localStorage无数据时报错）
    let user = null;
    try {
        user = JSON.parse(localStorage.getItem('user')) || {};
    } catch (e) {
        user = {};
    }
    // 设置用户信息
    if (user.nickname) {
        document.querySelector('.username').innerHTML = user.nickname;
    }
    if (user.avatar) {
        document.querySelector('.avatar').src = user.avatar;
    }


    // 2. 筛选和搜索逻辑
    document.addEventListener('DOMContentLoaded', function() {
        const searchInput = document.querySelector('.search-input');
        const searchBtn = document.querySelector('.search-btn');
        const filterOptions = document.querySelectorAll('.filter-option');
        const resetBtn = document.getElementById('resetBtn');
        // 上下文路径（避免请求路径错误）
        const contextPath = "${pageContext.request.contextPath}";

        // 封装请求函数
        function sendFilterRequest() {
            const singerName = searchInput.value.trim();
            const region = document.querySelector('.filter-option[data-type="region"].active')?.dataset.value || 'all';
            const gender = document.querySelector('.filter-option[data-type="gender"].active')?.dataset.value || 'all';
            // 拼接完整请求路径
        let url;
        url = contextPath + '/artists?singerName=' + encodeURIComponent(singerName) + '&region=' + region + '&gender=' + gender;
            window.location.href=url
        }

        // 搜索按钮+回车事件
        searchBtn.addEventListener('click', sendFilterRequest);
        searchInput.addEventListener('keydown', function(e) {
            if (e.key === 'Enter') sendFilterRequest();
        });

        filterOptions.forEach(function(option) {
            option.addEventListener('click', function(e) {
                // 阻止默认行为+冒泡
                e.preventDefault();
                e.stopPropagation();

                // 获取筛选类型
                const type = this.dataset.type || this.getAttribute('data-type');
                if (!type) {
                    console.error("按钮无data-type属性：", this);
                    return;
                }

                // 找父容器
                let parentOptions = this.closest('.filter-options');
                if (!parentOptions) {
                    let parent = this.parentElement;
                    while (parent && !parent.classList.contains('filter-options')) {
                        parent = parent.parentElement;
                    }
                    parentOptions = parent;
                }
                if (!parentOptions) {
                    console.error("未找到.filter-options父容器");
                    return;
                }

                // 移除同类型按钮的active
                const sameTypeBtns = parentOptions.querySelectorAll('.filter-option[data-type="' + type + '"]');
                sameTypeBtns.forEach(function(item) {
                    item.classList.remove('active');
                });

                // 给当前按钮加active
                this.classList.add('active');

                setTimeout(function() {
                    sendFilterRequest();
                }, 50);
            });
        });

        // 重置按钮事件
        resetBtn.addEventListener('click', function() {
            searchInput.value = '';
            // 重置地区筛选
            const regionBtns = document.querySelectorAll('.filter-option[data-type="region"]');
            regionBtns.forEach(btn => btn.classList.remove('active'));
            document.querySelector('.filter-option[data-type="region"][data-value="all"]').classList.add('active');
            // 重置类型筛选
            const genderBtns = document.querySelectorAll('.filter-option[data-type="gender"]');
            genderBtns.forEach(btn => btn.classList.remove('active'));
            document.querySelector('.filter-option[data-type="gender"][data-value="all"]').classList.add('active');
            sendFilterRequest();
        });
    });

    // 退出按钮事件
    let exit=document.querySelector('.exit');
    exit.addEventListener("click",function () {
        window.location.href = "${pageContext.request.contextPath}/logout";
    })
</script>

<script src="static/js/main.js"></script>
<script src="static/js/artists.js"></script>
</body>
</html>