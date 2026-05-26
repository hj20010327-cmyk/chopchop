// 알림
document.addEventListener("DOMContentLoaded", function () {
    const alarmBtn = document.getElementById("alarmBtn");
    const alarmPanel = document.getElementById("alarmPanel");

    if (!alarmBtn || !alarmPanel) return;

    alarmBtn.addEventListener("click", function (e) {
        e.stopPropagation();
        alarmPanel.classList.toggle("active");
    });

    alarmPanel.addEventListener("click", function (e) {
        e.stopPropagation();
    });

    document.addEventListener("click", function () {
        alarmPanel.classList.remove("active");
    });

    const closeButtons = alarmPanel.querySelectorAll(".alarm-close");

    closeButtons.forEach(function (btn) {
        btn.addEventListener("click", function () {
            btn.closest(".alarm-item").remove();
        });
    });
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

        if (currentPath === linkPath || currentPath.startsWith(rootPath + "/")) {
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

	overlay.style.display = "flex";
	document.body.classList.add("modal-open");
}

function closeModal(overlay) {
	if (!overlay) return;

	overlay.style.display = "none";

	// 열려 있는 overlay가 더 없을 때만 body 스크롤 해제
	const openedOverlay = document.querySelector(".overlay[style*='display: flex'], .overlay[style*='display: block']");

	if (!openedOverlay) {
		document.body.classList.remove("modal-open");
	}
}