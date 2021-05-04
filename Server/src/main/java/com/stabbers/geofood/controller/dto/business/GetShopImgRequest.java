package com.stabbers.geofood.controller.dto.business;

import lombok.Data;

import javax.validation.constraints.NotEmpty;

@Data
public class GetShopImgRequest {

    @NotEmpty
    int shopId;
}
