<%--
  Created by IntelliJ IDEA.
  User: dog
  Date: 2026/1/5
  Time: 08:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>我的喜欢</title>
  <link rel="stylesheet" href="static/css/main.css">
  <link rel="stylesheet" href="static/css/index.css">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: "Microsoft Yahei", sans-serif;
    }

    body {
      color: #333;
    }

    /* 标题样式 */
    .title {
      font-size: 32px;
      font-weight: 700;
      margin-bottom: 20px;
    }
    a{
      text-decoration: none;
    }

    /* 标签栏样式 - 扩大点击区域 */
    .tab-bar {
      display: flex;
      gap: 25px;
      margin-bottom: 20px;
      border-bottom: 1px solid #eee;
      padding-bottom: 10px;
    }
    .tab-item {
      font-size: 16px;
      color: #666;
      cursor: pointer;
      display: flex;
      align-items: center;
      padding: 5px 10px;
      user-select: none;
    }
    .tab-item.active {
      color: #00b51d;
      font-weight: 500;
    }
    .tab-num {
      margin-left: 5px;
    }

    /* 功能按钮栏 */
    .btn-bar {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 15px;
    }
    .left-btns {
      display: flex;
      gap: 10px;
    }
    .func-btn {
      border-radius: 2px;
      font-size: 14px;
      margin-right: 6px;
      padding: 0 23px;
      height: 38px;
      line-height: 38px;
      display: inline-block;
      white-space: nowrap;
      box-sizing: border-box;
      overflow: hidden;
      min-width: 122px;
      text-align: center;
      border: 1px solid #c9c9c9;
    }
    .func-btn1, .func-btn {
      border-radius: 2px;
      font-size: 14px;
      margin-right: 6px;
      padding: 0 23px;
      height: 38px;
      line-height: 38px;
      display: inline;
      white-space: nowrap;
      box-sizing: border-box;
      overflow: hidden;
    }
    .func-btn1 {
      border: 1px solid #31c27c;
      background-color: #31c27c;
      color: #fff;
    }
    .right-tools {
      display: flex;
      align-items: center;
      gap: 15px;
    }
    .search-box {
      display: flex;
      align-items: center;
      gap: 5px;
      color: #999;
      font-size: 14px;
    }
    .tool-icons {
      display: flex;
      align-items: center;
      gap: 12px;
    }
    .tool-icons i {
      width: 16px;
      height: 16px;
      cursor: pointer;
      background-color: #ccc;
      display: block;
      border-radius: 3px;
    }

    /* 列表表头 */
    .list-header {
      display: grid;
      grid-template-columns: 3fr 2fr 1fr;
      padding: 8px 0;
      font-size: 14px;
      color: #999;
      border-bottom: 1px solid #eee;
    }

    /* 歌曲列表项 */
    .song-item {
      display: grid;
      grid-template-columns: 3fr 2fr 1fr;
      align-items: center;
      padding: 10px 0;
      background-color: #f9f9f9;
      margin-top: 5px;
      border-radius: 3px;
    }
    .info {
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .cover {
      width: 40px;
      height: 40px;
      border-radius: 2px;
      margin-left: 12px;
      background-color: #c8e6c9;
    }
    .song-text {
      display: flex;
      flex-direction: column;
      gap: 3px;
    }
    .song-name {
      font-size: 14px;
      color: #333;
      display: flex;
      align-items: center;
      gap: 5px;
    }
    .tag-vip {
      font-size: 10px;
      color: #fff;
      background-color: #fa2c19;
      padding: 1px 3px;
      border-radius: 2px;
    }
    .tag-hq {
      font-size: 10px;
      color: #fff;
      background-color: #ff8a00;
      padding: 1px 3px;
      border-radius: 2px;
    }
    .song-singer {
      font-size: 12px;
      color: #999;
    }
    .song-album {
      font-size: 14px;
      color: #666;
    }
    .song-duration {
      font-size: 14px;
      color: #666;
      text-align: right;
      padding-right: 10px;
      margin-right: 12px;
    }
    .content-area {
      padding-left: 12px;
      flex: 1;
      overflow-y: auto;
    }
    .list-header .time {
      text-align: right;
      margin-right: 24px;
    }
    .mod_btn_green__icon_play {
      top: 12px;
    }
    .navbar-right img {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      object-fit: cover;
    }

    /* 歌单展示区域样式 */
    .playlist-container {
      display: none; /* 默认隐藏 */
      margin-top: 10px;
    }
    .mod_playlist {
      width: 100%;
    }
    .playlist__list {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
      list-style: none;
    }
    .playlist__item {
      width: 200px;
    }
    .playlist__item_box {
      width: 100%;
    }
    .playlist__cover {
      position: relative;
      width: 200px;
      height: 200px;
    }
    .playlist__pic {
      width: 100%;
      height: 100%;
      object-fit: cover;
      border-radius: 4px;
    }
    .mod_cover__mask {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0,0,0,0.2);
      border-radius: 4px;
      display: none;
    }
    .playlist__cover:hover .mod_cover__mask {
      display: block;
    }
    .mod_cover__icon_play {
      position: absolute;
      bottom: 10px;
      right: 10px;
      width: 40px;
      height: 40px;
      display: none;
    }
    .playlist__cover:hover .mod_cover__icon_play {
      display: block;
    }
    .playlist__title_txt {
      margin-top: 8px;
      font-size: 14px;
      color: #333;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
    .playlist__other {
      font-size: 12px;
      color: #999;
      display: block;
      margin-top: 4px;
    }

    /* 无数据/加载中样式 */
    .no-data {
      padding: 20px;
      text-align: center;
      color: #999;
      font-size: 14px;
    }
    .exit{
      cursor: pointer;
    }
    /* 加载中样式 */
    .loading {
      padding: 20px;
      text-align: center;
      color: #666;
      font-size: 14px;
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
        <li class="menu-item active">
          <a href="FavoriteServlet" class="menu-link">
            <img src="static/images/喜欢-active.png" class="menu-icon-img active-img" alt="">
            <img src="static/images/喜欢.png" class="menu-icon-img normal-img" alt="" style="display: none;">
            <span class="menu-text">我的喜欢</span>
          </a>
        </li>
        <li class="menu-item">
          <a href="artists" class="menu-link">
            <img src="static/images/歌手分类-active.png" class="menu-icon-img active-img" alt="" style="display: none;">
            <img src="static/images/歌手分类.png" class="menu-icon-img normal-img" alt="">
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
        <img src="" alt="用户头像" style="" class="avatar"/>
        <span class="exit"><img src="static/images/退出.png" style="width: 13px;height: 13px;" alt="" />退出</span>
      </div>
    </div>

    <div class="content-area">
      <h1 class="title">喜欢</h1>
      <!-- 标签栏 -->
      <div class="tab-bar">
        <div class="tab-item active" data-type="1">
          歌曲<span class="tab-num">${songCount}</span>
        </div>
        <div class="tab-item" data-type="2">
          歌单<span class="tab-num">${sheetCount}</span>
        </div>
      </div>

      <!-- 功能按钮栏 -->
      <div class="btn-bar">
        <div class="left-btns">
<%--          循环我要的是这个player?SongId=1,2格式--%>

    <c:forEach var="song" items="${list}" varStatus="status">
        <c:if test="${status.index == 0}">
            <c:set var="songIds" value="${song.songId}"/>
        </c:if>
        <c:if test="${status.index > 0}">
            <c:set var="songIds" value="${songIds},${song.songId}"/>
        </c:if>
    </c:forEach>
    <a class="func-btn1" href="player?SongId=${songIds}">全部播放</a>
        </div>
      </div>

      <!-- 歌曲列表区域 -->
      <div class="song-list-container" <c:if test="${currentType == 2}">style="display: none;"</c:if>>
        <div class="list-header">
          <div>歌名/歌手</div>
          <div>专辑</div>
          <div class="time">时长</div>
        </div>
        <div id="song-list-content">
          <c:choose>
            <c:when test="${not empty list && currentType == 1}">
              <c:forEach items="${list}" var="favorite">
            <a href="player?SongId=${favorite.songId}">
                <div class="song-item">
                  <div class="info">
                    <div><img src="${favorite.avatar}" class="cover"  alt=""/></div>
                    <div class="song-text">
                      <div class="song-name">${favorite.songName}</div>
                      <div class="song-singer">${favorite.singerName}</div>
                    </div>
                  </div>
                  <div class="song-album">${favorite.album}</div>
                  <div class="song-duration">${favorite.time}</div>

                </div>
            </a>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <div class="no-data">未找到喜欢的歌曲</div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>

      <!-- 歌单展示区域 -->
      <div class="playlist-container" <c:if test="${currentType == 1}">style="display: none;"</c:if>>
        <div class="mod_playlist mod_slide">
          <ul id="playlist-list-content" class="playlist__list slide__list">
            <c:choose>
              <c:when test="${not empty list && currentType == 2}">
                <c:forEach items="${list}" var="sheet">
                  <li class="playlist__item">
                    <a href="playlist?sheet_id=${sheet.id}">
                      <div class="playlist__item_box">
                        <div class="playlist__cover mod_cover">
                          <!-- 动态加载歌单封面 -->
                          <img src="${sheet.songSheetAvatar}" class="playlist__pic" alt="${sheet.songSheetName}">
                          <i class="mod_cover__mask"></i>
                          <img src="./static/images/播放1.png" class="mod_cover__icon_play" alt="播放">
                        </div>
                        <div class="playlist__title_txt">
                            ${sheet.songSheetName}
                          <span class="playlist__other" >${sheet.songSheetResume} | ${sheet.songCount}首</span>
                        </div>
                      </div>
                    </a>
                  </li>
                </c:forEach>
              </c:when>
              <c:otherwise>
                <li class="no-data">未找到喜欢的歌单</li>
              </c:otherwise>
            </c:choose>
          </ul>
        </div>
      </div>
    </div>
  </main>
</div>

<script>
  let exit=document.querySelector('.exit');
  exit.addEventListener("click",function () {
    window.location.href = "${pageContext.request.contextPath}/logout";
  })
  // 初始化用户信息
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
  // console.log("当前页面：收藏");

  // 核心：标签切换逻辑
  // 容错处理：用户信息不存在时不报错
  if (user.nickname) {
    document.querySelector('.username').innerHTML = user.nickname;
  }
  if (user.avatar) {
    document.querySelector('.avatar').src = user.avatar;
  }
  // console.log("当前页面：收藏");

  // 核心：标签切换逻辑
  document.addEventListener('DOMContentLoaded', function() {
    // 1. 获取标签元素
    const tabItems = document.querySelectorAll('.tab-item');
    const songListContainer = document.querySelector('.song-list-container');
    const playlistContainer = document.querySelector('.playlist-container');
    const songListContent = document.getElementById('song-list-content');
    const playlistListContent = document.getElementById('playlist-list-content');

    // 2. 绑定点击事件
    tabItems.forEach(tab => {
      tab.addEventListener('click', function() {
        // 移除所有标签的active类
        tabItems.forEach(item => item.classList.remove('active'));
        // 给当前点击的标签添加active类
        this.classList.add('active');

        // 获取当前选中的类型（1=歌曲，2=歌单）
        const type = parseInt(this.getAttribute('data-type'));
        // 获取用户ID（从localStorage的用户信息中取）
        const userId = user.id || '';

        // 3. 切换显示容器
        if (type === 1) {
          songListContainer.style.display = 'block';
          playlistContainer.style.display = 'none';
        } else {
          songListContainer.style.display = 'none';
          playlistContainer.style.display = 'block';
        }

        // 4. 发起AJAX请求获取对应数据
        loadFavoriteData(userId, type);
      });
    });

    // 初始化默认选中的标签（如果页面加载时currentType是2，默认选中歌单）
    <c:if test="${currentType == 2}">
    document.querySelector('.tab-item[data-type="2"]').classList.add('active');
    document.querySelector('.tab-item[data-type="1"]').classList.remove('active');
    </c:if>
  });

  // 加载收藏数据的AJAX函数
  function loadFavoriteData(userId, type) {
    // 校验用户ID
    if (!userId) {
      alert('未获取到用户信息，请先登录！');
      return;
    }

    // 显示加载中状态
    const targetContent = type === 1 ?
            document.getElementById('song-list-content') :
            document.getElementById('playlist-list-content');
    targetContent.innerHTML = '<div class="loading">加载中...</div>';

    // 创建AJAX请求
    const xhr = new XMLHttpRequest();
    // 改用传统字符串拼接方式拼接URL（核心修改点）
    const requestUrl = "FavoriteServlet?userId=" + userId + "&type=" + type + "&ajax=true";
    xhr.open('GET', requestUrl, true);
    xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');

    xhr.onreadystatechange = function() {
      if (xhr.readyState === 4) {
        if (xhr.status === 200) {
          // 解析返回的JSON数据
          try {
            const data = JSON.parse(xhr.responseText);
            // 渲染数据到页面
            renderFavoriteData(data, type);
          } catch (e) {
            targetContent.innerHTML = '<div class="no-data">数据解析失败</div>';
            console.error('解析数据失败：', e);
          }
        } else {
          // 请求失败处理
          targetContent.innerHTML = '<div class="no-data">加载失败，请重试</div>';
          console.error('请求失败，状态码：', xhr.status);
        }
      }
    };

    xhr.send();
  }

  // 渲染收藏数据到页面
  function renderFavoriteData(data, type) {
    const targetContent = type === 1 ?
            document.getElementById('song-list-content') :
            document.getElementById('playlist-list-content');

    // 无数据情况
    if (!data || data.length === 0) {
      targetContent.innerHTML = type === 1 ?
              '<div class="no-data">未找到喜欢的歌曲</div>' :
              '<li class="no-data">未找到喜欢的歌单</li>';
      return;
    }

    // 渲染歌曲列表（type=1）
    if (type === 1) {
      let html = '';
      data.forEach(favorite => {
        html +=
                '<div class="song-item">' +
                '<div class="info">' +
                '<div><img src="' + (favorite.avatar || '') + '" class="cover" alt=""/></div>' +
                '<div class="song-text">' +
                '<div class="song-name">' + (favorite.songName || '未知歌曲') + '</div>' +
                '<div class="song-singer">' + (favorite.singerName || '未知歌手') + '</div>' +
                '</div>' +
                '</div>' +
                '<div class="song-album">' + (favorite.album || '未知专辑') + '</div>' +
                '<div class="song-duration">' + (favorite.time || '00:00') + '</div>' +
                '</div>';
      });
      targetContent.innerHTML = html;
    }
    // 渲染歌单列表（type=2）
    else if (type === 2) {
      let html = '';
      data.forEach(sheet => {
        html +=
                '<li class="playlist__item">' +
                '<a href="playlist?sheet_id=' + (sheet.id || '') + '">' +
                '<div class="playlist__item_box">' +
                '<div class="playlist__cover mod_cover">' +
                // 动态加载歌单封面，无封面时用默认图
                '<img src="' + (sheet.songSheetAvatar || 'static/images/default-playlist.png') + '" class="playlist__pic" alt="' + (sheet.songSheetName || '未知歌单') + '">' +
                '<i class="mod_cover__mask"></i>' +
                '<img src="./static/images/播放1.png" class="mod_cover__icon_play" alt="播放">' +
                '</div>' +
                '<div class="playlist__title_txt">' +
                (sheet.songSheetName || '未知歌单') +
                '<span class="playlist__other">' + (sheet.songSheetResume || '无简介') + ' | ' + (sheet.songCount || 0) + '首</span>' +
                '</div>' +
                '</div>' +
                '</a>' +
                '</li>';
      });
      targetContent.innerHTML = html;
    }

  }
</script>

<script src="static/js/main.js"></script>
</body>
</html>