package com.hst.entity.BookingSys;


import jakarta.persistence.*;

@Entity
@Table(name = "room_images")
public class RoomImage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String imageUrl;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "room_id")
    private Room room;

	public synchronized Long getId() {
		return id;
	}

	public synchronized void setId(Long id) {
		this.id = id;
	}

	public synchronized String getImageUrl() {
		return imageUrl;
	}

	public synchronized void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public synchronized Room getRoom() {
		return room;
	}

	public synchronized void setRoom(Room room) {
		this.room = room;
	}

    // getters setters
}
