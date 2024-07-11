package org.zerock.ex00.mappers;


import org.zerock.ex00.domain.BoardVO;
import org.zerock.ex00.domain.Criteria;

import java.util.List;

public interface BoardMapper {

    List<BoardVO> getList();

    List<BoardVO> getPage(Criteria criteria);

    int getTotal(Criteria criteria);


    int insert(BoardVO boardVO); // DML insert update delete는 int다

    BoardVO select(Long bno);

    int update(BoardVO boardVO);

    // 소프트 delete
    // 실제 데이터를 지우는게 아니라 내용물만 지운다 ? 컬럼 하나를 넣어서 구분?
    // 삭제는 민감한 듯..
}
