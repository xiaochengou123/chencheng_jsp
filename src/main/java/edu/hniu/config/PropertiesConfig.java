package edu.hniu.config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;

public class PropertiesConfig {
    private static final Properties props = new Properties();
    private static final Map<String, String> cache = new ConcurrentHashMap<>();

    static {
        try (InputStream is = PropertiesConfig.class.getClassLoader()
                .getResourceAsStream("application.properties")) {
            if (is == null) {
                throw new RuntimeException("缺少 application.properties 配置文件");
            }
            props.load(is);
        } catch (IOException e) {
            throw new RuntimeException("加载配置文件失败", e);
        }
    }

    public static String getProperty(String key) {
        return cache.computeIfAbsent(key, k -> props.getProperty(k));
    }
}
