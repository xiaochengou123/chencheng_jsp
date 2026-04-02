<%--
  Created by IntelliJ IDEA.
  User: dog
  Date: 2026/1/5
  Time: 08:49
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册 - AI听歌系统</title>
    <link rel="stylesheet" href="static/css/auth.css">
</head>
<body>


<div class="container">
    <!-- 音乐装饰元素 -->
    <div class="music-notes">
        <span class="note note-1">♪</span>
        <span class="note note-2">♫</span>
        <span class="note note-3">♪</span>
        <span class="note note-4">♫</span>
        <span class="note note-5">♪</span>
    </div>

    <!-- 注册表单 -->
    <div class="auth-box" id="registerBox">

        <h1 class="title">注册</h1>
        <form id="registerForm" action="register" method="post">
            <div class="input-group">
                <input type="text" name="username" id="registerUsername" placeholder="用户名"  value="${username}">
            </div>
            <div class="input-group">
                <input type="text" name="nickname" id="registerNickname" placeholder="昵称" value="${nickname}">
            </div>
            <div class="input-group email-group">
                <input type="email" name="email" id="registerEmail" placeholder="邮箱" value="${email}">
                <button type="button" class="btn-code" id="getCodeBtn">获取验证码</button>
            </div>
            <div class="input-group">
                <input type="text" name="code" id="verifyCode" placeholder="邮箱验证码" required value="${code}">
            </div>
            <div class="input-group">
                <input type="password" name="password" id="registerPassword" placeholder="设置密码" required value="${password}">
            </div>
            <div class="input-group">
                <input type="password" id="confirmPassword" placeholder="确认密码" required>
            </div>
            <button type="submit" class="btn-primary">注册</button>
            <div class="switch-text">
                已有账号？<a href="login.jsp">立即登录</a>
            </div>
        </form>
    </div>
