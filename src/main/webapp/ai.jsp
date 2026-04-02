<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI一听 - 一听助手</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        .back-btn {
            position: fixed;
            top: 20px;
            left: 20px;
            padding: 8px 16px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 6px;
            z-index: 999;
            transition: background 0.2s;
        }
        .back-btn:hover {
            background: #0056b3;
        }
        .message-text {
            line-height: 1.8;
            white-space: pre-wrap !important;
            word-break: break-all !important;
            font-size: 14px;
        }
        /* 核心样式：强制代码块为白色背景+黑色文字 */
        .message-text pre {
            background: #ffffff !important;
            color: #000000 !important;
            padding: 16px !important;
            border-radius: 8px !important;
            margin: 12px 0 !important;
            overflow-x: auto !important;
            display: block !important;
            font-family: Consolas, Monaco, monospace !important;
            border: 1px solid #e0e0e0 !important;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05) !important;
        }
        .message-text pre code {
            color: #000000 !important;
            font-family: inherit !important;
            display: block !important;
            white-space: pre !important;
            line-height: 1.5 !important;
        }
        /* 特殊符号高亮 */
        .special-char {
            font-weight: bold !important;
            color: #ff6b6b !important;
        }
        .message-text .title-h1 {
            font-size: 24px;
            font-weight: 700 !important;
            margin: 16px 0 8px 0 !important;
            color: #333 !important;
        }
        .message-text .title-h2 {
            font-size: 22px;
            font-weight: 700 !important;
            margin: 14px 0 7px 0 !important;
            color: #333 !important;
        }
        .message-text .title-h3 {
            font-size: 20px;
            font-weight: 700 !important;
            margin: 12px 0 6px 0 !important;
            color: #333 !important;
        }
        .message-text .title-h4 {
            font-size: 18px;
            font-weight: 700 !important;
            margin: 10px 0 5px 0 !important;
            color: #333 !important;
        }
        .message-text .title-h5 {
            font-size: 16px;
            font-weight: 700 !important;
            margin: 8px 0 4px 0 !important;
            color: #333 !important;
        }
        .message-text .title-h6 {
            font-size: 14px;
            font-weight: 700 !important;
            margin: 6px 0 3px 0 !important;
            color: #333 !important;
        }
        .user-message .message-content .title-h1,
        .user-message .message-content .title-h2,
        .user-message .message-content .title-h3,
        .user-message .message-content .title-h4,
        .user-message .message-content .title-h5,
        .user-message .message-content .title-h6 {
            color: white !important;
        }
        /* 用户消息中的代码块也保持白色背景+黑色文字 */
        .user-message .message-content pre {
            background: #ffffff !important;
            color: #000000 !important;
            border: 1px solid #b3d1ff !important;
        }
        .chat-messages {
            width: 80%;
            height: 600px;
            margin: 20px auto;
            padding: 20px;
            background: #fafafa;
            border-radius: 10px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-top: 70px;
        }
        .message {
            display: flex;
            gap: 10px;
            max-width: 85%;
        }
        .ai-message {
            margin-right: auto;
        }
        .user-message {
            margin-left: auto;
        }
        .message-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            flex-shrink: 0;
            /*background: #ddd;*/
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .message-content {
            padding: 12px 18px;
            border-radius: 20px;
            background: #f1f1f1;
        }
        .user-message .message-content {
            background: #007bff;
            color: white;
        }
        .chat-input-wrap {
            width: 80%;
            margin: 0 auto;
            display: flex;
            gap: 10px;
        }
        #chatInput {
            flex: 1;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #ddd;
            resize: none;
            font-size: 14px;
            min-height: 40px;
            max-height: 120px;
        }
        #sendBtn {
            padding: 0 20px;
            border-radius: 8px;
            border: none;
            background: #007bff;
            color: white;
            cursor: pointer;
        }
        .message-text strong.inline-bold,
        .message-text b.inline-bold {
            font-weight: 600 !important;
            font-size: 0.95em !important;
            color: inherit !important;
        }
    </style>
