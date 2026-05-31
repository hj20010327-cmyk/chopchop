<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content admin-detail-page">

    <div class="header-row">
        <div>
            <h2 class="page-title">사원 상세</h2>
            <p class="page-subtitle">${admin.empName}(${admin.empId})의 상세 정보를 확인하세요.</p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 사원관리 &gt; 상세</p>
        </div>
    </div>

    <div class="btn-row admin-detail-btn-row">
        <div>
            <a class="btn btn-white"
               href="${pageContext.request.contextPath}/admin/list">
                목록
            </a>
        </div>

        <div style="display: flex; gap: 8px;">
            <a class="btn btn-main"
               href="${pageContext.request.contextPath}/admin/edit?empId=${admin.empId}">
                수정
            </a>

            <form action="${pageContext.request.contextPath}/admin/delete"
                  method="post"
                  onclick="return confirm('사원(${admin.empId})을 삭제하시겠습니까?');">

                <input type="hidden"
                       name="empId"
                       value="${admin.empId}">

                <button type="submit"
                        class="btn btn-red">
                    삭제
                </button>
            </form>
        </div>
    </div>

    <div class="emp-profile-card">

        <div class="emp-profile-left">
            <div class="emp-profile-img">
           		<c:choose>
				    <c:when test="${not empty admin.empImg}">
				        <img src="${pageContext.request.contextPath}${admin.empImg}" alt="프로필 이미지">
				    </c:when>
				    <c:otherwise>
				        <img src="${pageContext.request.contextPath}/upload/P02_login/basic.png" alt="기본 프로필 이미지">
				    </c:otherwise>
				</c:choose>
            </div>

            <div>
                <h3 class="emp-profile-name">${admin.empName}</h3>
                <p class="emp-profile-id">사원번호 : ${admin.empId}</p>
            </div>
        </div>

        <div class="emp-profile-status">
            <c:choose>
                <c:when test="${admin.empInOffice == 0}">
                    <span class="status-back status-back-success">• 재직</span>
                </c:when>

                <c:when test="${admin.empInOffice == 10}">
                    <span class="status-back status-back-warning">• 휴직</span>
                </c:when>

                <c:when test="${admin.empInOffice == 50}">
                    <span class="status-back status-back-info">• 퇴사</span>
                </c:when>

                <c:otherwise>
                    <span class="status-back status-back-info">• 미지정</span>
                </c:otherwise>
            </c:choose>
        </div>

    </div>

    <div class="emp-info-grid">

        <div class="emp-info-card">
            <h3 class="emp-section-title">사원 정보</h3>

            <div class="emp-table-wrap">
                <table class="emp-info-table">
                    <tr>
                        <th>사원번호</th>
                        <td>${admin.empId}</td>
                    </tr>
                    <tr>
                        <th>이름</th>
                        <td>${admin.empName}</td>
                    </tr>
                    <tr>
                        <th>부서</th>
                        <td>${admin.deptName}</td>
                    </tr>
                    <tr>
                        <th>연락처</th>
                        <td>
	                        ${(admin.empTel != null and admin.empTel != '') ? admin.empTel : '-' }
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="emp-info-card">
            <h3 class="emp-section-title">계정 정보</h3>

            <div class="emp-table-wrap">
                <table class="emp-info-table">
                    <tr>
                        <th>이메일</th>
                        <td>${admin.empEmail}</td>
                    </tr>
                    <tr>
                        <th>가입일</th>
                        <td>${admin.empHiredate}</td>
                    </tr>
                    <tr>
                        <th>권한</th>
                        <td>
                            <c:choose>
                                <c:when test="${admin.empAuth == 0}">퇴사자</c:when>
                                <c:when test="${admin.empAuth == 10}">작업자</c:when>
                                <c:when test="${admin.empAuth == 20}">관리자</c:when>
                                <c:when test="${admin.empAuth == 30}">최고관리자</c:when>
                                <c:otherwise>권한 미지정</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

    </div>

    <div class="emp-activity-section">
        <h3 class="emp-section-title">활동 정보</h3>

        <div class="emp-activity-wrap card-wrap">

            <div class="emp-activity-card card warning">
                <p class="activity-title card-title">대기 중인 작업</p>
                <p class="activity-count activity-wait card-value">${activity.waitCount} <span>건</span></p>
                <p class="activity-sub card-subtitle">최근 30일 기준</p>
            </div>

            <div class="emp-activity-card card success">
                <p class="activity-title card-title">진행 중인 작업</p>
                <p class="activity-count activity-progress card-value">${activity.progressCount} <span>건</span></p>
                <p class="activity-sub card-subtitle">최근 30일 기준</p>
            </div>

            <div class="emp-activity-card card safe">
                <p class="activity-title card-title">완료된 작업</p>
                <p class="activity-count activity-done card-value">${activity.doneCount} <span>건</span></p>
                <p class="activity-sub card-subtitle">최근 30일 기준</p>
            </div>

            <div class="emp-activity-card card danger">
                <p class="activity-title card-title">지연된 작업</p>
                <p class="activity-count activity-delay card-value">${activity.delayCount} <span>건</span></p>
                <p class="activity-sub card-subtitle">최근 30일 기준</p>
            </div>

        </div>
    </div>
    
    <div class="table-section sugg">
        <h3 class="emp-section-title">작성한 건의 사항</h3>
        
        <div class="table-wrap">
        	<table class="table">
        		<thead>
        			<tr>
        				<th style="width: 75px">번호</th>
        				<th style="width: 270px">제목</th>
        				<th style="width: 150px">등록일</th>
        				<th style="width: 90px">댓글</th>
        				<th style="width: 90px">조회수</th>
        				<th style="width: 130px">상태</th>
        			</tr>
        		</thead>
        		
        		<tbody>
        			<c:forEach var="sugg" items="${suggList}">
        				<tr class="clickable-sugg-row" data-sugg-no="${sugg.sugg_no}">
        					<td>${sugg.sugg_no}</td>
        					<td class="suggTitle">${sugg.sugg_title}</td>
        					<td>${sugg.sugg_cdate}</td>
        					<td>${sugg.comment_count}</td>
        					<td>${sugg.sugg_view}</td>
        					<td>
        						<c:choose>
									<c:when test="${sugg.sugg_answer == 'Y'}">
										<span class="status status-success">• 답변 완료</span>
									</c:when>
									<c:otherwise>
										<span class="status status-info">• 답변 대기</span>
									</c:otherwise>
								</c:choose>
        					</td>
        				</tr>
        			</c:forEach>
        			<c:if test="${empty suggList or suggList == null}">
        				<tr>
        					<td colspan="6">조회된 건의사항 없음</td>
        				</tr>
        			</c:if>
        		</tbody>
        	</table>
        </div>
    </div>

