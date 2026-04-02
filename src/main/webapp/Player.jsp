<%--
  Created by IntelliJ IDEA.
  User: dog
  Date: 2026/1/14
  Time: 19:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
  <meta charset="UTF-8">
  <meta name="viewport"
        content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>音乐播放器</title>
  <!--引入jQuery文件-->
  <script src="static/js/jquery.js"></script>
  <!--引入flexible文件-->
  <script src="static/js/flexible.js"></script>
  <!--引入bootstrap的JavaScript文件-->
  <script src="static/js/bootstrap.js"></script>
  <!--引入axios库文件-->
  <script src="static/js/axios.js"></script>
  <!--引入normalize文件-->
  <link type="text/css" rel="stylesheet" href="static/css/normalize.css">
  <!--引入bootstrap的样式表-->
  <link type="text/css" rel="stylesheet" href="static/css/bootstrap.css">
  <!--引入自定义样式表-->
  <link type="text/css" rel="stylesheet" href="static/css/bf.css">
  <!--不支持JavaScript设置-->
  <noscript>您的浏览器不支持JavaScript</noscript>
  <style>
    /* ========== 新增：logo样式 ========== */
    .music-logo {
      position: fixed; /* 固定在左上角，滚动页面也不会位移 */
      top: 0.2rem;     /* 距离顶部的距离，适配移动端rem单位 */
      left: 0.2rem;    /* 距离左侧的距离 */
      font-size: 0.4rem;/* 字体大小，适配移动端 */
      color: #fff;  /* 白色文字 */
      z-index: 9999;   /* 最高层级，避免被其他元素遮挡 */
      text-shadow: 0 0 5px rgba(0,0,0,0.3); /* 加轻微阴影，提升辨识度 */
      margin: 0;
      padding: 0.1rem;
      cursor: pointer;
    }
  </style>
</head>

<body>
<!-- ========== 新增：logo HTML结构 ========== -->
<h4 class="music-logo">ai - 一听</h4>

<!--背景图片部分-->
<div id="bgImage" class="bg">

</div>

<!--播放器主体部分-->
<div class="player_main">

  <!--唱片与歌曲信息及歌词部分 -->
  <div class="player_images_lyrics">
    <!--唱片部分-->
    <div class="player_images">
      <div class="disk">
        <img class="paused" id="disk_image" title="" src="" style="display: block">
      </div>
    </div>
    <!--歌词部分-->
    <div class="player_lyrics">
      <div class="info">
        <!--歌曲标题与歌手-->
        <header class="title">
          <div class="music_name"></div>
          <div class="music_singer"></div>
        </header>
        <!--正式歌词部分-->
        <div id="lyrics" class="lyrics">
          <ul id="lyrics_contents" class="lyrics_contents">
            <!--渲染生成歌词-->
            <!--<li class="sentence" data-order="0"></li>-->
          </ul>
        </div>
      </div>
    </div>
  </div>
  <!--控制部分-->
  <div class="player_control">
    <!--音乐源-->
    <audio id="player" controls="controls" style="position: absolute; visibility: hidden" >
      <source src="">
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
        <span id="current"></span>&nbsp;&nbsp;/&nbsp;&nbsp;<span id="total"></span>
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
        <button class=" btn-primary" id="music_list" type="button" data-bs-toggle="offcanvas"
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
    </div>
  </div>