</head>
<body>
<button class="back-btn" id="backBtn">← 返回</button>
<div class="chat-messages" id="chatMessages"></div>
<div class="chat-input-wrap">
    <textarea id="chatInput" placeholder="输入问题"></textarea>
    <button id="sendBtn">发送</button>
</div>

<script>
    let userJson = <%= session.getAttribute("User") == null ? "{}" : session.getAttribute("User") %>;
    let user = typeof userJson === 'object' && userJson !== null ? userJson : {};
    // 替换 Ollama 配置为阿里云通义千问配置
    const QWEN_CONFIG = {
        apiUrl: "${pageContext.request.contextPath}/chat", // 使用您的 Servlet
        stream: true
    };

    const chatMessages = document.getElementById('chatMessages');
    const chatInput = document.getElementById('chatInput');
    const sendBtn = document.getElementById('sendBtn');
    const backBtn = document.getElementById('backBtn');

    initAI();

    sendBtn.addEventListener('click', sendMessage);
    chatInput.addEventListener('keydown', (e) => {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            sendMessage();
        }
    });
    backBtn.addEventListener('click', () => {
        window.history.back();
    });

    async function initAI() {
        const loadingEl = addLoading();
        setTimeout(() => {
            loadingEl.remove();
            addMessage("我是一听的智能助手 (是cc团队首发的ai智能助手)", 'ai');
        }, 500);
    }

    async function sendMessage() {
        const text = chatInput.value.trim();
        if (!text) return;

        addMessage(text, 'user');
        chatInput.value = '';

        const isIdentityQuestion = /你是/i.test(text);
        const isNumber = /^[0-9a-zA-Z_?!]+$/.test(text);

        if (isIdentityQuestion || isNumber) {
            addMessage("我是一听的智能助手 (是cc团队首发的ai智能助手)", 'ai');
            return;
        }

        const loadingEl = addLoading();
        const history = getMessageHistory();

        // 准备请求数据
        const requestData = {
            message: text,
            history: history
        };

        await callQwenAPI(requestData, loadingEl);
    }

    async function callQwenAPI(requestData, loadingEl) {
        try {
            const response = await fetch(QWEN_CONFIG.apiUrl, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(requestData)
            });

            if (!response.ok) {
                throw new Error(`请求失败：${response.status}`);
            }

            const reader = response.body.getReader();
            const decoder = new TextDecoder();
            let aiContent = '';
            let aiMsgEl = null;

            while (true) {
                const { done, value } = await reader.read();
                if (done) break;

                const chunk = decoder.decode(value);
                const lines = chunk.split('\n');

                for (const line of lines) {
                    if (line.startsWith('data: ')) {
                        const dataStr = line.substring(6);

                        if (dataStr === '[DONE]') {
                            return; // 流结束
                        }

                        try {
                            const data = JSON.parse(dataStr);

                            if (data.error) {
                                throw new Error(data.error);
                            }

                            if (data.message?.content) {
                                aiContent += data.message.content;

                                if (!aiMsgEl) {
                                    loadingEl.remove();
                                    aiMsgEl = addMessage('', 'ai', false);
                                }

                                aiMsgEl.querySelector('.message-text').innerHTML = formatContent(aiContent);
                                chatMessages.scrollTop = chatMessages.scrollHeight;
                            }
                        } catch (e) {
                            console.log('解析JSON失败:', e);
                        }
                    }
                }
            }
        } catch (err) {
            loadingEl.remove();
            addMessage(`请求失败：${err.message}`, 'ai');
            console.error(err);
        }
    }

    function formatContent(text) {
        if (!text) return '';

        // 步骤1：转义基础HTML字符
        const escapeHtml = (str) => {
            return str.replace(/[&<>"'`\/]/g, (c) => ({
                '&': '&amp;',
                '<': '&lt;',
                '>': '&gt;',
                '"': '&quot;',
                "'": '&#39;',
                '`': '&#96;',
                '/': '&#x2F;'
            }[c]));
        };

        let formattedText = escapeHtml(text);

        // 步骤2：处理代码块
        formattedText = formattedText.replace(/```([\s\S]*?)```/g, (match, codeContent) => {
            if (!codeContent) return match;

            const lines = codeContent.trim().split('\n');
            const lang = lines[0].match(/^[a-zA-Z0-9]+$/) ? lines[0] : '';
            const actualCode = lang ? lines.slice(1).join('\n') : codeContent;

            let escapedCode = actualCode
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;');

            escapedCode = escapedCode.replace(/([\{\}\[\]\(\);=\+\-\*\/<>])/g, '<span class="special-char">$1</span>');

            return `<pre><code>${escapedCode}</code></pre>`;
        });

        // 步骤3：处理粗体
        formattedText = formattedText.replace(/\*\*(.*?)\*\*/g, '<strong class="inline-bold">$1</strong>');
        formattedText = formattedText.replace(/__(.*?)__/g, '<strong class="inline-bold">$1</strong>');

        // 步骤4：处理标题
        formattedText = formattedText.replace(/^# (.*$)/gm, '<div class="title-h1">$1</div>');
        formattedText = formattedText.replace(/^## (.*$)/gm, '<div class="title-h2">$1</div>');
        formattedText = formattedText.replace(/^### (.*$)/gm, '<div class="title-h3">$1</div>');
        formattedText = formattedText.replace(/^#### (.*$)/gm, '<div class="title-h4">$1</div>');
        formattedText = formattedText.replace(/^##### (.*$)/gm, '<div class="title-h5">$1</div>');
        formattedText = formattedText.replace(/^###### (.*$)/gm, '<div class="title-h6">$1</div>');

        // 步骤5：处理换行
        formattedText = formattedText.replace(/\n/g, '<br>');

        return formattedText;
    }

    function addMessage(content, sender, scroll = true) {
       
        const msgDiv = document.createElement('div');
        msgDiv.className = `message ${sender}-message`;

        const avatar = document.createElement('img');
        avatar.className = 'message-avatar';
        avatar.src = sender === 'ai' ? 'static/images/ai.png' : user.avatar==null ? 'static/images/user.png' : user.avatar;


        const contentDiv = document.createElement('div');
        contentDiv.className = 'message-content';
        const textDiv = document.createElement('div');
        textDiv.className = 'message-text';
        textDiv.innerHTML = formatContent(content);

        contentDiv.appendChild(textDiv);
        msgDiv.appendChild(avatar);
        msgDiv.appendChild(contentDiv);

        chatMessages.appendChild(msgDiv);
        if (scroll) chatMessages.scrollTop = chatMessages.scrollHeight;
        return msgDiv;
    }

    function addLoading() {
        const loadingDiv = document.createElement('div');
        loadingDiv.className = 'message ai-message';
        loadingDiv.innerHTML = `
<!--                <image class="message-avatar">AI</image>-->
              <img src="static/images/ai.png" class="message-avatar"  alt="">
                <div class="message-content">
                    <div class="message-text">AI正在生成回答...</div>
                </div>
            `;
        chatMessages.appendChild(loadingDiv);
        chatMessages.scrollTop = chatMessages.scrollHeight;
        return loadingDiv;
    }

    function getMessageHistory() {
        const messages = [];
        const msgElements = chatMessages.querySelectorAll('.message');
        msgElements.forEach(el => {
            if (!el.querySelector('.message-text')) return;
            const role = el.classList.contains('ai-message') ? 'assistant' : 'user';
            const content = el.querySelector('.message-text').textContent.trim();
            messages.push({ role, content });
        });
        return messages;
    }

    function sleep(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }
</script>
</body>
</html>