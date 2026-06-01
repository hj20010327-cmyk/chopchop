package kr.or.chop.common.ai.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class WorkAiPredictRequestDTO {

    @JsonProperty("work_order_qty")
    private double workOrderQty;

    @JsonProperty("work_prev_qty")
    private double workPrevQty;

    @JsonProperty("work_status")
    private int workStatus;

    @JsonProperty("plan_fin_qty")
    private double planFinQty;

    @JsonProperty("plan_wp_qty")
    private double planWpQty;

    @JsonProperty("item_type")
    private int itemType;

    @JsonProperty("work_month")
    private int workMonth;

    @JsonProperty("work_weekday")
    private int workWeekday;

    @JsonProperty("summer_flag")
    private int summerFlag;

    @JsonProperty("winter_flag")
    private int winterFlag;

    @JsonProperty("qty_risk_score")
    private int qtyRiskScore;

    @JsonProperty("season_risk_score")
    private int seasonRiskScore;
}