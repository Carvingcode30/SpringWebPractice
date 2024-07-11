package org.zerock.ex00.controller;


import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.web.bind.annotation.*;
import org.zerock.ex00.domain.Criteria;
import org.zerock.ex00.domain.PageDTO;
import org.zerock.ex00.domain.ReplyVO;
import org.zerock.ex00.service.ReplyService;

import java.awt.*;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/reply")
@RequiredArgsConstructor
@Log4j2
public class ReplyController {

    private final ReplyService replyService;

    @PostMapping("/register")
    public Map<String, Long> register( @RequestBody ReplyVO replyVO) {

        log.info(replyVO);
        Long rno = replyService.register(replyVO);
        return Map.of("RNO", rno);

    }

    @GetMapping("/{rno}")
    public ReplyVO get(@PathVariable("rno")Long rno) {

        return replyService.get(rno);
    }

    @GetMapping("/list/{bno}")
    public Map<String, Object> getListOfBoard(@PathVariable("bno") Long bno,
                                              Criteria criteria) {

        log.info("bno: " + bno);
        log.info(criteria);

        List<ReplyVO> replyList = replyService.getListWithBno(criteria, bno);

        int total = replyService.getTotalWithBno(criteria, bno);

        PageDTO pageDTO = new PageDTO(criteria, total);

        // 예전엔 모델에 담았지만, 이제는 어떻게 담을건가? > Map으로


        return Map.of("replyList", replyList, "pageDTO", pageDTO);
    }
}
