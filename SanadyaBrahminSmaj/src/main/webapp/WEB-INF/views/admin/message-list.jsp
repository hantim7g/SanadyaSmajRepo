<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Messages</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="<c:url value='/webjars/bootstrap/5.3.3/css/bootstrap.min.css'/>" rel="stylesheet"/>
</head>
<body class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="mb-0">Messages</h3>
        <c:if test="${canCreate}">
            <a class="btn btn-primary btn-sm" href="<c:url value='/admin/messages/new'/>">New</a>
        </c:if>
    </div>

    <table class="table table-striped mt-3 align-middle">
        <thead>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Photo</th>
            <th>City</th>
            <th class="text-end">Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="m" items="${messages}">
            <tr id="row-${m.id}">
                <td>${m.id}</td>
                <td>${m.title}</td>
                <td>
                    <c:if test="${not empty m.photoUrl}">
                        <img src="${m.photoUrl}" alt="photo" style="height:48px;border-radius:4px;"/>
                    </c:if>
                </td>
                <td>${m.cityOrArea}</td>
                <td class="text-end">
                    <div class="btn-group">
                        <c:if test="${canEdit}">
                            <a class="btn btn-outline-secondary btn-sm" href="<c:url value='/admin/messages/${m.id}/edit'/>">Edit</a>
                        </c:if>

                        <c:if test="${canDelete}">
                            <button type="button"
                                    class="btn btn-outline-danger btn-sm"
                                    data-bs-toggle="modal"
                                    data-bs-target="#confirmDeleteModal"
                                    data-delete-url="<c:url value='/admin/messages/${m.id}/delete'/>"
                                    data-title="${m.title}">
                                Delete
                            </button>
                        </c:if>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Confirm Delete Modal -->
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <form id="confirmDeleteForm" method="post" action="">
            <div class="modal-header">
              <h5 class="modal-title">Confirm delete</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
              <p id="confirmDeleteText" class="mb-0"></p>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
              <button type="submit" class="btn btn-danger">Delete</button>
            </div>
          </form>
        </div>
      </div>
    </div>

<script src="<c:url value='/webjars/jquery/3.7.1/jquery.min.js'/>"></script>
<script src="<c:url value='/webjars/bootstrap/5.3.3/js/bootstrap.bundle.min.js'/>"></script>
<script>
const modalEl = document.getElementById('confirmDeleteModal');
modalEl.addEventListener('show.bs.modal', function (event) {
    const button = event.relatedTarget;
    const url = button.getAttribute('data-delete-url');
    const title = button.getAttribute('data-title') || 'this item';
    document.getElementById('confirmDeleteForm').setAttribute('action', url);
    document.getElementById('confirmDeleteText').textContent =
        'Delete "' + title + '"? This action cannot be undone.';
});
</script>
</body>
</html>
