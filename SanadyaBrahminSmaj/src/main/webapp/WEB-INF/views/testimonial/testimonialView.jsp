<%@ include file="/WEB-INF/views/includes/header.jsp" %>
  <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

        <!DOCTYPE html>
        <html lang="hi">

        <head>
          <meta charset="UTF-8">
          <title>सदस्यों के प्रशंसापत्र</title>
          <style>
            :root {
              --brand-1: #f87e03;
              --brand-2: #b65c02;
              --ink: #2b2b2b;
              --muted: #6a6a6a;
              --bg: #fffaf4;
              --card: #fff7ec;
              --accent: #ffdcc2;
              --divider: #f0d9b7;
              --link: #d46509;
              --approve: #1e7a2e;
            }

            body {
              background: var(--bg);
              font-family: 'Segoe UI', 'Noto Sans Devanagari', sans-serif;
              color: var(--ink);
            }

            .wrap {
              max-width: 1100px;
              margin: 28px auto;
              padding: 0 16px;
            }

            .page-head {
              background: linear-gradient(135deg, var(--brand-1) 0%, var(--brand-2) 100%);
              color: #fff;
              border-radius: 14px;
              padding: 18px 20px;
              margin-bottom: 18px;
              box-shadow: 0 6px 18px rgba(0, 0, 0, .12);
              display: flex;
              align-items: center;
              justify-content: space-between;
              gap: 12px;
              flex-wrap: wrap;
            }

            .page-head h2 {
              margin: 0;
              font-weight: 800;
              letter-spacing: .2px;
            }

            .count {
              opacity: .95;
              font-weight: 600;
            }

            /* optional search + page size */
            .toolbar {
              background: #fff;
              border-radius: 12px;
              padding: 10px 12px;
              margin-bottom: 14px;
              box-shadow: 0 3px 12px rgba(0, 0, 0, .06);
              display: flex;
              gap: 10px;
              flex-wrap: wrap;
              align-items: center;
            }

            .toolbar input,
            .toolbar select {
              border: 1px solid var(--divider);
              border-radius: 10px;
              padding: 8px 10px;
              outline: none;
              background: #fffdf8;
            }

            .toolbar .btn {
              background: var(--brand-1);
              color: #fff;
              border: none;
              padding: 8px 14px;
              border-radius: 10px;
              font-weight: 700;
              cursor: pointer;
            }

            .toolbar .btn:hover {
              background: #e06f00;
            }

            /* testimonial row (like screenshot) */
            .tcard {
              background: #fff;
              border-radius: 14px;
              padding: 18px;
              margin: 0 0 14px 0;
              box-shadow: 0 6px 18px rgba(0, 0, 0, .06);
              border-left: 6px solid var(--brand-1);
            }

            .trow {
              display: grid;
              grid-template-columns: 120px 1fr;
              gap: 18px;
            }

            .avatar {
              width: 96px;
              height: 96px;
              border-radius: 50%;
              object-fit: cover;
              border: 3px solid #fff;
              box-shadow: 0 1px 8px rgba(0, 0, 0, .08);
              background: #ffe8cf;
              display: flex;
              align-items: center;
              justify-content: center;
              font-weight: 800;
              color: #7a3d00;
              font-size: 28px;
            }

            .header {
              display: flex;
              flex-direction: column;
              gap: 4px;
              margin-bottom: 8px;
            }

            .name {
              font-weight: 800;
              font-size: 1.1rem;
              color: #2c220f;
            }

            .role {
              color: #e0702f;
              font-weight: 700;
              font-size: .95rem;
            }

            .msg {
              color: #2c2c2c;
              line-height: 1.7;
              background: #fff7ef;
              border-left: 3px solid var(--accent);
              padding: 12px;
              border-radius: 8px;
              white-space: pre-wrap;
              word-wrap: break-word;
            }

            .meta {
              display: flex;
              align-items: center;
              gap: 14px;
              margin-top: 10px;
              color: var(--muted);
              font-size: .92rem;
            }

            .status {
              display: inline-flex;
              align-items: center;
              gap: 6px;
              font-weight: 700;
              color: var(--approve);
              background: #e7f9ea;
              border: 1px solid #c2efca;
              padding: 4px 10px;
              border-radius: 999px;
            }

            .self {
              outline: 2px dashed #ffb74d;
              outline-offset: 4px;
            }

            /* divider between cards like screenshot */
            .soft-divider {
              height: 1px;
              background: linear-gradient(90deg, transparent, var(--divider), transparent);
              margin: 14px 0;
            }

            /* pagination */
            .pagination {
              display: flex;
              gap: 6px;
              justify-content: center;
              margin-top: 18px;
              flex-wrap: wrap;
            }

            .page-link {
              display: inline-block;
              padding: 8px 12px;
              border-radius: 10px;
              background: #fff;
              border: 1px solid var(--divider);
              color: #633b05;
              text-decoration: none;
              font-weight: 700;
            }

            .page-link:hover {
              background: #fff4e0;
            }

            .page-item.active .page-link {
              background: var(--brand-1);
              color: #fff;
              border-color: var(--brand-1);
            }

            .page-item.disabled .page-link {
              opacity: .5;
              pointer-events: none;
            }

            @media (max-width:720px) {
              .trow {
                grid-template-columns: 64px 1fr;
                gap: 12px;
              }

              .avatar {
                width: 56px;
                height: 56px;
                font-size: 18px;
              }
            }
          </style>
        </head>

        <body>
          <div class="wrap">
            <div class="page-head">
              <h2>सदस्यों के प्रशंसापत्र</h2>
              <div class="count">कुल: ${totalItems}</div>
            </div> <!-- Toolbar: search + page size (optional) -->
            <form id="filterForm" class="toolbar"> <input type="text" name="q" value="${param.q}"
                placeholder="नाम, पदनाम या संदेश खोजें"> <select name="size">
                <option value="6" ${size==6 ? 'selected' : '' }>6</option>
                <option value="9" ${size==9 ? 'selected' : '' }>9</option>
                <option value="12" ${size==12 ? 'selected' : '' }>12</option>
                <option value="24" ${size==24 ? 'selected' : '' }>24</option>
              </select> <button class="btn" type="submit">🔍 खोजें</button>
              <c:if test="${not empty currentUser}"> <a class="btn" style="text-decoration:none; background:#3c7d1f;"
                  href="/member/add-testimonial">+ प्रशंसापत्र जोड़ें</a> </c:if>
            </form> <!-- List -->
            <c:choose>
              <c:when test="${empty testimonials}">
                <div class="tcard" style="text-align:center; font-weight:600; color:#8a6b3a;">कोई प्रशंसापत्र उपलब्ध
                  नहीं</div>
              </c:when>
              <c:otherwise>
                <c:forEach var="t" items="${testimonials}" varStatus="st">
                  <c:set var="fullName" value="${t.user.fullName}" />
                  <c:set var="designation" value="${not empty t.designation ? t.designation : t.user.occupation}" />
                  <c:set var="isSelf" value="${not empty currentUser and currentUser.id == t.user.id}" />
                  <div class="tcard ${isSelf ? 'self' : ''}">
                    <div class="trow">
                      <!-- Left: avatar (image or initials) -->
                      <div>
                        <c:choose>
                          <c:when test="${not empty t.user.profileImagePath}">
                            <img class="avatar" src="${t.user.profileImagePath}" alt="avatar">
                          </c:when>
                          <c:otherwise>
                            <div class="avatar">
                              <c:choose>
                                <c:when test="${not empty fullName}">
                                  <c:set var="nparts" value="${fn:split(fullName,' ')}" />
                                  <c:choose>
                                    <c:when test="${fn:length(nparts) >= 2}">
                                      <c:out
                                        value="${fn:toUpperCase(fn:substring(nparts,0,1))}${fn:toUpperCase(fn:substring(nparts[fn:length(nparts)-1],0,1))}" />
                                    </c:when>
                                    <c:otherwise>
                                      <c:out value="${fn:toUpperCase(fn:substring(fullName,0,2))}" />
                                    </c:otherwise>
                                  </c:choose>
                                </c:when>
                                <c:otherwise>?</c:otherwise>
                              </c:choose>
                            </div>
                          </c:otherwise>
                        </c:choose>
                      </div>

                      <!-- Right: content -->
                      <div>
                        <div class="header">
                          <div class="name">
                            <c:out value="${fullName}" />
                          </div>
                          <div class="role">
                            <c:out value="${designation}" />
                          </div>
                        </div>

                        <div class="msg">
                          <c:out value="${t.message}" />
                        </div>

                        <div class="meta">
                          <div>🕒
                            <c:out value="${t.formattedCreatedDate}" />
                          </div>
                          <div class="status">✔️
                            <c:out value="${t.status}" />
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <c:if test="${!st.last}">
                    <div class="soft-divider"></div>
                  </c:if>
                </c:forEach>

                <!-- Page info -->
                <c:if test="${totalPages > 0}">
                  <p class="text-center" style="color:#7a5a23;">पृष्ठ ${currentPage + 1} / ${totalPages}</p>
                </c:if>

                <!-- Pagination -->
                <c:if test="${totalPages > 0}">
                  <nav>
                    <ul class="pagination">
                      <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                        <a class="page-link" href="#" data-page="${currentPage - 1}">⏮ पिछला</a>
                      </li>
                      <c:forEach begin="0" end="${totalPages - 1}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                          <a class="page-link" href="#" data-page="${i}">${i + 1}</a>
                        </li>
                      </c:forEach>
                      <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                        <a class="page-link" href="#" data-page="${currentPage + 1}">अगला ⏭</a>
                      </li>
                    </ul>
                  </nav>
                </c:if>
              </c:otherwise>
            </c:choose>

          </div>
          <script> (function () { function gotoPage(p) { const url = new URL(window.location.href); url.searchParams.set('page', p); const sizeSel = document.querySelector('select[name="size"]'); const qEl = document.querySelector('input[name="q"]'); if (sizeSel) url.searchParams.set('size', sizeSel.value || '9'); if (qEl && qEl.value.trim().length > 0) url.searchParams.set('q', qEl.value.trim()); else url.searchParams.delete('q'); window.location.href = url.toString(); } document.addEventListener('click', function (e) { const a = e.target.closest('.page-link'); if (!a || !a.dataset.page) return; e.preventDefault(); const to = parseInt(a.dataset.page, 10); if (!isNaN(to) && to >= 0) gotoPage(to); }); const form = document.getElementById('filterForm'); if (form) { form.addEventListener('submit', function (e) { e.preventDefault(); const url = new URL(window.location.href); url.searchParams.set('page', '0'); const size = form.querySelector('select[name="size"]').value; const q = form.querySelector('input[name="q"]').value.trim(); url.searchParams.set('size', size || '9'); if (q.length > 0) url.searchParams.set('q', q); else url.searchParams.delete('q'); window.location.href = url.toString(); }); } })(); </script>
        </body>

        </html>