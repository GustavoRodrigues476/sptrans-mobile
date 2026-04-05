package com.sptrans.mobilidade_urbana.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import com.sptrans.mobilidade_urbana.dto.DeviceDTO;
import com.sptrans.mobilidade_urbana.entities.Device;
import com.sptrans.mobilidade_urbana.repositories.DeviceRepository;

@Service
public class DeviceService {
	
	@Autowired
	private DeviceRepository repository;
	
	@Transactional(readOnly = true)
	public DeviceDTO findById(Long deviceId) {
		Optional<Device> result = repository.findById(deviceId);
		Device device = result.get();
		DeviceDTO dto = new DeviceDTO(device);
		return dto;
	}
	
	@Transactional(readOnly = true)
	public Page<DeviceDTO> findAll(Pageable pageable) {
		Page<Device> result = repository.findAll(pageable);
		return result.map(x -> new DeviceDTO(x));
	}
	
	@Transactional
	public DeviceDTO insert(DeviceDTO dto) {
		Device entity = new Device();
		copyDtoToEntity(dto, entity);
		entity = repository.save(entity);
		return new DeviceDTO(entity);
	}

	private void copyDtoToEntity(DeviceDTO dto, Device entity) {
		entity.setDeviceId(dto.getDeviceId());
		entity.setDeviceToken(dto.getDeviceToken());
		entity.setPlatform(dto.getPlatform());
		entity.setAppVersion(dto.getAppVersion());
		entity.setCreatedAt(dto.getCreatedAt());
		
	}

}
