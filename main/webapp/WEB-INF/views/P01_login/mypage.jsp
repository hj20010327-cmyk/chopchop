<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content user-detail-page">

    <div class="header-row">
        <div>
            <h2 class="page-title">마이페이지</h2>
            <p class="page-subtitle">내 정보를 확인하고 관리하세요.</p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 마이페이지</p>
        </div>
    </div>

    <div class="btn-row">
    	<div></div>
        <div>
            <a class="btn btn-main"
               href="${pageContext.request.contextPath}/mypage/edit?empId=${user.empId}">
                수정
            </a>
        </div>
    </div>

    <div class="emp-profile-card">

        <div class="emp-profile-left">
            <div class="emp-profile-img">
           		<c:choose>
				    <c:when test="${not empty user.empImg}">
				        <img src="${pageContext.request.contextPath}${user.empImg}" alt="프로필 이미지">
				    </c:when>
				    <c:otherwise>
				        <img src="${pageContext.request.contextPath}/upload/P02_login/basic.png" alt="기본 프로필 이미지">
				    </c:otherwise>
				</c:choose>
            </div>

            <div>
                <h3 class="emp-profile-name">${user.empName}</h3>
                <p class="emp-profile-id">사원번호 : ${user.empId}</p>
            </div>
        </div>

        <div class="emp-profile-status">
            <c:choose>
                <c:when test="${user.empInOffice == 0}">
                    <span class="status-back status-back-success">• 재직</span>
                </c:when>

                <c:when test="${user.empInOffice == 10}">
                    <span class="status-back status-back-warning">• 휴직</span>
                </c:when>

                <c:when test="${user.empInOffice == 50}">
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
                        <td>${user.empId}</td>
                    </tr>
                    <tr>
                        <th>이름</th>
                        <td>${user.empName}</td>
                    </tr>
                    <tr>
                        <th>부서</th>
                        <td>${user.empDname}</td>
                    </tr>
                    <tr>
                        <th>연락처</th>
                        <td>
	                        ${(user.empTel != null and user.empTel != '') ? user.empTel : '-' }
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
                        <td>${user.empEmail}</td>
                    </tr>
                    <tr>
                        <th>가입일</th>
                        <td>${user.empHiredate}</td>
                    </tr>
                    <tr>
                        <th>권한</th>
                        <td>
                            <c:choose>
                                <c:when test="${user.empAuth == 0}">퇴사자</c:when>
                                <c:when test="${user.empAuth == 10}">작업자</c:when>
                                <c:when test="${user.empAuth == 20}">관리자</c:when>
                                <c:when test="${user.empAuth == 30}">최고관리자</c:when>
                                <c:otherwise>권한 미지정</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        
    </div>
    
    <div class="card-wrap">

            <div class="card warning">
                <p class="card-title">대기 중인 작업</p>
                <p class="card-value">${actWork.waitCount} <span>건</span></p>
                <p class="card-subtitle">최근 30일 기준</p>
            </div>

            <div class="card success">
                <p class="card-title">진행 중인 작업</p>
                <p class="card-value">${actWork.progressCount} <span>건</span></p>
                <p class="card-subtitle">최근 30일 기준</p>
            </div>

            <div class="card safe">
                <p class="card-title">완료된 작업</p>
                <p class="card-value">${actWork.doneCount} <span>건</span></p>
                <p class="card-subtitle">최근 30일 기준</p>
            </div>

            <div class="card danger">
                <p class="card-title">지연된 작업</p>
                <p class="card-value">${actWork.delayCount} <span>건</span></p>
                <p class="card-subtitle">최근 30일 기준</p>
            </div>

        </div>
    
    <div class="table-section">
    	<h3 class="emp-section-title">알림 내역</h3>
    	<div class="table-wrap">
    		<table class="table">
		        <thead>
		            <tr>
		                <th>유형</th>
		                <th>제목</th>
		                <th>내용</th>
		                <th>등록일</th>
		            </tr>
		        </thead>
		
		        <tbody>
		            <c:choose>
		                <c:when test="${empty alarmList}">
		                    <tr>
		                        <td colspan="4" class="empty">
		                            확인할 알림이 없습니다.
		                        </td>
		                    </tr>
		                </c:when>
		
		                <c:otherwise>
		                    <c:forEach var="alarm" items="${alarmList}">
		                        <tr onclick="location.href='${pageContext.request.contextPath}/alarm/detail?alarmId=${alarm.alarmId}'">
		                            <td>
		                                <c:choose>
		                                    <c:when test="${alarm.alarmTypeNo == 10}">작업</c:when>
		                                    <c:when test="${alarm.alarmTypeNo == 20}">이상</c:when>
		                                    <c:when test="${alarm.alarmTypeNo == 30}">점검</c:when>
		                                    <c:when test="${alarm.alarmTypeNo == 40}">일반</c:when>
		                                    <c:otherwise>알림</c:otherwise>
		                                </c:choose>
		                            </td>
		
		                            <td>${alarm.alarmTitle}</td>
		                            <td>${alarm.alarmContent}</td>
		
		                            <td>
		                                <fmt:formatDate value="${alarm.alarmDate}" pattern="yyyy-MM-dd HH:mm"/>
		                            </td>
		                        </tr>
		                    </c:forEach>
		                </c:otherwise>
		            </c:choose>
		        </tbody>
		    </table>
    	</div>
    </div>

    <div class="table-section workOrder">
        <h3 class="emp-section-title">금일 작업 사항</h3>
        
        <div class="table-wrap">
        	<table class="table">
        		<thead>
        			<tr>
        				<th>작업번호</th>
        				<th>품목</th>
        				<th>수량</th>
        				<th>담당자</th>
        				<th>작업자</th>
        				<th>상태</th>
        			</tr>
        		</thead>
        		
        		<tbody>
        			<c:forEach var="work" items="${workList}">
        				<tr class="clickable-work-row" data-work-id="${work.workId}" data-dept="${user.empDeptno}">
	        				<td class="workId">${work.workId}</td>
	        				<td>${work.itemName} (${work.item})</td>
	        				<td>${work.qty} ${work.itemUnit}</td>
	        				<td>${work.directorName} (${work.directorId})</td>
	        				<td>${work.workerName} (${work.workerId})</td>
	        				<td>
	        					<c:choose>
									<c:when test="${work.status == 10}">
										<span class="status status-warning">• 대기</span>
									</c:when>
									<c:when test="${work.status == 20}">
										<span class="status status-success">• 진행 중</span>
									</c:when>
									<c:when test="${work.status == 30}">
										<span class="status status-safe">• 완료</span>
									</c:when>
									<c:when test="${work.status == 40}">
										<span class="status stauts-danger">• 지연</span>
									</c:when>
									<c:when test="${work.status == 0}">
										<span class="status status-info">• 보류</span>
									</c:when>
									<c:otherwise>
										<span class="status status-info">-</span>
									</c:otherwise>
								</c:choose>
	        				</td>
        				</tr>
        			</c:forEach>
        			<c:if test="${empty workList or workList == null}">
        				<tr>
        					<td colspan="6">조회된 작업사항 없음</td>
        				</tr>
        			</c:if>
        		</tbody>
        	</table>
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
    .user-detail-page {
        max-width: 1080px;
        margin: 0 auto;
    }

    .user-detail-btn-row {
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
    }
    
    .table-section {
    	margin-bottom: 30px;
    }
	
	.clickable-work-row:hover .workId,
	.clickable-sugg-row:hover .suggTitle {
		color: var(--main-green);
		text-decoration: underline;
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

<script>
	window.addEventListener("load", function() {
		bindMypageRows();
	});
	
	function bindMypageRows() {
		const contextPath = "${pageContext.request.contextPath}";
	
		const workRows = document.querySelectorAll(".clickable-work-row");
		const suggRows = document.querySelectorAll(".clickable-sugg-row");
	
		for (let i = 0; i < workRows.length; i++) {
			workRows[i].addEventListener("click", function() {
				const workId = this.dataset.workId;
				const dept = this.dataset.dept;
	
				if (!workId) {
					return;
				}
	
				if (dept === "10") {
					location.href = contextPath + "/work/detail?workId=" + encodeURIComponent(workId);
					return;
				}
	
				if (dept === "20") {
					location.href = contextPath + "/qc/detail?qcId=" + encodeURIComponent(workId);
					return;
				}
	
				alert("이동 가능한 부서가 아닙니다.");
			});
		}
	
		for (let i = 0; i < suggRows.length; i++) {
			suggRows[i].addEventListener("click", function() {
				const suggNo = this.dataset.suggNo;
	
				if (!suggNo) {
					return;
				}
	
				location.href = contextPath + "/sugg/detail?sugg_no=" + encodeURIComponent(suggNo);
			});
		}
	}
</script>