</div>

<style>
    .admin-detail-page {
        max-width: 1080px;
        margin: 0 auto;
    }

    .admin-detail-btn-row {
        margin-top: 24px;
        margin-bottom: 26px;
    }

    .emp-profile-card {
        position: relative;

        min-height: 140px;
        padding: 24px 26px;

        display: flex;
        align-items: center;
        justify-content: space-between;

        border: 1px solid var(--gray);
        border-radius: 8px;
        background-color: #fff;

        margin-bottom: 16px;
    }

    .emp-profile-status {
        position: absolute;
        top: 22px;
        right: 26px;
    }

    .emp-profile-left {
        display: flex;
        align-items: center;
        gap: 34px;
    }

    .emp-profile-img {
        width: 96px;
        height: 96px;

        border-radius: 50%;
        background-color: white;
    }
    
    
    .emp-profile-img img {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	    display: block;
	    border-radius: 50%;
	}

    .emp-profile-name {
        margin: 0 0 10px;

        font-size: 20px;
        font-weight: 700;
    }

    .emp-profile-id {
        margin: 0;

        font-size: 15px;
        font-weight: 500;
        color: var(--dark-gray);
    }

    .emp-info-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 18px;

        margin-bottom: 36px;
    }

    .emp-info-card {
        min-height: 235px;
        padding: 26px 24px;

        border: 1px solid var(--gray);
        border-radius: 8px;
        background-color: #fff;
    }

    .emp-section-title {
        margin: 0 0 28px;

        font-size: 18px;
        font-weight: 700;
        color: #222;
    }

    .emp-table-wrap {
        padding: 0 18px;
    }

    .emp-info-table {
        width: 100%;
        border-collapse: collapse;
        table-layout: fixed;

        border-top: 1px solid var(--gray);
    }

    .emp-info-table tr {
        border-bottom: 1px solid var(--gray);
    }

    .emp-info-table th,
    .emp-info-table td {
        height: 38px;
        padding: 0 10px;

        font-size: 14px;
        text-align: left;
        vertical-align: middle;

        background-color: #fff;
    }

    .emp-info-table th {
        width: 32%;
        font-weight: 700;
    }

    .emp-info-table td {
        width: 68%;
        font-weight: 500;
        color: #222;
    }
    
    .card-wrap {
    	margin-bottom: 40px;
    }
    
    .card {
    	width: 200px;	
    	display: flex;
    	flex-direction: column;
    	align-items: center;
    	
    	gap: 10px;
    }
    
    .card-value {
    	margin: 0px;
    }
    
    .card-value span {
    	font-weight: 500;
    	font-size: 18px;
    	color: black
    }

/*     .emp-activity-section { */
/*         margin-top: 10px; */
/*     } */

/*     .emp-activity-section .emp-section-title { */
/*         margin-bottom: 20px; */
/*     } */

/*     .emp-activity-wrap { */
/*         display: flex; */
/*         justify-content: center; */
/*         gap: 24px; */
/*     } */

/*     .emp-activity-card { */
/*         width: 165px; */
/*         min-height: 130px; */
/*         padding: 20px 16px; */

/*         border: 1px solid var(--gray); */
/*         border-radius: 8px; */
/*         background-color: #fff; */

/*         text-align: center; */
/*     } */

/*     .activity-title { */
/*         margin: 0 0 14px; */

/*         font-size: 16px; */
/*         font-weight: 700; */
/*     } */

/*     .activity-count { */
/*         margin: 0 0 12px; */

/*         font-size: 32px; */
/*         font-weight: 800; */
/*         line-height: 1; */
/*     } */

/*     .activity-count span { */
/*         margin-left: 6px; */

/*         font-size: 16px; */
/*         font-weight: 700; */
/*         color: black; */
/*     } */

/*     .activity-sub { */
/*         margin: 0; */

/*         font-size: 12px; */
/*         color: var(--dark-gray); */
/*     } */

/*     .activity-wait { */
/*         color: var(--warning); */
/*     } */

/*     .activity-progress { */
/*         color: var(--success); */
/*     } */

/*     .activity-done { */
/*         color: var(--info); */
/*     } */

/*     .activity-delay { */
/*         color: var(--danger); */
/*     } */

    @media (max-width: 1000px) {
        .emp-info-grid {
            grid-template-columns: 1fr;
        }

        .emp-activity-wrap {
            flex-wrap: wrap;
        }

        .emp-profile-card {
            align-items: flex-start;
            flex-direction: column;
            gap: 20px;
        }

        .emp-profile-status {
            position: static;
        }
    }
</style>