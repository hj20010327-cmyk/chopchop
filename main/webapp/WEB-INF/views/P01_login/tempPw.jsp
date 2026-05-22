<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<h1>임시 비밀번호 발급</h1>
		<div class="sub-title"
				style="font-size: 14px;">사원번호와 이메일 주소를 입력 후 로그인 해주세요.</div>
	</div>
	<form action="${pageContext.request.contextPath}/login/tempPw.do"
			method="post"
			id="loginForm">
		<div class="input"
				style="display: flex; flex-direction: column; align-items: center; gap: 20px;">
			<div class="empId search-item">
				<label>사원번호</label>
				<input type="text" id="empId" name="empId" placeholder="사원번호를 입력하세요">
			</div>
			<div class="email search-item">
				<label>이메일</label>
				<input type="text" id="empEmail" name="empEmail" placeholder="이메일 주소를 입력하세요">
			</div>
		</div>
		
		<div id="message"></div>
		
		<button type="submit" id="submitBtn" class="btn btn-main" onclick="loginChk()">임시 비밀번호 전송</button>
	</form>
	
	<a id="movePw" href="${pageContext.request.contextPath}/login">로그인 페이지로 이동</a>

</div>

<div class="overlay">
	<div class="loading-box modal">
		<div class="circles">
			<i></i>
			<i></i>
			<i></i>
		</div>
		<p>이메일 전송 중...</p>
	</div>
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
	
	.loading-box {
		position:fixed;
		left:50%; top:50%;
		z-index:100;
		transform:translate(-50%, -50%);
		padding: 30px 70px;
		text-align:center;
		background:#fff;
		box-shadow:0 3px 0 rgba(0,0,0,.2);
	}
	
	.loading-box .circles {
		padding-top:30px;
	}
	
	.loading-box .circles i {
		display:inline-block;
		margin:0 3px;
		width:10px;
		height:10px;
		background:var(--main-green);
		border-radius:50em;
		
		animation: scaleBounce .6s infinite alternate;
	}
	
	.loading-box p {
		margin-top:10px;
		font-size:16px;
	}
	@keyframes scaleBounce {
		from {transform:scale(.7)}
		to {transform:scale(1.3)}
	}
	.loading-box .circles i:nth-child(2) {animation-delay:.1s;}
	.loading-box .circles i:nth-child(3) {animation-delay:.2s;}
		
</style>

<script>

	document.querySelector("#loginForm").addEventListener("submit", function(e) {
		e.preventDefault();
		loginChk();
	});
	
	function loginChk() {
		const loginForm = document.getElementById("loginForm");
		
		const empId = document.querySelector("#empId").value.trim();
		const empEmail = document.querySelector("#empEmail").value.trim();
		
		const message = document.querySelector("#message");
		
		const overlay = document.querySelector(".overlay");
		
		if (empId == null || empId == "") {
			message.innerText = "ⓘ 사원번호를 입력해주세요";
			document.querySelector("#empId").focus();
			return;
		}
		
		
		if (empEmail == null || empEmail == "") {
			message.innerText = "ⓘ 이메일 주소를 입력해주세요";
			document.querySelector("#empEmail").focus();
			return;
		}
		
		overlay.style.display = "flex";
		
		const contextPath = '${pageContext.request.contextPath}';
		let url = contextPath + "/login/tempPw.do?empId=" + encodeURIComponent(empId) + "&empEmail=" + encodeURIComponent(empEmail);

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
				message.innerText = "ⓘ 이메일 주소로 임시 비밀번호가 전송되었습니다";
			} else {
				if (data.message == "noId") {
					message.innerText = "ⓘ 존재하지 않거나 사용 불가한 사용자입니다";
					document.querySelector("#empId").focus();
				} else if (data.message == "wrongEmail") {
					message.innerText = "ⓘ 이메일 주소가 일치하지 않습니다";
					document.querySelector("#empEmail").focus();
				} else {
					message.innerText = "ⓘ 메일을 보낼 수 없습니다. 관리자에게 문의해주세요."
				}
			}
			
		})
		.catch(error => {
			console.error(error);
			alert("사용자 정보를 불러오지 못했습니다.");
		})
		.finally(() => {
	        overlay.style.display = "none";
	    });
		
	}
	
</script>