</div>
<script>
  $(() => {
    // ========== 补充id、bg、lyrics属性 ==========
    const musics = [
      <c:forEach var="song" items="${songList}" varStatus="status">
      {
        name: "${song.name}",
        singer: "${song.singer}",
        audio: "${song.audio}",
        record: "${song.record}",// 唱片图片路径
        bg: "${song.bg}"        // 补充背景图属性
      }${status.last ? '' : ','}
      </c:forEach>
    ];

    // ========== 确保根据currentSongId正确匹配索引 ==========
    let num = 0;
    const currentSongId = ${currentSongId};
    // 遍历数组找到当前歌曲的索引（兼容currentSongId不存在的情况）
    if (musics.length > 0 && currentSongId) {
      for (let i = 0; i < musics.length; i++) {
        // 确保id类型一致（数字对比）
        if (musics[i].id === Number(currentSongId)) {
          num = i;
          break;
        }
      }
    }

    //播放列表模块
    (function () {

      let str = musics.map(function (ele, index) {
        console.log()
        return '<button type="button" class="list-group-item list-group-item-action music" ' +
                'data-id="' + index + '" ' +
                'data-song-id="' + ele.id + '" ' +
                'aria-current="false">' + ele.name + '</button>';
      }).join('');
      $('#list-group').html(str);
    })();


    //初始化播放
    //初始化播放
    function initPlay(num, shouldPlay = true) {
      // 安全校验：防止num超出数组范围
      if (num < 0 || num >= musics.length) num = 0;

      //唱片旋转复位以及修改唱片图片
      const recordUrl = musics[num].bg;
      console.log(recordUrl)
      $('#disk_image').removeClass('played').addClass('paused').attr('src', recordUrl);
      //背景图片切换（补充非空判断）
      const bgUrl = musics[num].bg; // 默认背景图
      $('#bgImage').css({ 'background-image': "url("+bgUrl+")"});
      //音乐播放状态
      document.getElementById('player').pause();
      //歌曲换源（补充非空判断）
      const audioUrl = musics[num].audio || '';
      $('#player').eq(0).attr('src', audioUrl);
      //播放按钮初始化
      $('#play_btn').removeClass('icon_stop_btn').addClass('icon_status_btn');
      //歌曲名称初始化
      $('.music_name').text(musics[num].name || '未知歌曲');
      //歌手初始化
      $('.music_singer').text(musics[num].singer || '未知歌手');
      //歌单当前播放设置
      $('#list-group').children().eq(num).addClass('active').siblings().removeClass('active');

      //初始化歌词（补充非空判断，避免加载不存在的歌词文件）
      const lyricsPath = musics[num].lyrics;
      if (lyricsPath) {
        lyricsLode(lyricsPath);
      } else {
        $('#lyrics_contents').html('<li class="sentence">暂无歌词</li>');
      }
      //重置歌词同步状态
      $('#lyrics_contents').css({ 'transform': 'translateY(0)' }).children().removeClass('active_sentence');

      // 如果需要播放，则尝试播放
      if (shouldPlay) {
        const audioElement = document.getElementById('player');
        if (audioUrl) {
          const playPromise = audioElement.play();

          if (playPromise !== undefined) {
            playPromise.then(() => {
              // 播放成功，更新UI状态
              $('#play_btn').removeClass('icon_status_btn').addClass('icon_stop_btn');
              $('#disk_image').removeClass('paused').addClass('played');
            }).catch((error) => {
              console.log('播放被阻止:', error);
              // 保持暂停状态，等待用户交互
              $('#play_btn').removeClass('icon_stop_btn').addClass('icon_status_btn');
            });
          }
        }
      }
    }


    // 初始化播放（确保num有效）
    initPlay(num, true);

    //时间进度模块
    // 获取音频元素和显示当前时间的元素
    const totalTime = $("#total");
    let current = $("#current");
    let audioPlayer = document.getElementById('player');

    //获取音乐总时长
    audioPlayer.addEventListener('canplaythrough', getTotal);

    function getTotal() {
      let duration = audioPlayer.duration;
      let minutes = parseInt(duration / 60);
      let seconds = parseInt(duration % 60);
      let m = minutes >= 10 ? minutes : '0' + minutes;
      let s = seconds >= 10 ? seconds : '0' + seconds;
      let total = m + ':' + s;
      totalTime.text(total);
      return duration;
    }
    document.querySelector('.music-logo').addEventListener('click',()=>{
      window.history.back();//返回上一页
    })

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
      let progress = ((currentTime / getTotal()) * 100).toFixed(2) + '%';
      $('#cursor').css({ 'width': progress });
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
      $('#play_btn').toggleClass('icon_stop_btn');
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
      alert("音乐文件加载失败，请检查路径是否正确！");
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
    const status = ['static/images/mode1.png', 'static/images/mode2.png', 'static/images/mode3.png'];
    //初始化播放模式图标（避免样式丢失）
    $('#status_btn').css({ 'background-image': `url(${status[0]})` });
    //切换状态
    let status_id = 0;
    $('#status_btn').click(() => {
      status_id++;
      if (status_id === status.length) {
        status_id = 0;
      }
      $('#status_btn').css({ 'background-image': `url(${status[status_id]})` });
    });

    //状态监测并执行对应操作
    function getStatus() {
      const play_btn = $('#play_btn');
      switch (status_id) {
              //单曲循环模式
        case 0:
          audioPlayer.currentTime = 0; // 重置播放进度到开头
          play_btn.trigger('click');
          break;
              //顺序播放模式
        case 1:
          $('#next_btn').trigger('click');
          play_btn.trigger('click');
          break;
              //随机播放模式
        case 2:
          randomPlay();
          initPlay(num,true);
          play_btn.trigger('click');
          break;
      }
    }

    //随机播放功能
    function randomPlay() {
      if (musics.length <= 1) return; // 只有1首歌时不随机
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
      if (speed_id >= speeds.length) { // 修复边界判断错误
        speed_id = 0;
      }
      $('#speed').text(speeds[speed_id] + 'X');
      //调用audio的API实现播放速度切换
      audioPlayer.playbackRate = speeds[speed_id];
    });

    //切歌模块
    (function () {
      //下一首
      $('#next_btn').click(() => {
        num++;
        if (num >= musics.length) {
          num = 0;
        }
        initPlay(num,true);
        getCurrentTime();
      })
      //上一首
      $('#prev_btn').click(() => {
        num--;
        if (num < 0) {
          num = musics.length - 1;
        }
        initPlay(num,true);
        getCurrentTime();
      });
    })();

    //通过歌曲列表实现切换歌曲
    $('#list-group').on('click', 'button', function () {
      // 注意：这里要把data-id转成数字
      const index = parseInt($(this).attr('data-id'));
      if (!isNaN(index)) {
        num = index; // 更新全局num，保证切歌逻辑一致
        initPlay(index);
      }
    });

    //音量控制模块
    (function () {
      //当点击音量图标，切换状态,同时将音量设置为0
      const loudness_icon = $('#loudness_icon');
      const loudness_ruler_bar = $('.loudness_ruler_bar');
      // 初始化音量
      audioPlayer.volume = (parseInt(loudness_ruler_bar.val()) / 100).toFixed(2);

      loudness_icon.on('click', function () {
        $(this).toggleClass('close_voice');
        if (document.querySelector('#loudness_icon').classList.contains('close_voice')) {
          audioPlayer.volume = 0;
        } else {
          audioPlayer.volume = (parseInt(loudness_ruler_bar.val()) / 100).toFixed(2);
        }
      })
      //当拖动音量条时改变音量
      loudness_ruler_bar.on('input', function () { // 改用input事件，实时响应
        const volume = (parseInt($(this).val()) / 100).toFixed(2);
        audioPlayer.volume = volume;
        //当音量为零时，自动切换音量图标状态
        if (volume <= 0) {
          loudness_icon.addClass('close_voice');
        } else {
          loudness_icon.removeClass('close_voice');
        }
      })
    })();

    //键盘检测模块（通过空格键可以进行播放与暂停）
    document.addEventListener('keyup', (e) => {
      if (e.keyCode === 32 && !e.target.tagName.toLowerCase() === 'input') { // 避免输入框中按空格触发
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
        if (lycArr.length === 0) {
          $('#lyrics_contents').html('<li class="sentence">暂无歌词</li>');
          return;
        }
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
          const activeLine = $('.active_sentence');
          if (activeLine.length && activeLine.attr("data-order") > 6) {
            const offset = -40 * (activeLine.attr("data-order") - 6);
            $('#lyrics_contents').css({ 'transform': `translateY(${offset}px)` });
          }
        }

        audioPlayer.addEventListener('timeupdate', function () {
          let curTime = parseFloat(audioPlayer.currentTime.toFixed(3));
          synchronizeLyrics(curTime);
          lyricsScroll();
        });
      }).catch(function (error) {
        console.error('加载歌词失败:', error);
        $('#lyrics_contents').html('<li class="sentence">歌词加载失败</li>');
      });
    }
  });
</script>
</body>
</html>