package edu.hniu.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 用户喜欢记录实体类
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
public class MyLike {
    private Integer id;                         // 喜欢记录ID
    private Integer userId;                     // 用户ID
    private Integer type;                       // 类型(1:歌曲, 2:歌单)
    private Integer targetId;                   // 目标ID(歌曲或歌单ID)
    private java.time.LocalDateTime createtime; // 创建时间

    // Getters and Setters
}