package edu.hniu.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 用户实体类
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private Integer id;             // 用户ID
    private String username;        // 用户名
    private String password;        // 用户密码
    private String nickname;        // 昵称
    private String email;           // 邮箱
    private String avatar;          // 头像
    private String resume;          // 简历
    private java.time.LocalDateTime createtime; // 创建时间
    private java.time.LocalDateTime updatetime; // 修改时间
}