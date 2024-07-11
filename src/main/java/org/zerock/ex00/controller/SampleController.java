package org.zerock.ex00.controller;

import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.ex00.domain.SampleDTO;
import org.zerock.ex00.domain.SampleDTOList;
import org.zerock.ex00.domain.TodoDTO;

import java.util.Arrays;

@Controller
@Log4j2
@RequestMapping("/sample")
public class SampleController {


    @GetMapping("/basic")
    public void basic() {
        log.info("basic-------------------");
    }

    // @RequestParam -> 주로 GET 방식의 요청 파라미터를 받아와서 해당 값을 메서드의 매개변수에 바인딩하기 위해 사용됩니다.
    // 근데 이렇게 코드를 작성하면 번거로우면 DTO 방식도있다. 둘 중에 편한걸로
//    @GetMapping("/ex1")
//    public void ex1(
//        @RequestParam("name") String name,
//        @RequestParam(
//                value="age",
//                required=false,
//                defaultValue = "10") int age
//        ) {sa
//        log.info("ex1-------------------");
//        log.info(name);
//        log.info(age);
//    }

    @GetMapping("/ex1")
    public void ex1(SampleDTO sampleDTO) {
        log.info("ex1-------------------");
        log.info(sampleDTO);
    }

    @GetMapping("/ex02Array")
    public String ex02Array( String[] ids ) {
        log.info("========================");
        log.info(Arrays.toString(ids));
        return "sample/ex2";
    }

    // 이름 가격, 이름 가격 ... 이렇게 여러개를 처리하는 경우가 생긴다
    // List 처리
    @GetMapping("/ex02Bean")
    public void ex02Bean(SampleDTOList list) {
        log.info(list);
    }

    @GetMapping("/ex03")
    public void ex03(TodoDTO todoDTO) {

        log.info("------------");
        log.info(todoDTO);
    }

    @GetMapping("/ex04")
    // Model의 객체가 자동으로 만들어진다
    public void ex04(
            // page라는 int 파라미터 값을 page라는 이름으로 jsp에서 쓸거야
            // 그래서 어떨때 쓰는거지?
            // model.addAttribute는 모델에 데이터를 추가할 때 사용하고, @ModelAttribute("")는 컨트롤러 메서드에서 파라미터로 받거나 모델에서 초기화된 객체를 가져올 때 사용됩니다.
            // 파라미터로 들어온거 model로 삼고싶다? @ModelAttribute
            // model 이란건 서버에서 처리한 결과 컨트롤러가 서비스 비즈니스 로직을 통해 처리된 결과.
            // 내가 만든 데이터는 아닌데 얘도 model로 간주했음 좋겠다 하면 @ModelAttribute를 붙인다?
            @ModelAttribute("dto") SampleDTO dto,
            @ModelAttribute("page") int page,
            Model model) {

        model.addAttribute("list", new String[]{"AAA", "BBB", "CCC"});
    }

    @GetMapping("/ex05")
    public String ex05(RedirectAttributes rttr) {
    // 브라우저 ---- 컨트롤러
        // 브라우저에서 컨트롤러 호출 > 컨트롤러에서 '이거 잘못왔다 여기 아니야 다른곳이야'
        // 그러면서 방향을 다시 안내해주는게 redirect
        // 다시 안내해주면 http 프로토콜 한 싸이클이 끝난거(request - response)
        // redirect라는 애가 header에서는 location이라고 온다
        // 그 담에 다시 안내받은 곳으로 호출하고 결과를 받아가는 형태
        // 이러면 서버 호출이 2번이 이루어진다
        // RedirectAttributes는 get방식밖에 안된다

        // RedirectAttributes 리다이렉트 될 때 파라미터를 전달하는 용도
        rttr.addAttribute("v1", "ABC");
        rttr.addAttribute("v2", "XYZ");

        // 매우 중요. 한번만 전달한다. Flash 섬광 (번쩍) -> 리다이렉트 할 때 한번만 보낼거야
        // 한번만 전달하는 데이터를 쓸 때 addFlashAttribute
        // 성공 실패할때 결과데이터 잠깐 한번 보여줄 때 많이 씀
        rttr.addFlashAttribute("core", "ABCDE");


       // rttr.addFlashAttribute("ids", arr);

        return "redirect:/sample/basic";
    }
}
