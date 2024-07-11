package org.zerock.ex00.domain;


import lombok.Data;

@Data
public class Criteria {

    private int pageNum = 1;
    private int amount = 10;

    // null, T, C, W, TC, TW, TCW
    private String[] types;
    private String keyword;

    private String typeStr;

    public void setTypes(String[] types) {
        this.types = types;

        if(types !=null && types.length >0) {
            // typeStr = String.join("", types);: types 배열에 있는 각각의 요소들을 빈 문자열("")로 구분하여 하나의 문자열로 합칩니다. 이렇게 합쳐진 문자열은 typeStr이라는 멤버 변수에 저장됩니다.
            typeStr = String.join("", types); // .join() 메서드는 Java에서 문자열을 결합하는 메서드입니다. 이 메서드는 Java 8부터 String 클래스에 추가되었습니다.
        }
    }

    public void setPageNum(int pageNum) {

        if(pageNum <= 0) {
            this.pageNum = 1;
            return;
        }
        this.pageNum = pageNum;
    }

    public void setAmount(int amount) {

        if(amount <= 10 || amount > 100) {
            this.amount = 10;
            return;
        }
        this.amount = amount;
    }

    // 값을 반환하는 getter 메서드
    public int getSkip() {

        return (this.pageNum -1) * this.amount;

    }

}
