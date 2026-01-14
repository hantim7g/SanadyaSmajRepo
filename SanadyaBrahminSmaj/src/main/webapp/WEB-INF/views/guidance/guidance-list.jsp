<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>


    <%@ include file="/WEB-INF/views/includes/header.jsp" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

			<!DOCTYPE html>
			<html lang="hi">
			<head>
			    <title>मार्गदर्शन</title>
				<style>
				body {
				    background: #f5f1e8;
				    font-family: "Noto Serif Devanagari", serif;
				    color: #2b2b2b;
				}

				/* Container like book */
				.guidance-book-container {
				    max-width: 900px;
				    background: #fffdf7;
				    padding: 40px 50px;
				    box-shadow: 0 0 25px rgba(0,0,0,0.08);
				    margin-top: 40px;
				    margin-bottom: 40px;
				}

				/* Title */
				.book-title {
				    font-size: 28px;
				    font-weight: bold;
				    color: #8b3e00;
				    display: flex;
				    align-items: center;
				    margin-bottom: 40px;
				}

				.book-line {
				    width: 6px;
				    height: 34px;
				    background: #c05a00;
				    margin-right: 14px;
				}

				/* Entry */
				.book-entry {
				    margin-bottom: 60px;
				}

				/* Author */
				.author-section {
				    display: flex;
				    align-items: center;
				    margin-bottom: 18px;
				}

				.author-photo {
				    width: 90px;
				    height: 90px;
				    object-fit: cover;
				    border-radius: 50%;
				    border: 1px solid #ccc;
				    margin-right: 20px;
				}

				.author-name {
				    font-size: 20px;
				    font-weight: bold;
				}

				.author-designation {
				    font-size: 14px;
				    color: #666;
				}

				/* Content */
				.book-content {
				    font-size: 17px;
				    line-height: 2;
				    text-align: justify;
				    text-indent: 40px;
				    white-space: pre-line;
				}

				/* Admin actions minimal */
				.admin-book-actions {
				    margin-top: 15px;
				    font-size: 13px;
				    color: #777;
				}

				.admin-book-actions a {
				    color: #555;
				    text-decoration: none;
				}

				.admin-book-actions a:hover {
				    text-decoration: underline;
				}

</style>
				
				</head>

			<body>

			<div class="container guidance-book-container">

			    <!-- Title -->
			    <div class="book-title">
			        <span class="book-line"></span>
			        मार्गदर्शन
			    </div>

			    <!-- Guidance Entries -->
			    <c:forEach var="g" items="${guidanceList}">
			        <div class="book-entry">

			            <!-- Author Section -->
			            <div class="author-section">
			                <img src="${empty g.imageUrl ? '/images/default-user.png' : g.imageUrl}"
			                     class="author-photo">

			                <div class="author-info">
			                    <div class="author-name">${g.personName}</div>
			                    <div class="author-designation">${g.designation}</div>
			                </div>
			            </div>

			            <!-- Content -->
			            <div class="book-content">
			                ${g.content}
			            </div>

			            <!-- Admin controls (small & hidden feel) -->
			            <c:if test="${isAdmin}">
			                <div class="admin-book-actions">
			                    <a href="/admin/guidance/edit/${g.id}">✏️ संपादित</a> |
			                    <a href="javascript:void(0)"
			                       class="delete-btn"
			                       data-id="${g.id}">🗑️ हटाएँ</a>
			                </div>
			            </c:if>

			        </div>
			    </c:forEach>

			    <!-- Admin Add -->
			    <c:if test="${isAdmin}">
			        <div class="text-end mt-5">
			            <a href="/admin/guidance/add" class="btn btn-outline-dark">
			                + नया मार्गदर्शन जोड़ें
			            </a>
			        </div>
			    </c:if>

			</div>

			<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
			<script>
			    $(".delete-btn").click(function () {
			        let id = $(this).data("id");
			        if (confirm("क्या यह मार्गदर्शन हटाना चाहते हैं?")) {
			            $.ajax({
			                url: "/admin/guidance/delete/" + id,
			                type: "DELETE",
			                success: () => location.reload()
			            });
			        }
			    });
			</script>

			</body>
			</html>
