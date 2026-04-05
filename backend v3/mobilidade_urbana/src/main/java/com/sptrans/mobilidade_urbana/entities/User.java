package com.sptrans.mobilidade_urbana.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name="users")
public class User {
	@Id
	@Column(length = 50)
	private String userId;
	private LocalDateTime createdAt;
	
	@OneToOne(mappedBy="user", cascade=CascadeType.ALL)
	private UserPreferences userPreferences;
	
	@OneToOne
	@JoinColumn(name = "device_id", nullable = false, unique = true)
	private Device device;
	
	
	public User() {}

	public User(String userId, LocalDateTime createdAt, Integer deviceId, Device device) {
		super();
		this.userId = userId;
		this.createdAt = createdAt;
		this.device = device;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public Device getDevice() {
		return device;
	}

	public void setDevice(Device device) {
		this.device = device;
	}

	@Override
	public int hashCode() {
		return Objects.hash(userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		return Objects.equals(userId, other.userId);
	}
	

}
