<%--
  Created by IntelliJ IDEA.
  User: dog
  Date: 2026/1/5
  Time: 08:48
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录 - AI听歌系统</title>
    <link rel="stylesheet" href="static/css/auth.css">
</head>
<body>

<script>
    // ================== 1. 全局定义showMessage函数 ==================
    function showMessage(message, type = 'info') {
        document.querySelectorAll('.message').forEach(el => el.remove());

        const messageDiv = document.createElement('div');
        messageDiv.className = "message message-" + type;
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

    // ================== 2. 动画样式 ==================
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

    // ================== 3. 修复：后端错误信息展示（放到window.onload确保DOM加载完成） ==================
    <% if (request.getAttribute("error") != null) { %>
    window.onload = function () {
        // 强化转义：处理单引号、换行、回车等特殊字符，避免JS语法错误
        const errorMsg = '<%= request.getAttribute("error").toString().replace("'", "\\'").replace("\n", "\\n").replace("\r", "\\r") %>';
        showMessage(errorMsg, 'error');
    };
    <% } %>

    // ================== 4. 登录表单逻辑 ==================
    document.addEventListener('DOMContentLoaded', function () {
        const loginForm = document.getElementById('loginForm');

        if (loginForm) {
            loginForm.addEventListener('submit', function (e) {
                e.preventDefault();

                const username = document.getElementById('loginUsername').value.trim();
                const password = document.getElementById('loginPassword').value;

                if (username.length < 3) {
                    showMessage('用户名长度至少为3位', 'error');
                    return;
                }
                if (password.length < 6) {
                    showMessage('密码长度至少为6位', 'error');
                    return;
                }

                loginForm.submit();
            });
        }
    });
</script>

<div class="container">
    <div class="music-notes">
        <span class="note note-1">♪</span>
        <span class="note note-2">♫</span>
        <span class="note note-3">♪</span>
        <span class="note note-4">♫</span>
        <span class="note note-5">♪</span>
    </div>

    <div class="auth-box" id="loginBox">
        <h1 class="title">登录</h1>
        <form id="loginForm" method="post" action="login">
            <div class="input-group">
                <input type="text" name="username" id="loginUsername" placeholder="用户名" required>
            </div>
            <div class="input-group">
                <input type="password" name="password" id="loginPassword" placeholder="密码" required>
            </div>
            <button type="submit" class="btn-primary">登录</button>

            <div class="switch-text">
                没有账号,
                <a href="register.jsp">

                    立即注册
                </a>
            </div>
        </form>
    </div>
</div>

</body>
</html>