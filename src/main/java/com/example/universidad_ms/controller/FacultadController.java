package com.example.universidad_ms.controller;

import com.example.universidad_ms.model.Facultad;
import com.example.universidad_ms.services.FacultadService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@RestController
@RequestMapping("/Facultades")
public class FacultadController {

    private final FacultadService facultadService;
    private final RestTemplate restTemplate;

    private static final String COCINERO_URL =
            "https://app-restaurante-e5gtdyb8d0fhc0c7.francecentral-01.azurewebsites.net/cocinero";

    @Autowired
    public FacultadController(FacultadService facultadService, RestTemplate restTemplate) {
        this.facultadService = facultadService;
        this.restTemplate = restTemplate;
    }

    @PostMapping
    public Facultad agregarfacultad(@RequestBody Facultad facultad){
        return facultadService.saveFacultad(facultad);
    }

    @PostMapping("/procesar")
    public ResponseEntity<?> procesar(@RequestBody ObjectNode payload) {
        if (payload == null || !payload.hasNonNull("facultad")) {
            return ResponseEntity.badRequest().body("El JSON debe incluir el objeto 'facultad'.");
        }

        JsonNode facultadNode = payload.get("facultad");
        if (facultadNode == null || !facultadNode.isObject()) {
            return ResponseEntity.badRequest().body("'facultad' debe ser un objeto JSON.");
        }

        String faculNombre = facultadNode.path("faculNombre").asText(null);
        String decano = facultadNode.path("decano").asText(null);
        Integer numeroEstuiantes = facultadNode.has("NumeroEstuiantes") && !facultadNode.get("NumeroEstuiantes").isNull()
                ? facultadNode.get("NumeroEstuiantes").asInt()
                : null;

        if (faculNombre == null || faculNombre.isBlank()) {
            return ResponseEntity.badRequest().body("facultad.faculNombre es obligatorio.");
        }

        Facultad entidad = new Facultad(null, faculNombre, decano, numeroEstuiantes);
        Facultad guardada = facultadService.saveFacultad(entidad);

        ((ObjectNode) facultadNode).put("id", guardada.getId());
        payload.set("facultad", facultadNode); // deja intactos 'proyecto' y 'cocinero'

        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            HttpEntity<ObjectNode> request = new HttpEntity<>(payload, headers);

            ResponseEntity<String> resp = restTemplate.postForEntity(COCINERO_URL, request, String.class);

            return ResponseEntity.status(resp.getStatusCode())
                    .headers(resp.getHeaders())
                    .body(resp.getBody());
        } catch (RestClientException ex) {
            return ResponseEntity.status(HttpStatus.BAD_GATEWAY)
                    .body("Error al consumir el endpoint de cocinero: " + ex.getMessage());
        }
    }

    @GetMapping
    public ResponseEntity<List<Facultad>> getAlls() {
        List<Facultad> facultades = facultadService.getAllFacultades();
        return ResponseEntity.ok(facultades);
    }
}
