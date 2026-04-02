package edu.hniu.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 歌单实体类
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
public class SongSheet {
    private Integer id;                 // 歌单ID
    private String songSheetName;       // 歌单名称
    private String songSheetResume;     // 歌单简介
    private String songSheetAvatar;     // 歌单封面
    private Integer songCount;          // 新增：歌单包含的歌曲数量
    private List<String> type;// 歌单类别
}