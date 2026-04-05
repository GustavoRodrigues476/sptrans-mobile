package com.sptrans.mobilidade_urbana.entities;

import java.time.LocalDateTime;
import java.util.Objects;
import java.util.UUID;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;

@Entity
@Table(name="devices")
public class Device {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long deviceId;
	@Column(unique=true)
	private UUID deviceToken;
	@Enumerated(EnumType.STRING)
	private Platform platform;
	private String appVersion;
	private LocalDateTime createdAt;
	
	@OneToOne(mappedBy="device")
	private User user;
	
	public Device() {}

	public Device(Long deviceId, UUID deviceToken, Platform platform, String appVersion, LocalDateTime createdAt) {
		super();
		this.deviceId = deviceId;
		this.deviceToken = deviceToken;
		this.platform = platform;
		this.appVersion = appVersion;
		this.createdAt = createdAt;
	}
	
	@PrePersist
    public void prePersist() {
        this.createdAt = LocalDateTime.now();
    }

	public Long getDeviceId() {
		return deviceId;
	}

	public void setDeviceId(Long deviceId) {
		this.deviceId = deviceId;
	}

	public UUID getDeviceToken() {
		return deviceToken;
	}

	public void setDeviceToken(UUID deviceToken) {
		this.deviceToken = deviceToken;
	}

	public Platform getPlatform() {
		return platform;
	}

	public void setPlatform(Platform platform) {
		this.platform = platform;
	}

	public String getAppVersion() {
		return appVersion;
	}

	public void setAppVersion(String appVersion) {
		this.appVersion = appVersion;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	@Override
	public int hashCode() {
		return Objects.hash(deviceId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Device other = (Device) obj;
		return Objects.equals(deviceId, other.deviceId);
	}
	
}
