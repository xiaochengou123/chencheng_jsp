package edu.hniu.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 歌单类型关联实体类
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class SongSheetType {
    private Integer id;             // 歌单类型ID
    private Integer songSheetId;    // 歌单ID
    private Integer type;           // 类别

    // Getters and Setters
}