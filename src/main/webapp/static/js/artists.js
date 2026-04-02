// 歌手分类页面基本功能
document.addEventListener('DOMContentLoaded', function() {
    // 重置按钮功能
    const resetBtn = document.getElementById('resetBtn');
    
    if (resetBtn) {
        resetBtn.addEventListener('click', function() {
            // 简单的重置功能，可以后续扩展
            console.log('重置功能被点击');
        });
    }
    
    // 页面淡入效果
    const artistsPage = document.querySelector('.artists-page');
    if (artistsPage) {
        artistsPage.style.opacity = '0';
        artistsPage.style.transform = 'translateY(20px)';
        
        setTimeout(() => {
            artistsPage.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
            artistsPage.style.opacity = '1';
            artistsPage.style.transform = 'translateY(0)';
        }, 100);
    }
});