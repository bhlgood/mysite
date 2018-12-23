<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page trimDirectiveWhitespaces="true"%>
<!doctype html>
<html>
<head>
<%@ include file="/WEB-INF/inc/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/inc/topbar.jsp" %>
<div class="container">
	<h1 class="page-header">${bbsName} - <small>글 읽기</small></h1>
		
	<!-- 제목, 작성자, 작성일시, 조회수 -->
	<div class="alert alert-info">
		<h3 style="margin: 0">
		    ${readDocument.subject}<br/>
			<small>
				${readDocument.writerName}
				<a href="mailto:${readDocument.email}">
					<i class="glyphicon glyphicon-envelope"></i></a> 
					/ 조회수 : ${readDocument.hit}  / 작성일시 : ${readDocument.regDate}
			</small>
		</h3>
	</div>
	
	<!-- 첨부파일 목록 표시하기 -->
	<c:if test="${fileList != null}">
		<!-- 첨부파일 목록 -->
		<table class="table table-bordered">
			<tbody>
				<tr>
					<th class="warning" style="width: 100px">첨부파일</th>
					<td>
						<c:forEach var="file" items="${fileList}">
							<!-- 다운로드를 위한 URL만들기 -->
							<c:url var="downloadUrl" value="/download.do">
								<c:param name="file" value="${file.fileDir}/${file.fileName}" />
								<c:param name="orgin" value="${file.originName}" />
							</c:url>
							<!-- 다운로드 링크 -->
							<a href="${downloadUrl}" class="btn btn-link btn-xs">${file.originName}</a>
						</c:forEach>
					</td>
				</tr>
			</tbody>
		</table>
		
		<!-- 이미지만 별도로 화면에 출력하기 -->
		<c:forEach var="file" items="${fileList}">
			<c:if test="${fn:substringBefore(file.contentType, '/') == 'image'}">
				<c:url var="downloadUrl" value="/download.do">
					<c:param name="file" value="${file.fileDir}/${file.fileName}" />
				</c:url>
				<p>
					<img src="${downloadUrl}" class="img-responsive" style="margin: auto"/>
				</p>
			</c:if>
		</c:forEach>
	</c:if>
	
	<!-- 내용 -->
	<section style="padding: 0 10px 20px 10px">
		${readDocument.content}
	</section>
		
	<!-- 다음글/이전글 -->
	<table class="table table-bordered">
		<tbody>
			<tr>
				<th class="success" style="width: 100px">다음글</th>
				<td>
					<c:choose>
						<c:when test="${nextDocument != null}">
							<c:url var="nextUrl" value="/bbs/document_read.do">
								<c:param name="category" value="${category}" />
								<c:param name="document_id" value="${nextDocument.id}" />
							</c:url>
							<a href="${nextUrl}">${nextDocument.subject}</a>
						</c:when>
						<c:otherwise>
							다음글이 없습니다.
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th class="success" style="width: 100px">이전글</th>
				<td>
					<c:choose>
						<c:when test="${prevDocument != null}">
							<c:url var="prevUrl" value="/bbs/document_read.do">
								<c:param name="category" value="${category}" />
								<c:param name="document_id" value="${prevDocument.id}" />
							</c:url>
							<a href="${prevUrl}">${prevDocument.subject}</a>
						</c:when>
						<c:otherwise>
							이전글이 없습니다.
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</tbody>
	</table>
		
	<!-- 버튼들 : category값에 대한 상태유지 필요함 -->
	<div class="clearfix">
		<div class="pull-right">
			<a href="${pageContext.request.contextPath}/bbs/document_list.do?category=${category}" 
				class="btn btn-info">목록보기</a>
			<a href="${pageContext.request.contextPath}/bbs/document_write.do?category=${category}" 
				class="btn btn-primary">글쓰기</a>
			<!-- 수정,삭제 대상을 지정하기 위해서 글 번호가 전달되어야 한다. -->
			<a href="${pageContext.request.contextPath}/bbs/document_edit.do?category=${category}&document_id=${readDocument.id}" class="btn btn-warning">수정하기</a>
			<a href="${pageContext.request.contextPath}/bbs/document_delete.do?category=${category}&document_id=${readDocument.id}" class="btn btn-danger">삭제하기</a>
		</div>
	</div>
		
	<!-- 덧글 -->
		
</div>
<%@ include file="/WEB-INF/inc/footer.jsp" %>
</body>
</html>