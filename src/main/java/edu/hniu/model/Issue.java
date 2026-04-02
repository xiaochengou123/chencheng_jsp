package edu.hniu.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 发行记录实体类（歌手-歌曲多对多关系）
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Issue {
    private Integer id;             // 发行记录ID
    private Integer singerId;       // 歌手ID
    private Integer songId;         // 歌曲ID

    // Getters and Setters
}