<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Booking - Sanadyabrahmin Smaj</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .room-card {
            display: inline-block; margin: 8px; padding: 15px 18px; background: #f8fafb;
            border-radius: 6px; border: 1px solid #dee2e6;
            min-width: 80px; text-align: center; font-size: 18px; line-height: 22px;
        }
        .room-card.booked { 
            background: #ede9e9; color: #b94a48; font-weight: 600; border-color:#b94a48;
        }
        .room-card.hall { background: #e3f2fd;}
        .room-card.available { background: #e6ffed; border-color: #198754; color: #198754;}
        .option-radio { margin-right: 8px;}
    </style>
</head>
<body>
<div class="container mt-4">

    <h2 class="mb-4">🕉️ Room & Hall Booking - Sanadyabrahmin Smaj</h2>

    <!-- Show booking result (passed as model attribute 'message') -->
    <c:if test="${not empty message}">
        <div class="alert alert-info">${message}</div>
    </c:if>

    <!-- Booking form -->
    <form id="bookingForm" action="/book" method="post" class="card p-4 mb-4 shadow-sm">
        <div class="mb-3">
            <label for="bookingDate" class="form-label">Date</label>
            <input type="date" name="date" required min="${date}" value="${date}" id="bookingDate" class="form-control" />
        </div>
        <div class="mb-3">
            <label for="buildingSelect" class="form-label">Building</label>
            <select name="buildingId" required id="buildingSelect" class="form-select">
                <c:forEach var="b" items="${buildings}">
                    <option value="${b.id}">${b.name}</option>
                </c:forEach>
            </select>
        </div>

        <!-- Here we'll inject dynamic availability/booking options (using AJAX) -->
        <div id="bookingOptions"></div>

        <div class="mb-3">
            <label for="bookedBy" class="form-label">Your Full Name</label>
            <input type="text" name="bookedBy" required id="bookedBy" class="form-control" />
        </div>
        <div class="mb-3">
            <label for="specialRequest" class="form-label">Special Request (Optional)</label>
            <input type="text" name="specialRequest" id="specialRequest" class="form-control" />
        </div>
        <button type="submit" id="bookBtn" class="btn btn-primary px-5">Book</button>
    </form>

    <div>
        <h5>Legend:</h5>
        <span class="badge bg-success">Available</span> &nbsp;
        <span class="badge bg-danger">Booked</span> &nbsp;
        <span class="badge bg-info text-dark">Hall</span>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
    // Global cache for all rooms
    let ROOMS_ALL = [
      <c:forEach items="${rooms}" var="room" varStatus="s">
         {
            id: ${room.id},
            buildingId: ${room.building.id},
            roomNumber: ${room.roomNumber},
            type: "${room.type}"
         }<c:if test="${!s.last}">,</c:if>
      </c:forEach>
    ];

    // Render booking options dynamically
    function renderBookingOptions(availData) {
        let buildingId = $("#buildingSelect").val();
        let date = $("#bookingDate").val();
        let rooms = ROOMS_ALL.filter(r => r.buildingId == buildingId);
        let opts = '';

        if(availData.buildingBooked) {
            opts += '<div class="mb-3 alert alert-warning"><b>⚠️ Entire building is already booked for this date.</b></div>';
            opts += '<div class="mb-1">Room & hall bookings only possible for other dates/buildings.</div>';
            opts += '<input type="hidden" name="status" value="" />'
        }
        else {
            // List rooms and show "Booked"/"Available"
            opts += '<div class="mb-3">';
            opts += '<label class="form-label">Select to book:</label><br/>';

            // If no rooms/halls booked, allow building OR any room/hall booking
            if(!availData.roomsBooked) {
                // Entire building option
                opts += `<input class="form-check-input option-radio" type="radio" name="status" value="building" id="optBuilding" checked>
                        <label class="form-check-label me-3" for="optBuilding"><b>Entire Building</b></label><br/>`;
            }

            // Individual rooms/halls
            if(rooms.length > 0) {
                opts += '<div class="d-flex flex-wrap">';
                rooms.forEach(r => {
                    let booked = availData.bookedRooms && availData.bookedRooms.includes(r.id);
                    let isHall = r.type === 'hall';
                    let radioDisabled = availData.buildingBooked || booked || (!!availData.roomsBooked && !isHall && !availData.roomAvailableIds.includes(r.id));
                    let badge = (booked)
                        ? '<span class="badge bg-danger">Booked</span>' 
                        : (isHall ? '<span class="badge bg-info text-dark">Hall</span>' : '<span class="badge bg-success">Available</span>');
                    opts += `<div class="room-card${booked?' booked':''}${isHall?' hall':''}${(!booked && !availData.buildingBooked)?' available':''}">
                            <input class="form-check-input option-radio" type="radio" name="status" value="room-${r.id}" id="room${r.id}"
                                ${booked || availData.buildingBooked?'disabled':''}
                                ${(!availData.roomsBooked && !availData.buildingBooked)?'':'checked'}>
                            <label for="room${r.id}">`;
                    opts += isHall ? `<b>Hall ${r.roomNumber}</b>` : `Room ${r.roomNumber}`;
                    opts += `</label> ${badge}</div>`;
                });
                opts += '</div>';
            }
            opts += '</div>';
        }
        $("#bookingOptions").html(opts);
    }

    // Fetch availability for current selection
    function loadAvailability() {
        let buildingId = $("#buildingSelect").val();
        let date = $("#bookingDate").val();
        if(!buildingId || !date) return;
        $.get("/api/availability", { buildingId: buildingId, date: date }, function(resp){
            // Augment response with info for rendering
            if(!resp.bookedRooms) resp.bookedRooms = [];
            if(!resp.roomAvailableIds) resp.roomAvailableIds = [];
            renderBookingOptions(resp);
        });
    }

    $(document).ready(function() {
        $("#buildingSelect, #bookingDate").on("change", loadAvailability);
        loadAvailability();

        // Form submit: Map which radio is picked to the API fields
        $("#bookingForm").on("submit", function(ev){
            // Determine which radio
            let picked = $("input[name='status']:checked").val();
            if(!picked) {
                alert('Please select an option to book.');
                ev.preventDefault();
                return;
            }
            if(picked === 'building') {
                $('#bookingForm').append('<input type="hidden" name="status" value="building"/>');
                $('input[name="roomId"]').remove();
            } else if (picked.startsWith('room-')) {
                $('#bookingForm').append('<input type="hidden" name="status" value="room"/>');
                let roomId = picked.substring(5);
                $('#bookingForm').append('<input type="hidden" name="roomId" value="'+roomId+'"/>');
            }
        });
    });
</script>

</body>
</html>
