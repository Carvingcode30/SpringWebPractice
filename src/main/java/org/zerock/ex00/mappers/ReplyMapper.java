package org.zerock.ex00.mappers;

import org.apache.ibatis.annotations.Param;
import org.zerock.ex00.domain.Criteria;
import org.zerock.ex00.domain.ReplyVO;

import java.util.List;

public interface ReplyMapper {

    Long insert(ReplyVO replyVO);

    ReplyVO selectOne(Long rno);

    int deleteOne(Long rno);

    int updateOne(ReplyVO replyVO);

    List<ReplyVO> getList(
            @Param("cri") Criteria cri,
            @Param("bno") Long bno);

    int getTotal(@Param("cri") Criteria cri,
                 @Param("bno") Long bno);
}
