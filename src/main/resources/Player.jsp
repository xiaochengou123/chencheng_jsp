<%--
  Created by IntelliJ IDEA.
  User: dog
  Date: 2026/1/14
  Time: 10:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>音乐播放器</title>
    <!--引入jQuery文件-->
    <script src="../webapp/static/js/jquery.js"></script>
    <!--引入flexible文件-->
    <script src="../webapp/static/js/flexible.js"></script>
    <!--引入bootstrap的JavaScript文件-->
    <script src="../webapp/static/js/bootstrap.js"></script>
    <!--引入axios库文件-->
    <script src="../webapp/static/js/axios.js"></script>
    <!--引入normalize文件-->
    <link type="text/css" rel="stylesheet" href="../webapp/static/css/normalize.css">
    <!--引入bootstrap的样式表-->
    <link type="text/css" rel="stylesheet" href="../webapp/static/css/bootstrap.css">
    <!--引入自定义样式表-->
    <link type="text/css" rel="stylesheet" href="../webapp/static/css/bf.css">
    <!--不支持JavaScript设置-->
    <noscript>您的浏览器不支持JavaScript</noscript>
</head>

<body>
<%
    // 获取传递的SongId参数
    String songIdStr = request.getParameter("SongId");
    int currentSongId = 1; // 默认播放第一首歌

    if (songIdStr != null && !songIdStr.trim().isEmpty()) {
        try {
            currentSongId = Integer.parseInt(songIdStr);
        } catch (NumberFormatException e) {
            currentSongId = 1;
        }
    }

    // 模拟从数据库获取的歌曲列表（这里写死）
    List<Song> songList = new ArrayList<>();

    // 添加歌曲数据
    songList.add(new Song(1, "暮色回响", "张韶涵",
            "static/audio/张韶涵 - 暮色回响.flac",
            "static/images/bg/bg-暮色回响-张韶涵.png",
            "static/images/record/record-暮色回响.jpg",
            "static/lrc/暮色回响.lrc"));

    songList.add(new Song(2, "I LOVE U", "洛天依",
            "static/audio/洛天依 - I LOVE U.flac",
            "static/images/bg/bg-此刻Memories-洛天依.png",
            "static/images/record/record-I LOVE U-洛天依.jpg",
            "static/lrc/ILOVEYOU.lrc"));

    songList.add(new Song(3, "我们都拥有海洋", "洛天依",
            "static/audio/洛天依 - 我们都拥有海洋.flac",
            "static/images/bg/bg-我们都拥有海洋-洛天依.png",
            "static/images/record/record-我们都拥有海洋-洛天依.jpg",
            "static/lrc/我们都拥有海洋.lrc"));

    songList.add(new Song(4, "歌行四方", "洛天依",
            "static/audio/洛天依 - 歌行四方.flac",
            "static/images/bg/bg-歌行四方-洛天依.png",
            "static/images/record/record-歌行四方-洛天依.jpg",
            "static/lrc/歌行四方.lrc"));

    songList.add(new Song(5, "此刻Memories", "洛天依",
            "static/audio/洛天依 - 此刻Memories (洛天依ver).flac",
            "static/images/bg/bg-此刻Memories-洛天依.png",
            "static/images/record/record-此刻Memories-洛天依.jpg",
            "static/lrc/此刻Memories.lrc"));

    // 确保当前歌曲ID在有效范围内
    if (currentSongId < 1) currentSongId = 1;
    if (currentSongId > songList.size()) currentSongId = songList.size();

    // 获取当前要播放的歌曲
    Song currentSong = null;
    for (Song song : songList) {
        if (song.getId() == currentSongId) {
            currentSong = song;
            break;
        }
    }

    // 如果找不到对应的歌曲，默认播放第一首
    if (currentSong == null && !songList.isEmpty()) {
        currentSong = songList.get(0);
        currentSongId = 1;
    }
%>

