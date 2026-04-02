package edu.hniu.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 用户收藏歌曲列表实体类
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
public class SongList {
    private Integer id;             // 歌曲列表ID
    private Integer userId;         // 用户ID
    private Integer songId;         // 歌曲ID

    // Getters and Setters
}