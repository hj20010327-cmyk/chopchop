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
				<input type="passowrd" id="empNewPw" placeholder="새로운 비밀번호를 입력하세요">
			</div>
			<div class="pw search-item">
				<label>새 비밀번호 확인</label>
				<input type="password" id="empPw" name="empPw" placeholder="새로운 비밀번호를 확인해주세요">
			</div>
		</div>
		
		<div id="message"></div>
		
		<button type="button" id="submitBtn" class="btn btn-main" onclick="loginChk()">비밀번호 변경</button>
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
	
	
</script>