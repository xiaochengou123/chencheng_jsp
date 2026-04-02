// 全局变量：请求控制器（替代原currentRequest，更规范）
let abortController = null;

// 渲染歌曲列表
function renderSongList(songList) {
    const songContainer = document.querySelector('.song-list-container');
    const listHeader = songContainer.querySelector('.list-header');
    songContainer.innerHTML = '';
    songContainer.appendChild(listHeader);

    if (!songList || songList.length === 0) {
        songContainer.innerHTML += '<div class="no-data">暂无喜欢的歌曲</div>';
        return;
    }

    let songHtml = '';
    songList.forEach(song => {
        songHtml += `
            <div class="song-item">
                <div class="info">
                    <div><img src="${song.avatar || 'images/default-cover.png'}" class="cover" /></div>
                    <div class="song-text">
                        <div class="song-name">${song.songName || '未知歌曲'}</div>
                        <div class="song-singer">${song.singerName || '未知歌手'}</div>
                    </div>
                </div>
                <div class="song-album">${song.album || '未知专辑'}</div>
                <div class="song-duration">${song.time || '00:00'}</div>
            </div>
        `;
    });
    songContainer.innerHTML += songHtml;
}

// 渲染歌单列表
function renderPlaylist(sheetList) {
    const playlistUl = document.querySelector('.playlist__list');
    playlistUl.innerHTML = '';

    if (!sheetList || sheetList.length === 0) {
        playlistUl.innerHTML = '<li class="no-data">暂无喜欢的歌单</li>';
        return;
    }

    let sheetHtml = '';
    sheetList.forEach(sheet => {
        sheetHtml += `
            <li class="playlist__item">
                <a href="playlist?sheet_id=${sheet.id || ''}">
                    <div class="playlist__item_box">
                        <div class="playlist__cover mod_cover">
                            <img src="${sheet.songSheetAvatar || 'images/default-playlist.png'}" class="playlist__pic" alt="${sheet.songSheetName || '未知歌单'}">
                            <i class="mod_cover__mask"></i>
                            <img src="images/播放1.png" class="mod_cover__icon_play">
                        </div>
                        <div class="playlist__title_txt">
                            ${sheet.songSheetName || '未知歌单'}
                            <span class="playlist__other">${sheet.songSheetResume || '暂无简介'} | ${sheet.songCount || 0}首</span>
                        </div>
                    </div>
                </a>
            </li>
        `;
    });
    playlistUl.innerHTML = sheetHtml;
}

// 核心：加载数据（抽离逻辑，便于复用）
async function loadData(userId, type, contextPath) {
    // 1. 中止上一次未完成的请求
    if (abortController) {
        abortController.abort();
    }
    // 2. 创建新的中止控制器
    abortController = new AbortController();
    const signal = abortController.signal;

    // 3. 获取容器元素，显示加载中
    const songContainer = document.querySelector('.song-list-container');
    const playlistContainer = document.querySelector('.playlist-container');
    const listHeader = songContainer.querySelector('.list-header');

    if (type === 1) {
        songContainer.style.display = 'block';
        playlistContainer.style.display = 'none';
        songContainer.innerHTML = listHeader.outerHTML + '<div class="no-data">加载中...</div>';
    } else {
        songContainer.style.display = 'none';
        playlistContainer.style.display = 'block';
        playlistContainer.querySelector('.playlist__list').innerHTML = '<li class="no-data">加载中...</li>';
    }

    // 4. 拼接正确的请求URL（核心修复：用隐藏元素的contextPath）
    const baseUrl = `${window.location.origin}${contextPath}/FavoriteServlet`;
    const params = new URLSearchParams();
    params.append("userId", userId);
    params.append("type", type);
    params.append("ajax", "true");
    const fullUrl = `${baseUrl}?${params.toString()}`;

    try {
        // 5. 发送请求（带中止信号）
        const response = await fetch(fullUrl, {
            method: 'GET',
            headers: { 'Content-Type': 'application/json;charset=UTF-8' },
            credentials: 'include', // 携带Cookie/Session
            signal: signal // 绑定中止信号
        });

        // 6. 检查响应状态
        if (!response.ok) {
            throw new Error(`服务器返回错误：${response.status}`);
        }

        // 7. 解析响应（先读文本，兼容空数据）
        const text = await response.text();
        if (!text) {
            throw new Error("服务器返回空数据");
        }
        const data = JSON.parse(text);

        // 8. 处理后端返回的错误
        if (data.error) {
            throw new Error(data.error);
        }

        // 9. 渲染数据
        if (type === 1) {
            renderSongList(data);
        } else {
            renderPlaylist(data);
        }
    } catch (error) {
        // 过滤主动中止的错误，只处理真实异常
        if (error.name !== 'AbortError') {
            console.error('加载失败:', error);
            const errorMsg = error.message || '加载失败，请重试';
            if (type === 1) {
                songContainer.innerHTML = listHeader.outerHTML + `<div class="no-data">${errorMsg}</div>`;
            } else {
                playlistContainer.querySelector('.playlist__list').innerHTML = `<li class="no-data">${errorMsg}</li>`;
            }
        }
    }
}

// 绑定标签点击事件
function bindTabClick(userId, contextPath) {
    console.log("用户ID：", userId, "上下文路径：", contextPath);
    if (!userId) {
        alert('未获取到用户信息，请重新登录！');
        window.location.href = `../../login.jsp`;
        return;
    }

    const tabItems = document.querySelectorAll('.tab-item');
    tabItems.forEach(tab => {
        // 移除原有事件，避免重复绑定
        tab.removeEventListener('click', tabClickHandler);
        // 绑定新事件
        tab.addEventListener('click', tabClickHandler);
    });

    // 点击处理器
    function tabClickHandler() {
        // 切换标签样式
        tabItems.forEach(item => item.classList.remove('active'));
        this.classList.add('active');
        // 获取类型并加载数据
        const type = this.dataset.type;
        loadData(userId, type, contextPath);
    }
}