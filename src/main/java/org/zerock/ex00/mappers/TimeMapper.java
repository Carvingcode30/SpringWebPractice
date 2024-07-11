package org.zerock.ex00.mappers;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {

    // mariadb에서 현재시간 가져올 때
    @Select("select now()")
    String getTime();

    String getTime2();
}
