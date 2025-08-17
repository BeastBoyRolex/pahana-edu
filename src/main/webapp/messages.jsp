<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 8/3/2025
  Time: 12:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- Display success message --%>
<c:if test="${not empty successMessage}">
  <div class="alert alert-success alert-dismissible fade show" role="alert">
      ${successMessage}
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <c:remove var="successMessage" scope="session" />
</c:if>

<%-- Display error message --%>
<c:if test="${not empty errorMessage}">
  <div class="alert alert-danger alert-dismissible fade show" role="alert">
      ${errorMessage}
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <c:remove var="errorMessage" scope="session" />
</c:if>
