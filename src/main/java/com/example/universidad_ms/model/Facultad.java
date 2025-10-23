package com.example.universidad_ms.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name="Facultad")
public class Facultad {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String faculNombre;
    private String decano;
    private Integer NumeroEstuiantes;

    public Facultad(Object o, String faculNombre, String decano, Integer numeroEstuiantes) {}

    public Integer getId() {
        return this.id;
    }
}
