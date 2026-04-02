<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: dog
  Date: 2026/1/5
  Time: 08:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>歌手详情页</title>
    <link rel="stylesheet" href="static/css/main.css">
    <style>
        /* 原有样式完全保留，不修改 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "微软雅黑", sans-serif;
        }
        body {
            background-color: #f5f5f5;
        }
        .container {
            width: 1200px;
            margin: 20px auto;
            background-color: #fff;
            border-radius: 4px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .header {
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .logo {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }
        .search-bar {
            display: flex;
            align-items: center;
        }
        .search-bar button {
            margin-left: 8px;
            background: none;
            border: none;
            cursor: pointer;
        }
        .user-info {
            display: flex;
            align-items: center;
        }
        .user-info span {
            margin-right: 10px;
        }
        .user-info img {
            width: 40px; height: 40px; border-radius: 50%; object-fit: cover;
        }
        .user-info .logout {
            color: #999;
            cursor: pointer;
            font-size: 14px;
        }
        .sidebar {
            width: 200px;
            float: left;
            border-right: 1px solid #eee;
        }
        .sidebar ul {
            list-style: none;
        }
        .sidebar li {
            padding: 15px 20px;
            cursor: pointer;
            color: #666;
        }
        .sidebar li:hover {
            background-color: #f8f8f8;
        }
        .sidebar li.active {
            color: #ff6700;
        }
        .main-content {
            margin-left: 200px;
            padding: 20px;
        }
        .singer-header {
            display: flex;
            align-items: flex-start;
            margin-bottom: 20px;
        }
        .singer-avatar {
            width: 120px;
            height: 120px;
            background-color: #ddd;
            border-radius: 4px;
            margin-right: 20px;
            overflow: hidden;
        }
        .singer-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .singer-info h2 {
            font-size: 24px;
            margin-bottom: 8px;
        }
        .singer-info span {
            color: #999;
            margin-bottom: 10px;
        }
        .btn-group button {
            padding: 5px 10px;
            margin-right: 5px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        .btn-green {
            background-color: #52c41a;
            color: #fff;
        }
        .btn-gray {
            background-color: #f5f5f5;
            color: #333;
        }
        .song-table {
            width: 100%;
            border-collapse: collapse;
        }
        .song-table th, .song-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        .song-table th {
            background-color: #f8f8f8;
            font-weight: normal;
            color: #666;
        }
        .song-table td {
            color: #333;
        }
        .header .back-btn { padding: 5px 10px; background: #eee; border: none; border-radius: 3px; cursor: pointer; position: relative; left: 150px;}
        #aa{
            position: relative;
            left: 160px;
        }
        .no-data {
            text-align: center;
            color: #999;
            padding: 20px 0;
        }
        .avatar { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; }
        .like-wrap {
            position: relative;
            display: inline-flex;
            align-items: center;
            width: 100%;
        }
        .like-btn {
            opacity: 0;
            margin-left: 8px;
            cursor: pointer;
            transition: all 0.2s ease;
            color: #999;
            position: absolute;
            right: 0;
        }
        .song-table tr:hover .like-btn {
            opacity: 1;
        }
        .like-btn:hover {
            color: #ff6700;
        }
        .like-btn.active {
            color: #ff6700;
        }
        .like-btn.disabled {
            cursor: not-allowed;
            opacity: 0.5 !important;
        }
        .song-table td:nth-child(3) {
            position: relative;
            padding-right: 25px;
        }
        .exit{
            cursor: pointer;
        }
        a{
            text-decoration: none;
            color: #000;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 头部区域 -->
    <div class="header">
        <div>
            <span>ai 一听</span>
            <button class="back-btn">返回</button>
            <input type="hidden" id="singerId" value="${SingerBaseInfo.singerId}">
            <input type="text"  id="aa" placeholder="请输入歌名" value="${song_name}"/>
            <button style="border: none; background: none; cursor: pointer;position: relative;left: 138px;top: 2px;" class="search">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
            </button>
        </div>
        <div class="navbar-right">
            <span class="username"></span>
            <img src="" alt="用户头像" class="avatar"/>
            <span class="exit"><img src="static/images/退出.png" style="width: 13px;height: 13px;" alt=""/>退出</span>
        </div>
    </div>

    <!-- 侧边栏 + 主内容 -->
    <div class="content-wrap">
        <div class="sidebar">
            <ul>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
            </ul>
        </div>

        <div class="main-content">
            <c:if test="${not empty SingerBaseInfo}">
                <div class="singer-header">
                    <div class="singer-avatar">
                        <img src="${not empty SingerBaseInfo.avatar ? SingerBaseInfo.avatar : 'images/default-avatar.png'}"
                             alt="歌手头像"/>
                    </div>
                    <div class="singer-info">
                        <h2>${SingerBaseInfo.singerName}</h2>
                        <c:forEach items="${SongList}" var="song">
                            <span>${song.type}</span>
                        </c:forEach>
                        <div class="btn-group">
                            <button class="btn-green"><img src="images/播放 (1).png" style="width: 13px;height: 13px;">播放全部</button>
                            <button class="btn-gray"><img src="images/下载.png" style="width: 13px;height: 13px;">下载</button>
                            <button class="btn-gray"><img src="images/批量编辑.png" style="width: 13px;height: 13px;">批量</button>
                        </div>
                    </div>
                </div>
            </c:if>

            <table class="song-table">
                <thead>
                <tr>
                    <th>歌曲</th>
                    <th>专辑</th>
                    <th>时长</th>
                </tr>
                </thead>
                <tbody id="songList">
                <c:choose>
                    <c:when test="${not empty SongList}">
                        <c:forEach items="${SongList}" var="song" varStatus="status">
                            <tr>
                                <td><a href="player?SongId=${song.songId}">${song.songName}</a></td>
                                <td><a href="player?SongId=${song.songId}">${song.album}</a></td>
                                <td>
                                    <div class="like-wrap">
                                        <a href="player?SongId=${song.songId}"> ${song.time}</a>
                                        <!-- 移除data-like-status，仅保留歌曲ID -->
                                        <svg class="like-btn" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                             data-song-id="${song.songId}">
                                            <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                                        </svg>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="3" class="no-data">未找到匹配的歌曲</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script>
    // 从localStorage获取用户信息
    let user = null;
    try {
        user = JSON.parse(localStorage.getItem('user')) || {};
    } catch (e) {
        user = {};
    }
    // 设置用户信息到页面
    if (user.nickname) {
        document.querySelector('.username').innerHTML = user.nickname;
    }
    if (user.avatar) {
        document.querySelector('.avatar').src = user.avatar;
    }

    // 基础功能：搜索/返回按钮（保留）
    let search = document.querySelector('.search');
    search.addEventListener('click',function () {
        let singerId = document.getElementById('singerId').value;
        let songName = document.querySelector('#aa').value;
        // 新增：校验歌手ID不能为空
        if (!singerId) {
            alert('歌手ID不能为空！');
            return;
        }
        window.location.href = 'artists_detail?singer_id=' + singerId + '&song_name=' + encodeURIComponent(songName);
    });
    document.getElementById('aa').addEventListener('keydown', function(e) {
        if (e.key === 'Enter') {
            search.click();
        }
    });
    document.querySelector('.back-btn').addEventListener('click', function () {
        window.location.href = 'artists';
    });

    // ========== 通用AJAX工具函数（统一参数/action） ==========
    function sendAjax(action, targetId, callback) {
        // 登录校验
        if (!user || !user.id) {
            alert('请先登录后再操作！');
            return;
        }
        const userId = Number(user.id);
        if (isNaN(userId) || userId <= 0) {
            alert('用户ID格式错误，请重新登录！');
            return;
        }

        // 增删操作校验targetId
        const isModifyAction = ['addSong', 'deleteSong', 'addSheet', 'deleteSheet'].includes(action);
        if (isModifyAction) {
            if (!targetId && targetId !== 0) {
                alert('目标ID不能为空！');
                return;
            }
            if (isNaN(Number(targetId))) {
                alert('目标ID必须是数字！');
                return;
            }
        }

        // 发送请求
        const xhr = new XMLHttpRequest();
        xhr.open('POST', 'likeSong', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.timeout = 3000; // 超时时间
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    callback(xhr.responseText);
                } else {
                    alert('请求失败：' + xhr.statusText);
                }
            }
        };
        xhr.ontimeout = function() {
            alert('请求超时，请刷新重试！');
        };

        // 拼接参数（关键：用targetId，和后端一致）
        const params = new URLSearchParams();
        params.append('userId', userId);
        params.append('action', action);
        if (targetId || targetId === 0) {
            params.append('targetId', targetId);
        }
        xhr.send(params);
    }

    //  核心：点赞功能（纯数据库操作）
    document.addEventListener('DOMContentLoaded', function() {
        const likeBtns = document.querySelectorAll('.like-btn');

        // 校验用户是否登录
        let userId = Number(user.id);
        if (!user || !user.id || isNaN(userId) || userId <= 0) {
            alert('请先登录后再操作！');
            likeBtns.forEach(btn => {
                btn.classList.add('disabled');
                btn.style.pointerEvents = 'none';
            });
            return;
        }

        // ========== 1. 初始化歌曲点赞状态（修正action为querySong） ==========
        sendAjax('querySong', '', function(likedSongIdsStr) {
            console.log("已收藏歌曲ID列表：", likedSongIdsStr); // 调试用
            const likedSongIds = likedSongIdsStr ? likedSongIdsStr.split(',').map(Number) : [];
            likeBtns.forEach(btn => {
                const songId = Number(btn.getAttribute('data-song-id'));
                if (likedSongIds.includes(songId)) {
                    btn.classList.add('active');
                }
            });
        });

        // ========== 2. 绑定点赞/取消点击事件（修正action为addSong/deleteSong） ==========
        likeBtns.forEach(btn => {
            btn.addEventListener('click', function() {
                const songId = Number(this.getAttribute('data-song-id'));
                if (isNaN(songId) || songId <= 0) {
                    alert('歌曲ID格式错误！');
                    return;
                }

                const isLiked = this.classList.contains('active');
                const action = isLiked ? 'deleteSong' : 'addSong';

                sendAjax(action, songId, function(res) {
                    alert(res);
                    if (action === 'addSong') {
                        btn.classList.add('active');
                    } else {
                        btn.classList.remove('active');
                    }
                });
            });
        });
    });
    let exit=document.querySelector('.exit');
    exit.addEventListener("click",function () {
        window.location.href = "${pageContext.request.contextPath}/logout";
    })
</script>

</body>
</html>