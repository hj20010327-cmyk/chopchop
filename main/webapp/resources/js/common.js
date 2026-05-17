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