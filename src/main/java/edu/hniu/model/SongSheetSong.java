package edu.hniu.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 歌单与歌曲关联实体类
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
public class SongSheetSong {
    private Integer id;             // 歌单歌曲ID
    private Integer songId;         // 歌曲ID
    private Integer songSheetId;    // 歌单ID

    // Getters and Setters
}