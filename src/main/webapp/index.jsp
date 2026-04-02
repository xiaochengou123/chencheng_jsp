<%--
  Created by IntelliJ IDEA.
  User: dog
  Date: 2026/1/5
  Time: 08:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI听歌系统</title>
    <link rel="stylesheet" href="static/css/main.css">
    <link rel="stylesheet" href="static/css/index.css">
    <link rel="stylesheet" href="static/css/auth.css">
    <style>
        .mod_bg {
            background: url(images/bg_detail.bb32b2d1.webp);
        }

        .mod_index {
            position: relative;

        }

        .mod_index .section_inner {
            z-index: 2;
            overflow: hidden;
        }

        .section_inner {
            max-width: 1200px;
            margin: 0 auto;
            position: relative;
        }

        .index__hd {
            display: block;
            margin: 65px auto;
            width: 196px;
            height: 40px;
            right: 10px;
            position: relative;
        }
        .index__hd1 {
            display: block;
            margin: 12px auto;
            width: 196px;
            height: 40px;
        }



        /* 新歌首发模块样式 - 三段式背景：上灰、中白、下灰 */
        .new-songs-section {
            position: relative;
            overflow: hidden;
        }

        /* 移除之前的背景图和遮罩 */
        .new-songs-section::before {
            content: none !important;
        }

        .new-songs-section {
            background-image: url(images/bg_detail.bb32b2d1.webp);
        }

        /* 标题区域样式 */
        .new-songs-header {
            display: flex !important;
            justify-content: space-between !important;
            align-items: center !important;
            margin-bottom: 20px;
        }



        /* 分类标签样式 - 修复嵌套问题，居中显示 */
        .new-songs-section > .section_inner > .new-songs-tabs > div {
            display: flex !important;
            gap: 30px !important;
            /* margin-bottom: 30px !important; */
            padding-bottom: 15px !important;
            justify-content: center !important;
        }

        /* 歌曲列表样式 - 3*3网格布局，只显示9首歌曲 */
        .new-songs-grid {
            display: grid !important;
            grid-template-columns: repeat(3, 1fr) !important;
            gap: 25px 30px !important;
            margin-bottom: 30px !important;
            grid-template-rows: repeat(3, auto) !important;
            overflow: hidden !important;
        }

        /* 只显示前9首歌曲，隐藏第10首及以后的歌曲 */
        .new-song-item:nth-child(n+10) {
            display: none !important;
        }

        /* 歌曲项样式 - 左封面、中信息、右时长水平布局 */
        .new-song-item {
            display: flex !important;
            flex-direction: row !important;
            align-items: center !important;
            cursor: pointer !important;
            transition: all 0.3s ease !important;
            background: transparent !important;
            border-radius: 0 !important;
            padding: 10px 0 !important;
            box-shadow: none !important;
            border-bottom: 1px solid #f0f0f0 !important;
        }



        /* 封面图样式 - 左侧正方形 */
        .song-cover {
            width: 60px !important;
            height: 60px !important;
            aspect-ratio: 1 / 1 !important;
            border-radius: 8px !important;
            overflow: hidden !important;
            margin-right: 15px !important;
            flex-shrink: 0 !important;
            background: #f0f0f0 !important;
        }

        /* 歌曲信息样式 - 中间垂直布局 */
        .song-info {
            flex: 1 !important;
            display: flex !important;
            flex-direction: column !important;
            align-items: flex-start !important;
            gap: 5px !important;
            margin-bottom: 0 !important;
            min-width: 0 !important;
        }

        /* 歌曲名称样式 - 上 */
        .song-name {
            font-size: 14px !important;
            font-weight: 600 !important;
            color: #333 !important;
            text-align: left !important;
            overflow: hidden !important;
            text-overflow: ellipsis !important;
            white-space: nowrap !important;
            width: 100% !important;
        }

        /* 歌手名称样式 - 下 */
        .song-artist {
            font-size: 12px !important;
            color: #999 !important;
            text-align: left !important;
            overflow: hidden !important;
            text-overflow: ellipsis !important;
            white-space: nowrap !important;
            width: 100% !important;
        }

        /* 歌曲时长样式 - 右侧 */
        .song-duration {
            font-size: 12px !important;
            color: #ccc !important;
            text-align: right !important;
            margin-left: 15px !important;
            flex-shrink: 0 !important;
        }

        /* 响应式设计调整 */
        @media (max-width: 1200px) {
            .new-songs-grid {
                grid-template-columns: repeat(2, 1fr) !important;
            }
        }

        @media (max-width: 768px) {
            .new-songs-grid {
                grid-template-columns: 1fr !important;
                gap: 15px !important;
            }
        }

        /* 分页指示器样式 - 修复嵌套问题 */
        .new-songs-section > .section_inner > .new-songs-pagination {
            display: flex !important;
            justify-content: center !important;
            gap: 12px !important;
            margin-bottom: 40px !important;
        }

        /* 响应式设计 */
        @media (max-width: 1200px) {
            .new-songs-grid {
                grid-template-columns: repeat(2, 1fr) !important;
            }
        }

        @media (max-width: 768px) {
            .new-songs-section {
                padding: 20px 0 !important;
            }

            .new-songs-grid {
                grid-template-columns: 1fr !important;
                gap: 15px !important;
            }

            .new-songs-header {
                flex-direction: column !important;
                align-items: flex-start !important;
                gap: 15px !important;
            }

            .new-songs-section > .section_inner > .new-songs-tabs {
                gap: 15px !important;
                overflow-x: auto !important;
                padding-bottom: 10px !important;
            }
        }

        /*列表区域*/
        .mod_playlist .playlist__list {
            position: relative;

        }

        .slide__list {
            position: relative;
            font-size: 0;
            width: 1250%;
            transition: .5s;
        }

        .mod_playlist .playlist__item {
            position: relative;
            width: 1.6%;
            padding-bottom: 0;

        }

        .mod_slide {
            margin-bottom: 20px;
        }

        .mod_playlist .playlist__item {
            display: inline-block;
            width: 1.6%;
            padding-bottom: 44px;
            overflow: hidden;
            font-size: 14px;
            vertical-align: top;
        }

        .mod_index--hot .mod_playlist .playlist__item_box {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
        }

        .mod_playlist .playlist__item_box {
            position: relative;
            margin-right: 20px;
        }

        .mod_playlist .playlist__cover {
            position: relative;
            display: block;
            overflow: hidden;
            padding-top: 100%;
            margin-bottom: 15px;
        }

        .mod_cover {
            zoom: 1;
        }

        .playlist__pic {
            position: absolute;
            top: 0;
            left: 0;
        }

        .mod_cover__mask {
            position: absolute;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: #000;
            opacity: 0;
            filter: alpha(opacity=0);
            transition: opacity .5s;
        }

        .mod_slide_switch {
            width: 100%;
            text-align: center;
            right: 55px;
            position: relative;
        }

        .slide_switch__item {
            display: inline-block;
            width: 28px;
            height: 12px;
            padding: 0 0 26px;
            margin: 0 1px;
            background: transparent;
        }

        .slide_switch__item_active .slide_switch__bg {
            background-color: rgba(0, 0, 0, .6);
        }

        .mod_playlist .playlist__title a {
            font-size: 14px;
        }

        a {
            color: #000;
            cursor: pointer;
            text-decoration: none;
        }

        .playlist__other {
            color: #999;
            height: 22px;
            font-size: 14px;
            display: block;
        }

        .playlist__title_txt {
            float: left;
        }
        .active {
            background: rgba(255, 255, 255, 0.15);
        }

        .mod_cover__icon_play {
            position: absolute;
            left: 50%;
            top: 50%;
            margin: -35px;
            width: 70px;
            height: 70px;
            filter: alpha(opacity=0);
            opacity: 0;
            -webkit-transform: scale(.7) translateZ(0);
            -webkit-transition-property: opacity, -webkit-transform;
            -webkit-transition-duration: .5s;
            transform: scale(.7) translateZ(0);
            transition-property: opacity, transform;
            transition-duration: .5s;
            zoom: 1;
        }

        .mod_cover:hover .mod_cover__icon_play {
            opacity: 1;
            filter: none;
        }

        .mod_cover:hover .mod_cover__mask {
            opacity: .2;
            filter: alpha(opacity=20);
            transition: opacity .5s;
        }

        .slide_switch__item {
            display: inline-block;
            width: 28px;
            height: 12px;
            padding: 0 0 26px;
            margin: 0 1px;
            background: transparent;
        }

        .slide_switch__bg {
            display: block;
            width: 8px;
            height: 8px;
            background-color: rgba(0, 0, 0, .1);
            border-radius: 12px;
            margin: 0 auto;
        }
        .navbar-right img { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; }
        /* 分页圆点 hover 效果 */
        .slide_switch__item:hover .slide_switch__bg {
            background-color: rgba(0, 0, 0, .4);
            cursor: pointer;
        }
        /* 激活状态保持原有样式 */
        .slide_switch__item_active .slide_switch__bg {
            background-color: rgba(0, 0, 0, .6);
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
        <!-- Logo区域 -->
        <div class="logo-section">
            <span>ai 一听</span>
        </div>

        <!-- 菜单导航 -->
        <nav class="menu-nav">
            <ul class="menu-list">
                <li class="menu-item active">
                    <a href="songSheetPage" class="menu-link">
                        <img src="static/images/首页-active.png" class="menu-icon-img active-img" alt="">
                        <img src="static/images/首页.png" class="menu-icon-img normal-img" alt="" style="display: none;">
                        <span class="menu-text">首页</span>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="FavoriteServlet" class="menu-link btn">
                        <img src="static/images/喜欢-active.png" class="menu-icon-img active-img" alt=""
                             style="display: none;">
                        <img src="static/images/喜欢.png" class="menu-icon-img normal-img" alt="">
                        <span class="menu-text">我的喜欢</span>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="artists" class="menu-link">
                        <img src="static/images/歌手分类-active.png" class="menu-icon-img active-img" alt=""
                             style="display: none;">
                        <img src="static/images/歌手分类.png" class="menu-icon-img normal-img" alt="">
                        <span class="menu-text">歌手分类</span>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="ai.jsp" class="menu-link">
                        <img src="static/images/ai-active.png" class="menu-icon-img active-img" alt=""
                             style="display: none;">
                        <img src="static/images/ai.png" class="menu-icon-img normal-img" alt="">
                        <span class="menu-text">智能AI</span>
                    </a>
                </li>
            </ul>
        </nav>
    </aside>

    <!-- 右侧主内容区域 -->
    <main class="main-content">

        <!-- 顶部导航栏 -->
        <div class="top-navbar">
            <div class="navbar-left">
                <div class="navbar-title"></div>
            </div>
            <div class="navbar-right">
                <span class="username"></span>
                <img src="" alt="用户头像" style="" class="avatar"/>
                <span class="exit"><img src="static/images/退出.png" style="width: 13px;height: 13px;" alt=""/>退出</span>
            </div>
        </div>
        <!-- 内容区域 -->
        <div class="content-area">
            <!-- 首页内容 -->
            <div class="page-content" id="homePage">
                <!-- 右侧主内容区域 -->
                <main class="main-content">
                    <div class="moder_bg mod_index mod_bg" id="content">
                        <div class="section_inner  ">
                            <!-- 标题 -->
                            <div class="index__hd">
                                <h2 class="custom-title">歌单推荐</h2>
                            </div>

                            <!-- 分页展示 -->
                            <div class="mod_playlist mod_slide">
                                <ul class="playlist__list slide__list">
                                    <!-- 动态渲染当前页歌单数据 -->
                                    <c:forEach items="${songSheetPage.data}" var="sheet">
                                        <li class="playlist__item">
                                            <a href="playlist?sheet_id=${sheet.id}">
                                                <div class="playlist__item_box">
                                                    <div class="playlist__cover mod_cover">
                                                        <!-- 动态加载歌单封面 -->
                                                        <img src="${sheet.songSheetAvatar}" class="playlist__pic" alt="${sheet.songSheetName}">
                                                        <i class="mod_cover__mask"></i>
                                                        <img src="./static/images/播放1.png" class="mod_cover__icon_play">
                                                    </div>
                                                    <div class="playlist__title_txt">
                                                            ${sheet.songSheetName}
                                                        <!-- 显示歌单简介和歌曲数量 -->
                                                        <span class="playlist__other">${sheet.songSheetResume} | ${sheet.songCount}首</span>
                                                    </div>
                                                </div>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>

                            <!-- 动态渲染分页圆点指示器 -->
                            <ul class="mod_slide_switch" id="paginationDots">
                                <c:forEach begin="1" end="${songSheetPage.totalPage}" var="page">
                                    <li class="slide_switch__item ${songSheetPage.currentPage == page ? 'slide_switch__item_active' : ''}">
                                        <a class="slide_switch__bg" href="javascript:switchPage(${page})"></a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </main>
            </div>

            <!-- 我的喜欢页面 -->
            <div class="page-content" id="favoritePage" style="display: none;">
                <!-- 关键修改2：iframe也指向Servlet，保持统一 -->
                <iframe src="FavoriteServlet" class="page-iframe" frameborder="0"></iframe>
            </div>

            <!-- 歌手分类页面 -->
            <div class="page-content" id="artistsPage" style="display: none;">
                <iframe src="artists" class="page-iframe" frameborder="0"></iframe>
            </div>

            <!-- 智能AI页面 -->
            <div class="page-content" id="aiPage" style="display: none;">
                <iframe src="ai.jsp" class="page-iframe" frameborder="0"></iframe>
            </div>
        </div>
    </main>
</div>
<script>
    let exit=document.querySelector('.exit');
    exit.addEventListener("click",function () {
        window.location.href = "${pageContext.request.contextPath}/logout";
    })
    // 分页切换函数
    function switchPage(pageNum) {
        window.location.href = "${pageContext.request.contextPath}/songSheetPage?pageNum=" + pageNum;
    }

    // 页面初始化：修复EL表达式在JS中的使用方式
    window.onload = function() {
        // 方式1：通过JSP判断后输出JS变量（推荐）
        <c:choose>
        <c:when test="${empty songSheetPage}">
        // 没有分页数据时，主动加载第一页
        switchPage(1);
        </c:when>
        <c:otherwise>
        // 有分页数据时，无需额外操作
        <%--console.log("当前页码：", ${songSheetPage.currentPage});--%>
        </c:otherwise>
        </c:choose>

        const currentUrl = window.location.pathname;
        const menuLinks = document.querySelectorAll('.menu-link');

        // 关键修改3：优化菜单激活逻辑，兼容FavoriteServlet路径
        if (currentUrl.includes("songSheetPage") || currentUrl.includes("index.jsp")) {
            activateMenuItem(0); // 首页
        } else if (currentUrl.includes("FavoriteServlet")) {
            activateMenuItem(1); // 我的喜欢
        } else if (currentUrl.includes("artists")) {
            activateMenuItem(2); // 歌手分类
        } else if (currentUrl.includes("ai.jsp")) {
            activateMenuItem(3); // 智能AI
        }

        // 核心：提取菜单激活逻辑为函数，避免重复代码
        function activateMenuItem(index) {
            // 先重置所有菜单项
            menuLinks.forEach(link => {
                const parent = link.closest('.menu-item');
                parent.classList.remove('active');
                parent.querySelector('.active-img').style.display = 'none';
                parent.querySelector('.normal-img').style.display = 'inline';
            });
            // 激活目标菜单项
            const targetLink = menuLinks[index];
            const targetParent = targetLink.closest('.menu-item');
            targetParent.classList.add('active');
            targetParent.querySelector('.active-img').style.display = 'inline';
            targetParent.querySelector('.normal-img').style.display = 'none';
        }
    }

    // 关键修改4：增强用户信息容错处理，避免null报错
    let userJson = <%= session.getAttribute("User") == null ? "{}" : session.getAttribute("User") %>;
    let user = typeof userJson === 'object' && userJson !== null ? userJson : {};

    // console.log("完整用户对象：", user);
    localStorage.setItem('user', JSON.stringify(user));

    // 容错处理：用户信息不存在时不报错
    if (user.nickname) {
        document.querySelector('.username').innerHTML = user.nickname;
    }
    if (user.avatar) {
        document.querySelector('.avatar').src = user.avatar;
    }


</script>
<script src="static/js/main.js"></script>
</body>
</html>