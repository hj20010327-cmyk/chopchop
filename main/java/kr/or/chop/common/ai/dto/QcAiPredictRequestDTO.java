package kr.or.chop.common.ai.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class QcAiPredictRequestDTO {

    @JsonProperty("qc_qty")
    private int qcQty;

    @JsonProperty("lot_qty")
    private int lotQty;

    @JsonProperty("work_prev_qty")
    private int workPrevQty;

    @JsonProperty("plan_fin_qty")
    private int planFinQty;

    @JsonProperty("plan_wp_qty")
    private int planWpQty;

    @JsonProperty("item_type")
    private String itemType;

    @JsonProperty("item_qc_type")
    private String itemQcType;

    @JsonProperty("qc_type")
    private String qcType;

    @JsonProperty("qc_month")
    private String qcMonth;

    @JsonProperty("qc_weekday")
    private String qcWeekday;
}