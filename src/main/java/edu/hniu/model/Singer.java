package edu.hniu.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 歌手实体类
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Singer {
    private Integer id;             // 歌手ID
    private String singerName;      // 歌手名称
    private Integer type;           // 类型(1:男歌手,2:女歌手,3:组合/乐队)
    private java.time.LocalDate birthday; // 生日
    private String nationality;     // 国籍
    private String resume;          // 简历
    private String avatar;          // 头像
    private LocalDateTime createtime; // 创建时间
    private LocalDateTime updatetime; // 更新时间
    private Integer Issue_Id;//发行记录ID


}