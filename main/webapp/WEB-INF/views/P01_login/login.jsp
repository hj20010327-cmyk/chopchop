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
	<form action="${pageContext.request.contextPath}/login/login.do"
			method="post"
			enctype="multipart/form-data"
			id="loginForm">
		<div class="input"
				style="display: flex; flex-direction: column; align-items: center; gap: 20px;">
			<div class="empId search-item">
				<label>사원번호</label>
				<input type="text" id="empId" name="empId" placeholder="사원번호를 입력하세요.">
			</div>
			<div class="pw search-item">
				<label>비밀번호</label>
				<input type="password" id="empPw" name="empPw" placeholder="비밀번호를 입력하세요.">
			</div>
		</div>
		
		<div id="message"></div>
		
		<button type="button" id="submitBtn" class="btn btn-main" onclick="loginChk()">로그인</button>
	</form>
	
	<a id="movePw" href="">비밀번호를 잊어버리셨나요?</a>

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
		let url = contextPath + "/login/login.do?empId=" + encodeURIComponent(empId) + "&empPw=" + encodeURIComponent(empPw);

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
		})
		.then(data => {
			console.log(data);
			
			if (data.result == "success") {
				window.location.href = "${pageContext.request.contextPath}/item/list";
			} else {
				if (data.reason == "noId") {
					message.innerText = "ⓘ 아이디가 존재하지 않거나 사용 불가한 계정입니다";
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
	
</script>