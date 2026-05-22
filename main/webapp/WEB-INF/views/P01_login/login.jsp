<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="content"
		style="display: flex; flex-direction: column; justify-content: center; align-items: center; gap: 30px;
				height: calc(100vh - 120px);">

	<div class="logo">
		<img src="${pageContext.request.contextPath}/upload/logo.png" alt="logo.png"
				style="width: 250px;">
	</div>
	<div class="title"
			style="display: flex; flex-direction: column; align-items: center;">
		<h1>로그인</h1>
		<div class="sub-title"
				style="font-size: 14px;">사원번호와 비밀번호를 입력 후 로그인 해주세요.</div>
	</div>
	<form action="${pageContext.request.contextPath}/login.do"
			method="post"
			id="loginForm">
		<div class="input"
				style="display: flex; flex-direction: column; align-items: center; gap: 20px;">
			<div class="empId search-item">
				<label>사원번호</label>
				<input type="text" id="empId" name="empId" placeholder="사원번호를 입력하세요">
			</div>
			<div class="pw search-item">
				<label>비밀번호</label>
				<div class="pw-wrap">
					<input type="password" id="empPw" name="empPw" placeholder="비밀번호를 입력하세요">
					<button type="button" class="pw-toggle showPw" onclick="showPw()">
						<svg width="14" height="12" viewBox="0 0 14 9" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path d="M13.2176 3.83C13.3835 4.01375 13.4753 4.25248 13.4753 4.5C13.4753 4.74752 13.3835 4.98625 13.2176 5.17C12.1676 6.3 9.77764 8.5 6.98764 8.5C4.19764 8.5 1.80764 6.3 0.757639 5.17C0.591799 4.98625 0.5 4.74752 0.5 4.5C0.5 4.25248 0.591799 4.01375 0.757639 3.83C1.80764 2.7 4.19764 0.5 6.98764 0.5C9.77764 0.5 12.1676 2.7 13.2176 3.83Z" stroke="#000001" stroke-linecap="round" stroke-linejoin="round"/>
							<path d="M6.98761 6.5C8.09218 6.5 8.98761 5.60457 8.98761 4.5C8.98761 3.39543 8.09218 2.5 6.98761 2.5C5.88304 2.5 4.98761 3.39543 4.98761 4.5C4.98761 5.60457 5.88304 6.5 6.98761 6.5Z" stroke="#000001" stroke-linecap="round" stroke-linejoin="round"/>
						</svg>
					</button>
					<button type="button" class="pw-toggle hidePw" onclick="hidePw()">
						<svg width="14" height="12" viewBox="0 0 14 12" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path d="M12.2776 4.3999C12.6576 4.7399 12.9776 5.0699 13.2176 5.3299C13.3835 5.51365 13.4753 5.75238 13.4753 5.9999C13.4753 6.24742 13.3835 6.48615 13.2176 6.6699C12.1676 7.7999 9.77765 9.9999 6.98765 9.9999H6.58765" stroke="#000001" stroke-linecap="round" stroke-linejoin="round"/>
							<path d="M3.85764 9.13C2.69927 8.48125 1.65261 7.65067 0.757639 6.67C0.591799 6.48625 0.5 6.24752 0.5 6C0.5 5.75248 0.591799 5.51375 0.757639 5.33C1.80764 4.2 4.19764 2 6.98764 2C8.08741 2.02299 9.16375 2.32216 10.1176 2.87" stroke="#000001" stroke-linecap="round" stroke-linejoin="round"/>
							<path d="M12.4876 0.5L1.48761 11.5" stroke="#000001" stroke-linecap="round" stroke-linejoin="round"/>
							<path d="M5.57761 7.41C5.20202 7.03665 4.98984 6.52958 4.98761 6C4.98761 5.46957 5.19832 4.96086 5.5734 4.58579C5.94847 4.21071 6.45718 4 6.98761 4C7.51719 4.00223 8.02426 4.21441 8.39761 4.59" stroke="#000001" stroke-linecap="round" stroke-linejoin="round"/>
							<path d="M8.72761 7C8.54959 7.3043 8.2943 7.55614 7.98761 7.73" stroke="#000001" stroke-linecap="round" stroke-linejoin="round"/>
						</svg>
					</button>
				</div>
			</div>
		</div>
		
		<div id="message"></div>
		
		<button type="submit" id="submitBtn" class="btn btn-main">로그인</button>
	</form>
	
	<a id="movePw" href="${pageContext.request.contextPath}/login/tempPw">비밀번호를 잊어버리셨나요?</a>

