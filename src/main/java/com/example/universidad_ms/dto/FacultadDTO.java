package com.example.universidad_ms.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class FacultadDTO {
    private Integer id;
    private String faculNombre;
    private String decano;

    @JsonProperty("NumeroEstuiantes")
    private Integer numeroEstuiantes;
}
