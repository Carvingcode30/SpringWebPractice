package org.zerock.ex00.service;


import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.ex00.domain.Criteria;
import org.zerock.ex00.domain.ReplyVO;
import org.zerock.ex00.mappers.ReplyMapper;

import java.util.List;

@Transactional
@RequiredArgsConstructor
@Log4j2
@Service
public class ReplyService {

    private final ReplyMapper replyMapper;

    public Long register(ReplyVO replyVO) {

        replyMapper.insert(replyVO);

        return replyVO.getRno();

    }

    public ReplyVO get(Long rno) {

        return replyMapper.selectOne(rno);
    }

    public boolean modify(ReplyVO replyVO) {

        return replyMapper.updateOne(replyVO) == 1;
    }

    public boolean remove(Long rno) {

        return replyMapper.deleteOne(rno) == 1;
    }

    public List<ReplyVO> getListWithBno(Criteria cri, Long bno) {
        return replyMapper.getList(cri, bno);
    }

    public int getTotalWithBno(Criteria criteria, Long bno) {
        return replyMapper.getTotal(criteria, bno);
    }
}
