<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
        <%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
            <%@ include file="/WEB-INF/views/includes/header.jsp" %>
                <!DOCTYPE html>
                <html lang="hi">

                <head>
                    
                    <meta charset="UTF-8">
                     <title>कार्यक्रम सूची</title>
                    
                    <meta name="viewport" content="width=device-width, initial-scale=1">
                    
                    <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet" />
                    
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"> -->
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

                        .event-card {
                            max-width: 920px;
                            margin-left: auto;
                            margin-right: auto;
                            border-radius: 12px;
                            background: transparent;
                            box-shadow: 0 2px 10px rgba(246, 174, 94, .07);
                            margin-bottom: 32px;
                            border: none;
                        }

                        @media (min-width: 768px) {
                            .col-12 {
                                max-width: 920px;
                                margin-left: auto;
                                margin-right: auto;
                            }
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

                        .event-details-bottom {
                            border-radius: 0 0 12px 12px;
                            background: #fff;
                        }

                        @media (max-width:900px) {
                            .event-card .row>div {
                                margin-bottom: 1rem;
                            }

                            .carousel-item img,
                            .carousel-item .placeholder-img {
                                height: 320px;
                                max-height: 320px;
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
                        }
                    </style>
                </head>

                <body>
                     <div class="container my-4">
                          <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
                               <h2 class="heading-orange">कार्यक्रम सूची</h2>
                              </div>
                          <c:choose>
                               <c:when test="${not empty eventPage and not empty eventPage.content}">
                                    <div class="row">
                                         <c:forEach var="ev" items="${eventPage.content}">
                                              <div class="col-12">
                                                   <div class="event-card p-0">
                                                        <!-- Carousel Section -->
                                                        <div class="event-carousel-wrap mb-0">
                                                             <div id="carousel-${ev.id}" class="carousel slide"
                                                        data-bs-ride="carousel">
                                                                  <div class="carousel-inner">
                                                                      
                                                            <c:set var="hasAnyImage" value="false" />
                                                                      
                                                            <c:set var="firstImage" value="true" />
                                                                       <c:if
                                                                test="${not empty ev.mainImageUrl}">
                                                                            <div
                                                                    class="carousel-item active">
                                                                                 <img
                                                                        src="${ev.mainImageUrl}" alt="मुख्य चित्र" />
                                                                                </div>
                                                                           
                                                                <c:set var="firstImage" value="false" />
                                                                           
                                                                <c:set var="hasAnyImage" value="true" />
                                                                          
                                                            </c:if>
                                                                       <c:forEach var="img"
                                                                items="${ev.images}">
                                                                            <c:if
                                                                    test="${not empty img.url}">
                                                                                 <div
                                                                        class="carousel-item <c:if test='${firstImage}'>active</c:if>">
                                                                                      <img
                                                                            src="${img.url}"
                                                                            alt="<c:out value='${img.altText}'/>"
                                                                            title="<c:out value='${img.caption}'/>" />
                                                                                     </div>
                                                                                
                                                                    <c:set var="firstImage" value="false" />
                                                                                
                                                                    <c:set var="hasAnyImage" value="true" />
                                                                               
                                                                </c:if>
                                                                           </c:forEach>
                                                                       <c:if test="${!hasAnyImage}">
                                                                            <div
                                                                    class="carousel-item active">
                                                                                 <div
                                                                        class="placeholder-img">(कोई चित्र उपलब्ध नहीं)
                                                                    </div>
                                                                                </div>
                                                                           </c:if>
                                                                     
                                                        </div>
                                                                  <c:if
                                                            test="${(not empty ev.mainImageUrl and fn:length(ev.images) > 0) or (fn:length(ev.images) > 1)}">
                                                                       <button class="carousel-control-prev"
                                                                type="button" data-bs-target="#carousel-${ev.id}"
                                                                data-bs-slide="prev">
                                                                            <span
                                                                    class="carousel-control-prev-icon"
                                                                    aria-hidden="true"></span>
                                                                            <span
                                                                    class="visually-hidden">Previous</span>
                                                                           </button>
                                                                       <button class="carousel-control-next"
                                                                type="button" data-bs-target="#carousel-${ev.id}"
                                                                data-bs-slide="next">
                                                                            <span
                                                                    class="carousel-control-next-icon"
                                                                    aria-hidden="true"></span>
                                                                            <span
                                                                    class="visually-hidden">Next</span>
                                                                           </button>
                                                                      </c:if>
                                                                 </div>
                                                            </div>
                                                        <!-- Details Section -->
                                                        <div
                                                    class="event-details-bottom p-3 bg-white rounded-bottom">
                                                             <h4 class="card-title mb-2"
                                                        style="color: #181818;">
                                                                 
                                                        <c:out value="${ev.title}" />
                                                                
                                                    </h4>
                                                            
                                                    <c:set var="trimmedContent"          
                                                        value="${fn:length(ev.content) > 120 ? fn:substring(ev.content, 0, 120).concat('...') : ev.content}" />
                                                             <p class="small mb-1" style="color: #000000;">
                                                                 
                                                        <c:out value="${trimmedContent}" />
                                                                
                                                    </p>
                                                             <div class="mb-1">
                                                                  <span class="badge event-badge me-2"
                                                            style="color:#fff;background:#b17c45;">लेखक:
                                                                      
                                                            <c:out value="${ev.author}" />
                                                                     
                                                        </span>
                                                                  <span
                                                            class="badge event-badge-date me-2">कार्यक्रम तिथि:
                                                                      
                                                            <c:out value="${ev.eventDate}" />
                                                                     
                                                        </span>
                                                                  <span class="badge event-badge me-2"
                                                            style="color:#fff;background:#af5c10;">प्रकाशन:
                                                                      
                                                            <c:out value="${ev.publishDate}" />
                                                                     
                                                        </span>
                                                                 </div>
                                                             <div class="mb-1">
                                                                  

                                                                       <span>
																		
                                                                            <a href="/events/${ev.id}"
                                                                   
                                                                    class="text-decoration-underline small"      
                                                                           style="color:#b17c45;">कार्यक्रम
                                                                    विवरण</a>
                                                                           </span>
                                                                     
                                                                 </div>
                                                           
                                                </div>
                                                       </div>
                                                  </div>
                                             </c:forEach>
                                        </div>
                                    <!-- Pagination -->
                                    <c:if test="${eventPage.totalPages > 1}">
                                         <nav>
                                              <ul class="pagination justify-content-center my-3">
                                                   <c:forEach var="i" begin="0"
                                                end="${eventPage.totalPages - 1}">
                                                        <li
                                                    class="page-item ${i == eventPage.number ? 'active' : ''}">
                                                             <a class="page-link"          
                                                        href="?page=${i}&size=${eventPage.size}">
                                                                  ${i + 1}
                                                                 </a>
                                                            </li>
                                                       </c:forEach>
                                                  </ul>
                                             </nav>
                                        </c:if>
                                   </c:when>
                               <c:otherwise>
                                    <div class="alert alert-info text-center mt-5">कोई कार्यक्रम उपलब्ध नहीं है।
                                </div>
                                   </c:otherwise>
                              </c:choose>
                         </div>
                    
                    <!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> -->
                </body>

                </html> 			<%@ include file="/WEB-INF/views/includes/footer.jsp" %>