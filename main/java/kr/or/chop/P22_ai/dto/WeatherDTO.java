package kr.or.chop.P22_ai.dto;

import lombok.Data;

@Data
public class WeatherDTO {

    private double temp;
    private int humidity;
    private String weatherMain;
}