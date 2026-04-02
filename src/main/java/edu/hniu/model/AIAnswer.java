package edu.hniu.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * AI回答实体类
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
public class AIAnswer {
    private Integer id;             // AI回答ID
    private String content;         // 内容
    private Integer userId;         // 用户ID

}