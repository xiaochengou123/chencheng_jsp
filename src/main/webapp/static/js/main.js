// 主页面JavaScript
document.addEventListener('DOMContentLoaded', function() {
    // 初始化
    initApp();
    initMenu();
    // 播放器相关初始化已删除
});

// 初始化应用
function initApp() {
    // 检查登录状态
    const userInfo = localStorage.getItem('userInfo');
    if (userInfo) {
        const user = JSON.parse(userInfo);
        document.getElementById('userName').textContent = user.nickname || user.username || '音乐爱好者';
    }
}

// 初始化菜单
function initMenu() {
    const menuItems = document.querySelectorAll('.menu-item');
    const menuIcon = document.querySelector('.menu-icon');
    const sidebar = document.querySelector('.sidebar');
    const contentArea = document.querySelector('.content-area');
    let isMenuOpen = true;

    // 菜单切换功能 - 移除所有延迟
    if (menuIcon && sidebar) {
        menuIcon.addEventListener('click', (e) => {
            e.preventDefault(); // 阻止默认行为
            e.stopPropagation(); // 阻止事件冒泡
            
            isMenuOpen = !isMenuOpen;
            
            // 立即切换状态，无延迟
            if (isMenuOpen) {
                sidebar.classList.remove('collapsed');
                contentArea.classList.remove('expanded');
            } else {
                sidebar.classList.add('collapsed');
                contentArea.classList.add('expanded');
            }
        });
    }
    
    // 页面加载时立即设置正确的菜单状态
    setActiveMenuByCurrentPage();
    
    // 菜单项点击不做任何处理，让浏览器自然跳转
    // 新页面加载后会自动调用setActiveMenuByCurrentPage设置正确状态
}

// 页面加载时自动设置正确的菜单状态 - 零延迟版本
function setActiveMenuByCurrentPage() {
    const menuItems = document.querySelectorAll('.menu-item');
    const currentPath = window.location.pathname;
    const currentPage = currentPath.split('/').pop() || 'index.jsp';
    
    // 立即移除所有active状态 - 无延迟
    menuItems.forEach(mi => mi.classList.remove('active'));
    
    // 根据当前页面设置正确的active状态 - 立即执行
    menuItems.forEach(mi => {
        const link = mi.querySelector('a');
        if (link) {
            const href = link.getAttribute('href');
            if (href === currentPage) {
                mi.classList.add('active');
            }
        }
    });
    
    // 立即更新所有图标显示状态 - 同步执行
    menuItems.forEach(mi => {
        const activeImg = mi.querySelector('.active-img');
        const normalImg = mi.querySelector('.normal-img');
        if (activeImg && normalImg) {
            if (mi.classList.contains('active')) {
                activeImg.style.display = 'block';
                normalImg.style.display = 'none';
            } else {
                activeImg.style.display = 'none';
                normalImg.style.display = 'block';
            }
        }
    });
}

// 显示消息提示
function showMessage(message, type = 'info') {
    // 移除已存在的消息
    const existingMessages = document.querySelectorAll('.message');
    existingMessages.forEach(msg => msg.remove());
    
    // 创建新消息
    const messageDiv = document.createElement('div');
    messageDiv.className = `message message-${type}`;
    messageDiv.textContent = message;
    
    const colors = {
        'success': 'linear-gradient(135deg, #4caf50 0%, #45a049 100%)',
        'error': 'linear-gradient(135deg, #f44336 0%, #e53935 100%)',
        'info': 'linear-gradient(135deg, #2196f3 0%, #1976d2 100%)',
        'warning': 'linear-gradient(135deg, #ff9800 0%, #f57c00 100%)'
    };
    
    messageDiv.style.cssText = `
        position: fixed;
        top: 30px;
        left: 50%;
        transform: translateX(-50%);
        padding: 16px 32px;
        border-radius: 8px;
        color: white;
        font-size: 15px;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.25);
        z-index: 10000;
        background: ${colors[type] || colors['info']};
        animation: slideDown 0.4s ease;
    `;
    
    document.body.appendChild(messageDiv);
    
    // 3秒后自动移除
    setTimeout(() => {
        messageDiv.style.animation = 'slideUp 0.4s ease';
        setTimeout(() => {
            if (document.body.contains(messageDiv)) {
                document.body.removeChild(messageDiv);
            }
        }, 400);
    }, 3000);
}

// 添加动画样式
const style = document.createElement('style');
style.textContent = `
    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateX(-50%) translateY(-30px);
        }
        to {
            opacity: 1;
            transform: translateX(-50%) translateY(0);
        }
    }
    
    @keyframes slideUp {
        from {
            opacity: 1;
            transform: translateX(-50%) translateY(0);
        }
        to {
            opacity: 0;
            transform: translateX(-50%) translateY(-30px);
        }
    }
`;
document.head.appendChild(style);