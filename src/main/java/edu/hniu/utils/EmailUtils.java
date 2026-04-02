package edu.hniu.utils;

import com.sun.mail.util.MailSSLSocketFactory;
import edu.hniu.config.PropertiesConfig;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.security.GeneralSecurityException;
import java.util.Properties;
import java.util.Random;



public class EmailUtils {
    // 发件人邮箱（你的QQ邮箱）
    private static final String FROM_EMAIL= PropertiesConfig.getProperty("fromEmail");
    // QQ邮箱授权码（不是登录密码！）
    private static final String EMAIL_PASSWORD=PropertiesConfig.getProperty("EmailPassword");
    // SMTP 配置
    private static final String SMTP_HOST = "smtp.qq.com";
    private static final String SMTP_PORT = "465";
    /**
     * 发送验证码到指定邮箱，并返回生成的验证码（可用于测试或日志）
     *
     * @param toEmail 目标邮箱地址
     * @return 生成的6位验证码，发送失败返回 null
     */
    public static String sendVerificationCode(String toEmail) throws GeneralSecurityException {
        if (toEmail == null || toEmail.trim().isEmpty()) {
            throw new IllegalArgumentException("邮箱地址不能为空");
        }

        // 生成6位随机验证码
        String code = String.format("%06d", new Random().nextInt(999999));

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.qq.com");
        props.put("mail.smtp.port", "465");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.enable", "true");

        MailSSLSocketFactory sf = new MailSSLSocketFactory();
        sf.setTrustAllHosts(true);
        props.put("mail.smtp.ssl.socketFactory", sf);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, EMAIL_PASSWORD);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress("woingm@foxmail.com", "验证码发送系统"));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject("【验证码】您的验证码");
            message.setText("您好！您的验证码是：" + code + "，5分钟内有效，请勿泄露。");

            Transport.send(message);
            return code; // 成功发送，返回验证码

        } catch (Exception e) {
            e.printStackTrace();
            return null; // 发送失败
        }
    }

    public static void main(String[] args) throws GeneralSecurityException {
        System.out.println(EmailUtils.sendVerificationCode("205614780@qq.com"));
    }
}