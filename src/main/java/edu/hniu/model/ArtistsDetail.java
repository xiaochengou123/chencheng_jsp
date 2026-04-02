// 建议放在edu.hniu.entity包下
package edu.hniu.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@AllArgsConstructor
@NoArgsConstructor
@Data
public class ArtistsDetail {
    // 对应查询的所有字段
    private Integer singerId;    // singer_id
    private String singerName;   // singerName
    private String avatar;       // avatar
    private String type;        // type
    private String album;        // album
    private String songName;     // songName
    private String time;         // time
    private Integer songId;      // song_id
}