<%!
    // 定义一个内部类表示歌曲
    class Song {
        private int id;
        private String name;
        private String singer;
        private String audioPath;
        private String bgImagePath;
        private String recordImagePath;
        private String lyricsPath;

        public Song(int id, String name, String singer, String audioPath,
                    String bgImagePath, String recordImagePath, String lyricsPath) {
            this.id = id;
            this.name = name;
            this.singer = singer;
            this.audioPath = audioPath;
            this.bgImagePath = bgImagePath;
            this.recordImagePath = recordImagePath;
            this.lyricsPath = lyricsPath;
        }

        public int getId() { return id; }
        public String getName() { return name; }
        public String getSinger() { return singer; }
        public String getAudioPath() { return audioPath; }
        public String getBgImagePath() { return bgImagePath; }
        public String getRecordImagePath() { return recordImagePath; }
        public String getLyricsPath() { return lyricsPath; }
    }
%>

<!--背景图片部分-->
<div id="bgImage" class="bg"
     style="background-image: url('<%= currentSong != null ? currentSong.getBgImagePath() : "" %>');">
</div>

<!--播放器主体部分-->
<div class="player_main">
    <!--唱片与歌曲信息及歌词部分 -->
    <div class="player_images_lyrics">
        <!--唱片部分-->
        <div class="player_images">
            <div class="disk">
                <img class="paused" id="disk_image" title=""
                     src="<%= currentSong != null ? currentSong.getRecordImagePath() : "" %>"
                     style="display: block">
            </div>
        </div>
        <!--歌词部分-->
        <div class="player_lyrics">
            <div class="info">
                <!--歌曲标题与歌手-->
                <header class="title">
                    <div class="music_name"><%= currentSong != null ? currentSong.getName() : "" %></div>
                    <div class="music_singer"><%= currentSong != null ? currentSong.getSinger() : "" %></div>
                </header>
                <!--正式歌词部分-->
                <div id="lyrics" class="lyrics">
                    <ul id="lyrics_contents" class="lyrics_contents">
                        <!--歌词将通过JavaScript动态加载-->
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!--控制部分-->
    <div class="player_control">
        <!--音乐源-->
        <audio id="player" controls="controls" style="position: absolute; visibility: hidden">
            <source src="<%= currentSong != null ? currentSong.getAudioPath() : "" %>">
        </audio>
        <!--进度条-->
        <div class="progress-bar">
            <div id="ruler" class="progress ruler" role="progressbar" aria-label="Animated striped example"
                 aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">
                <div id="cursor" class="progress-bar progress-bar-striped progress-bar-animated cursor"></div>
            </div>
        </div>
        <!--控制按钮-->
        <div class="button_table">
            <!--时间进度-->
            <div class="time">
                <span id="current">00:00</span>&nbsp;&nbsp;/&nbsp;&nbsp;<span id="total">00:00</span>
            </div>
            <!--核心控制组-->
            <div id="center_control">
                <!--状态按钮（默认单曲循环）-->
                <div id="status_btn" class="icon_status_btn model1"></div>
                <!--上一首-->
                <div id="prev_btn" class="icon_prev_btn"></div>
                <!--播放按钮-->
                <div id="play_btn" class="icon_play_btn"></div>
                <!--下一首-->
                <div id="next_btn" class="icon_next_btn"></div>
                <!--音量控制部分-->
                <div id="loudness_bar" class="loudness_bar">
                    <div id="loudness_icon" class="open_voice"></div>
                    <input type="range" class="loudness_ruler_bar" value="20" id="customRange1">
                </div>
            </div>
            <!--列表与倍速-->
            <div class="list_continue">
                <!--倍速模块-->
                <div id="speed">1.0X</div>
                <!--歌曲列表模块（按钮）-->
                <button class="btn-primary" id="music_list" type="button" data-bs-toggle="offcanvas"
                        data-bs-target="#offcanvasRight" aria-controls="offcanvasRight"></button>
            </div>
        </div>
    </div>
</div>
<!--歌单模块-->
<div class="offcanvas offcanvas-end right_nav" tabindex="-1" id="offcanvasRight"
     aria-labelledby="offcanvasRightLabel">
    <!--歌单标题-->
    <div class="offcanvas-header nav_header">
        <h5 class="offcanvas-title play_list" id="offcanvasRightLabel">播放队列</h5>
    </div>
    <!--歌曲列表-->
    <div class="offcanvas-body music_list_nav" style="padding-top: 0.1rem!important;">
        <div id="list-group" class="list-group"
             style="width: 100%!important; height: 100%!important; border-radius: 0!important;">
            <%
                // 渲染歌曲列表
                for (Song song : songList) {
                    String activeClass = (song.getId() == currentSongId) ? "active" : "";
            %>
            <button type="button" class="list-group-item list-group-item-action music <%= activeClass %>"
                    data-id="<%= song.getId() %>" aria-current="false">
                <%= song.getName() %> - <%= song.getSinger() %>
            </button>
            <%
                }
            %>
        </div>
    </div>
