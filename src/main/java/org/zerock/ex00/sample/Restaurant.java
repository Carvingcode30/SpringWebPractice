package org.zerock.ex00.sample;

import lombok.RequiredArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Component
@ToString // ?
@RequiredArgsConstructor // 생성자 자동 생성?
public class Restaurant {

    private final Chef chef;

}
