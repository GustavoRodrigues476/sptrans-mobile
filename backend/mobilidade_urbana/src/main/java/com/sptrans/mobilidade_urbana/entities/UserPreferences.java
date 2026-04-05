package com.sptrans.mobilidade_urbana.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "user_preferences")
public class UserPreferences {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "preference_id")
	private Long preferenceId;
	private Boolean slowPace;
	private Integer maxWalkingTime;
	@Enumerated(EnumType.STRING)
	@Column(name = "route_preference", nullable = false)
	private RoutePreference routePreference;
	private Integer notifyBeforeDeparture;
	private LocalDateTime updatedAt;
	
	@OneToOne
	@JoinColumn(name = "user_id", nullable = false, unique=true)
	private User user;
	
	public UserPreferences() {}

	public UserPreferences(Long preferenceId, Boolean slowPace, Integer maxWalkingTime, RoutePreference routePreference,
			Integer notifyBeforeDeparture, LocalDateTime updatedAt, User user) {
		super();
		this.preferenceId = preferenceId;
		this.slowPace = slowPace;
		this.maxWalkingTime = maxWalkingTime;
		this.routePreference = routePreference;
		this.notifyBeforeDeparture = notifyBeforeDeparture;
		this.updatedAt = updatedAt;
		this.user = user;
	}

	public Long getPreferenceId() {
		return preferenceId;
	}

	public void setPreferenceId(Long preferenceId) {
		this.preferenceId = preferenceId;
	}

	public Boolean getSlowPace() {
		return slowPace;
	}

	public void setSlowPace(Boolean slowPace) {
		this.slowPace = slowPace;
	}

	public Integer getMaxWalkingTime() {
		return maxWalkingTime;
	}

	public void setMaxWalkingTime(Integer maxWalkingTime) {
		this.maxWalkingTime = maxWalkingTime;
	}

	public RoutePreference getRoutePreference() {
		return routePreference;
	}

	public void setRoutePreference(RoutePreference routePreference) {
		this.routePreference = routePreference;
	}

	public Integer getNotifyBeforeDeparture() {
		return notifyBeforeDeparture;
	}

	public void setNotifyBeforeDeparture(Integer notifyBeforeDeparture) {
		this.notifyBeforeDeparture = notifyBeforeDeparture;
	}

	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public int hashCode() {
		return Objects.hash(preferenceId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UserPreferences other = (UserPreferences) obj;
		return Objects.equals(preferenceId, other.preferenceId);
	}

}
