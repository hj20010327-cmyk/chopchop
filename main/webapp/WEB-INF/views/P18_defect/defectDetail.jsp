<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">
    
    <div class="header-row">
        <div>
            <h2 class="page-title">불량 유형 상세</h2>

            <p class="page-subtitle">
                선택한 불량 유형의 상세 정보를 확인하세요.
            </p>
        </div>
        
        <div>
            <p class="page-route">
                홈 &gt; 불량 유형 관리 &gt; 상세
            </p>
        </div>
    </div>

    <div class="btn-row">
        
        <div class="left">
            <a class="btn btn-white"
               href="${pageContext.request.contextPath}/defect/list">
                목록으로
            </a>
        </div>

        <div class="right">
            
            <a class="btn btn-main"
               href="${pageContext.request.contextPath}/defect/edit?defTypeId=${def.defTypeId}">
                수정
            </a>

            <a class="btn btn-red"
               href="${pageContext.request.contextPath}/defect/delete?defTypeId=${def.defTypeId}"
               onclick="return confirm('불량유형(${def.defTypeId})을 삭제하시겠습니까?');">
                삭제
            </a>

        </div>

    </div>
    
    <div class="content-content">
        
        <div class="content-content-content">
            
            <div class="content-content-content-title">
                불량 유형 상세정보
            </div>

            <div class="info-table-wrap">
                
                <table class="info-table">
                    
                    <tbody>

                        <tr>
                            <th>불량 유형명</th>
                            <td>${def.defTypeName}</td>

                            <th>불량 유형 코드</th>
                            <td>${def.defTypeId}</td>
                        </tr>

                        <tr>
                            <th>
                                기준 조치
                            </th>

                            <td colspan="3"
                                class="def-top-align">

                                <div class="def-detail-text"><c:choose><c:when test="${not empty def.defStandardAction}">${def.defStandardAction}</c:when><c:otherwise>-</c:otherwise></c:choose></div>

                            </td>
                        </tr>

                    </tbody>

                </table>

            </div>

        </div>

    </div>
    
</div>

<style>

.def-top-align {
    vertical-align: top !important;
}

.def-detail-text {
    min-height: 80px;

    padding: 12px 0;

    line-height: 1.6;

    white-space: pre-wrap;
    text-align: left;
}

</style>