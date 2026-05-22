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
		<h1>비밀번호 변경</h1>
		<div class="sub-title"
				style="font-size: 14px; text-align: center;">비밀번호 변경 후 다시 로그인해주세요.<br>비밀번호는 8~20자에 영문, 숫자, 특수문자를 모두 포함해야 합니다.</div>
	</div>
	<form action="${pageContext.request.contextPath}/login/changePw.do"
			method="post"
			id="loginForm">
		<div class="input"
				style="display: flex; flex-direction: column; align-items: center; gap: 20px;">
			<div class="pw search-item">
				<label>새 비밀번호</label>
				<div class="pw-wrap">
					<input type="password" id="empNewPw" placeholder="새로운 비밀번호를 입력하세요">
					<button type="button" class="pw-toggle showNewPw" onclick="showNewPw()">
						<svg width="14" height="12" viewBox="0 0 14 9" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path d="M13.2176 3.83C13.3835 4.01375 13.4753 4.25248 13.4753 4.5C13.4753 4.74752 13.3835 4.98625 13.2176 5.17C12.1676 6.3 9.77764 8.5 6.98764 8.5C4.19764 8.5 1.80764 6.3 0.757639 5.17C0.591799 4.98625 0.5 4.74752 0.5 4.5C0.5 4.25248 0.591799 4.01375 0.757639 3.83C1.80764 2.7 4.19764 0.5 6.98764 0.5C9.77764 0.5 12.1676 2.7 13.2176 3.83Z" stroke="#000001" stroke-linecap="round" stroke-linejoin="round"/>
							<path d="M6.98761 6.5C8.09218 6.5 8.98761 5.60457 8.98761 4.5C8.98761 3.39543 8.09218 2.5 6.98761 2.5C5.88304 2.5 4.98761 3.39543 4.98761 4.5C4.98761 5.60457 5.88304 6.5 6.98761 6.5Z" stroke="#000001" stroke-linecap="round" stroke-linejoin="round"/>
						</svg>
					</button>
					<button type="button" class="pw-toggle hidePw hideNewPw" onclick="hideNewPw()">
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
			<div class="pw search-item">
				<label>새 비밀번호 확인</label>
				<div class="pw-wrap">
					<input type="password" id="empPw" name="empPw" placeholder="새로운 비밀번호를 확인해주세요">
					<button type="button" class="pw-toggle showNewPwChk" onclick="showNewPwChk()">
						<svg width="14" height="12" viewBox="0 0 14 9" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path d="M13.2176 3.83C13.3835 4.01375 13.4753 4.25248 13.4753 4.5C13.4753 4.74752 13.3835 4.98625 13.2176 5.17C12.1676 6.3 9.77764 8.5 6.98764 8.5C4.19764 8.5 1.80764 6.3 0.757639 5.17C0.591799 4.98625 0.5 4.74752 0.5 4.5C0.5 4.25248 0.591799 4.01375 0.757639 3.83C1.80764 2.7 4.19764 0.5 6.98764 0.5C9.77764 0.5 12.1676 2.7 13.2176 3.83Z" stroke="#000001" stroke-linecap="round" stroke-linejoin="round"/>
							<path d="M6.98761 6.5C8.09218 6.5 8.98761 5.60457 8.98761 4.5C8.98761 3.39543 8.09218 2.5 6.98761 2.5C5.88304 2.5 4.98761 3.39543 4.98761 4.5C4.98761 5.60457 5.88304 6.5 6.98761 6.5Z" stroke="#000001" stroke-linecap="round" stroke-linejoin="round"/>
						</svg>
					</button>
					<button type="button" class="pw-toggle hidePw hideNewPwChk" onclick="hideNewPwChk()">
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
		
		<button type="submit" id="submitBtn" class="btn btn-main" onclick="loginChk()">비밀번호 변경</button>
	</form>
	
	<a id="movePw" href="${pageContext.request.contextPath}/login">로그인 페이지로 이동</a>

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
		
		const empNewPw = document.querySelector("#empNewPw").value.trim();
		const empPw = document.querySelector("#empPw").value.trim();
		
		const message = document.querySelector("#message");
		
		if (empNewPw == null || empNewPw == "") {
			message.innerText = "ⓘ 비밀번호를 모두 입력해주세요";
			document.querySelector("#empNewPw").focus();
			return;
		}
		
		
		if (empPw == null || empPw == "") {
			message.innerText = "ⓘ 비밀번호를 모두 입력해주세요";
			document.querySelector("#empPw").focus();
			return;
		}
		
		if (empNewPw != empPw) {
			message.innerText = "ⓘ 비밀번호가 서로 다릅니다. 다시 확인해주세요.";
			document.querySelector("#empPw").focus();
			return;
		}
		
		const pwRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*_\-+=?])[A-Za-z\d!@#$%^&*_\-+=?]{8,20}$/;
		
		if (!pwRegex.test(empPw)) {
	        message.innerText = "ⓘ 8~20자의 영문, 숫자, 특수문자(!@#$%^&*_-+=?)를 모두 포함해야 합니다.";
	        return;
	    }
		
		loginForm.submit();
		
	}
	
	function showNewPw() {
		document.querySelector("#empNewPw").type = "text";
		document.querySelector(".showNewPw").style = "display: none";
		document.querySelector(".hideNewPw").style = "display: inline";
	}
	
	function hideNewPw() {
		document.querySelector("#empNewPw").type = "password";
		document.querySelector(".hideNewPw").style = "display: none";
		document.querySelector(".showNewPw").style = "display: inline";
	}
	
	function showNewPwChk() {
		document.querySelector("#empPw").type = "text";
		document.querySelector(".showNewPwChk").style = "display: none";
		document.querySelector(".hideNewPwChk").style = "display: inline";
	}
	
	function hideNewPwChk() {
		document.querySelector("#empPw").type = "password";
		document.querySelector(".hideNewPwChk").style = "display: none";
		document.querySelector(".showNewPwChk").style = "display: inline";
	}
	
	
</script>