</div>

<script>
    $(() => {
        // 从JSP获取歌曲列表数据
        const musics = [
            <%
                for (int i = 0; i < songList.size(); i++) {
                    Song song = songList.get(i);
            %>
            {
                id: <%= song.getId() %>,
                audio: '<%= song.getAudioPath() %>',
                bg: '<%= song.getBgImagePath() %>',
                record: '<%= song.getRecordImagePath() %>',
                name: '<%= song.getName() %>',
                singer: '<%= song.getSinger() %>',
                lyrics: '<%= song.getLyricsPath() %>'
            }<%= (i < songList.size() - 1) ? "," : "" %>
            <%
                }
            %>
        ];

        // 当前播放的歌曲索引（从0开始）
        let num = <%= currentSongId - 1 %>;

        //初始化播放
        function initPlay(num) {
            //唱片旋转复位以及修改唱片图片
            $('#disk_image').removeClass('played').addClass('paused').attr('src', `${musics[num].record}`);
            //背景图片切换
            $('#bgImage').css({ 'background-image': `url(${musics[num].bg})` });
            //音乐播放状态
            document.getElementById('player').pause();
            //歌曲换源
            $('#player').eq(0).attr('src', `${musics[num].audio}`);
            //播放按钮初始化
            $('#play_btn').removeClass('icon_stop_btn').addClass('icon_play_btn');
            //歌曲名称初始化
            $('.music_name').text(musics[num].name);
            //歌手初始化
            $('.music_singer').text(musics[num].singer);
            //歌单当前播放设置
            $('#list-group').children().eq(num).addClass('active').siblings().removeClass('active');
            //初始化歌词
            lyricsLode(musics[num].lyrics);
            // 重置歌词同步状态
            $('#lyrics_contents').css({ 'transform': 'translateY(0)' }).children().removeClass('active_sentence');

            // 更新URL中的SongId参数（但不刷新页面）
            const newUrl = `Player.jsp?SongId=${musics[num].id}`;
            window.history.replaceState({}, document.title, newUrl);
        }

        //时间进度模块
        // 获取音频元素和显示当前时间的元素
        const totalTime = $("#total");
        let current = $("#current");
        let audioPlayer = document.getElementById('player');

        //获取音乐总时长
        audioPlayer.addEventListener('canplaythrough', getTotal);

        function getTotal() {
            let duration = audioPlayer.duration;
            if (isNaN(duration) || duration === Infinity) {
                return 0;
            }
            let minutes = parseInt(duration / 60);
            let seconds = parseInt(duration % 60);
            let m = minutes >= 10 ? minutes : '0' + minutes;
            let s = seconds >= 10 ? seconds : '0' + seconds;
            let total = m + ':' + s;
            totalTime.text(total);
            return duration;
        }

        // 每秒更新当前时间以及进度条
        function getCurrentTime() {
            //更新当前时间
            let currentTime = audioPlayer.currentTime;
            let minutes = parseInt(currentTime / 60);
            let seconds = parseInt(currentTime % 60);
            let m = minutes >= 10 ? minutes : '0' + minutes;
            let s = seconds >= 10 ? seconds : '0' + seconds;
            let currents = m + ':' + s;
            current.text(currents);
            //更新进度条
            changeRuler(currentTime);
        }

        //更新当前进度条
        function changeRuler(currentTime) {
            let totalDuration = getTotal();
            if (totalDuration > 0) {
                let progress = ((currentTime / totalDuration) * 100).toFixed(2) + '%';
                $('#cursor').css({ 'width': progress });
            }
        }

        //点击进度条跳转到指定点播放
        const ruler = $('#ruler');
        ruler.on('mousedown', function (event) {
            if (!audioPlayer.paused || audioPlayer.currentTime !== 0) {
                let pgsWidth = parseFloat($(ruler).css('width').replace('px', ''));
                let rate = event.offsetX / pgsWidth;
                audioPlayer.currentTime = audioPlayer.duration * rate;
                changeRuler(audioPlayer.currentTime);
            }
        });

        let intervalId = setInterval(getCurrentTime, 1000);

        //音乐播放结束
        audioPlayer.addEventListener('ended', function () {
            //清除计时器
            clearInterval(intervalId);
            //唱片停止旋转
            $('#disk_image').removeClass('played').addClass('paused');
            //播放按钮更改状态
            $('#play_btn').removeClass('icon_stop_btn').addClass('icon_play_btn');
            //进度条复位
            $('#cursor').css({ 'width': '0%' });
            //检测播放模式并执行对应操作
            getStatus();
            // 重置歌词同步状态
            $('#lyrics_contents').css({ 'transform': 'translateY(0)' }).children().removeClass('active_sentence');
        });

        // 如果音频加载失败，清除定时器
        audioPlayer.addEventListener('error', function () {
            clearInterval(intervalId);
            console.error("音乐文件出现问题！");
        });

        //播放/暂停按钮部分
        $('#play_btn').click(function () {
            //切换按钮样式
            $(this).toggleClass('icon_stop_btn');
            //切换唱片状态(停止or旋转)
            $('#disk_image').toggleClass('played');
            //播放歌曲
            const player = document.getElementById('player');
            if (player.paused) {
                player.play();
                //重置当前时间
                intervalId = setInterval(getCurrentTime, 1000);
            } else {
                player.pause();
            }
        });

        //播放状态部分
        //数据初始化
        const statusIcons = ['static/images/mode1.png', 'static/images/mode2.png', 'static/images/mode3.png'];
        //切换状态
        let status_id = 0;
        $('#status_btn').click(() => {
            status_id++;
            if (status_id === statusIcons.length) {
                status_id = 0;
            }
            $('#status_btn').css({ 'background-image': `url(${statusIcons[status_id]})` });
        });

        //状态监测并执行对应操作
        function getStatus() {
            switch (status_id) {
                //循环播放模式
                case 0:
                    audioPlayer.currentTime = 0;
                    audioPlayer.play();
                    $('#play_btn').addClass('icon_stop_btn').removeClass('icon_play_btn');
                    $('#disk_image').addClass('played').removeClass('paused');
                    intervalId = setInterval(getCurrentTime, 1000);
                    break;
                //顺序播放模式
                case 1:
                    //相当于一直点击下一首
                    $('#next_btn').trigger('click');
                    $('#play_btn').trigger('click');
                    break;
                //随机播放模式
                case 2:
                    randomPlay();
                    initPlay(num);
                    $('#play_btn').trigger('click');
                    break;
            }
        }

        //随机播放功能
        function randomPlay() {
            let id = parseInt(Math.random() * (musics.length));
            while (id === num) {
                id = parseInt(Math.random() * (musics.length));
            }
            num = id;
        }

        //倍速模块
        //数据初始化
        const speeds = ['1.0', '1.5', '2.0', '0.5'];
        //切换状态
        let speed_id = 0;
        $('#speed').click(() => {
            speed_id++;
            if (speed_id === speeds.length) {
                speed_id = 0;
            }
            $('#speed').text(speeds[speed_id] + 'X');
            //调用audio的API实现播放速度切换
            audioPlayer.playbackRate = parseFloat(speeds[speed_id]);
        });

        //切歌模块
        //下一首
        $('#next_btn').click(() => {
            num++;
            if (num === musics.length) {
                num = 0;
            }
            initPlay(num);
            //当前时间初始化
            getCurrentTime();
            //自动播放
            setTimeout(() => {
                $('#play_btn').trigger('click');
            }, 100);
        });

        //上一首
        $('#prev_btn').click(() => {
            num--;
            if (num < 0) {
                num = musics.length - 1;
            }
            initPlay(num);
            //当前时间初始化
            getCurrentTime();
            //自动播放
            setTimeout(() => {
                $('#play_btn').trigger('click');
            }, 100);
        });

        //通过歌曲列表实现切换歌曲
        $('#list-group').on('click', 'button', function () {
            const songId = parseInt($(this).attr('data-id'));
            // 找到对应歌曲的索引
            num = musics.findIndex(song => song.id === songId);
            if (num !== -1) {
                initPlay(num);
                //自动播放
                setTimeout(() => {
                    $('#play_btn').trigger('click');
                }, 100);
            }
        });

        //音量控制模块
        //当点击音量图标，切换状态,同时将音量设置为0
        const loudness_icon = $('#loudness_icon');
        const loudness_ruler_bar = $('.loudness_ruler_bar');
        loudness_icon.on('click', function () {
            $(this).toggleClass('close_voice');
            if (document.querySelector('#loudness_icon').classList.contains('close_voice')) {
                audioPlayer.volume = 0;
                loudness_ruler_bar.val(0);
            } else {
                audioPlayer.volume = 0.2;
                loudness_ruler_bar.val(20);
            }
        });

        //当拖动音量条时改变音量
        loudness_ruler_bar.on('input', function () {
            const volume = parseInt($(this).val()) / 100;
            audioPlayer.volume = volume;
            //当音量为零时，自动切换音量图标状态
            if (volume === 0) {
                document.querySelector('#loudness_icon').className = 'close_voice';
            } else {
                document.querySelector('#loudness_icon').className = 'open_voice';
            }
        });

        //键盘检测模块（通过空格键可以进行播放与暂停）
        document.addEventListener('keyup', (e) => {
            if (e.keyCode === 32 || e.code === 'Space') {
                e.preventDefault();
                $('#play_btn').trigger('click');
            }
        });

        //歌词模块
        function lyricsLode(lrcPath) {
            // 清空之前的歌词
            let lycArr = [];
            $('#lyrics_contents').empty();

            // 发起请求获取歌词文件
            axios.get(lrcPath).then(function (response) {
                // 确保响应的文本是字符串
                let lyricsText = response.data;
                // 解析歌词文本
                let lyricsLines = lyricsText.split('\n');
                lyricsLines.forEach(function (line) {
                    let matches = line.match(/\[(\d+:\d+\.\d+)\](.*)/);
                    if (matches && matches.length >= 3) {
                        let timeStr = matches[1];
                        let minutes = parseInt(timeStr.split(':')[0], 10);
                        let seconds = parseFloat(timeStr.split(':')[1]);
                        let time = minutes * 60 + seconds;
                        let text = matches[2].trim();
                        if (text) {
                            lycArr.push({ time: time, line: text });
                        }
                    }
                });

                // 渲染歌词
                let lyricsHtml = lycArr.map(function (lyric, index) {
                    return `<li class="sentence" data-order="${index}">${lyric.line}</li>`;
                }).join('');
                $('#lyrics_contents').html(lyricsHtml);

                //歌词同步
                function synchronizeLyrics(curTime) {
                    for (let i = 0; i < lycArr.length; i++) {
                        if (curTime >= lycArr[i].time && (!lycArr[i + 1] || curTime < lycArr[i + 1].time)) {
                            $('#lyrics_contents').children().eq(i).addClass('active_sentence').siblings().removeClass('active_sentence');
                            break;
                        }
                    }
                }

                //歌词滚动
                function lyricsScroll() {
                    const activeSentence = $('.active_sentence');
                    if (activeSentence.length > 0) {
                        const order = parseInt(activeSentence.attr("data-order"));
                        if (order > 6) {
                            $('#lyrics_contents').css({ 'transform': `translateY(${-40 * (order - 6)}px)` });
                        }
                    }
                }

                audioPlayer.addEventListener('timeupdate', function () {
                    let curTime = parseFloat(audioPlayer.currentTime.toFixed(3));
                    //高亮显示
                    synchronizeLyrics(curTime);
                    //歌词滚动
                    lyricsScroll();
                });
            }).catch(function (error) {
                console.error('加载歌词失败:', error);
                $('#lyrics_contents').html('<li class="sentence">歌词加载失败或暂无歌词</li>');
            });
        }

        // 初始化歌词
        lyricsLode(musics[num].lyrics);

        // 初始化播放状态
        audioPlayer.load();
    });
</script>
</body>

</html>
