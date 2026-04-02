package edu.hniu.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 歌曲实体类
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Song {
    private Integer id;             // 歌曲ID
    private String songName;        // 歌名
    private Integer time;           // 时长(秒)
    private String album;           // 专辑
    private java.time.LocalDate releaseDate; // 发行日期
    private String songCover;       // 歌曲封面
    private String songFile;        // 歌曲文件路径
    private String type;            // 类型

}