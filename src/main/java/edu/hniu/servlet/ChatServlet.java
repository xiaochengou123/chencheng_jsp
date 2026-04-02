package edu.hniu.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.util.*;
import com.alibaba.dashscope.aigc.generation.*;
import com.alibaba.dashscope.common.*;
import com.alibaba.fastjson2.*;
import edu.hniu.config.PropertiesConfig;

@WebServlet("/chat")
public class ChatServlet extends HttpServlet {

    private static final String API_KEY = PropertiesConfig.getProperty("API_KEY");
    private static final String MODEL = PropertiesConfig.getProperty("MODEL");



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/event-stream;charset=UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Connection", "keep-alive");

        PrintWriter out = response.getWriter();

        try {
            // 读取请求体
            StringBuilder requestBody = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                requestBody.append(line);
            }

            JSONObject requestData = JSONObject.parseObject(requestBody.toString());
            String message = requestData.getString("message");
            JSONArray history = requestData.getJSONArray("history");

            // 构建消息列表
            List<Message> messages = new ArrayList<>();

            // 添加系统提示
            messages.add(Message.builder()
                    .role(Role.SYSTEM.getValue())
                    .content("你是一个专业的助手，回答问题时请结构清晰，合理使用标题(#~######)和代码块。代码块用(```)包裹。")
                    .build());

            // 添加历史消息
            if (history != null) {
                for (int i = 0; i < history.size(); i++) {
                    JSONObject msg = history.getJSONObject(i);
                    messages.add(Message.builder()
                            .role(msg.getString("role"))
                            .content(msg.getString("content"))
                            .build());
                }
            }

            // 添加当前消息
            messages.add(Message.builder()
                    .role(Role.USER.getValue())
                    .content(message)
                    .build());

            // 创建Generation实例并调用
            Generation gen = new Generation();

            GenerationParam param = GenerationParam.builder()
                    .apiKey(API_KEY)
                    .model(MODEL)
                    .messages(messages)
                    .resultFormat(GenerationParam.ResultFormat.MESSAGE)
                    .topP(0.8)
                    .build();
            // 调用API获取完整响应
            GenerationResult result = gen.call(param);
            String aiResponse = result.getOutput().getChoices().get(0).getMessage().getContent();

            // 将完整响应拆分成字符流式返回（模拟流式效果）
            String[] chunks = splitIntoChunks(aiResponse, 10); // 每10个字符一个chunk

            for (String chunk : chunks) {
                if (!chunk.isEmpty()) {
                    JSONObject data = new JSONObject();
                    JSONObject messageObj = new JSONObject();
                    messageObj.put("content", chunk);
                    data.put("message", messageObj);

                    out.write("data: " + data.toJSONString() + "\n\n");
                    out.flush();

                    // 添加延迟模拟流式效果
                    Thread.sleep(50);
                }
            }

            // 发送结束标记
            out.write("data: [DONE]\n\n");
            out.flush();

        } catch (Exception e) {
            JSONObject error = new JSONObject();
            error.put("error", e.getMessage());
            out.write("data: " + error.toJSONString() + "\n\n");
            out.flush();
            e.printStackTrace();
        }
    }

    // 将字符串分割成小块
    private String[] splitIntoChunks(String text, int chunkSize) {
        if (text == null || text.isEmpty()) {
            return new String[0];
        }

        int length = text.length();
        int chunksCount = (int) Math.ceil((double) length / chunkSize);
        String[] chunks = new String[chunksCount];

        for (int i = 0; i < chunksCount; i++) {
            int start = i * chunkSize;
            int end = Math.min(start + chunkSize, length);
            chunks[i] = text.substring(start, end);
        }

        return chunks;
    }
}