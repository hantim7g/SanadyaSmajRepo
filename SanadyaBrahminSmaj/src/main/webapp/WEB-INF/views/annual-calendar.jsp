<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="hi">
<head>
    <meta charset="UTF-8">
    <title>वार्षिक कैलेंडर</title>

    
    <style>
        body {
            font-family: 'Noto Sans Devanagari', sans-serif;
            background: #fff8ef;
        }

        .page-header {
            background: #ffb300;
            padding: 14px 20px;
            border-radius: 8px;
            font-weight: 700;
            box-shadow: 0 4px 12px rgba(0,0,0,.15);
        }

        .calendar-box {
            background: #fff;
            border-radius: 14px;
            padding: 18px;
            box-shadow: 0 6px 18px rgba(0,0,0,.08);
            transition: .3s;
        }

        .calendar-box:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 24px rgba(255,179,0,.35);
        }

        .calendar-month {
            font-weight: 700;
            font-size: 1.1rem;
            color: #c04b00;
        }

        .calendar-events {
            font-size: .95rem;
            white-space: pre-line;
        }

        .admin-actions a {
            text-decoration: none;
            margin-left: 8px;
            font-size: .85rem;
        }
    </style>
</head>

<body>

<div class="container my-4">

    <!-- Header -->
    <div class="page-header mb-3">📅 वार्षिक कैलेंडर</div>

    <!-- Admin Button -->
    <c:if test="${isAdmin}">
        <div class="text-end mb-3">
            <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#calendarModal">
                + नया कैलेंडर जोड़ें
            </button>
        </div>
    </c:if>

    <!-- Calendar Rows -->
    <div class="row g-3">
        <c:forEach items="${calendarList}" var="c">
            <div class="col-12">
                <div class="calendar-box d-flex justify-content-between align-items-start">

                    <div>
                        <div class="calendar-month">
                            📅 ${c.eventDate}
                        </div>
                        <div class="calendar-events mt-1">
                            ${c.description}
                        </div>
                    </div>

                    <c:if test="${isAdmin}">
                        <div class="admin-actions text-end">
                            <a href="javascript:void(0)" class="edit-btn text-primary"
                               data-id="${c.id}"
                               data-date="${c.rawDate}"
                               data-desc="${c.description}">✏️</a>

                            <a href="javascript:void(0)" class="delete-btn text-danger"
                               data-id="${c.id}">🗑️</a>
                        </div>
                    </c:if>

                </div>
            </div>
        </c:forEach>
    </div>

</div>

<!-- Modal -->
<div class="modal fade" id="calendarModal" tabindex="-1">
    <div class="modal-dialog">
        <form class="modal-content" id="calendarForm">
            <div class="modal-header">
                <h5 class="modal-title">वार्षिक कैलेंडर</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <input type="hidden" id="id">

                <div class="mb-3">
                    <label class="form-label">तिथि</label>
                    <input type="date" class="form-control" id="eventDate" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">विवरण</label>
                    <textarea class="form-control" id="description" rows="4" required></textarea>
                </div>
            </div>

            <div class="modal-footer">
                <button type="submit" class="btn btn-success">सहेजें</button>
            </div>
        </form>
    </div>
</div>


<script>
    $(".edit-btn").click(function () {
        $("#id").val($(this).data("id"));
        $("#eventDate").val($(this).data("date"));
        $("#description").val($(this).data("desc"));
        $("#calendarModal").modal("show");
    });

    $(".delete-btn").click(function () {
        let id = $(this).data("id");

        bootbox.confirm({
            title: "पुष्टि करें",
            message: "क्या आप यह प्रविष्टि हटाना चाहते हैं?",
            centerVertical: true,
            buttons: {
                confirm: { label: "हाँ, हटाएँ", className: "btn-danger" },
                cancel: { label: "नहीं", className: "btn-secondary" }
            },
            callback: function (result) {
                if (result) {
                    $.ajax({
                        url: "/admin/calendar/delete/" + id,
                        type: "DELETE",
                        success: function () {
                            bootbox.alert({
                                message: "✔ सफलतापूर्वक हटाया गया",
                                centerVertical: true,
                                callback: function () {
                                    location.reload();
                                }
                            });
                        }
                    });
                }
            }
        });
    });

    $("#calendarForm").submit(function (e) {
        e.preventDefault();

        $.post("/admin/calendar/save", {
            id: $("#id").val(),
            eventDate: $("#eventDate").val(),
            description: $("#description").val()
        }, function () {
            bootbox.alert({
                message: "✔ विवरण सफलतापूर्वक सहेजा गया",
                centerVertical: true,
                callback: function () {
                    location.reload();
                }
            });
        });
    });
</script>

</body>
</html>
