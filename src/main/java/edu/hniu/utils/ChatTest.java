package edu.hniu.utils;

import java.util.Arrays;
import com.alibaba.dashscope.aigc.generation.Generation;
import com.alibaba.dashscope.aigc.generation.GenerationResult;
import com.alibaba.dashscope.aigc.generation.GenerationParam;
import com.alibaba.dashscope.common.Message;
import com.alibaba.dashscope.common.Role;
import com.alibaba.dashscope.exception.ApiException;
import com.alibaba.dashscope.exception.InputRequiredException;
import com.alibaba.dashscope.exception.NoApiKeyException;
import com.alibaba.dashscope.protocol.Protocol;

public class ChatTest {
    public static GenerationResult callWithMessage()
            throws NoApiKeyException, ApiException, InputRequiredException {
        // 修复点1：直接指定API Key（测试场景用，生产环境不建议硬编码）
        String apiKey = "你的key";

        // 修复点2：根据API Key地域选择base_url（国内地域用下面的地址，新加坡用dashscope-intl）
        // 国内地域：https://dashscope.aliyuncs.com/api/v1
        // 新加坡地域：https://dashscope-intl.aliyuncs.com/api/v1
        Generation gen = new Generation(Protocol.HTTP.getValue(), "https://dashscope.aliyuncs.com/api/v1");

        Message sysMsg = Message.builder()
                .role(Role.SYSTEM.getValue())
                .content("You are a helpful assistant.").build();
        Message userMsg = Message.builder()
                .role(Role.USER.getValue())
                .content("请编写一个Python函数 find_prime_numbers，该函数接受一个整数 n 作为参数，并返回一个包含所有小于 n 的质数（素数）的列表。不要输出非代码的内容和Markdown的代码块。").build();

        GenerationParam param = GenerationParam.builder()
                .apiKey(apiKey) // 传入有效密钥
                .model("qwen3-coder-plus")
                .messages(Arrays.asList(sysMsg, userMsg))
                .resultFormat(GenerationParam.ResultFormat.MESSAGE)
                .build();
        return gen.call(param);
    }

    public static void main(String[] args) {
        try {
            GenerationResult result = callWithMessage();
            System.out.println(result.getOutput().getChoices().get(0).getMessage().getContent());
        } catch (ApiException | NoApiKeyException | InputRequiredException e) {
            System.err.println("请求异常: " + e.getMessage());
            e.printStackTrace();
        }
    }
}