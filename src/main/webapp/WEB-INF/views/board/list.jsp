<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="../includes/header.jsp"%>


<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800">Tables</h1>
<p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
    For more information about DataTables, please visit the <a target="_blank"
                                                               href="https://datatables.net">official DataTables documentation</a>.</p>

<!-- DataTales Example -->
<div class="card shadow mb-4">
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
    </div>
    <div class="card-body">

        <div>
            <select name='typeSelect'>
                <option value="">--</option>
                <option value="T" ${cri.typeStr == 'T' ? 'selected' : ''}>제목</option>
                <option value="C" ${cri.typeStr == 'C' ? 'selected' : ''}>내용</option>
                <option value="W" ${cri.typeStr == 'W' ? 'selected' : ''}>작성자</option>
                <option value="TC" ${cri.typeStr == 'TC' ? 'selected' : ''}>제목 OR 내용</option>
                <option value="TW" ${cri.typeStr == 'TW' ? 'selected' : ''}>제목 OR 작성자</option>
                <option value="TCW" ${cri.typeStr == 'TCW' ? 'selected' : ''}>제목 OR 내용 OR 작성자</option>
            </select>
            <input type='text' name='keywordInput' value="${cri.keyword}"/>
            <button class='btn btn-default searchBtn'>Search</button>
        </div>

        <div class="table-responsive">

            <form id="actionForm" method="get" action="/board/list">
                <input type="hidden" name="pageNum" value="${cri.pageNum}">
                <input type="hidden" name="amount" value="${cri.amount}">
                <c:if test="${cri.types != null && cri.keyword != null}">
                    <c:forEach var="type" items="${cri.types}">
                        <input type="hidden" name="types" value="${type}">
                    </c:forEach>
                    <input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>">
                </c:if>
            </form>

            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                <tr>
                    <th>Bno</th>
                    <th>Title</th>
                    <th>Writer</th>
                    <th>RegDate</th>
                    <th>UpdateDate</th>
                </tr>
                </thead>
                <tbody class="tbody">
                <!-- c:out을 쓰는 이유 -->
                <c:forEach var="board" items="${list}">
                    <tr data-bno="${board.bno}"> <!--??? -->
                        <td><c:out value="${board.bno}"/></td>
                        <td><c:out value="${board.title}"/></td>
                        <td><c:out value="${board.writer}"/></td>
                        <td><c:out value="${board.regDate}"/></td>
                        <td><c:out value="${board.updateDate}"/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

                <!-- page -->
            <div>

                <ul class="pagination">

                    <c:if test="${pageMaker.prev}">
                        <li class="page-item">
                            <a class="page-link" href="${pageMaker.startPage - 1}" tabindex="-1">Previous</a>
                        </li>
                    </c:if>


                    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
                        <li class="page-item ${cri.pageNum == num ? 'active':''} ">
                            <a class="page-link" href="${num}">${num}</a>
                        </li>
                    </c:forEach>


                    <c:if test="${pageMaker.next}">
                        <li class="page-item">
                            <a class="page-link" href="${pageMaker.endPage + 1}">Next</a>
                        </li>
                    </c:if>
                </ul>

            </div>
            <form action="/board/register" method="get">
                <button type="submit" class="btn btn-primary">글쓰기</button>
            </form>
        </div>
    </div>
</div>

<!-- 모달 -->

<div id="myModal" class="modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Modal title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>Modal body text goes here.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary">Save changes</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


 <%@include file="../includes/footer.jsp"%>

<script>

    const result = '${result}' // 없으면 빈 문자열이 되지만 있으면 글자가 되게 처리하려고 '' 붙임

    const myModal = new bootstrap.Modal(document.getElementById('myModal'))

    console.log(myModal)

    if(result) {
        myModal.show()
    }

    const actionForm = document.querySelector("#actionForm")

    document.querySelector('.tbody').addEventListener("click", (e) => {

        const target = e.target.closest("tr") // 가장 가까운 상위를 찾는거 ?
        const bno = target.dataset.bno

        const before = document.querySelector("#clonedActionForm")

        if(before) {
            before.remove()
        }

       const clonedActionForm = actionForm.cloneNode(true) // 복사본 객체 만드는 거
        // 클론하는이유? 안전하게 하려고 뭘??
        clonedActionForm.setAttribute("action",`/board/read/\${bno}`)
        clonedActionForm.setAttribute("id", 'clonedActionForm')
        console.log(clonedActionForm)

        document.body.append(clonedActionForm)

        clonedActionForm.submit()

    }, false)

    document.querySelector(".searchBtn").addEventListener("click", (e) => {
        e.preventDefault()
        e.stopPropagation()
        /*
        e.stopPropagation()은 자바스크립트에서 이벤트(event) 버블링(bubbling)이나 캡처링(capturing)을 중단시키는 메서드입니다. 이 메서드는 이벤트 객체(e 또는 event)의 메서드로 호출됩니다.

이벤트 버블링이나 캡처링은 HTML 요소에서 발생한 이벤트가 부모 요소로 전파되는 방식을 의미합니다. 예를 들어, 사용자가 특정 버튼을 클릭할 때, 해당 버튼에 등록된 클릭 이벤트는 버튼 자체에서 시작하여 부모 요소(예: DIV, BODY 등)까지 전파됩니다. 이때 e.stopPropagation()을 호출하면 이벤트의 추가 전파를 중단할 수 있습니다.

         */

        const selectObj = document.querySelector("select[name='typeSelect']")
        const selectValue = selectObj.options[selectObj.selectedIndex].value

        console.log("selectValue----------------")
        console.log(selectValue)

        const arr = selectValue.split("")

        console.log(arr)

        // actionForm에 hidden태그로 만들어서 검색 조건 추가
        // 페이지 번호도 1 페이지로
        // amount도 새로 만들자.

        let str = ''

        str = `<input type='hidden' name='pageNum' value=1>`
        str += `<input type='hidden' name='amount' value=${cri.amount}>`

        if(arr && arr.length >0) {
            for(const type of arr) {
                str += `<input type='hidden' name='types' value=\${type}>`
            }
        }

        const keywordValue = document.querySelector("input[name='keywordInput']").value
        str += `<input type='hidden' name='keyword' value='\${keywordValue}'>`
        actionForm.innerHTML = str
        actionForm.submit()
    })


    document.querySelector(".pagination").addEventListener("click", (e) => {

        e.preventDefault() // 기본동작 하지마?
        const target = e.target;
        console.log(target)

        const targetPage = target.getAttribute("href")
        console.log(targetPage)

        // 페이지 목록 이동 활성화
        actionForm.setAttribute("action","/board/list")
        actionForm.querySelector("input[name='pageNum']").value = targetPage
        actionForm.submit() // form 제출 할 때 사용하는 메서드

    }, false) // 캡처링 하지 않아 버블링만 하겠다.


</script>

<%@include file="../includes/end.jsp"%>