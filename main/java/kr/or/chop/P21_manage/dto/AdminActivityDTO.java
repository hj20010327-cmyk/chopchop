package kr.or.chop.P21_manage.dto;

import lombok.Data;

@Data
public class AdminActivityDTO {
    private int waitCount;
    private int progressCount;
    private int doneCount;
    private int delayCount;
}