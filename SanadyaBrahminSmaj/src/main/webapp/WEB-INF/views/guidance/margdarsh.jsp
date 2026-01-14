<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
  <%@ include file="/WEB-INF/views/includes/header.jsp" %>
<!DOCTYPE html>
<html lang="hi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>${fn:escapeXml(pageTitle != null ? pageTitle : 'शुभकामना संदेश')}</title>

  <style>
    :root{
      --primary:#d97706; /* warm saffron */
      --accent:#b45309;  /* deep saffron */
      --ink:#1f2937;     /* slate */
      --paper:#fffaf0;   /* light parchment */
    }

    body{
      background: radial-gradient(ellipse at top left, rgba(217,119,6,.14), transparent 60%),
                  radial-gradient(ellipse at bottom right, rgba(180,83,9,.12), transparent 60%),
                  var(--paper);
      font-family: "Noto Sans Devanagari", system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial, sans-serif;
      color: var(--ink);
    }

    .page-wrap{
      max-width: 900px;
      margin: 24px auto 64px;
      padding: 0 12px;
    }

    .hero-card{
      background: #fffef9;
      border: 1px solid rgba(180,83,9,.15);
      border-radius: 24px;
      box-shadow: 0 10px 30px rgba(0,0,0,.06);
      overflow: hidden;
      position: relative;
      isolation: isolate;
    }

    /* soft decorative edge */
    .hero-card::before{
      content: "";
      position: absolute; inset: 0; z-index: 0;
      background: linear-gradient(135deg, rgba(217,119,6,.10), rgba(217,119,6,0) 40%),
                  linear-gradient(-135deg, rgba(244,172,94,.10), rgba(244,172,94,0) 45%);
      pointer-events: none;
    }

    .top-ribbon{
      background: linear-gradient(90deg, var(--primary), var(--accent));
      height: 8px;
    }

    .header-area{
      padding: 28px 28px 8px;
      position: relative;
      z-index: 1;
    }

    .avatar{
      width: 116px; height: 140px;
      object-fit: cover; object-position: center;
      border-radius: 14px;
      border: 4px solid #fff;
      box-shadow: 0 6px 20px rgba(0,0,0,.12);
    }

    .title{
      font-family: "Noto Serif Devanagari", serif;
      font-weight: 700;
      letter-spacing: .3px;
      color: var(--accent);
    }

    .subtle{
      color:#6b7280;
      font-size: .96rem;
    }

    .divider{
      display: flex; align-items:center; gap:12px;
      margin: 18px 0 6px;
    }
    .divider .line{ flex:1; height:1px; background: linear-gradient(90deg, transparent, rgba(180,83,9,.35), transparent); }
    .divider .dot{ width:10px; height:10px; border-radius:999px; background: var(--primary); box-shadow:0 0 0 4px rgba(217,119,6,.15);}    

    .content-area{
      padding: 6px 28px 28px;
      z-index: 1;
      position: relative;
    }

    .dropcap:first-letter{
      font-family: "Noto Serif Devanagari", serif;
      float:left; font-size:3.1rem; line-height: 2.6rem; padding: .2rem .6rem .2rem 0; font-weight:700; color: var(--accent);
    }

    blockquote{
      border-left: 4px solid rgba(217,119,6,.4);
      padding-left: 14px; margin-left: 6px; color:#374151; font-style: italic;
      background: rgba(217,119,6,.05); border-radius: 8px;
    }

    .actions{
      gap: .6rem;
    }

    .btn-soft{
      --bs-btn-color:#fff; --bs-btn-bg:var(--accent); --bs-btn-border-color:var(--accent);
      --bs-btn-hover-bg:#8a3f08; --bs-btn-hover-border-color:#8a3f08;
      --bs-btn-focus-shadow-rgb:180,83,9;
    }

    .badge-rounded{
      background: rgba(217,119,6,.12); color: var(--accent); border:1px solid rgba(217,119,6,.25);
      padding:.35rem .6rem; border-radius:999px; font-weight:600;
    }

    .footer-note{
      display:flex; align-items:center; justify-content:space-between; gap:12px;
      padding: 16px 24px; color:#6b7280; font-size:.95rem;
      border-top: 1px dashed rgba(180,83,9,.3);
      background: linear-gradient(0deg, rgba(217,119,6,.05), transparent);
    }

    .page-number{ font-weight:700; color: var(--accent); }

    @media print{
      body{ background:#fff; }
      .actions, .navbar, .print-hide{ display:none !important; }
      .hero-card{ box-shadow:none; border: none; }
    }
  </style>
</head>
<body>


  <main class="page-wrap">
                <c:forEach var="message" items="${messages}">
    <div class="hero-card">
      <div class="top-ribbon"></div>

      <div class="header-area">
        <div class="row g-3 align-items-center">
          <div class="col-4 col-sm-3 col-md-2 text-center">
            <img class="avatar" src="<c:url value='${empty message.photoUrl ? "/images/placeholder-portrait.png" : message.photoUrl}'/>" alt="${fn:escapeXml(message.authorName)}"/>
          </div>
          <div class="col">
            <h1 class="h3 title mb-1">${fn:escapeXml(message.authorName)}</h1>
            <div class="subtle">${fn:escapeXml(message.authorTitle)}</div>
            <div class="subtle">${fn:escapeXml(message.authorSubtitle)}</div>
          </div>
          <div class="col-auto text-end">
            <span class="badge-rounded">${fn:escapeXml(message.cityOrArea)}</span>
          </div>
        </div>
        <div class="divider"><div class="line"></div><div class="dot"></div><div class="line"></div></div>
        <h2 class="h4 mt-2" style="font-family:'Noto Serif Devanagari',serif">${fn:escapeXml(message.title != null ? message.title : 'शुभकामना संदेश')}</h2>
      </div>

      <div class="content-area">
        <c:if test="${not empty message.lead}">
          <p class="mb-3 dropcap">${fn:escapeXml(message.lead)}</p>
        </c:if>

        <!-- If server sends safe HTML, render here; else fallback to escaped text -->
        <c:choose>
          <c:when test="${not empty message.contentHtml}">
            <div class="fs-5" style="line-height:1.9" >${message.contentHtml}</div>
          </c:when>
          <c:otherwise>
            <p class="fs-5" style="line-height:1.9">${fn:escapeXml(message.content)}</p>
          </c:otherwise>
        </c:choose>

        <c:if test="${not empty message.quote}">
          <blockquote class="mt-3 mb-1">${fn:escapeXml(message.quote)}</blockquote>
        </c:if>

        <div class="mt-4 d-flex justify-content-end">
          <div class="text-end">
            <div class="fw-semibold">${fn:escapeXml(message.signatureName)}</div>
            <div class="subtle">${fn:escapeXml(message.signatureDesignation)}</div>
          </div>
        </div>
      </div>

      <div class="footer-note">
        <div>${fn:escapeXml(message.footerNote != null ? message.footerNote : (message.dateText != null ? message.dateText : ''))}</div>
        <div class="page-number">${fn:escapeXml(message.pageNumber != null ? message.pageNumber : '')}</div>
      </div>
    </div>
            </c:forEach>
    <!-- Inspiration: red fabric background in provided photo (for context only) -->
    <div class="small text-center mt-3 text-muted">© ${fn:escapeXml(brandName != null ? brandName : 'सनाड्य ब्राह्मण महासभा')}</div>
  </main>

  <script>
    $(function(){
      $('#btnPrint').on('click', function(){ window.print(); });

      $('#btnCopy').on('click', async function(){
        try{
          await navigator.clipboard.writeText(window.location.href);
          const toast = $('<div class="position-fixed bottom-0 end-0 p-3" style="z-index:1080"></div>')
            .append(`<div class="toast align-items-center show" role="status" aria-live="polite" aria-atomic="true">
                        <div class="d-flex">
                          <div class="toast-body">लिंक कॉपी हो गया ✅</div>
                          <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                        </div>
                      </div>`);
          $('body').append(toast);
          setTimeout(()=>toast.remove(), 2200);
        }catch(e){ alert('कॉपी नहीं हो सका'); }
      });
    });
  </script>
</body>
</html>
