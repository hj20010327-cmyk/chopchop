package kr.or.chop.common.ai.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class QcAiPredictRequestDTO {

    @JsonProperty("lot_qty")
    private double lotQty;

    @JsonProperty("qc_qty")
    private double qcQty;

    @JsonProperty("item_type")
    private int itemType;

    @JsonProperty("item_qc_type")
    private int itemQcType;

    @JsonProperty("qc_type")
    private int qcType;

    @JsonProperty("work_order_qty")
    private double workOrderQty;

    @JsonProperty("qc_month")
    private int qcMonth;

    @JsonProperty("qc_weekday")
    private int qcWeekday;

    @JsonProperty("inspection_risk_score")
    private int inspectionRiskScore;

    @JsonProperty("summer_flag")
    private int summerFlag;

    @JsonProperty("winter_flag")
    private int winterFlag;
}