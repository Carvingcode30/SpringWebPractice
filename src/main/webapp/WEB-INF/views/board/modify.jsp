<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="../includes/header.jsp"%>

<!-- DataTales Example -->
<div class="card shadow mb-4">
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">Board Modify</h6>
    </div>
    <div class="card-body"> <!--실제 내용물 들어가는 곳 -->
        <!-- form에서 전송이 필요없는 데이터는 name을 없애면 된다  -->
        <form id="actionForm" action="/board/modify" method="post">



        <div class="input-group input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text">Bno</span>
            </div>
            <input type="text" name="bno" class="form-control" value="<c:out value="${vo.bno}"/>" readonly="readonly"/>
        </div>
        <div class="input-group input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text">Title</span>
            </div>
            <input type="text" name="title" class="form-control" value="<c:out value="${vo.title}"/>">
        </div>
        <div class="input-group input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text">Content</span>
            </div>
            <input type="text" name="content" class="form-control" value="<c:out value="${vo.content}"/>">
        </div>
        <div class="input-group input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text">Writer</span>
            </div>
            <input type="text" class="form-control" value="<c:out value="${vo.writer}"/>" readonly="readonly">
        </div>
        <div class="input-group input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text">RegDate</span>
            </div>
            <input type="text" class="form-control" value="<c:out value="${vo.regDate}"/>" readonly="readonly">
        </div>
        <div class="input-group input-group-lg">
            <button type="submit" class="btn btn-info btnList">LIST</button>
            <button type="submit" class="btn btn-warning btnModify">MODIFY</button>
            <button type="submit" class="btn btn-danger btnRemove">REMOVE</button>
        </div>
        </form>
    </div>
</div>

<form id="listForm" action="/board/list">
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

    const bno = `${vo.bno}`
    const actionForm = document.querySelector("#actionForm")
    const listForm = document.querySelector("#listForm")

    // ID안쓰고 그냥 클래스를 쓴다
    document.querySelector(".btnList").addEventListener("click",(e) => {
        e.preventDefault() // ?
        e.stopPropagation()
        listForm.submit()
    }, false) // 캡쳐링 펄스?

    document.querySelector(".btnModify").addEventListener("click",(e) => {
        e.preventDefault() // ?
        e.stopPropagation() // ?

        actionForm.action = `/board/modify/\${bno}`
        actionForm.method = 'post'
        actionForm.submit()
    }, false) // 캡쳐링 펄스?

    document.querySelector(".btnRemove").addEventListener("click",(e) => {
        e.preventDefault() // ?
        e.stopPropagation() // ?

        actionForm.action = `/board/remove/\${bno}`
        actionForm.method = 'post'
        actionForm.submit()
    }, false) // 캡쳐링 펄스?
</script>

<%@include file="../includes/end.jsp"%>