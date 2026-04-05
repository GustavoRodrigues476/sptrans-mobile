package com.sptrans.mobilidade_urbana.dto;

import java.time.LocalDateTime;
import java.util.UUID;

import com.sptrans.mobilidade_urbana.entities.Device;
import com.sptrans.mobilidade_urbana.entities.Platform;

import jakarta.persistence.Column;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotBlank;

public class DeviceDTO {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long deviceId;
	@Column(unique=true)
	private UUID deviceToken;
	@Enumerated(EnumType.STRING)
	private Platform platform;
	private String appVersion;
	private LocalDateTime createdAt;
	
	public DeviceDTO() {}

	public DeviceDTO(Long deviceId, UUID deviceToken, Platform platform, String appVersion, LocalDateTime createdAt) {
		super();
		this.deviceId = deviceId;
		this.deviceToken = deviceToken;
		this.platform = platform;
		this.appVersion = appVersion;
		this.createdAt = createdAt;
	}
	
	public DeviceDTO(Device entity) {
		deviceId = entity.getDeviceId();
		deviceToken = entity.getDeviceToken();
		platform = entity.getPlatform();
		appVersion = entity.getAppVersion();
		createdAt = entity.getCreatedAt();
	}

	public Long getDeviceId() {
		return deviceId;
	}

	public UUID getDeviceToken() {
		return deviceToken;
	}

	public Platform getPlatform() {
		return platform;
	}

	public String getAppVersion() {
		return appVersion;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	
	

}
