package com.example.universidad_ms.services;

import com.example.universidad_ms.model.Facultad;
import com.example.universidad_ms.repository.FacultadRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FacultadService {

    private final FacultadRepository facultadRepository;

    @Autowired
    public FacultadService(FacultadRepository facultadRepository) {
        this.facultadRepository = facultadRepository;
    }

    public Facultad saveFacultad(Facultad facultad){
        return facultadRepository.save(facultad);
    }

    public List<Facultad> getAllFacultades() {
        return facultadRepository.findAll();
    }
}
