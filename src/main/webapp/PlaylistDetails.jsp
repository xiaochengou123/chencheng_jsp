<%--
  Created by IntelliJ IDEA.
  User: dog
  Date: 2026/1/5
  Time: 08:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>歌单详情页</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box;}
        body { background: #f5f5f5; padding: 20px; }
        .container { width: 1000px; margin: 0 auto; background: #fff; border-radius: 4px; box-shadow: 0 0 5px rgba(0,0,0,0.1); }
        /* 顶部导航 */
        .header { padding: 15px 20px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; }
        .header .back-btn { padding: 5px 10px; background: #eee; border: none; border-radius: 3px; cursor: pointer; margin-left: 80px}
        .header .user { display: flex; align-items: center; gap: 10px; }
        .header .user img { width: 30px; height: 30px; border-radius: 50%; }
        /* 侧边栏 + 歌单内容 */
        .main { display: flex; }
        .sidebar { width: 150px; padding: 20px; border-right: 1px solid #eee; }
        .sidebar ul { list-style: none; }
        .sidebar li { padding: 8px 0; cursor: pointer; }
        .sidebar li.active { color: #ff4a4a; }
        /* 歌单详情 */
        .playlist-detail { flex: 1; padding: 20px; }
        .playlist-header { display: flex; gap: 20px; margin-bottom: 20px; }
        .playlist-header .cover { width: 120px; height: 120px; background: #eee; }
        .playlist-info .tags { color: #999; font-size: 12px; margin: 5px 0; }
        .playlist-info .desc { color: #666; font-size: 14px; margin-bottom: 10px; }
        .playlist-info .btns button { padding: 5px 10px; margin-right: 10px; border: none; border-radius: 3px; cursor: pointer; }
        .playlist-info .btns .play { background: #2db55d; color: #fff; }
        /* 歌曲列表 */
        .song-table { width: 100%; border-collapse: collapse; }
        .song-table th, .song-table td { padding: 10px; border-bottom: 1px solid #eee; text-align: left; }
        .song-table th { font-weight: normal; color: #999; }
        .user img{
            width: 40px; height: 40px; border-radius: 50%; object-fit: cover;
        }
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
        /* 新增歌单喜欢按钮样式 */
        .sheet-like-btn {
            transition: all 0.2s ease;
        }
        .sheet-like-btn.disabled {
            cursor: not-allowed;
            opacity: 0.5;
        }
        .exit{
            cursor: pointer;
        }
       tr a {
            text-decoration: none;
            color: #000;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 顶部导航 -->
    <div class="header">
        <div>
            <span>ai 一听</span>
            <button class="back-btn">返回</button>
        </div>
        <div class="user">
            <span class="username"></span>
            <img src="" alt="" class="avatar">
            <span class="exit"><img src="static/images/退出.png" style="width:13px;height:13px;" alt=""/>退出</span>
        </div>
    </div>

    <!-- 主体：侧边栏 + 歌单内容 -->
    <div class="main">
        <div class="sidebar"></div>

        <!-- 静态歌单详情 -->
        <div class="playlist-detail">
            <!-- 歌单头部（封面 + 信息） -->
            <div class="playlist-header">
                <div class="cover"><img src="${songSheet.songSheetAvatar}" alt="歌单封面" style="width:100%;height:100%;"></div>
                <div class="playlist-info">
                    <h2> ${songSheet.songSheetName}</h2>
                    <div class="tags">标签:
                        <c:forEach items="${songSheet.type}" var="type">
                            <span class="tag">${type}</span>
                        </c:forEach>
                    </div>
                    <div class="desc">${songSheet.songSheetResume}</div>
                    <div class="btns">
                        <button class="play"><img src="static/images/播放 (1).png" style="width:13px;height:13px;" alt="">播放全部</button>
                        <!-- 修复：将songSheetId改为id，并增加空值兜底 -->
                        <button class="sheet-like-btn" data-sheet-id="${empty songSheet.id ? '' : songSheet.id}">
                            <img src="static/images/喜欢.png" style="width:13px;height:13px;">
                        </button>
                    </div>
                </div>
            </div>

            <!-- 歌曲列表 -->
            <table class="song-table">
                <thead>
                <tr>
                    <th>歌曲</th>
                    <th>歌手</th>
                    <th>专辑</th>
                    <th>时长</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty Info}">
                        <c:forEach items="${Info}" var="song" >

                            <tr>

                                <td><a href="player?SongId=${song.songId}">${song.songName} </a></td>
                                <td><a href="player?SongId=${song.songId}">${song.singerName} </a></td>
                                <td><a href="player?SongId=${song.songId}">${song.album} </a></td>
                                <td>
                                    <div class="like-wrap">
                                            ${song.time}
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
                            <td colspan="4" class="no-data">未找到匹配的歌曲</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    // 从Session获取用户信息
    let userJson = <%= session.getAttribute("User") == null ? "{}" : session.getAttribute("User") %>;
    let user = typeof userJson === 'object' ? userJson : {};
    // 修复：将songSheetId改为id，并增加空值兜底（转为JS合法语法）
    const sheetId = ${empty songSheet.id ? 'null' : songSheet.id};

    // console.log("完整用户对象：", user);
    // console.log("歌单ID：", sheetId); // 调试用：查看歌单ID是否正确
    document.querySelector('.username').innerHTML = user.nickname ;
    document.querySelector('.avatar').src= user.avatar;
    document.querySelector('.back-btn').addEventListener('click', function () {
       window.history.back();//返回上一页
    });



    // ========== 1. 歌曲点赞逻辑 ==========
    document.addEventListener('DOMContentLoaded', function() {
        const songLikeBtns = document.querySelectorAll('.like-btn');
        const sheetLikeBtn = document.querySelector('.sheet-like-btn');

        // 通用用户登录校验
        let userId = null;
        if (!user || !user.id) {
            alert('请先登录后再操作！');
            // 禁用所有点赞/收藏按钮
            songLikeBtns.forEach(btn => {
                btn.classList.add('disabled');
                btn.style.pointerEvents = 'none';
            });
            sheetLikeBtn.classList.add('disabled');
            sheetLikeBtn.style.pointerEvents = 'none';
            return;
        }
        userId = Number(user.id);
        if (isNaN(userId) || userId <= 0) {
            alert('用户ID格式错误！请重新登录');
            songLikeBtns.forEach(btn => {
                btn.classList.add('disabled');
                btn.style.pointerEvents = 'none';
            });
            sheetLikeBtn.classList.add('disabled');
            sheetLikeBtn.style.pointerEvents = 'none';
            return;
        }

        // 歌单ID非空校验（仅针对歌单操作）
        if (sheetLikeBtn && (!sheetId || sheetId <= 0)) {
            alert('歌单ID无效，请刷新页面重试！');
            sheetLikeBtn.classList.add('disabled');
            sheetLikeBtn.style.pointerEvents = 'none';
        }

        // ========== 2. 初始化歌曲点赞状态（修复：增加日志） ==========
        sendAjax('querySong', '', function(likedSongIdsStr) {
            // console.log("查询已收藏歌曲返回结果：", likedSongIdsStr);
            const likedSongIds = likedSongIdsStr ? likedSongIdsStr.split(',').map(Number) : [];
            // console.log("解析后的已收藏歌曲ID列表：", likedSongIds);
            songLikeBtns.forEach(btn => {
                const songId = Number(btn.dataset.songId);
                if (likedSongIds.includes(songId)) {
                    btn.classList.add('active');
                }
            });
        });

        // ========== 3. 歌曲点赞/取消点击事件 ==========
        songLikeBtns.forEach(btn => {
            btn.addEventListener('click', function() {
                const songId = Number(this.dataset.songId);
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

        // ========== 4. 初始化歌单收藏状态 ==========
        sendAjax('querySheet', '', function(likedSheetIdsStr) {
            // console.log("查询已收藏歌单返回结果：", likedSheetIdsStr);
            const likedSheetIds = likedSheetIdsStr ? likedSheetIdsStr.split(',').map(Number) : [];
            // console.log("解析后的已收藏歌单ID列表：", likedSheetIds);
            if (likedSheetIds.includes(sheetId)) {
                sheetLikeBtn.classList.add('active');
                sheetLikeBtn.innerHTML = '<img src="static/images/喜欢-active.png" style="width:13px;height:13px;" alt="">';
            }
        });

        // ========== 5. 歌单收藏/取消点击事件 ==========
        sheetLikeBtn.addEventListener('click', function() {
            const isLiked = this.classList.contains('active');
            const action = isLiked ? 'deleteSheet' : 'addSheet';

            sendAjax(action, sheetId, function(res) {
                alert(res);
                // 更新按钮样式和文字
                if (action === 'addSheet') {
                    sheetLikeBtn.classList.add('active');
                    sheetLikeBtn.innerHTML = '<img src="static/images/喜欢-active.png" style="width:13px;height:13px;" alt="">';
                } else {
                    sheetLikeBtn.classList.remove('active');
                    sheetLikeBtn.innerHTML = '<img src="static/images/喜欢.png" style="width:13px;height:13px;" alt="">';
                }
            });
        });
        // ========== 通用工具函数：发送AJAX请求（修复核心） ==========
        function sendAjax(action, targetId, callback) {
            // 1. 先校验用户登录状态（所有操作都需要）
            if (!user.id) {
                alert('用户未登录');
                return;
            }

            // 2. 仅对增删操作校验targetId（query操作不需要targetId）
            const isModifyAction = ['addSong', 'deleteSong', 'addSheet', 'deleteSheet'].includes(action);
            if (isModifyAction) {
                // 增删操作必须传targetId，且不能是0/空
                if (!targetId && targetId !== 0) {
                    alert('目标ID不能为空');
                    return;
                }
                // 校验targetId是数字
                if (isNaN(Number(targetId))) {
                    alert('目标ID必须是数字');
                    return;
                }
            }

            // 3. 发送AJAX请求
            const xhr = new XMLHttpRequest();
            xhr.open('POST', 'likeSong', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    callback(xhr.responseText);
                }
            };
            // 拼接参数：兼容查询（targetId为空）和增删（targetId有值）
            const params="userId="+user.id+"&action="+action+"&targetId="+targetId;
            xhr.send(params);
        }
    });
    let exit=document.querySelector('.exit');
    exit.addEventListener("click",function () {
        window.location.href = "${pageContext.request.contextPath}/logout";
    })
</script>
</body>
</html>