</div>

<style>

	input:-webkit-autofill,
	input:-webkit-autofill:hover,
	input:-webkit-autofill:focus,
	input:-webkit-autofill:active {
		-webkit-box-shadow: 0 0 0 1000px #f8f9fa inset !important;
		box-shadow: 0 0 0 1000px #f8f9fa inset !important;
		-webkit-text-fill-color: #333 !important;
	}
	
	.input input {
		width: 350px;
	}
	
	#message {
		font-size: 14px;
		margin: 20px auto 0;
	    text-align: center;
	    
	    color: var(--danger);
	}
	
	#submitBtn {
		width: 300px;
		margin: 30px auto 0;
	}
	
	#movePw {
		font-size: 14px;
		text-decoration: underline;
		
		color: #111;
	}
	
	#movePw:hover {
		color: var(--main-green);
	}
	
</style>

<script>

	document.querySelector("#loginForm").addEventListener("submit", function(e) {
		e.preventDefault();
		loginChk();
	});
	
	function loginChk() {
		const loginForm = document.getElementById("loginForm");
		
		const empId = document.querySelector("#empId").value.trim();
		const empPw = document.querySelector("#empPw").value.trim();
		
		const message = document.querySelector("#message");
		
		if (empId == null || empId == "") {
			message.innerText = "ⓘ 사원번호를 입력해주세요";
			document.querySelector("#empId").focus();
			return;
		}
		
		
		if (empPw == null || empPw == "") {
			message.innerText = "ⓘ 비밀번호를 입력해주세요";
			document.querySelector("#empPw").focus();
			return;
		}
		
		const contextPath = '${pageContext.request.contextPath}';
		let url = contextPath + "/login.do?empId=" + encodeURIComponent(empId) + "&empPw=" + encodeURIComponent(empPw);

		fetch(url, {
			method: "POST",
			headers: {
				"Accept": "application/json"
			}
		})
		.then(response => {
			if (!response.ok) {
				throw new Error("사용자 정보 조회 실패");
			}
			return response.json();
			console.log("status:", response.status);
		    console.log("content-type:", response.headers.get("content-type"));
		    return response.text();
		})
		.then(data => {
			console.log(data);
			
			if (data.result == "success") {
				window.location.href = contextPath + data.redirectUrl;
			} else {
				if (data.reason == "noId") {
					message.innerText = "ⓘ 존재하지 않거나 사용 불가한 사용자입니다";
					document.querySelector("#empId").focus();
				} else if (data.reason == "wrongPw") {
					message.innerText = "ⓘ 비밀번호가 일치하지 않습니다";
					document.querySelector("#empPw").focus();
				} else {
					message.innerText = "ⓘ 로그인 할 수 없습니다. 관리자에게 문의해주세요."
				}
			}
			
		})
		.catch(error => {
			console.error(error);
			alert("사용자 정보를 불러오지 못했습니다.");
		});
		
	}
	
	function showPw() {
		document.querySelector("#empPw").type = "text";
		document.querySelector(".showPw").style = "display: none";
		document.querySelector(".hidePw").style = "display: inline";
	}
	
	function hidePw() {
		document.querySelector("#empPw").type = "password";
		document.querySelector(".hidePw").style = "display: none";
		document.querySelector(".showPw").style = "display: inline";
	}
	
</script>