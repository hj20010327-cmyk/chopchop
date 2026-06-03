// 알림
document.addEventListener("DOMContentLoaded", function () {

    const alarmBtn = document.getElementById("alarmBtn");
    const alarmPanel = document.getElementById("alarmPanel");
    const alarmListBox = document.getElementById("alarmListBox");

    if (!alarmBtn || !alarmPanel || !alarmListBox) return;

    alarmBtn.addEventListener("click", function (e) {

        e.stopPropagation();

        const isOpen = alarmPanel.classList.contains("active");

        if (isOpen) {
            alarmPanel.classList.remove("active");
            return;
        }

        alarmPanel.classList.add("active");

        loadMyAlarmList();
    });

    alarmPanel.addEventListener("click", function (e) {
        e.stopPropagation();
    });

    document.addEventListener("click", function () {
        alarmPanel.classList.remove("active");
    });

    function loadMyAlarmList() {

        alarmListBox.innerHTML =
            "<div class='alarm-empty'>알림을 불러오는 중입니다.</div>";

        fetch(contextPath + "/alarm/myListJson")
            .then(function (response) {
                return response.json();
            })
            .then(function (result) {

                let html = "";

                if (result.length === 0) {

                    html += "<div class='alarm-empty'>";
                    html += "확인할 알림이 없습니다.";
                    html += "</div>";

                    alarmListBox.innerHTML = html;

                    return;
                }

                let showList = result.slice(0, 2);

                for (let i = 0; i < showList.length; i++) {

                    html += "<div class='alarm-item' ";
                    html += "onclick=\"location.href='" + contextPath + "/alarm/detail?alarmId=" + showList[i].alarmId + "'\">";

                    html += "<div class='alarm-content-wrap'>";

                    html += "<p class='alarm-text'>";
                    html += "[" + getAlarmTypeName(showList[i].alarmTypeNo) + "] ";
                    html += showList[i].alarmTitle;
                    html += "</p>";

                    html += "<div class='alarm-time'>";
                    html += formatAlarmDate(showList[i].alarmDate);
                    html += "</div>";

                    html += "</div>";

                    html += "</div>";
                }

                if (result.length > 2) {
                    html += "<div class='alarm-more' ";
                    html += "onclick=\"location.href='" + contextPath + "/mypage/alarm'\">";
                    html += "더보기";
                    html += "</div>";
                }

                alarmListBox.innerHTML = html;
                bindAlarmCloseButtons();
            })
            .catch(function () {

                alarmListBox.innerHTML =
                    "<div class='alarm-empty'>알림 조회 실패</div>";
            });
    }

    function bindAlarmCloseButtons() {
    const closeButtons = alarmPanel.querySelectorAll(".alarm-close");

    closeButtons.forEach(function (btn) {
        btn.addEventListener("click", function (e) {
            e.stopPropagation();
            btn.closest(".alarm-item").remove();
        });
    });
}

    function getAlarmTypeName(typeNo) {

        switch (Number(typeNo)) {

            case 10:
                return "작업";

            case 20:
                return "이상";

            case 30:
                return "점검";

            case 40:
                return "일반";

            default:
                return "알림";
        }
    }

    function formatAlarmDate(value) {

        if (!value) {
            return "";
        }

        const date = new Date(value);

        const yyyy = date.getFullYear();
        const mm = String(date.getMonth() + 1).padStart(2, "0");
        const dd = String(date.getDate()).padStart(2, "0");

        const hh = String(date.getHours()).padStart(2, "0");
        const mi = String(date.getMinutes()).padStart(2, "0");

        return yyyy + "-" + mm + "-" + dd + " " + hh + ":" + mi;
    }
});

// 사이드바
document.addEventListener("DOMContentLoaded", function () {
    setSnbActiveMenu();
});

function setSnbActiveMenu() {
    const currentPath = window.location.pathname;
    const snb = document.querySelector(".snb");

    if (!snb) return;

    const menuLinks = snb.querySelectorAll(".snb-menu[href]");
    const subLinks = snb.querySelectorAll(".snb-submenu-link[href]");

    menuLinks.forEach(function (link) {
        link.classList.remove("active");
    });

    subLinks.forEach(function (link) {
        link.classList.remove("active");
    });

    const groups = snb.querySelectorAll(".snb-group");

    groups.forEach(function (group) {
        group.classList.remove("open");
    });

    subLinks.forEach(function (link) {
        const linkPath = new URL(link.href).pathname;

        // /chop/admin/list -> /chop/admin
        const pathParts = linkPath.split("/");
        const rootPath = "/" + pathParts[1] + "/" + pathParts[2];

        if (currentPath === linkPath || currentPath.startsWith(linkPath + "/")) {
            link.classList.add("active");

            const group = link.closest(".snb-group");

            if (group) {
                group.classList.add("open");

                const parentMenu = group.querySelector(".snb-menu");

                if (parentMenu) {
                    parentMenu.classList.add("active");
                }
            }
        }
    });

    menuLinks.forEach(function (link) {
        const linkPath = new URL(link.href).pathname;

        if (currentPath === linkPath) {
            link.classList.add("active");
        }
    });
}

