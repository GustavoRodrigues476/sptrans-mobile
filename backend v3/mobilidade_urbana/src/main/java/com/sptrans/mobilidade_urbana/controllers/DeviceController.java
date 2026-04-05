package com.sptrans.mobilidade_urbana.controllers;

import java.net.URI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.sptrans.mobilidade_urbana.dto.DeviceDTO;
import com.sptrans.mobilidade_urbana.services.DeviceService;

import jakarta.validation.Valid;

@RestController
@RequestMapping(value = "/devices")
public class DeviceController {
	
	@Autowired
	private DeviceService service;
	
	@GetMapping(value = "/{deviceId}")
	public ResponseEntity<DeviceDTO> findById(@PathVariable Long deviceId){
		DeviceDTO dto = service.findById(deviceId);
		return ResponseEntity.ok(dto);
	}
	
	@GetMapping
	public ResponseEntity<Page<DeviceDTO>> findAll(Pageable pageable) {
		Page<DeviceDTO> dto = service.findAll(pageable);
		return ResponseEntity.ok(dto);
	}
	
	@PostMapping
	public ResponseEntity<DeviceDTO> insert(@Valid @RequestBody DeviceDTO dto) {
		/*dto = service.insert(dto);
		return dto;*/
		dto = service.insert(dto);
		URI uri = ServletUriComponentsBuilder.fromCurrentRequest().path("/{deviceId}")
				.buildAndExpand(dto.getDeviceId()).toUri();
		return ResponseEntity.created(uri).body(dto);
	}

}
