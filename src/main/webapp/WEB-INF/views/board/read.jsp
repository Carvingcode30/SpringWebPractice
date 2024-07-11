<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="../includes/header.jsp"%>

<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800">Read</h1>
<p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
    For more information about DataTables, please visit the <a target="_blank"
                                                               href="https://datatables.net">official DataTables documentation</a>.</p>

<!-- DataTales Example -->
<div class="card shadow mb-4">
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">Board Read</h6>
    </div>
    <div class="card-body"> <!--실제 내용물 들어가는 곳 -->
        <div class="input-group input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text">Bno</span>
            </div>
            <input type="text" class="form-control" value="<c:out value="${vo.bno}"/>" readonly="readonly"/>
        </div>
        <div class="input-group input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text">Title</span>
            </div>
            <input type="text" name="title" class="form-control" value="<c:out value="${vo.title}"/>" readonly="readonly">
        </div>
        <div class="input-group input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text">Content</span>
            </div>
            <input type="text" name="content" class="form-control" value="<c:out value="${vo.content}"/>" readonly="readonly">
        </div>
        <div class="input-group input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text">Writer</span>
            </div>
            <input type="text" name="writer" class="form-control" value="<c:out value="${vo.writer}"/>" readonly="readonly">
        </div>
        <div class="input-group input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text">RegDate</span>
            </div>
            <input type="text" name="regDate" class="form-control" value="<c:out value="${vo.regDate}"/>" readonly="readonly">
        </div>

        <div class="input-group input-group-lg">
            <button type="submit" class="btn btn-info btnList">LIST</button>
            <button type="submit" class="btn btn-warning btnModify">MODIFY</button>
        </div>
    </div>
</div>

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

<%@include file="../includes/footer.jsp"%>

<script>

    const actionForm = document.querySelector("#actionForm")
    const bno = '${vo.bno}'

    // ID안쓰고 그냥 클래스를 쓴다
    document.querySelector(".btnList").addEventListener("click",(e) => {
        actionForm.setAttribute("action", "/board/list")
        actionForm.submit()
    }, false) // 캡쳐링 펄스?

    document.querySelector(".btnModify").addEventListener("click",(e) => {
        actionForm.setAttribute("action", `/board/modify/\${bno}`) // 자바스크립트를 jstl에서 표현할 때 백틱 문자열 쓰는거같은디?
        actionForm.submit()
    }, false) // 캡쳐링 펄스?

</script>

<%@include file="../includes/end.jsp"%>
