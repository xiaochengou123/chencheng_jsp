package edu.hniu.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Player {
    private Integer id;          // 对应查询结果的id
    private String bg;       // 背景图片路径
    private String audio;        // 对应查询结果的audio（songFile）
    private String record;       // 对应查询结果的record（songCover）
    private String name;         // 对应查询结果的name（songName）
    private String singer;       // 对应查询结果的singer（singerName）
    private Object time;
}
