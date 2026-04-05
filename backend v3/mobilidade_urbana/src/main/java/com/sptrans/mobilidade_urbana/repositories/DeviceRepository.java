package com.sptrans.mobilidade_urbana.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sptrans.mobilidade_urbana.entities.Device;

public interface DeviceRepository extends JpaRepository<Device, Long> {
}
