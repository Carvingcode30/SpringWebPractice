package org.zerock.ex00.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class BoardVO {

    private Long bno; //JPA할때 Long을 써서 그냥..
    private String title;
    private String content;
    private String writer;

    private LocalDateTime regDate;
    private LocalDateTime updateDate;

}