function openModal(overlay) {
	if (!overlay) return;

	overlay.classList.add("active");
	document.body.classList.add("modal-open");
}

function closeModal(overlay) {
	if (!overlay) return;

	overlay.classList.remove("active");

	const openedOverlay = document.querySelector(".overlay.active");

	if (!openedOverlay) {
		document.body.classList.remove("modal-open");
	}
}

/* ==============================
   페이지네이션 전용 스크롤 위치 저장
============================== */

document.addEventListener("DOMContentLoaded", function () {

    const pagingLinks = document.querySelectorAll(".pagination a[href]");

    pagingLinks.forEach(function (link) {
        link.addEventListener("click", function () {
            sessionStorage.setItem("pagingScrollRestore", "Y");
            sessionStorage.setItem("pagingScrollPath", window.location.pathname);
            sessionStorage.setItem("pagingScrollPosition", String(window.scrollY));
        });
    });
});

/* ==============================
   페이지네이션 이동 후 스크롤 복원
============================== */

window.addEventListener("load", function () {

    const restoreYn = sessionStorage.getItem("pagingScrollRestore");
    const savedPath = sessionStorage.getItem("pagingScrollPath");
    const savedPosition = sessionStorage.getItem("pagingScrollPosition");

    if (
        restoreYn === "Y" &&
        savedPath === window.location.pathname &&
        savedPosition !== null
    ) {
        window.scrollTo({
            top: parseInt(savedPosition, 10),
            behavior: "auto"
        });
    }

    sessionStorage.removeItem("pagingScrollRestore");
    sessionStorage.removeItem("pagingScrollPath");
    sessionStorage.removeItem("pagingScrollPosition");
});

/* ==============================
   맨 위로 버튼
============================== */

document.addEventListener("DOMContentLoaded", function () {

    const topBtn = document.getElementById("topBtn");

    if (!topBtn) return;

    function toggleTopBtn() {
        if (window.scrollY > 300) {
            topBtn.classList.add("show");
        } else {
            topBtn.classList.remove("show");
        }
    }

    topBtn.addEventListener("click", function () {
        window.scrollTo({
            top: 0,
            behavior: "smooth"
        });
    });

    window.addEventListener("scroll", toggleTopBtn);
    toggleTopBtn();
});


/* ==============================
   모바일 하단 사이드바
============================== */

document.addEventListener("DOMContentLoaded", function () {

    const mobileSnbBtn = document.getElementById("mobileSnbBtn");
    const mobileSnbOverlay = document.getElementById("mobileSnbOverlay");
    const mobileSnbSheet = document.getElementById("mobileSnbSheet");
    const mobileSnbClose = document.getElementById("mobileSnbClose");

    if (!mobileSnbBtn || !mobileSnbOverlay || !mobileSnbSheet || !mobileSnbClose) {
        return;
    }

    function openMobileSnb() {
        mobileSnbOverlay.classList.add("active");
        mobileSnbSheet.classList.add("active");
        document.body.classList.add("mobile-snb-open");
        mobileSnbSheet.setAttribute("aria-hidden", "false");
    }

    function closeMobileSnb() {
        mobileSnbOverlay.classList.remove("active");
        mobileSnbSheet.classList.remove("active");
        document.body.classList.remove("mobile-snb-open");
        mobileSnbSheet.setAttribute("aria-hidden", "true");
    }

    mobileSnbBtn.addEventListener("click", function (e) {
        e.stopPropagation();
        openMobileSnb();
    });

    mobileSnbClose.addEventListener("click", function (e) {
        e.stopPropagation();
        closeMobileSnb();
    });

    mobileSnbOverlay.addEventListener("click", function () {
        closeMobileSnb();
    });

    mobileSnbSheet.addEventListener("click", function (e) {
        e.stopPropagation();
    });

    document.addEventListener("keydown", function (e) {
        if (e.key === "Escape") {
            closeMobileSnb();
        }
    });

    const groupButtons = mobileSnbSheet.querySelectorAll(".mobile-snb-group-btn");

    groupButtons.forEach(function (btn) {
        btn.addEventListener("click", function () {

            const group = btn.closest(".mobile-snb-group");

            if (!group) return;

            group.classList.toggle("open");
        });
    });

    const mobileLinks = mobileSnbSheet.querySelectorAll("a[href]");

    mobileLinks.forEach(function (link) {
        link.addEventListener("click", function () {
            closeMobileSnb();
        });
    });
});

/* ==============================
   브라우저 탭 제목 자동 설정
============================== */

document.addEventListener("DOMContentLoaded", function () {

    const serviceName = "CHOP";
    const pageTitle = document.querySelector(".page-title");

    if (pageTitle && pageTitle.textContent.trim() !== "") {
        document.title = pageTitle.textContent.trim() + " | " + serviceName;
        return;
    }

    const h1Title = document.querySelector("h1");

    if (h1Title && h1Title.textContent.trim() !== "") {
        document.title = h1Title.textContent.trim() + " | " + serviceName;
        return;
    }

    document.title = serviceName;
});