<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
      <%@ include file="/WEB-INF/views/includes/header.jsp" %>
        <!DOCTYPE html>
        <html lang="hi">

        <head>
          <meta charset="UTF-8">
          <title>कार्यक्रमों की सूची</title>
          <meta name="viewport" content="width=device-width, initial-scale=1">
          <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
          <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
          <style>
            body {
              background: #fffaf0;
              font-family: 'Segoe UI', 'Noto Sans Devanagari', sans-serif;
            }

            .heading-orange {
              color: #b65c02;
              border-left: 6px solid #f87e03;
              padding-left: 12px;
              font-weight: bold;
            }

            .btn-main {
              background: linear-gradient(to right, #f87e03, #b65c02);
              border: none;
              color: #fff !important;
              font-weight: 600;
            }

            .btn-main:hover,
            .btn-main:focus {
              background: #ffa600;
            }

            .max-width-920 {
              max-width: 920px;
              margin-left: auto;
              margin-right: auto;
            }

            .event-card-admin {
              max-width: 920px;
              margin-left: auto;
              margin-right: auto;
              border-radius: 12px;
              background: transparent;
              box-shadow: 0 2px 10px rgba(246, 174, 94, .07);
              margin-bottom: 32px;
              border: none;
              overflow: visible;
            }

            .event-carousel-wrap {
              border-radius: 12px 12px 0 0;
              overflow: hidden;
              width: 100%;
            }

            .carousel-inner {
              border-radius: 12px 12px 0 0;
              background: #fff3e0;
            }

            .carousel-item img,
            .carousel-item .placeholder-img {
              width: 100%;
              max-height: 100%;
              object-fit: cover;
              border-radius: 12px 12px 0 0;
            }

            .placeholder-img {
              background: linear-gradient(135deg, #fbeab2, #ffe5d0 50%, #ffe2b6);
              min-height: 400px;
              display: flex;
              align-items: center;
              justify-content: center;
              color: #b28d5d;
              font-size: 1.3rem;
              font-style: italic;
              border-radius: 12px 12px 0 0;
            }

            .carousel-control-prev,
            .carousel-control-next {
              z-index: 3 !important;
              top: 30%;
              height: 40%;
            }

            .event-badge,
            .event-badge-date {
              color: #fff;
              background: #b65c02;
            }

            .event-details-box {
              background: #fff;
              border-radius: 0 0 12px 12px;
              padding: 1.1rem 1.2rem 1rem 1.2rem;
              box-shadow: 0 2px 10px rgba(246, 174, 94, .05);
              margin-top: 0;
            }

            .admin-actions .btn {
              min-width: 80px;
              margin-bottom: 4px;
            }

            /* Filter Bar Styling */
            .filter-form .form-control,
            .filter-form .form-select {
              border-radius: 8px;
              border: 1.5px solid #ecc099;
              background: #fffdfa;
              color: #57360c;
              font-size: 1.07rem;
              min-height: 2.45rem;
            }

            .filter-form .form-label {
              color: #915504;
              font-weight: 600;
            }

            .filter-form {
              background: linear-gradient(97deg, #fff7ed 75%, #fffbe9 100%);
              border-radius: 11px;
              box-shadow: 0 1px 8px 0 #facb87a6;
              padding: 18px 10px 6px 10px;
              margin-bottom: 2.3rem !important;
            }

            @media (max-width: 960px) {
              .max-width-920 {
                max-width: 99vw;
                padding-left: 4px;
                padding-right: 4px;
              }
            }

            @media (max-width:900px) {
              .event-card-admin .row>div {
                margin-bottom: 1rem;
              }

              .carousel-item img,
              .carousel-item .placeholder-img {
                height: 320px;
                max-height: 320px;
              }

              .event-details-box {
                padding: 1rem 0.6rem 0.8rem 0.6rem;
              }
            }

            @media (max-width:600px) {
              .heading-orange {
                font-size: 1.2rem;
              }

              .carousel-item img,
              .carousel-item .placeholder-img {
                height: 200px;
                max-height: 200px;
              }

              .event-details-box {
                padding: 0.7rem 0.25rem 0.45rem 0.25rem;
              }
            }
          </style>
          <script>
            function confirmDelete(eventId) {
              if (confirm("क्या आप वाकई इस कार्यक्रम को हटाना चाहते हैं? (This cannot be undone)"))
                window.location.href = '/admin/event-delete?id=' + eventId;
            }
          </script>
        </head>

        <body>
          <div class="container my-4">
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
              <h2 class="heading-orange">कार्यक्रमों की सूची (प्रशासन)</h2>
              <a class="btn btn-main" href="/admin/event-form"><i class="bi bi-plus-lg"></i> नया कार्यक्रम जोड़ें</a>
            </div>
            <!-- Filter Bar -->
            <form method="get" action="/admin/events" class="row mb-3 g-2 align-items-end filter-form">
              <div class="col-md-2">
                <label for="search" class="form-label mb-0">शीर्षक/विवरण खोजें</label>
                <input type="text" id="search" name="search" class="form-control" value="${search}"
                  placeholder="Search..." />
              </div>
              <div class="col-md-2">
                <label for="author" class="form-label mb-0">लेखक</label>
                <input type="text" id="author" name="author" class="form-control" value="${author}"
                  placeholder="Author" />
              </div>
              <div class="col-md-2">
                <label for="publishDate" class="form-label mb-0">सटीक प्रकाशन तिथि</label>
                <input type="date" id="publishDate" name="publishDate" class="form-control" value="${publishDate}" />
              </div>
              <div class="col-md-2">
                <label for="publishDateStart" class="form-label mb-0">प्रकाशन तिथि से</label>
                <input type="date" id="publishDateStart" name="publishDateStart" class="form-control"
                  value="${publishDateStart}" />
              </div>
              <div class="col-md-2">
                <label for="publishDateEnd" class="form-label mb-0">प्रकाशन तिथि तक</label>
                <input type="date" id="publishDateEnd" name="publishDateEnd" class="form-control"
                  value="${publishDateEnd}" />
              </div>
              <div class="col-md-1">
                <label for="isCorosal" class="form-label mb-0">होमपेज पर है?</label>
                <select class="form-select" id="isCorosal" name="isCorosal">
                  <option value="" <c:if test="${empty isCorosal}">selected</c:if>>सभी</option>
                  <option value="true" <c:if test="${isCorosal == 'true'}">selected</c:if>>सिर्फ होमपेज</option>
                  <option value="false" <c:if test="${isCorosal == 'false'}">selected</c:if>>होमपेज नहीं</option>
                </select>
              </div>
              <div class="col-md-1">
                <label for="eventStatus" class="form-label mb-0">स्थिति</label>
                <select class="form-select" id="eventStatus" name="eventStatus">
                  <option value="" <c:if test="${empty eventStatus}">selected</c:if>>सभी</option>
                  <option value="true" <c:if test="${eventStatus == 'true'}">selected</c:if>>दिखाएँ (Active)</option>
                  <option value="false" <c:if test="${eventStatus == 'false'}">selected</c:if>>छुपाएँ (Inactive)
                  </option>
                </select>
              </div>
              <div class="col-12 d-flex justify-content-end mt-2">
                <button class="btn btn-main" type="submit">फिल्टर</button>
              </div>
            </form>
            <!-- Event Cards -->
            <c:choose>
              <c:when test="${not empty eventPage and not empty eventPage.content}">
                <div class="row ">
                  <c:forEach var="ev" items="${eventPage.content}">
                    <div class="col-12">
                      <div class="card event-card-admin p-0 ">
                        <!-- Carousel section -->
                        <div class="event-carousel-wrap mb-0">
                          <div id="carousel-${ev.id}" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                              <c:set var="hasAnyImage" value="false" />
                              <c:set var="firstImage" value="true" />
                              <c:if test="${not empty ev.mainImageUrl}">
                                <div class="carousel-item active">
                                  <img src="${ev.mainImageUrl}" alt="मुख्य चित्र" />
                                </div>
                                <c:set var="firstImage" value="false" />
                                <c:set var="hasAnyImage" value="true" />
                              </c:if>
                              <c:forEach var="img" items="${ev.images}">
                                <c:if test="${not empty img.url}">
                                  <div class="carousel-item <c:if test='${firstImage}'>active</c:if>">
                                    <img src="${img.url}" alt="<c:out value='${img.altText}'/>"
                                      title="<c:out value='${img.caption}'/>" />
                                  </div>
                                  <c:set var="firstImage" value="false" />
                                  <c:set var="hasAnyImage" value="true" />
                                </c:if>
                              </c:forEach>
                              <c:if test="${!hasAnyImage}">
                                <div class="carousel-item active">
                                  <div class="placeholder-img">(कोई चित्र उपलब्ध नहीं)</div>
                                </div>
                              </c:if>
                            </div>
                            <c:if
                              test="${(not empty ev.mainImageUrl and fn:length(ev.images) > 0) or (fn:length(ev.images) > 1)}">
                              <button class="carousel-control-prev" type="button" data-bs-target="#carousel-${ev.id}"
                                data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                              </button>
                              <button class="carousel-control-next" type="button" data-bs-target="#carousel-${ev.id}"
                                data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                              </button>
                            </c:if>
                          </div>
                        </div>
                        <!-- Details section (always below carousel, not overlay) -->
                        <div class="event-details-box">
                          <h4 class="card-title mb-2" style="color: #181818;">
                            <c:out value="${ev.title}" />
                          </h4>
                          <c:set var="trimmedContent"
                            value="${fn:length(ev.content) > 120 ? fn:substring(ev.content, 0, 120).concat('...') : ev.content}" />
                          <p class="small mb-1" style="color: #000000;">
                            <c:out value="${trimmedContent}" />
                          </p>
                          <div class="mb-1">
                            <span class="badge event-badge me-2" style="color:#fff;background:#b17c45;">लेखक:
                              <c:out value="${ev.author}" />
                            </span>
                            <span class="badge event-badge-date me-2">कार्यक्रम तिथि:
                              <c:out value="${ev.eventDate}" />
                            </span>
                            <span class="badge event-badge me-2" style="color:#fff;background:#af5c10;">प्रकाशन:
                              <c:out value="${ev.publishDate}" />
                            </span>
                          </div>
                          <div class="mb-1">
                            <i class="bi bi-calendar-week text-warning"></i>
                            <span class="me-2">शुरू:
                              <c:out value="${ev.startDate}" />
                            </span>
                            <span class="me-2">पूर्ण:
                              <c:out value="${ev.endDate}" />
                            </span>
                            <c:if test="${not empty ev.eventUrl}">
                              <span>
                                <a href="${ev.eventUrl}" target="_blank" class="text-decoration-underline small"
                                  style="color:#b17c45;">कार्यक्रम विवरण</a>
                              </span>
                            </c:if>
                          </div>
                          <div class="d-flex justify-content-end flex-wrap gap-2 admin-actions mt-2">
                            <form method="post" action="/admin/event-toggle-status" style="display:inline;">
                              <input type="hidden" name="id" value="${ev.id}">
                              <button type="submit"
                                class="btn ${ev.eventStatus ? 'btn-success' : 'btn-danger'} fw-bold btn-sm"
                                title="${ev.eventStatus ? 'Hide on Site' : 'Show on Site'}"
                                onclick="return confirm('क्या आप इस कार्यक्रम की स्थिति बदलना चाहते हैं?');">
                                ${ev.eventStatus ? 'कार्यक्रम दिखाएँ' : 'कार्यक्रम छुपाएँ'}
                              </button>
                            </form>
                            <form method="post" action="/admin/event-toggle-corosal" style="display:inline;">
                              <input type="hidden" name="id" value="${ev.id}">
                              <button type="submit"
                                class="btn ${ev.corosal ? 'btn-success' : 'btn-danger'} fw-bold btn-sm"
                                title="${ev.corosal ? 'स्लाइडर में दिखाएँ' : 'स्लाइडर से छुपाएँ'}"
                                onclick="return confirm('क्या आप इसे होमपेज स्लाइडर की स्थिति बदलना चाहते हैं?');">
                                ${ev.corosal ? 'होमपेज पर दिखाएँ' : 'होमपेज से छुपाएँ'}
                              </button>
                            </form>
                            <a href="/admin/event-form?id=${ev.id}" class="btn btn-outline-danger fw-bold btn-sm">
                              <i class="bi bi-pencil-square"></i> संपादन
                            </a>
                            <a href="javascript:void(0);" onclick="confirmDelete('${ev.id}');"
                              class="btn btn-danger fw-bold btn-sm">
                              <i class="bi bi-trash"></i> हटाएँ
                            </a>
                          </div>
                        </div>
                        <!-- End Details -->
                      </div>
                    </div>
                  </c:forEach>
                </div>
                <c:if test="${eventPage.totalPages > 1}">
                  <nav>
                    <ul class="pagination justify-content-center my-3">
                      <c:forEach var="i" begin="0" end="${eventPage.totalPages - 1}">
                        <li class="page-item ${i == eventPage.number ? 'active' : ''}">
                          <a class="page-link" href="?page=${i}&size=${eventPage.size
                    }<c:if test='${not empty search}'>&search=${search}</c:if
                    ><c:if test='${not empty author}'>&author=${author}</c:if
                    ><c:if test='${not empty publishDate}'>&publishDate=${publishDate}</c:if
                    ><c:if test='${not empty publishDateStart}'>&publishDateStart=${publishDateStart}</c:if
                    ><c:if test='${not empty publishDateEnd}'>&publishDateEnd=${publishDateEnd}</c:if
                    ><c:if test='${not empty isCorosal}'>&isCorosal=${isCorosal}</c:if
                    ><c:if test='${not empty eventStatus}'>&eventStatus=${eventStatus}</c:if>">
                            ${i + 1}
                          </a>
                        </li>
                      </c:forEach>
                    </ul>
                  </nav>
                </c:if>
              </c:when>
              <c:otherwise>
                <div class="alert alert-info text-center mt-5">कोई कार्यक्रम उपलब्ध नहीं है।</div>
              </c:otherwise>
            </c:choose>
          </div>
          <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>