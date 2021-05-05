package com.stabbers.geofood.controller.dto.business;

import lombok.Data;

import javax.validation.constraints.NotEmpty;
import java.util.Date;

@Data
public class MovementRequest {
    @NotEmpty
    private double longitude;

    @NotEmpty
    private double latitude;

    @NotEmpty
    private String date;

}
