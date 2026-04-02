package edu.hniu.servlet;

import edu.hniu.dao.PlayerDao;
import edu.hniu.model.Player;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "PlayerServlet",urlPatterns = "/player")
public class PlayerServlet extends HttpServlet {

    // ========== 新增：音频URL清洗方法（复用性强） ==========
    private String cleanAudioUrl(String audioUrl) {
        if (audioUrl == null || audioUrl.trim().isEmpty()) {
            return "";
        }
        // 1. 去除换行、回车、制表符等特殊空白字符
        String cleanUrl = audioUrl.replaceAll("[\n\r\t]", "").trim();
        // 2. 如果包含多个URL（空格/逗号分隔），只取第一个
        if (cleanUrl.contains(" ")) {
            cleanUrl = cleanUrl.split(" ")[0];
        } else if (cleanUrl.contains(",")) {
            cleanUrl = cleanUrl.split(",")[0];
        }
        // 3. 再次trim确保无多余空格
        return cleanUrl.trim();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 设置请求编码
        req.setCharacterEncoding("UTF-8");
        // 2. 获取SongId参数（支持多个ID，如1,2,3）
        String songIdStr = req.getParameter("SongId");
        // 3. 安全解析多个歌曲ID，过滤空/无效值
        int[] songId = null;
        if (songIdStr != null && !songIdStr.trim().isEmpty()) {
            String[] idStrArr = songIdStr.split(",");
            List<Integer> idList = new ArrayList<>();
            for (String idStr : idStrArr) {
                idStr = idStr.trim();
                if (!idStr.isEmpty()) {
                    try {
                        idList.add(Integer.parseInt(idStr));
                    } catch (NumberFormatException e) {
                        e.printStackTrace(); // 忽略无效数字
                    }
                }
            }
            if (!idList.isEmpty()) {
                songId = new int[idList.size()];
                for (int i = 0; i < idList.size(); i++) {
                    songId[i] = idList.get(i);
                }
            }
        }

        // 4. 查询对应ID的歌曲列表（仅查询传入的ID）
        List<Player> songList = null;
        try {
            songList = new PlayerDao().getPlayerInfo(songId);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // 5. 安全校验：确保至少有一首歌曲
        if (songList == null || songList.isEmpty()) {
            req.setAttribute("error", "暂无指定的歌曲数据");
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
            return;
        }

        // ========== 核心修改：清洗所有Player对象的audio字段 ==========
        for (Player song : songList) {
            String originalAudio = song.getAudio();
            String cleanedAudio = cleanAudioUrl(originalAudio);
            // 打印日志，方便调试对比清洗前后的URL
            System.out.println("清洗前audio：" + originalAudio);
            System.out.println("清洗后audio：" + cleanedAudio);
            // 将清洗后的URL重新设置回Player对象
            song.setAudio(cleanedAudio);
        }

        // ========== 原有：校验音频路径有效性（逻辑保留） ==========
        String projectPath = getServletContext().getRealPath("/");
        for (Player song : songList) {
            String audioPath = song.getAudio();
            // 如果是相对路径，拼接项目根路径校验
            if (audioPath != null && !audioPath.startsWith("http")) {
                File audioFile = new File(projectPath + audioPath);
                // 打印路径日志，方便调试
                System.out.println("音频文件路径：" + audioFile.getAbsolutePath());
                System.out.println("音频文件是否存在：" + audioFile.exists());
            }
        }

        // ========== 设置当前播放歌曲 ==========
        Player currentSong = null;
        Integer currentSongId = null;
        // 如果传了单个SongId，优先选中该歌曲
        if (songIdStr != null && !songIdStr.contains(",") && songList.size() > 0) {
            try {
                int targetId = Integer.parseInt(songIdStr.trim());
                for (Player song : songList) {
                    if (song.getId() == targetId) {
                        currentSong = song;
                        currentSongId = targetId;
                        break;
                    }
                }
            } catch (NumberFormatException e) {
                // 解析失败则选第一首
                currentSong = songList.get(0);
                currentSongId = currentSong.getId();
            }
        } else {
            // 无指定ID则选第一首
            currentSong = songList.get(0);
            currentSongId = currentSong.getId();
        }

        // 6. 传递数据到JSP
        req.setAttribute("songList", songList);
        req.setAttribute("currentSong", currentSong);
        req.setAttribute("currentSongId", currentSongId);
        req.getRequestDispatcher("/Player.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}