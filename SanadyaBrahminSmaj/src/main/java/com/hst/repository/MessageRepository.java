package com.hst.repository;


import org.springframework.data.jpa.repository.JpaRepository;

import com.hst.entity.Message;

public interface MessageRepository extends JpaRepository<Message, Long> {
}