</div>
<script>

    // ================== 关键修复：把showMessage提为全局函数 ==================
    function showMessage(message, type = 'info') {
        document.querySelectorAll('.message').forEach(el => el.remove());

        const messageDiv = document.createElement('div');
        messageDiv.className ="message message-"+type;
        messageDiv.textContent = message;

        let bgColor;
        if (type === 'error') {
            bgColor = '#e74c3c';
        } else if (type === 'success') {
            bgColor = '#2ecc71';
        } else {
            bgColor = '#3498db';
        }

        messageDiv.style.position = 'fixed';
        messageDiv.style.top = '20px';
        messageDiv.style.left = '50%';
        messageDiv.style.transform = 'translateX(-50%)';
        messageDiv.style.padding = '12px 24px';
        messageDiv.style.borderRadius = '6px';
        messageDiv.style.color = 'white';
        messageDiv.style.fontSize = '14px';
        messageDiv.style.zIndex = '1000';
        messageDiv.style.backgroundColor = bgColor;
        messageDiv.style.animation = 'slideDown 0.4s ease';
        document.body.appendChild(messageDiv);

        setTimeout(() => {
            messageDiv.style.animation = 'slideUp 0.4s ease';
            setTimeout(() => {
                if (messageDiv.parentNode) messageDiv.parentNode.removeChild(messageDiv);
            }, 400);
        }, 3000);
    }

    // ================== 展示后端传递的错误信息（修复执行时机） ==================
    <% if (request.getAttribute("error") != null) { %>
    // 页面加载时直接调用全局的showMessage
    showMessage('<%= request.getAttribute("error").toString().replace("'", "\\'") %>', 'error');
    <% } %>

    document.addEventListener('DOMContentLoaded', function () {
        const registerForm = document.getElementById('registerForm');
        const getCodeBtn = document.getElementById('getCodeBtn');

        let countdown = 0;
        let countdownTimer = null;

        // ================== 注册逻辑 ==================
        if (registerForm && getCodeBtn) {
            registerForm.addEventListener('submit', function (e) {
                const username = document.getElementById('registerUsername').value.trim();
                const nickname = document.getElementById('registerNickname').value.trim();
                const email = document.getElementById('registerEmail').value.trim();
                const Code = document.getElementById('verifyCode').value.trim();
                const password = document.getElementById('registerPassword').value;
                const confirmPassword = document.getElementById('confirmPassword').value;

                // 前端验证逻辑保留，提前拦截错误
                if (!validateRegisterForm(username, nickname, email, Code, password, confirmPassword)) {
                    e.preventDefault();
                    return;
                }
                if (password !== confirmPassword) {
                    e.preventDefault();
                    showMessage('密码不一致', 'error');
                    return;
                }



            });

            getCodeBtn.addEventListener('click', function () {
                const username = document.getElementById('registerUsername').value.trim();
                const nickname = document.getElementById('registerNickname').value.trim();
                const password = document.getElementById('registerPassword').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                const email = document.getElementById('registerEmail').value.trim();
                if (!validateEmail(email)) {
                    showMessage('请输入有效的邮箱地址', 'error');
                    return;
                }

                // 发送 AJAX 请求获取验证码
                fetch('EmailServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: "email="+encodeURIComponent(email)+"&username="+encodeURIComponent(username)+"&nickname="+encodeURIComponent(nickname)+"&password="+encodeURIComponent(password)
                })
                    .then(response => {
                        // 调试：打印完整的响应状态和URL
                        // console.log("响应状态码：", response.status);
                        // console.log("响应URL：", response.url);
                        // 读取响应内容并打印
                        return response.text().then(text => {
                            // console.log("Servlet返回的内容：", text);
                            return { ok: response.ok, text: text };
                        });
                    })
                    .then(data => {
                        if (data.ok) {
                            sendVerificationCode();
                            showMessage('验证码发送请求已提交', 'success');
                        } else {
                            showMessage('发送验证码失败：' + data.text, 'error');
                        }
                    })
                    .catch(error => {
                        showMessage('网络错误，发送验证码失败', 'error');
                        // console.error('获取验证码失败:', error);
                    });
            });
        }

        // ================== 验证码相关 ==================
        function sendVerificationCode() {
            showMessage('正在发送验证码...', 'info');
            startCountdown();
        }

        function startCountdown() {
            countdown = 60;
            getCodeBtn.disabled = true;
            updateButtonText();

            countdownTimer = setInterval(() => {
                countdown--;
                if (countdown <= 0) {
                    clearInterval(countdownTimer);
                    getCodeBtn.disabled = false;
                    getCodeBtn.textContent = '获取验证码';
                } else {
                    updateButtonText();
                }
            }, 1000);
        }

        function updateButtonText() {
            getCodeBtn.textContent = countdown+"秒后重试";
        }

        // ================== 表单验证 ==================
        function validateRegisterForm(username, nickname, email, verifyCode, password, confirmPassword) {
            if (username.length < 3) {
                showMessage('用户名长度至少为3位', 'error');
                return false;
            }
            if (!/^[a-zA-Z0-9_]+$/.test(username)) {
                showMessage('用户名只能包含字母、数字和下划线', 'error');
                return false;
            }
            if (nickname.length < 2) {
                showMessage('昵称长度至少为2位', 'error');
                return false;
            }
            if (!validateEmail(email)) {
                showMessage('请输入有效的邮箱地址', 'error');
                return false;
            }
            if (!verifyCode) {
                showMessage('请输入验证码', 'error');
                return false;
            }
            if (password.length < 6) {
                showMessage('密码长度至少为6位', 'error');
                return false;
            }
            return true;
        }

        function validateEmail(email) {
            const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return re.test(email);
        }

        // 动画样式
        if (!document.getElementById('auth-message-style')) {
            const style = document.createElement('style');
            style.id = 'auth-message-style';
            style.textContent = `
                @keyframes slideDown {
                    from { opacity: 0; transform: translateX(-50%) translateY(-30px); }
                    to { opacity: 1; transform: translateX(-50%) translateY(0); }
                }
                @keyframes slideUp {
                    from { opacity: 1; transform: translateX(-50%) translateY(0); }
                    to { opacity: 0; transform: translateX(-50%) translateY(-30px); }
                }
            `;
            document.head.appendChild(style);
        }
    });
</script>

</body>
</html>